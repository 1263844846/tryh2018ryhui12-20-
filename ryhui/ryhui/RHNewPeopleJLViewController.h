//
//  RHNewPeopleJLViewController.h
//  ryhui
//
//  Created by 糊涂虫 on 16/10/27.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import "RHBaseViewController.h"

@interface RHNewPeopleJLViewController : RHBaseViewController

@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,copy)NSString * projectid;
@property(nonatomic,copy)NSString * type;
@property(nonatomic,strong)NSDictionary * datadic;
@property(nonatomic,strong)UINavigationController *nav;
@property(nonatomic,copy)NSString * nhstr;
@property(nonatomic,copy)NSString * mouthstr;
@end
