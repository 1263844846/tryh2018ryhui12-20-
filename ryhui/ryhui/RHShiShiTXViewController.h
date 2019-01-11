//
//  RHShiShiTXViewController.h
//  ryhui
//
//  Created by 糊涂虫 on 17/8/14.
//  Copyright © 2017年 stefan. All rights reserved.
//

#import "RHBaseViewController.h"
typedef void (^DeBlock)();
typedef void (^SQBlock)();

@interface RHShiShiTXViewController : RHBaseViewController
@property(nonatomic,strong)NSDictionary *bankdic;
@property(nonatomic,strong)UINavigationController *nav;
@property(nonatomic,copy)DeBlock mydeblock;
@property(nonatomic,assign)CGFloat today;
@property(nonatomic,copy)NSString *smallmoney;

@property(nonatomic,copy)SQBlock sqblock;

@property(nonatomic,copy)NSString *sqswitch;
-(void)rebsfirst;
-(void)moneyrebsfirst;
@end
