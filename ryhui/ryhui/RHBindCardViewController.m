//
//  RHBindCardViewController.m
//  ryhui
//
//  Created by jufenghudong on 15/4/12.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHBindCardViewController.h"
#import "RHRechargeWebViewController.h"
#import "RHBankListViewController.h"

@interface RHBindCardViewController ()

@end

@implementation RHBindCardViewController
@synthesize amountStr;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configBackButton];
    [self configTitleWithString:@"绑定快捷卡"];
    self.amountLabel.text=amountStr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (IBAction)bindAction:(id)sender {
    RHRechargeWebViewController* controllers=[[RHRechargeWebViewController alloc]initWithNibName:@"RHRegisterWebViewController" bundle:nil];
    controllers.price=amountStr;
    [self.navigationController pushViewController:controllers animated:YES];

}

- (IBAction)pushBankList:(id)sender {
    RHBankListViewController* controllers=[[RHBankListViewController alloc]initWithNibName:@"RHBankListViewController" bundle:nil];
    [self.navigationController pushViewController:controllers animated:YES];
}
@end
