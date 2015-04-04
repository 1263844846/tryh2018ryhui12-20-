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

@interface RHInvestmentWebViewController ()

@end

@implementation RHInvestmentWebViewController
@synthesize projectId;
@synthesize price;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configBackButton];
    [self configTitleWithString:@"投资"];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@common/main/invest",[RHNetworkService instance].doMain]];
    NSString *body = [NSString stringWithFormat: @"money=%@&projectId=%@",price,projectId];
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
    if ([url containsString:[NSString stringWithFormat:@"%@common/paymentResponse/initiativeTenderSuccess",[RHNetworkService instance].doMainhttp]]) {
        RHErrorViewController* controller=[[RHErrorViewController alloc]initWithNibName:@"RHErrorViewController" bundle:nil];
        controller.titleStr=[NSString stringWithFormat:@"投资金额%@元",price];
        controller.tipsStr=@"赚钱别忘告诉其他小伙伴哦~";
        controller.type=RHInvestmentSucceed;
        [self.navigationController pushViewController:controller animated:YES];
        
        return NO;
    }
    if ([url containsString:[NSString stringWithFormat:@"%@common/paymentResponse/initiativeTenderFailed",[RHNetworkService instance].doMainhttp]]) {
        
        RHErrorViewController* controller=[[RHErrorViewController alloc]initWithNibName:@"RHErrorViewController" bundle:nil];
        controller.titleStr=@"投资失败";
        controller.tipsStr=@"0";
        controller.type=RHInvestmentFail;
        [self.navigationController pushViewController:controller animated:YES];
        return NO;
    }
    return YES;
}
@end
