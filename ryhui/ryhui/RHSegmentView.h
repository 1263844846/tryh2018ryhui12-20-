//
//  RHSegmentView.h
//  ryhui
//
//  Created by stefan on 15/3/14.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RHSegmentControlDelegate <NSObject>

- (void)didSelectSegmentAtIndex:(int)index;
-(void)didSelectInvestment;

@end

@interface RHSegmentView : UIView

@property (weak, nonatomic) IBOutlet UILabel *segmentLabel;
@property (weak, nonatomic) IBOutlet UILabel *segmentLabel1;
@property (weak, nonatomic) IBOutlet UILabel *segmentLabel3;
@property (weak, nonatomic) IBOutlet UILabel *segmentLabel4;
@property (weak, nonatomic) IBOutlet UIView *segmentView1;
@property (weak, nonatomic) IBOutlet UIView *segmentView2;
@property (nonatomic, assign) int selectedIndex;
@property (nonatomic, assign) id<RHSegmentControlDelegate> delegate;

-(void)initData;
- (void)hidd;
- (void)hiddd;
@end
