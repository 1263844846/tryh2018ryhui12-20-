//
//  RHWithdrawWebViewController.m
//  ryhui
//
//  Created by 江 云龙 on 15/3/29.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHWithdrawWebViewController.h"

@interface RHWithdrawWebViewController ()

@end

@implementation RHWithdrawWebViewController
@synthesize amount;
@synthesize captcha;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configBackButton];
    [self configTitleWithString:@"提现"];
    
    NSURL *url = [NSURL URLWithString: @"http://www.ryhui.com/common/main/invest"];
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



@end
