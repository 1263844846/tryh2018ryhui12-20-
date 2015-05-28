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

@property (nonatomic,assign) int type;
@property (nonatomic,strong) NSString *titleStr;
@property (nonatomic,strong) NSString *tipsStr;

@end
