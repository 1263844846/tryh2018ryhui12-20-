//
//  RHInvestmentViewController.h
//  ryhui
//
//  Created by 江 云龙 on 15/3/18.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHBaseViewController.h"
#import "RHChooseGiftViewController.h"

@interface RHInvestmentViewController : RHBaseViewController

@property(nonatomic,strong)NSDictionary* dataDic;
@property(nonatomic,assign)int projectFund;
@property(nonatomic,assign)int panduan;
@property(nonatomic,copy)NSString * lilv;
@property(nonatomic,assign)BOOL newpeople;

@property(nonatomic,copy)NSString * everyoneEndAmountstr;


@property(nonatomic,copy)NSString *xmjres;

@property(nonatomic,copy)NSString *xmjid;

@property(nonatomic,copy)NSString * xmjfirst;
@end
