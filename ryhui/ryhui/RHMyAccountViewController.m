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
    self.scrollView.contentSize=CGSizeMake(self.scrollView.frame.size.width, 414);
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
        
        NSString* average=@"0.00";
        if (![[responseObject objectForKey:@"average"] isKindOfClass:[NSNull class]]) {
            average=[responseObject objectForKey:@"average"] ;
        }
        self.averageLabel.text=average;
        
        NSString* FrzBal=@"0.00";
        if (![[responseObject objectForKey:@"FrzBal"] isKindOfClass:[NSNull class]]) {
            FrzBal=[responseObject objectForKey:@"FrzBal"] ;
        }
        self.FrzBalLabel.text=FrzBal;
        
        NSString* AvlBal=@"0.00";
        if (![[responseObject objectForKey:@"AvlBal"] isKindOfClass:[NSNull class]]) {
            AvlBal=[responseObject objectForKey:@"AvlBal"] ;
        }
        self.balanceLabel.text=AvlBal;
        
        NSString* total=@"0.00";
        if (![[responseObject objectForKey:@"total"] isKindOfClass:[NSNull class]]) {
            total=[responseObject objectForKey:@"total"] ;
        }
        self.totalLabel.text=total;
        
        NSString* collectCapital=@"0.00";
        if (![[responseObject objectForKey:@"collectCapital"] isKindOfClass:[NSNull class]]) {
            collectCapital=[responseObject objectForKey:@"collectCapital"] ;
        }
        self.collectCapitalLabel.text=collectCapital;
        NSString* collectInterest=@"0";
        if (![[responseObject objectForKey:@"collectInterest"] isKindOfClass:[NSNull class]]) {
            collectInterest=[responseObject objectForKey:@"collectInterest"] ;
        }
        self.collectInterestLabel.text=collectInterest;
        
        NSString* collect=@"0.00";
        if (![[responseObject objectForKey:@"collect"] isKindOfClass:[NSNull class]]) {
            collect=[responseObject objectForKey:@"collect"];
        }
        self.collectPrepaymentPenaltyLabel.text=collect;
        
        NSString* earnInterest=@"0.00";
        if (![[responseObject objectForKey:@"earnInterest"] isKindOfClass:[NSNull class]]) {
            earnInterest=[responseObject objectForKey:@"earnInterest"];
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
            }else{
                self.balance=@"0";
                self.balanceLabel.text=@"0.00";
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
