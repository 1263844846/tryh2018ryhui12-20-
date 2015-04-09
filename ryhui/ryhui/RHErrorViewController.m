//
//  RHErrorViewController.m
//  ryhui
//
//  Created by 江 云龙 on 15/3/30.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHErrorViewController.h"
#import "RHProjectListViewController.h"
#import "RHMyAccountViewController.h"

@interface RHErrorViewController ()

@end

@implementation RHErrorViewController
@synthesize type;
@synthesize tipsStr;
@synthesize titleStr;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configBackButton];
    switch (type) {
        case RHInvestmentSucceed:
            [self configTitleWithString:@"投资成功"];
            [self succeed];
            break;
        case RHPaySucceed:
            [self configTitleWithString:@"充值成功"];
            [self succeed];
            break;
        case RHWithdrawSucceed:
            [self configTitleWithString:@"提现成功"];
            [self succeed];
            break;
        case RHInvestmentFail:
            [self configTitleWithString:@"投资失败"];
            [self fail];
            break;
        case RHPayFail:
            [self configTitleWithString:@"充值失败"];
            [self fail];
            break;
        case RHWithdrawFail:
            [self configTitleWithString:@"提现失败"];
            [self fail];
            break;
        default:
            break;
    }
    
    
    self.titleLabel.text=titleStr;
    self.tipsLabel.text=tipsStr;
}
-(void)succeed
{
    self.errorImageView.image=[UIImage imageNamed:@"error1.png"];
    self.titleLabel.textColor=[RHUtility colorForHex:@"#ff5d25"];
    self.tipsLabel.textColor=[RHUtility colorForHex:@"#989898"];
}

-(void)fail
{
    self.errorImageView.image=[UIImage imageNamed:@"error2.png"];
    self.titleLabel.textColor=[RHUtility colorForHex:@"#40b5b8"];
    self.tipsLabel.textColor=[RHUtility colorForHex:@"#989898"];
}

-(void)back
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)pushProjectList:(id)sender {
    RHProjectListViewController* controller=[[RHProjectListViewController alloc]initWithNibName:@"RHProjectListViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)pushMyAccount:(id)sender {
    
    [[RHTabbarManager sharedInterface] selectTabbarMain];
    
}
@end
