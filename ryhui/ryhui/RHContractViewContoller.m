//
//  RHContractViewContoller.m
//  ryhui
//
//  Created by 江 云龙 on 15/3/30.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHContractViewContoller.h"

@interface RHContractViewContoller ()

@end

@implementation RHContractViewContoller
@synthesize isAgreen;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configBackButton];
    NSURL *url = nil;
    if (isAgreen) {
        [self configTitleWithString:@"借款协议"];
        url=[NSURL URLWithString:[NSString stringWithFormat:@"%@front/payment/agreement/agreementInvestorApp?projectId=256&userId=89",[RHNetworkService instance].doMain]];
    }else{
        [self configTitleWithString:@"合同"];
        url=[NSURL URLWithString:[NSString stringWithFormat:@"%@front/payment/agreement/agreementInvestor?projectId=%@&userId=%@",[RHNetworkService instance].doMain,self.projectId,[RHUserManager sharedInterface].userId]];
    }
    
    [NSURL URLWithString:[NSString stringWithFormat:@"%@front/payment/agreement/agreementInvestor?projectId=%@&userId=%@",[RHNetworkService instance].doMain,self.projectId,[RHUserManager sharedInterface].userId]];

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url];
    [request setHTTPMethod: @"POST"];
    NSString* session=[[NSUserDefaults standardUserDefaults] objectForKey:@"RHSESSION"];
    if (session&&[session length]>0) {
        [request setValue:session forHTTPHeaderField:@"cookie"];
    }
    [self.webView loadRequest: request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
