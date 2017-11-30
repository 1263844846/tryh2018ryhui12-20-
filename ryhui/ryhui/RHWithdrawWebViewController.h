//
//  RHWithdrawWebViewController.h
//  ryhui
//
//  Created by 江 云龙 on 15/3/29.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHBaseViewController.h"

@interface RHWithdrawWebViewController : RHBaseViewController<UIWebViewDelegate>

@property(nonatomic,strong)NSString *captcha;
@property(nonatomic,strong)NSString *amount;
@property(nonatomic,strong)NSString * category;
@property(nonatomic,strong)NSString * bankcard;
@property(nonatomic,strong)NSString * cardBankCnaps;

@end
