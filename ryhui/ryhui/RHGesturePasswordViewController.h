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

@interface RHGesturePasswordViewController : RHBaseViewController<VerificationDelegate,ResetDelegate,GesturePasswordDelegate>

- (void)clear;

- (BOOL)exist;


@end
