//
//  RHRechargeViewController.m
//  ryhui
//
//  Created by stefan on 15/3/15.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHRechargeViewController.h"
#import "RHRechargeWebViewController.h"

@interface RHRechargeViewController ()

@end

@implementation RHRechargeViewController
@synthesize balance;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configBackButton];
    
    [self configTitleWithString:@"充值"];
    [self.textField becomeFirstResponder];
    
    self.balanceLabel.text=balance;
    
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

- (IBAction)recharge:(id)sender {
    
    RHRechargeWebViewController* controllers=[[RHRechargeWebViewController alloc]initWithNibName:@"RHRegisterWebViewController" bundle:nil];
    controllers.price=self.textField.text;
    [self.navigationController pushViewController:controllers animated:YES];
    
}
@end
