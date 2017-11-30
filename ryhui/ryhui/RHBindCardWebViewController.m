//
//  RHBindCardWebViewController.m
//  ryhui
//
//  Created by 江 云龙 on 15/3/30.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHBindCardWebViewController.h"
#import "MBProgressHUD.h"
#import "RHGesturePasswordViewController.h"

@interface RHBindCardWebViewController ()

{
    AppDelegate *app;
}
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation RHBindCardWebViewController
@synthesize delegate;

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@front/payment/account/bindCard",[RHNetworkService instance].newdoMain]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url];
    [request setHTTPMethod: @"POST"];
    NSString *session = [[NSUserDefaults standardUserDefaults] objectForKey:@"RHSESSION"];
    if (session&&[session length] > 0) {
        [request setValue:session forHTTPHeaderField:@"cookie"];
    }
    self.webView.delegate = self;
    [self.webView loadRequest: request];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configBackButton];
    [self configTitleWithString:@"绑卡"];
    
    app = [UIApplication sharedApplication].delegate;

   
}

- (void)back {
    [delegate getWithdrawData];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString* url=[request.URL absoluteString];
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
//    if ([url isEqualToString:[NSString stringWithFormat:@"%@common/paymentResponse/cashClientBackFailed",[RHNetworkService instance].doMain]]) {
//        
//        return NO;
//    }
    return YES;
}

@end
