//
//  RHDaETXViewController.h
//  ryhui
//
//  Created by 糊涂虫 on 17/8/14.
//  Copyright © 2017年 stefan. All rights reserved.
//

#import "RHBaseViewController.h"
typedef void (^SQBlock)();
@interface RHDaETXViewController : RHBaseViewController
@property(nonatomic,strong)UINavigationController *nav;
@property(nonatomic,strong)NSDictionary *bankdic;
@property(nonatomic,assign)CGFloat today;
@property(nonatomic,copy)NSString * lhcstr;
@property(nonatomic,copy)NSString *smallmoney;
@property(nonatomic,copy)SQBlock sqblock;

@property(nonatomic,copy)NSString *sqswitch;
-(void)rebsfirst;
-(void)moneyrebsfirst;
@end
