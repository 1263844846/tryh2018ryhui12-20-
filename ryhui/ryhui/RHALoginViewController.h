//
//  RHALoginViewController.h
//  ryhui
//
//  Created by stefan on 15/2/13.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHBaseViewController.h"

@interface RHALoginViewController : RHBaseViewController<UITextFieldDelegate>
@property(nonatomic,strong)NSString * str;
@property(nonatomic,assign)BOOL isForgotV;
@property(nonatomic,assign)BOOL isPan;

@end
