//
//  RHUserCenterMainViewController.m
//  ryhui
//
//  Created by stefan on 15/3/15.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHUserCenterMainViewController.h"
#import "RHUserCenterViewController.h"
#import "RHMyAccountViewController.h"
#import "RHTradingViewController.h"
#import "RHMyInvestmentViewController.h"
#import "RHRechargeViewController.h"

@interface RHUserCenterMainViewController ()

@end

@implementation RHUserCenterMainViewController
@synthesize balance;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configTitleWithString:@"个人中心"];
    self.username.text=[RHUserManager sharedInterface].username;
    self.ryUsername.text=[NSString stringWithFormat:@"ryh_%@",[RHUserManager sharedInterface].username];
    [self checkout];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkout) name:@"RHSELECTUSER" object:nil];
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"RHSELECTUSER" object:nil];
}

- (void)checkout
{
    [[RHNetworkService instance] POST:@"front/payment/account/queryBalance" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSString* AvlBal=[responseObject objectForKey:@"AvlBal"];
            if (AvlBal&&[AvlBal length]>0) {
                self.balance=AvlBal;
                self.balanceLabel.text=[NSString stringWithFormat:@"可用余额%@元",AvlBal];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"%@",error);
    }];
}

- (IBAction)pushAccountInfo:(id)sender {
    
    RHUserCenterViewController* controller=[[RHUserCenterViewController alloc]initWithNibName:@"RHUserCenterViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)pushMyAccount:(id)sender {
    RHMyAccountViewController* controller=[[RHMyAccountViewController alloc]initWithNibName:@"RHMyAccountViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)pushTradingRecord:(id)sender {
    RHTradingViewController* controller=[[RHTradingViewController alloc]initWithNibName:@"RHTradingViewController" bundle:nil];
    
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)pushMyInvestment:(id)sender {
    RHMyInvestmentViewController* controller=[[RHMyInvestmentViewController alloc]initWithNibName:@"RHMyInvestmentViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)pushMain:(id)sender {
    [[RHTabbarManager sharedInterface] selectTabbarMain];
}

- (IBAction)pushUser:(id)sender {
}

- (IBAction)pushMore:(id)sender {
    [[RHTabbarManager sharedInterface] selectTabbarMore];
}

- (IBAction)pushPay:(id)sender {
    
    RHRechargeViewController* controller=[[RHRechargeViewController alloc]initWithNibName:@"RHRechargeViewController" bundle:nil];
    controller.balance=self.balance;
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)extractPayment:(id)sender {
}

@end
