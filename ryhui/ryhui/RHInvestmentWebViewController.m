//
//  RHInvestmentWebViewController.m
//  ryhui
//
//  Created by 江 云龙 on 15/3/18.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHInvestmentWebViewController.h"

@interface RHInvestmentWebViewController ()

@end

@implementation RHInvestmentWebViewController
@synthesize projectId;
@synthesize price;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configBackButton];
    [self configTitleWithString:@"投资"];
    
    NSURL *url = [NSURL URLWithString: @"http://www.ryhui.com/common/main/invest"];
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


@end
