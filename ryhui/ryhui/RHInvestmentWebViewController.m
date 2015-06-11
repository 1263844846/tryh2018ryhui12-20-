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

@interface RHInvestmentWebViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation RHInvestmentWebViewController
@synthesize projectId;
@synthesize price;
@synthesize giftId;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configBackButton];
    [self configTitleWithString:@"投资"];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@common/main/invest",[RHNetworkService instance].doMain]];
    NSString *body = [NSString stringWithFormat: @"money=%@&projectId=%@&giftId=%@&investType=App",price,projectId,giftId?giftId:@""];
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

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString* url=[request.URL absoluteString];
//    DLog(@"%@",url);

    if ([url rangeOfString:@"common/paymentResponse/initiativeTenderSuccess"].location!=NSNotFound) {
        RHErrorViewController* controller=[[RHErrorViewController alloc]initWithNibName:@"RHErrorViewController" bundle:nil];
        controller.titleStr=[NSString stringWithFormat:@"投资金额%@元",price];
        controller.tipsStr=@"赚钱别忘告诉其他小伙伴哦~";
        controller.type=RHInvestmentSucceed;
        [self.navigationController pushViewController:controller animated:YES];
        
        return NO;
    }
    if ([url rangeOfString:@"common/paymentResponse/initiativeTenderFailed"].location!=NSNotFound) {
//        DLog(@"%@",url);
        RHErrorViewController* controller=[[RHErrorViewController alloc]initWithNibName:@"RHErrorViewController" bundle:nil];
        controller.titleStr=@"投资失败";
        NSArray* array=[url componentsSeparatedByString:@"&result="];
        if ([array count]>1) {
            controller.tipsStr=[[[array objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }
        controller.type=RHInvestmentFail;
        [self.navigationController pushViewController:controller animated:YES];
        return NO;
    }
    return YES;
}
@end
