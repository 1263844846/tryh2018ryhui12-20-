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

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation RHWithdrawWebViewController
@synthesize amount;
@synthesize captcha;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configBackButton];
    [self configTitleWithString:@"提现"];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@front/payment/account/cash",[RHNetworkService instance].doMain]];
    NSString *body = [NSString stringWithFormat: @"money=%@&captcha=%@",amount,captcha];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url];
    [request setHTTPMethod: @"POST"];
    NSString* session = [[NSUserDefaults standardUserDefaults] objectForKey:@"RHSESSION"];
    if (session && [session length] > 0) {
        [request setValue:session forHTTPHeaderField:@"cookie"];
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
    if ([url rangeOfString:@"common/paymentResponse/cashClientBackSuccess"].location != NSNotFound) {
        RHErrorViewController *controller = [[RHErrorViewController alloc]initWithNibName:@"RHErrorViewController" bundle:nil];
        controller.titleStr = [NSString stringWithFormat:@"申请提现金额%@元",amount];
        controller.tipsStr = @"资金预计于审核后T+1个工作日到账";
        controller.type = RHWithdrawSucceed;
        [self.navigationController pushViewController:controller animated:YES];

        return NO;
    }
    if ([url rangeOfString:@"common/paymentResponse/cashClientBackFailed"].location != NSNotFound) {
        
        RHErrorViewController *controller = [[RHErrorViewController alloc]initWithNibName:@"RHErrorViewController" bundle:nil];
        controller.titleStr = @"失败";
        NSArray* array = nil;
        if ([url rangeOfString:@"&RespDesc"].location != NSNotFound) {
            array = [url componentsSeparatedByString:@"&RespDesc="];
        }
        if ([url rangeOfString:@"&result="].location != NSNotFound) {
            array = [url componentsSeparatedByString:@"&result="];
        }
        if ([array count] > 1) {
            controller.tipsStr = [[[array objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }
        controller.type = RHWithdrawFail;
        [self.navigationController pushViewController:controller animated:YES];
        return NO;
    }
    return YES;
}

@end
