//
//  RHWithdrawViewController.h
//  ryhui
//
//  Created by 江 云龙 on 15/3/29.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHBaseViewController.h"

@interface RHWithdrawViewController : RHBaseViewController<UITextFieldDelegate,RHSegmentControlDelegate>
@property(nonatomic,strong)NSDictionary *bankdic;
- (void)getWithdrawData;
@property(nonatomic,copy)NSString * myswitch;
@end
