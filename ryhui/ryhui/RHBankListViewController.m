//
//  RHBankListViewController.m
//  ryhui
//
//  Created by jufenghudong on 15/4/17.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHBankListViewController.h"

@interface RHBankListViewController ()

@end

@implementation RHBankListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configBackButton];
    [self configTitleWithString:@"绑卡"];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@bindKJCard",[RHNetworkService instance].doMain]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url];
    
    [self.webView loadRequest: request];
}

@end
