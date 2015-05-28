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
#import "RHMyInvestmentViewController.h"

@interface RHErrorViewController ()

@property (weak, nonatomic) IBOutlet UIButton *secButton;
@property (weak, nonatomic) IBOutlet UIView *errorView;
@property (weak, nonatomic) IBOutlet UIImageView *errorImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipsLabel;

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
            [self myInvestMent];
            break;
        case RHPaySucceed:
            [self configTitleWithString:@"充值成功"];
            [self succeed];
            [self myAccount];
            break;
        case RHWithdrawSucceed:
            [self configTitleWithString:@"提现成功"];
            [self succeed];
            [self myAccount];
            break;
        case RHInvestmentFail:
            [self configTitleWithString:@"投资失败"];
            [self fail];
            [self myInvestMent];
            break;
        case RHPayFail:
            [self configTitleWithString:@"充值失败"];
            [self fail];
            [self myAccount];
            break;
        case RHWithdrawFail:
            [self configTitleWithString:@"提现失败"];
            [self fail];
            [self myAccount];
            break;
        default:
            break;
    }

    CGRect tipsRect = self.tipsLabel.frame;
    tipsRect.size.height = [tipsStr sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(204, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping].height;
    self.tipsLabel.frame = tipsRect;
    
    CGRect errorRect = self.errorImageView.frame;
    errorRect.origin.x = (239 - (50 + 7 + [titleStr sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(MAXFLOAT, 21) lineBreakMode:NSLineBreakByCharWrapping].width))/2.0;
    self.errorImageView.frame = errorRect;
    
    CGRect titleRect = self.titleLabel.frame;
    titleRect.origin.x = self.errorImageView.frame.origin.x+50+7;
    self.titleLabel.frame = titleRect;
    
    self.titleLabel.text = titleStr;
    self.tipsLabel.text = tipsStr;
}

- (void)succeed {
    self.errorImageView.image = [UIImage imageNamed:@"error1.png"];
    self.titleLabel.textColor = [RHUtility colorForHex:@"#ff5d25"];
    self.tipsLabel.textColor = [RHUtility colorForHex:@"#989898"];
}

- (void)fail {
    self.errorImageView.image = [UIImage imageNamed:@"error2.png"];
    self.titleLabel.textColor = [RHUtility colorForHex:@"#40b5b8"];
    self.tipsLabel.textColor = [RHUtility colorForHex:@"#989898"];
}

-(void)myInvestMent {
    [self.secButton setTitle:@"我的投资" forState:UIControlStateNormal];
    _secButton.tag = 10;
    [self.secButton addTarget:self action:@selector(pushMyAccount:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)myAccount {
    [self.secButton setTitle:@"我的账户" forState:UIControlStateNormal];
    _secButton.tag = 20;
    [self.secButton addTarget:self action:@selector(pushMyAccount:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pushProjectList:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:NO];
    UINavigationController* nav = [[RHTabbarManager sharedInterface] selectTabbarMain];
    RHProjectListViewController *controller = [[RHProjectListViewController alloc]initWithNibName:@"RHProjectListViewController" bundle:nil];
    controller.type = @"0";
    [nav pushViewController:controller animated:YES];
}

- (void)pushMyAccount:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:NO];
    UINavigationController* nav = [[RHTabbarManager sharedInterface] selectTabbarUser];
    UIViewController *controller;
    if (sender.tag == 10) {
        controller = [[RHMyInvestmentViewController alloc] initWithNibName:@"RHMyInvestmentViewController" bundle:nil];
    } else {
        controller = [[RHMyAccountViewController alloc]initWithNibName:@"RHMyAccountViewController" bundle:nil];
    }
    [nav pushViewController:controller animated:YES];
}

@end
