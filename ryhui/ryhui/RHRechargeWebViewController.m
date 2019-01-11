//
//  RHRechargeWebViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 17/3/15.
//  Copyright (c) 2017年 stefan. All rights reserved.
//

#import "RHRechargeWebViewController.h"
#import "MBProgressHUD.h"
#import "RHErrorViewController.h"
#import "RHGesturePasswordViewController.h"
@interface RHRechargeWebViewController ()
{
    AppDelegate *app;
}
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation RHRechargeWebViewController
@synthesize price;
@synthesize bankname;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    app = [UIApplication sharedApplication].delegate;
    [self getmoban];
    [self configBackButton];
    [self configTitleWithString:@"充值"];
}
-(void)getmoban{
    
    UIView * aview = [[UIView alloc]init];
    aview.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    
    [self.view addSubview:aview];
    [self.view addSubview:self.webView];
    aview.backgroundColor = [UIColor whiteColor];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    bankname = @"";
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@app/front/payment/appAccount/appRecharge",[RHNetworkService instance].newdoMain]];
    NSString *body = [NSString stringWithFormat: @"money=%@&type=QP&openBankId=%@",price,bankname];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url];
    [request setHTTPMethod: @"POST"];
    NSString* session=[[NSUserDefaults standardUserDefaults] objectForKey:@"RHSESSION"];
    NSString* session1=[[NSUserDefaults standardUserDefaults] objectForKey:@"RHNEWMYSESSION"];
    
    if (session1.length>12) {
        session = [NSString stringWithFormat:@"%@,%@",session,session1];
    }
    if (session&&[session length]>0) {
        [request setValue:session forHTTPHeaderField:@"cookie"];
    }
    [request setHTTPBody: [body dataUsingEncoding: NSUTF8StringEncoding]];
    [self.webView loadRequest: request];
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString* url=[request.URL absoluteString];
            DLog(@"---====---%@",url);
    
    if ([url rangeOfString:@"common/paymentResponse/netSaveClientSuccess"].location!=NSNotFound) {

        RHErrorViewController* controller=[[RHErrorViewController alloc]initWithNibName:@"RHErrorViewController" bundle:nil];
        controller.titleStr=[NSString stringWithFormat:@"充值金额%@元",price];
        controller.tipsStr=@"好项目不等人，快去抢吧~";
        controller.type=RHPaySucceed;
        [self.navigationController pushViewController:controller animated:YES];
        
        return NO;
    }
    if ([url rangeOfString:@"common/paymentResponse/netSaveClientFailed"].location!=NSNotFound) {
        RHErrorViewController* controller=[[RHErrorViewController alloc]initWithNibName:@"RHErrorViewController" bundle:nil];
//        controller.titleStr = @"银行卡余额不足";
        NSArray* array=[url componentsSeparatedByString:@"&RespDesc="];
        NSArray* secarray = [url componentsSeparatedByString:@"&SecRespDesc="];
        NSString * str = [NSString stringWithFormat:@"%@",secarray[1]];
        NSLog(@"--===---%ld",str.length);
//        NSData *data =[str dataUsingEncoding:NSUTF8StringEncoding];
        
//        str = @"fdsjdgsjkfdgg";
        NSString *encodedString;
        if (str.length>5) {
            encodedString =[str stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            encodedString = [encodedString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }
        NSString * firsten;
        
        if ([array count]>1) {
            NSArray *codeArray = [array[0] componentsSeparatedByString:@"="];
            NSArray * firstarray = [array[1] componentsSeparatedByString:@"&SecRespCode="];
            firsten = [firstarray[0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            firsten = [firsten stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            if (codeArray.count > 1) {
                NSString *code = codeArray[1];
//                NSLog(@"==============%@",code);
                if ([code integerValue] == 436) {
                    controller.titleStr = @"快捷充值卡信息验证失败";
                    controller.tipsStr = @"请避免以下情况并重试：\n姓名／身份证号与开户身份信息不符\n银行预留手机号与开户绑定手机号不符\n银行卡所属地区录入有误";
                } else {
                  controller.errorType = 435;
                }
            }
        }
        if (str.length > 1) {
            controller.recongestrsec = [NSString stringWithFormat:@"%@(%@)",firsten,encodedString];
        }else{
            controller.recongestrsec = [NSString stringWithFormat:@"%@",firsten];
        }
        controller.type = RHPayFail;
        [self.navigationController pushViewController:controller animated:YES];
        return NO;
    }
    
    if ([url rangeOfString:@"/common/user/login/index"].location != NSNotFound) {
        if ([RHUserManager sharedInterface].username&&[[RHUserManager sharedInterface].username length]>0) {
            [app sessionFail:nil];
            if ([[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@Gesture",[RHUserManager sharedInterface].username]]&&[[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@Gesture",[RHUserManager sharedInterface].username]] length]>0) {
                RHGesturePasswordViewController* controller=[[RHGesturePasswordViewController alloc]init];
                controller.isEnter = YES;
                //                UINavigationController *navi = (UINavigationController *)app.window.rootViewController;
                //                UIViewController *vc = navi.viewControllers[navi.viewControllers.count - 1];
                [self.navigationController pushViewController:controller animated:YES];
            }
        }
        
        return NO;
    }
    
    return YES;
}



- (NSString *)URLEncodedString:(NSString * )str
{
    // CharactersToBeEscaped = @":/?&=;+!@#$()~',*";
    // CharactersToLeaveUnescaped = @"[].";
    
    NSString *unencodedString = str;
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)unencodedString,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    
    return encodedString;
}
- (NSString *)stringByDecodingURLFormat:(NSString *)str

{
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0) {
        
         return [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!*'();:,.@&=+$/?%#[]_"]];
        
    } else {
        
         return [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
    }
    
//    return str;
    
}
@end
