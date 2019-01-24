//
//  RHInvestmentWebViewController.m
//  ryhui
//
//  Created by 江 云龙 on 15/3/18.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHInvestmentWebViewController.h"
#import "MBProgressHUD.h"
#import "RHErrorViewController.h"
#import "NSString+URL.h"
#import "RHGesturePasswordViewController.h"
#import "RHHFLoginPasswordViewController.h"
#import <WebKit/WebKit.h>
#import "UIImage+GIF.h"
//#import ""
@interface RHInvestmentWebViewController ()<UIWebViewDelegate,WKUIDelegate,WKNavigationDelegate>

{
    AppDelegate *app;
    int secondsCountDown;
    NSTimer *countDownTimer;
    NSURLConnection *_urlConnection;
    NSMutableURLRequest *_request;
    BOOL _authenticated;
}
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property(assign,nonatomic)int test;
@property(nonatomic,assign)BOOL ress;
@property (weak, nonatomic) IBOutlet UIView *hidenview;
@property (weak, nonatomic) IBOutlet UIImageView *hidenimage;
@property(nonatomic,strong)WKWebView * wkWebview;
@end

@implementation RHInvestmentWebViewController
@synthesize projectId;
@synthesize price;
@synthesize giftId;

- (void)viewDidLoad {
    _test = 0;
    [super viewDidLoad];
    //app = [UIApplication sharedApplication].delegate;
    
    [self configBackButton];
    [self configTitleWithString:@"出借"];
//    [[UIApplication sharedApplication].keyWindow addSubview:self.webView];

    self.webView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-65);
    if ([UIScreen mainScreen].bounds.size.height>740) {
        self.webView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }
    
  //  self.hidenview.frame = CGRectMake(0, 65, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-65);
   
  NSString *deviceUUID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@app/common/appMain/appInvest",[RHNetworkService instance].newdoMain]];
    //    NSString *body = [NSString stringWithFormat: @"money=%@&projectId=%@&giftId=%@",price,projectId,giftId?giftId:@""];
    
    NSString *body = [NSString stringWithFormat: @"money=%@&projectId=%@&giftId=%@&investType=App&popularizeCompany=appstore&equipment=%@",price,projectId,giftId?giftId:@"",deviceUUID];
    _request = [[NSMutableURLRequest alloc]initWithURL: url];
    [_request setHTTPMethod: @"POST"];
    
    NSString* session=[[NSUserDefaults standardUserDefaults] objectForKey:@"RHSESSION"];
    NSString* session1=[[NSUserDefaults standardUserDefaults] objectForKey:@"RHNEWMYSESSION"];
    
    if (session1.length>12) {
        session = [NSString stringWithFormat:@"%@,%@",session,session1];
    }
    if (session&&[session length]>0) {
        [_request setValue:session forHTTPHeaderField:@"cookie"];
        
        
    }
    [_request setHTTPBody:[body dataUsingEncoding: NSUTF8StringEncoding]];
    
    NSString *version = [UIDevice currentDevice].systemVersion;
    if (version.doubleValue >= 11.0) {
        self.wkWebview =  [[WKWebView alloc] initWithFrame:self.view.bounds];
        [self.wkWebview loadRequest:_request];
        [self.view addSubview:self.wkWebview];
        self.wkWebview.navigationDelegate = self;
        //    [[UIApplication sharedApplication].keyWindow addSubview:self.wkWebview];
        self.wkWebview.UIDelegate = self;
        self.wkWebview.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-65);
        if ([UIScreen mainScreen].bounds.size.height>740) {
            self.wkWebview.frame = CGRectMake(0,0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-95);
        }
    }else{
        
        self.webView.frame = CGRectMake(0, 65, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-65);
        if ([UIScreen mainScreen].bounds.size.height>740) {
            self.webView.frame = CGRectMake(0, 95, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-95);
        }
        self.webView.delegate =self;
        [self.webView loadRequest: _request];
         [[UIApplication sharedApplication].keyWindow addSubview:self.webView];
//        [self.view addSubview:self.webView];
    }
//    [self.hidenimage sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"loading-logo_180x180.gif"]];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"loading-logo_180x180" ofType:@"gif"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    self.hidenimage.image = [UIImage sd_animatedGIFWithData:data];
    
    
    
    
//    NSLog(@"--------=============%@",url);
//    [self.webView loadRequest: _request];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    self.webView.hidden = YES;
//    self.wkWebview.hidden = YES;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
   
    
    return;
    
   
   
    
}



-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    //    NSLog(@"----------------%@",error.description);
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    self.view.userInteractionEnabled = YES;
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString* url=[request.URL absoluteString];
    
    //    DLog(@"%@",url);
    if (!_authenticated) {
        _authenticated =NO;
        _urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self]; // 网上好多教程这句写的request写的是_request
        _request = request; //网上好多教程这句代码忘记加了
        [_urlConnection start];
        return NO;
    }
    if (self.ress==YES){
        RHErrorViewController* controller=[[RHErrorViewController alloc]initWithNibName:@"RHErrorViewController" bundle:nil];
        //  controller.titleStr=[NSString stringWithFormat:@"投资金额%@元",price];
        controller.tipsStr=@"       请稍后在我的账户查看出借结果\n     如有问题请拨打客服电话\n     400-010-4001    ";
        controller.type=RHInvestmentchixu;
        [self.navigationController pushViewController:controller animated:YES];
        return NO;
    }
    if ([url rangeOfString:@"common/paymentJxResponse/investRestBefore"].location!=NSNotFound) {
        // [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.webView.hidden = YES;
        // self.hidenview.hidden = NO;
        //return NO;
       
        NSLog(@"1111");
    }
    if ([url rangeOfString:@"common/paymentJxResponse/initiativeTenderSuccess"].location!=NSNotFound) {
        RHErrorViewController* controller=[[RHErrorViewController alloc]initWithNibName:@"RHErrorViewController" bundle:nil];
        controller.titleStr=[NSString stringWithFormat:@"出借金额%@元",price];
        controller.tipsStr=@"赚钱别忘告诉其他小伙伴哦~";
        controller.type=RHInvestmentSucceed;
        [self.navigationController pushViewController:controller animated:YES];
        
        return NO;
    }
    
    if ([url rangeOfString:@"common/paymentJxResponse/initiativeTenderFailed"].location!=NSNotFound) {
        //        DLog(@"%@",url);
        RHErrorViewController* controller=[[RHErrorViewController alloc]initWithNibName:@"RHErrorViewController" bundle:nil];
        
        //        [self.navigationController popViewControllerAnimated:YES];
        //        return NO;
        NSArray* array= nil;
        if ([url rangeOfString:@"&retMsg="].location != NSNotFound) {
            array = [url componentsSeparatedByString:@"&retMsg="];
            
            array= [array[1] componentsSeparatedByString:@"&txAmount="];
        }else{
            if ([url rangeOfString:@"&RespDesc="].location != NSNotFound) {
                array = [url componentsSeparatedByString:@"&RespDesc="];
            }
            
        }
        
        NSArray * array1 = nil;
        if ([url rangeOfString:@"retCode="].location != NSNotFound) {
            array1 = [url componentsSeparatedByString:@"retCode="];
            
            array1= [array1[1] componentsSeparatedByString:@"&retMsg"];
            
            NSLog(@"%@",array1);
        }
        
        //        if ([url rangeOfString:@"&result="].location != NSNotFound) {
        //            array = [url componentsSeparatedByString:@"&result="];
        //        }
        if ([array count]>1) {
            controller.tipsStr=[[[array objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSLog(@"---------%@",controller.tipsStr);
            if ([controller.tipsStr isEqualToString:@"标的信息不存在&TransAmt=50000.00"]) {
                controller.tipsStr =@"标的信息不存在";
            }
        }
        if (_test > 0) {
            return NO;
        }
        if (array1.count>1) {
            controller.bankbackstr = [NSString stringWithFormat:@"%@",array1[0]];
        }
        controller.type=RHInvestmentFail;
        [self.navigationController pushViewController:controller animated:YES];
        _test++;
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
    if ([url rangeOfString:@"common/paymentJxResponse/investBeforeHandle"].location!=NSNotFound) {
        
        NSURL *url1 = [NSURL URLWithString:[NSString stringWithFormat:@"%@common/paymentJxResponse/investBeforeUid",[RHNetworkService instance].newdoMain]];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url1];
        [request setHTTPMethod: @"POST"];
        
        NSString* session=[[NSUserDefaults standardUserDefaults] objectForKey:@"RHSESSION"];
        //            [[NSUserDefaults standardUserDefaults] setObject:[RHUserManager sharedInterface].userId forKey:@"RHUSERID"];
        NSString* session1=[[NSUserDefaults standardUserDefaults] objectForKey:@"RHNEWMYSESSION"];
        
        if (session1.length>12) {
            session = [NSString stringWithFormat:@"%@,%@",session,session1];
        }
        NSString* userid=[[NSUserDefaults standardUserDefaults] objectForKey:@"RHUSERID"];
        if (session&&[session length]>0) {
            [request setValue:session forHTTPHeaderField:@"cookie"];
            
            
        }
        NSString *body = [NSString stringWithFormat: @"userId=%@",userid];
        [request setHTTPBody:[body dataUsingEncoding: NSUTF8StringEncoding]];
        NSLog(@"--------=============%@",url);
        [self.webView loadRequest: request];
        
        
        
        
        return NO;
    }
    
//    if ([url rangeOfString:@"account/mySafe?id=4"].location!=NSNotFound) {
//
//        RHHFLoginPasswordViewController* controller=[[RHHFLoginPasswordViewController alloc]initWithNibName:@"RHHFLoginPasswordViewController" bundle:nil];
//        //        controller.titleStr=[NSString stringWithFormat:@"投资金额%@元",price];
//        //        controller.tipsStr=@"赚钱别忘告诉其他小伙伴哦~";
//        //        controller.type=RHInvestmentSucceed;
//
//        controller.backstring = @"back";
//        [self.navigationController pushViewController:controller animated:YES];
//        //NSLog(@"666");
//        return NO;
//    }
    
    
    
    return YES;
}


- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    if ([challenge previousFailureCount] == 0)
    {
        _authenticated = YES;
        NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        [challenge.sender useCredential:credential forAuthenticationChallenge:challenge];
    } else
    {
        [[challenge sender] cancelAuthenticationChallenge:challenge];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // remake a webview call now that authentication has passed ok.
    _authenticated = YES;
    [self.webView loadRequest:_request]; //  self.webView替换成自己的webview
    // Cancel the URL connection otherwise we double up (webview + url connection, same url = no good!)
    [_urlConnection cancel];
}





- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    NSLog(@"%@",navigationAction.request.URL.absoluteString);
    NSString *url=[navigationAction.request.URL absoluteString];
    //    DLog(@"%@",url);
    if ([url rangeOfString:@"app/front/payment/appReskTest/webViewReskBtn"].location != NSNotFound) {
        NSLog(@"----------");
        decisionHandler(WKNavigationActionPolicyCancel);
        RHProjectListViewController *controller = [[RHProjectListViewController alloc]initWithNibName:@"RHProjectListViewController" bundle:nil];
        controller.type = @"0";
        //    [nav pushViewController:controller animated:YES];
        [[RYHViewController Sharedbxtabar]tabBar:(RYHView *)controller.view didSelectedIndex:1];
        UIButton *btn = [[UIButton alloc]init];
        btn.tag = 1;
        [[RYHView Shareview] btnClick:btn];
        [self.navigationController popToRootViewControllerAnimated:NO];
        return;
        
    }
    
    if (self.ress==YES){
        decisionHandler(WKNavigationActionPolicyCancel);
        RHErrorViewController* controller=[[RHErrorViewController alloc]initWithNibName:@"RHErrorViewController" bundle:nil];
        //  controller.titleStr=[NSString stringWithFormat:@"投资金额%@元",price];
        controller.tipsStr=@"       请稍后在我的账户查看出借结果\n     如有问题请拨打客服电话\n     400-010-4001    ";
        controller.type=RHInvestmentchixu;
        [self.navigationController pushViewController:controller animated:YES];
        return ;
    }
    if ([url rangeOfString:@"common/paymentJxResponse/investRestBefore"].location!=NSNotFound) {
        // [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        self.webView.hidden = YES;
        // self.hidenview.hidden = NO;
        //return NO;
//        return;
        self.wkWebview.hidden = YES;
        NSLog(@"1111");
    }
    if ([url rangeOfString:@"common/paymentJxResponse/initiativeTenderSuccess"].location!=NSNotFound) {
        RHErrorViewController* controller=[[RHErrorViewController alloc]initWithNibName:@"RHErrorViewController" bundle:nil];
        controller.titleStr=[NSString stringWithFormat:@"出借金额%@元",price];
        controller.tipsStr=@"赚钱别忘告诉其他小伙伴哦~";
        controller.type=RHInvestmentSucceed;
        decisionHandler(WKNavigationActionPolicyCancel);
        [self.navigationController pushViewController:controller animated:YES];
        
        return ;
    }
    
    if ([url rangeOfString:@"common/paymentJxResponse/initiativeTenderFailed"].location!=NSNotFound) {
        //        DLog(@"%@",url);
        RHErrorViewController* controller=[[RHErrorViewController alloc]initWithNibName:@"RHErrorViewController" bundle:nil];
        
        //        [self.navigationController popViewControllerAnimated:YES];
        //        return NO;
        NSArray* array= nil;
        if ([url rangeOfString:@"&retMsg="].location != NSNotFound) {
            array = [url componentsSeparatedByString:@"&retMsg="];
            
            array= [array[1] componentsSeparatedByString:@"&txAmount="];
        }else{
            if ([url rangeOfString:@"&RespDesc="].location != NSNotFound) {
                array = [url componentsSeparatedByString:@"&RespDesc="];
            }
            
        }
        
        NSArray * array1 = nil;
        if ([url rangeOfString:@"retCode="].location != NSNotFound) {
            array1 = [url componentsSeparatedByString:@"retCode="];
            
            array1= [array1[1] componentsSeparatedByString:@"&retMsg"];
            
            NSLog(@"%@",array1);
        }
        
        //        if ([url rangeOfString:@"&result="].location != NSNotFound) {
        //            array = [url componentsSeparatedByString:@"&result="];
        //        }
        if ([array count]>1) {
            controller.tipsStr=[[[array objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSLog(@"---------%@",controller.tipsStr);
            if ([controller.tipsStr isEqualToString:@"标的信息不存在&TransAmt=50000.00"]) {
                controller.tipsStr =@"标的信息不存在";
            }
        }
        if (_test > 0) {
            return ;
        }
        if (array1.count>1) {
            controller.bankbackstr = [NSString stringWithFormat:@"%@",array1[0]];
        }
        controller.type=RHInvestmentFail;
        decisionHandler(WKNavigationActionPolicyCancel);
        [self.navigationController pushViewController:controller animated:YES];
        _test++;
        return ;
    }
    
    if ([url rangeOfString:@"/common/user/login/index"].location != NSNotFound) {
        if ([RHUserManager sharedInterface].username&&[[RHUserManager sharedInterface].username length]>0) {
            [app sessionFail:nil];
            if ([[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@Gesture",[RHUserManager sharedInterface].username]]&&[[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@Gesture",[RHUserManager sharedInterface].username]] length]>0) {
                RHGesturePasswordViewController* controller=[[RHGesturePasswordViewController alloc]init];
                controller.isEnter = YES;
                //                UINavigationController *navi = (UINavigationController *)app.window.rootViewController;
                //                UIViewController *vc = navi.viewControllers[navi.viewControllers.count - 1];
                decisionHandler(WKNavigationActionPolicyCancel);
                [self.navigationController pushViewController:controller animated:YES];
            }
        }
        
        return ;
    }
    if ([url rangeOfString:@"common/paymentJxResponse/investBeforeHandle"].location!=NSNotFound) {
        
        NSURL *url1 = [NSURL URLWithString:[NSString stringWithFormat:@"%@common/paymentJxResponse/investBeforeUid",[RHNetworkService instance].newdoMain]];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url1];
        [request setHTTPMethod: @"POST"];
        
        NSString* session=[[NSUserDefaults standardUserDefaults] objectForKey:@"RHSESSION"];
        //            [[NSUserDefaults standardUserDefaults] setObject:[RHUserManager sharedInterface].userId forKey:@"RHUSERID"];
        NSString* session1=[[NSUserDefaults standardUserDefaults] objectForKey:@"RHNEWMYSESSION"];
        
        if (session1.length>12) {
            session = [NSString stringWithFormat:@"%@,%@",session,session1];
        }
        NSString* userid=[[NSUserDefaults standardUserDefaults] objectForKey:@"RHUSERID"];
        if (session&&[session length]>0) {
            [request setValue:session forHTTPHeaderField:@"cookie"];
            
            
        }
        NSString *body = [NSString stringWithFormat: @"userId=%@",userid];
        [request setHTTPBody:[body dataUsingEncoding: NSUTF8StringEncoding]];
        NSLog(@"--------=============%@",url);
        [self.webView loadRequest: request];
        
        
        
        
        return ;
    }
    
    if ([url rangeOfString:@"account/mySafe?id=4"].location!=NSNotFound) {
        
        RHHFLoginPasswordViewController* controller=[[RHHFLoginPasswordViewController alloc]initWithNibName:@"RHHFLoginPasswordViewController" bundle:nil];
        //        controller.titleStr=[NSString stringWithFormat:@"投资金额%@元",price];
        //        controller.tipsStr=@"赚钱别忘告诉其他小伙伴哦~";
        //        controller.type=RHInvestmentSucceed;
        
        controller.backstring = @"back";
        decisionHandler(WKNavigationActionPolicyCancel);
        [self.navigationController pushViewController:controller animated:YES];
        //NSLog(@"666");
        return ;
    }
    
    
    //允许跳转
    decisionHandler(WKNavigationActionPolicyAllow);
}


- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler{
    
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        
        NSURLCredential *card = [[NSURLCredential alloc]initWithTrust:challenge.protectionSpace.serverTrust];
        
        completionHandler(NSURLSessionAuthChallengeUseCredential,card);
        
    }
}

@end
