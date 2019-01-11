//
//  RHWithdrawWebViewController.m
//  ryhui
//
//  Created by 江 云龙 on 15/3/29.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHWithdrawWebViewController.h"
#import "MBProgressHUD.h"
#import "RHErrorViewController.h"
#import "RHGesturePasswordViewController.h"
#import "RHHFLoginPasswordViewController.h"
#import "RHhelper.h"
@interface RHWithdrawWebViewController ()
{
    AppDelegate *app;
}
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation RHWithdrawWebViewController
@synthesize amount;
@synthesize captcha;
@synthesize category;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    app = [UIApplication sharedApplication].delegate;
    
    [self configBackButton];
    [self configTitleWithString:@"提现"];

    [RHhelper ShraeHelp].withdrawtest=101;
    
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@app/front/payment/appJxAccount/withdrawJxData",[RHNetworkService instance].newdoMain]];
     NSString *deviceUUID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSString *body = [NSString stringWithFormat: @"cardNumber=%@&money=%@&txFee=%@&category=%@&cardBankCnaps=%@&popularizeCompany=appstore&equipment=%@",self.bankcard,amount,captcha,category,self.cardBankCnaps,deviceUUID];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url];
    [request setHTTPMethod: @"POST"];
    NSString* session = [[NSUserDefaults standardUserDefaults] objectForKey:@"RHSESSION"];
    if (session && [session length] > 0) {
        [request setValue:session forHTTPHeaderField:@"Set-Cookie"];
    }
    [request setHTTPBody: [body dataUsingEncoding: NSUTF8StringEncoding]];
    [self.webView loadRequest: request];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *url=[request.URL absoluteString];
//    DLog(@"%@",url);
    if ([url rangeOfString:@"front/payment/account/myCash2"].location != NSNotFound) {
        RHErrorViewController *controller = [[RHErrorViewController alloc]initWithNibName:@"RHErrorViewController" bundle:nil];
        controller.titleStr = [NSString stringWithFormat:@"申请提现金额%@元",amount];
        controller.tipsStr = @"";
        controller.type = RHWithdrawSucceed;
        if ([RHhelper ShraeHelp].withdrawtest==10) {
            return NO;
        }
        
        [self.navigationController pushViewController:controller animated:YES];
        
        return NO;
    }
    
    if ([url rangeOfString:@"front/payment/account/myCash3"].location != NSNotFound) {
        
        RHErrorViewController *controller = [[RHErrorViewController alloc]initWithNibName:@"RHErrorViewController" bundle:nil];
        controller.titleStr = @"失败";
//        NSArray* array = nil;
//        if ([url rangeOfString:@"&RespDesc"].location != NSNotFound) {
//            array = [url componentsSeparatedByString:@"&RespDesc="];
//        }
//        if ([url rangeOfString:@"&result="].location != NSNotFound) {
//            array = [url componentsSeparatedByString:@"&result="];
//        }
//        if ([array count] > 1) {
//            controller.tipsStr = [[[array objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        }
        controller.type = RHWithdrawFail;
       // [self.navigationController pushViewController:controller animated:YES];
        
        [self.navigationController popViewControllerAnimated:YES];
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
    if ([url rangeOfString:@"account/mySafe?id=4"].location!=NSNotFound) {
        
        RHHFLoginPasswordViewController* controller=[[RHHFLoginPasswordViewController alloc]initWithNibName:@"RHHFLoginPasswordViewController" bundle:nil];
        //        controller.titleStr=[NSString stringWithFormat:@"投资金额%@元",price];
        //        controller.tipsStr=@"赚钱别忘告诉其他小伙伴哦~";
        //        controller.type=RHInvestmentSucceed;
        
        controller.backstring = @"backback";
        [self.navigationController pushViewController:controller animated:YES];
        //NSLog(@"666");
        return NO;
    }
    return YES;
}


@end
