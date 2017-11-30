//
//  RHGesturePasswordViewController.h
//  ryhui
//
//  Created by stefan on 15/2/28.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHBaseViewController.h"
#import "RHGestureView.h"
#import "RHGesturePasswordView.h"

@interface RHGesturePasswordViewController : RHBaseViewController<VerificationDelegate,ResetDelegate,GesturePasswordDelegate,UIAlertViewDelegate>

@property(nonatomic,assign)BOOL isReset;
@property(nonatomic,assign)BOOL isRegister;
@property(nonatomic,assign)BOOL isForgotV;

@property(nonatomic,assign)BOOL isEnter;
@property(nonatomic,assign)NSString * myres;
@property (nonatomic, assign)BOOL isNotification;
@property (nonatomic, strong) NSDictionary *userInfo;

@end
