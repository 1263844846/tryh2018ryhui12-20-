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
#import "RHMyMessageViewController.h"
#import "RHWithdrawViewController.h"
#import "RHALoginViewController.h"
#import "RHRegisterWebViewController.h"

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
    
    if (![RHUserManager sharedInterface].username) {
        self.errorLabel.text=@"您尚未登录账号";
        [self.errorButton setTitle:@"立即登录" forState:UIControlStateNormal];
    }else{
        if ([RHUserManager sharedInterface].custId) {
            self.overView.hidden=YES;
        }
    }

    
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
                [RHUserManager sharedInterface].balance=AvlBal;
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
    RHWithdrawViewController* controller=[[RHWithdrawViewController alloc] initWithNibName:@"RHWithdrawViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)pushMyMessage:(id)sender {
    RHMyMessageViewController* controller=[[RHMyMessageViewController alloc] initWithNibName:@"RHMyMessageViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)openAccount:(id)sender {
    
    UIButton * button=sender;
    if ([button.titleLabel.text isEqualToString:@"立即开户"]) {
        RHRegisterWebViewController* controller=[[RHRegisterWebViewController alloc] initWithNibName:@"RHRegisterWebViewController" bundle:nil];
        [self.navigationController pushViewController:controller animated:YES];
    }else{
        RHALoginViewController* controller=[[RHALoginViewController alloc] initWithNibName:@"RHALoginViewController" bundle:nil];
        [self.navigationController pushViewController:controller animated:YES];
    }
}
@end
