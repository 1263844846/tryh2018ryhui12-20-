//
//  RHMyAccountViewController.m
//  ryhui
//
//  Created by stefan on 15/3/15.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHMyAccountViewController.h"

@interface RHMyAccountViewController ()

@end

@implementation RHMyAccountViewController
@synthesize balance;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configBackButton];
    [self configTitleWithString:@"我的账户"];
    [self getMyAccountData];
    [self checkout];
}
//average = "9.35";
//collectCapital = 241400;
//collectInterest = "91720.75";
//collectPrepaymentPenalty = 0;
//earnInterest = "92289.23";
//earnPenaltyInterest = "2914.46";
//earnPrepaymentPenalty = 600;
//myAccount = 1;

-(void)getMyAccountData
{
    [[RHNetworkService instance] POST:@"front/payment/account/myAccountData" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"%@",responseObject);
        self.averageLabel.text=[[responseObject objectForKey:@"average"] stringValue];
        NSString* collectCapital=@"0";
        if (![[responseObject objectForKey:@"collectCapital"] isKindOfClass:[NSNull class]]) {
            collectCapital=[[responseObject objectForKey:@"collectCapital"] stringValue];
        }
        self.collectCapitalLabel.text=collectCapital;
        NSString* collectInterest=@"0";
        if (![[responseObject objectForKey:@"collectInterest"] isKindOfClass:[NSNull class]]) {
            collectInterest=[[responseObject objectForKey:@"collectInterest"] stringValue];
        }
        self.collectInterestLabel.text=collectInterest;
        
        NSString* collectPrepaymentPenalty=@"0";
        if (![[responseObject objectForKey:@"collectPrepaymentPenalty"] isKindOfClass:[NSNull class]]) {
            collectPrepaymentPenalty=[[responseObject objectForKey:@"collectPrepaymentPenalty"] stringValue];
        }
        self.collectPrepaymentPenaltyLabel.text=collectPrepaymentPenalty;
        
        NSString* earnInterest=@"0";
        if (![[responseObject objectForKey:@"earnInterest"] isKindOfClass:[NSNull class]]) {
            earnInterest=[[responseObject objectForKey:@"earnInterest"] stringValue];
        }
        self.earnInterestLabel.text=earnInterest;
                
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"%@",error);
    }];
}

- (void)checkout
{
    [[RHNetworkService instance] POST:@"front/payment/account/queryBalance" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSString* AvlBal=[responseObject objectForKey:@"AvlBal"];
            if (AvlBal&&[AvlBal length]>0) {
                self.balance=AvlBal;
                self.balanceLabel.text=AvlBal;
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"%@",error);
    }];
}

- (IBAction)pushMain:(id)sender {
    [[RHTabbarManager sharedInterface] selectTabbarMain];
}

- (IBAction)pushUser:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)pushMore:(id)sender {
    [[RHTabbarManager sharedInterface] selectTabbarMore];
}
- (IBAction)pushPay:(id)sender {
    
    RHRechargeViewController* controller=[[RHRechargeViewController alloc]initWithNibName:@"RHRechargeViewController" bundle:nil];
    controller.balance=self.balance;
    [self.navigationController pushViewController:controller animated:YES];
}
@end
