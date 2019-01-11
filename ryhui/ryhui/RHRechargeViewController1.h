//
//  RHRechargeViewController.h
//  ryhui
//
//  Created by stefan on 15/3/15.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHBaseViewController.h"

@interface RHRechargeViewController1 : RHBaseViewController<UITextFieldDelegate>

@property(nonatomic,strong)NSString* balance;
@property(nonatomic,strong)NSDictionary *bankdic;
@property(nonatomic,copy)NSString * bankress;
@end
