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
    RHSLBSucceed,
    RHSLBFail,
    RHZCSLBSucceed,
    RHZCSLBFail,
    RHInvestmentchixu,
    
};

@interface RHErrorViewController : RHBaseViewController

@property (nonatomic,assign) int type;
@property (nonatomic,strong) NSString *titleStr;
@property (nonatomic,strong) NSString *tipsStr;

@property (nonatomic, assign) int errorType;

@property (weak, nonatomic) IBOutlet UIButton *xianebtn;
@property(nonatomic,copy)NSString * recongestrsec;
@property (weak, nonatomic) IBOutlet UILabel *firstlab;
@property (weak, nonatomic) IBOutlet UILabel *secondlab;
@property (weak, nonatomic) IBOutlet UILabel *threelab;

@property(nonatomic,copy)NSString * bankbackstr;

@end
