//
//  RHNEWpeopleViewController.h
//  ryhui
//
//  Created by 糊涂虫 on 16/11/3.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import "RHBaseViewController.h"

@interface RHNEWpeopleViewController : RHBaseViewController
@property(nonatomic,strong)NSString* getType;
@property(nonatomic,strong)NSDictionary* dataDic;

@property(nonatomic,assign)int panduan;

@property(nonatomic,strong)NSString * lilv;

@property(nonatomic,copy)NSString * zhaungtaistr;
@property(nonatomic,strong)NSString* projectId;
@property(nonatomic,copy)NSString * judge;
@end
