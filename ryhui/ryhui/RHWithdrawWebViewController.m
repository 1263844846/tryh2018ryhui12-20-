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
@interface RHWithdrawWebViewController ()

@end

@implementation RHWithdrawWebViewController
@synthesize amount;
@synthesize captcha;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configBackButton];
    [self configTitleWithString:@"提现"];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@common/main/invest",[RHNetworkService instance].doMain]];
    NSString *body = [NSString stringWithFormat: @"money=%@&captcha=%@",amount,captcha];
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

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString* url=[request.URL absoluteString];

    DLog(@"%@",url);
    if ([url containsString:[NSString stringWithFormat:@"%@common/paymentResponse/cashClientBackSuccess",[RHNetworkService instance].doMainhttp]]) {
        RHErrorViewController* controller=[[RHErrorViewController alloc]initWithNibName:@"RHErrorViewController" bundle:nil];
        controller.titleStr=[NSString stringWithFormat:@"申请提现金额%@元",amount];
        controller.tipsStr=@"资金预计于审核后T+1个工作日到账";
        controller.type=RHWithdrawSucceed;
        [self.navigationController pushViewController:controller animated:YES];
        
        return NO;
    }
    if ([url containsString:[NSString stringWithFormat:@"%@common/paymentResponse/cashClientBackFailed",[RHNetworkService instance].doMainhttp]]) {
        
        RHErrorViewController* controller=[[RHErrorViewController alloc]initWithNibName:@"RHErrorViewController" bundle:nil];
        controller.titleStr=@"余额不足";
        controller.tipsStr=@"0";
        controller.type=RHWithdrawFail;
        [self.navigationController pushViewController:controller animated:YES];
        return NO;
    }
    return YES;
}
@end
