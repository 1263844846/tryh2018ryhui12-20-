//
//  RHBankListViewController.m
//  ryhui
//
//  Created by jufenghudong on 15/4/17.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHBankListViewController.h"

@interface RHBankListViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation RHBankListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configBackButton];
    [self configTitleWithString:@"支持银行限额"];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@bindKJCard",[RHNetworkService instance].doMain]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url];
    
    [self.webView loadRequest: request];
}

@end
