//
//  RHRegisterAgreenWebViewController.m
//  ryhui
//
//  Created by jufenghudong on 15/4/9.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHRegisterAgreenWebViewController.h"

@interface RHRegisterAgreenWebViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation RHRegisterAgreenWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configBackButton];
    [self configTitleWithString:@"《融益汇用户协议》"];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@regProtocol",[RHNetworkService instance].doMain]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url];
    [request setHTTPMethod:@"GET"];
    [self.webView loadRequest: request];
}

@end
