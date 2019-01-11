//
//  RHKHBankCardViewController.h
//  ryhui
//
//  Created by 糊涂虫 on 17/8/16.
//  Copyright © 2017年 stefan. All rights reserved.
//

#import "RHBaseViewController.h"
typedef void (^bankBlock)(NSString *showText,NSString* bankstr);
@interface RHKHBankCardViewController : RHBaseViewController
@property(nonatomic,copy)bankBlock bankblock;
@end
