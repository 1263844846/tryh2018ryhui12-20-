//
//  RHMyMessageDetailViewController.m
//  ryhui
//
//  Created by jufenghudong on 15/4/12.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHMyMessageDetailViewController.h"

@interface RHMyMessageDetailViewController ()

@end

@implementation RHMyMessageDetailViewController
@synthesize ids;
@synthesize titleStr;
@synthesize contentStr;
@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configBackButton];
    
    [self configTitleWithString:@"我的消息"];
    
    self.titleLabel.text=titleStr;
    self.contentLabel.text=contentStr;
    NSDictionary* parameters=[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"[%@]",ids],@"ids", nil];
    AFHTTPRequestOperationManager* manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[[AFCompoundResponseSerializer alloc]init];
    [manager POST:[NSString stringWithFormat:@"%@front/payment/account/markMessageReaded",[RHNetworkService instance].doMain] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        DLog(@"result==%@ <<<",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        NSString* result=[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSRange range=[result rangeOfString:@"success"];
        if (range.location!=NSNotFound) {
            [delegate refresh];

        }
    
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        DLog(@"%@",error);
    }];
}


- (IBAction)pushMain:(id)sender {
    [[[RHTabbarManager sharedInterface] selectTabbarMain] popToRootViewControllerAnimated:NO];
}

- (IBAction)pushUser:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)pushMore:(id)sender {
    [[[RHTabbarManager sharedInterface] selectTabbarMore] popToRootViewControllerAnimated:NO];
}

@end
