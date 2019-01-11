//
//  RHPLViewController.h
//  ryhui
//
//  Created by 糊涂虫 on 2018/4/18.
//  Copyright © 2018年 stefan. All rights reserved.
//

#import "RHBaseViewController.h"

typedef void(^myblock)() ;

@interface RHPLViewController : RHBaseViewController
@property(nonatomic,copy)NSString * projectid;
@property(nonatomic,strong)UINavigationController *nav;
@property(nonatomic,copy)myblock myblock;

@end
