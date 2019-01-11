//
//  RHMyInvestmentViewController.h
//  ryhui
//
//  Created by stefan on 15/3/15.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHBaseViewController.h"
#import "RHSegmentContentView.h"

@interface RHMyInvestmentViewController : RHBaseViewController<RHSegmentContentViewDelegate>

@property(nonatomic,assign)UINavigationController *nav;
@property(nonatomic,copy)NSString *resstr;
@end
