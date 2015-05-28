//
//  RHProjectListViewController.h
//  ryhui
//
//  Created by 江 云龙 on 15/3/17.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHBaseViewController.h"
#import "RHSegmentContentView.h"

@interface RHProjectListViewController : RHBaseViewController<RHSegmentContentViewDelegate>

@property(nonatomic,strong)NSString* type;

@end
