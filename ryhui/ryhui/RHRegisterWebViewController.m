//
//  RHRegisterWebViewController.m
//  ryhui
//
//  Created by stefan on 15/3/15.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHRegisterWebViewController.h"
#import "MBProgressHUD.h"
#import "RHGesturePasswordViewController.h"

@interface RHRegisterWebViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation RHRegisterWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configBackButton];
    [self configTitleWithString:@"开户"];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@front/payment/account/accountHF",[RHNetworkService instance].doMain]];

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url];
    [request setHTTPMethod:@"GET"];
    [self.webView loadRequest: request];
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString* url=[request.URL absoluteString];
//    DLog(@"%@",url);
    
    if ([url rangeOfString:@"front/payment/account/myAccount"].location !=NSNotFound) {
        [RHUserManager sharedInterface].custId = @"first";
        
        if ([RHUserManager sharedInterface].username&&[[RHUserManager sharedInterface].username length]>0) {
            if ([[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@Gesture",[RHUserManager sharedInterface].username]]&&[[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@Gesture",[RHUserManager sharedInterface].username]] length]>0) {
                [[RHTabbarManager sharedInterface] initTabbar];
                [[RHTabbarManager sharedInterface] selectTabbarUser];
            } else {
                RHGesturePasswordViewController* controller=[[RHGesturePasswordViewController alloc]init];
                controller.isRegister = YES;
                [self.navigationController pushViewController:controller animated:NO];
            }
        }else{
            RHGesturePasswordViewController* controller=[[RHGesturePasswordViewController alloc]init];
            controller.isRegister = YES;
            [self.navigationController pushViewController:controller animated:NO];
        }
        return NO;
    }
    return YES;
}
@end
