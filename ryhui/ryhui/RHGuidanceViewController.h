//
//  RHGuidanceViewController.h
//  ryhui
//
//  Created by 江 云龙 on 15/3/17.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RHSegmentContentView.h"

@interface RHGuidanceViewController : UIViewController<RHSegmentContentViewDelegate>

@property(nonatomic,strong)RHSegmentContentView* segmentContentView;
@property(nonatomic,strong)NSMutableArray* views;

@end
