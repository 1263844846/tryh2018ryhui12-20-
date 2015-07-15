//
//  RHRechargeWebViewController.m
//  ryhui
//
//  Created by stefan on 15/3/15.
//  Copyright (c) 2015年 stefan. All rights reserved.
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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    app = [UIApplication sharedApplication].delegate;
    
    [self configBackButton];
    [self configTitleWithString:@"充值"];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@front/payment/account/recharge",[RHNetworkService instance].doMain]];
    NSString *body = [NSString stringWithFormat: @"money=%@&type=QP",price];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url];
    [request setHTTPMethod: @"POST"];
    NSString* session=[[NSUserDefaults standardUserDefaults] objectForKey:@"RHSESSION"];
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
    if ([url rangeOfString:@"common/paymentResponse/netSaveClientSuccess"].location!=NSNotFound) {
//        DLog(@"%@",url);
        RHErrorViewController* controller=[[RHErrorViewController alloc]initWithNibName:@"RHErrorViewController" bundle:nil];
        controller.titleStr=[NSString stringWithFormat:@"充值金额%@元",price];
        controller.tipsStr=@"好项目不等人，快去抢吧~";
        controller.type=RHPaySucceed;
        [self.navigationController pushViewController:controller animated:YES];
        
        return NO;
    }
    if ([url rangeOfString:@"common/paymentResponse/netSaveClientFailed"].location!=NSNotFound) {
//        DLog(@"%@",url);

        RHErrorViewController* controller=[[RHErrorViewController alloc]initWithNibName:@"RHErrorViewController" bundle:nil];
        controller.titleStr=@"银行卡余额不足";
        controller.tipsStr=@"先往卡里塞点钱吧~";
        controller.type=RHPayFail;
        [self.navigationController pushViewController:controller animated:YES];
        return NO;
    }
    
    if ([url containsString:@"/common/user/login/index"]) {
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





@end
