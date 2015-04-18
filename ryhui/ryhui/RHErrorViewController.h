//
//  RHErrorViewController.h
//  ryhui
//
//  Created by 江 云龙 on 15/3/30.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHBaseViewController.h"
enum{
    RHInvestmentSucceed,
    RHInvestmentFail,
    RHPaySucceed,
    RHPayFail,
    RHWithdrawSucceed,
    RHWithdrawFail,
};

@interface RHErrorViewController : RHBaseViewController
@property (weak, nonatomic) IBOutlet UIButton *secButton;

@property (weak, nonatomic) IBOutlet UIView *errorView;
@property (weak, nonatomic) IBOutlet UIImageView *errorImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipsLabel;
@property (nonatomic,assign) int type;
@property (nonatomic,strong) NSString* titleStr;
@property (nonatomic,strong) NSString* tipsStr;

- (IBAction)pushProjectList:(id)sender;
- (IBAction)pushMyAccount:(id)sender;
@end
