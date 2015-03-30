//
//  RHBindCardWebViewController.m
//  ryhui
//
//  Created by 江 云龙 on 15/3/30.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHBindCardWebViewController.h"
#import "MBProgressHUD.h"

@interface RHBindCardWebViewController ()

@end

@implementation RHBindCardWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configBackButton];
    [self configTitleWithString:@"绑卡"];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@front/payment/account/bindCard",[RHNetworkService instance].doMain]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url];
    [request setHTTPMethod: @"POST"];
    NSString* session=[[NSUserDefaults standardUserDefaults] objectForKey:@"RHSESSION"];
    if (session&&[session length]>0) {
        [request setValue:session forHTTPHeaderField:@"cookie"];
    }
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

//-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
//{
//    NSString* url=[request.URL absoluteString];
//    if ([url isEqualToString:[NSString stringWithFormat:@"%@common/paymentResponse/cashClientBackSuccess",[RHNetworkService instance].doMain]]) {
//        
//        return NO;
//    }
//    if ([url isEqualToString:[NSString stringWithFormat:@"%@common/paymentResponse/cashClientBackFailed",[RHNetworkService instance].doMain]]) {
//        
//        return NO;
//    }
//    return YES;
//}

@end
