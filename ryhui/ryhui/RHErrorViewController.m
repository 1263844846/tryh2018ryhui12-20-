//
//  RHErrorViewController.m
//  ryhui
//
//  Created by 江 云龙 on 15/3/30.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHErrorViewController.h"

@interface RHErrorViewController ()

@end

@implementation RHErrorViewController
@synthesize type;
@synthesize tipsStr;
@synthesize titleStr;

- (void)viewDidLoad {
    [super viewDidLoad];
    switch (type) {
        case RHInvestmentSucceed:
        case RHPaySucceed:
        case RHWithdrawSucceed:
            self.errorImageView.image=[UIImage imageNamed:@"error1.png"];
            self.titleLabel.textColor=[RHUtility colorForHex:@"#ff5d25"];
            self.tipsLabel.textColor=[RHUtility colorForHex:@"#989898"];
            break;
        case RHInvestmentFail:
        case RHPayFail:
        case RHWithdrawFail:
            self.errorImageView.image=[UIImage imageNamed:@"error2.png"];
            self.titleLabel.textColor=[RHUtility colorForHex:@"#40b5b8"];
            self.tipsLabel.textColor=[RHUtility colorForHex:@"#989898"];
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)pushProjectList:(id)sender {
}

- (IBAction)pushMyAccount:(id)sender {
}
@end
