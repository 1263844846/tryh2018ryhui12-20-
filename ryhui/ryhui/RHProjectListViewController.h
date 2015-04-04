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

@property(nonatomic,strong)RHSegmentContentView* segmentContentView;

@property(nonatomic,strong)NSMutableArray* viewControllers;
@property (weak, nonatomic) IBOutlet UILabel *segmentLabel;
@property (weak, nonatomic) IBOutlet UILabel *segmentLabel1;
@property (weak, nonatomic) IBOutlet UILabel *segmentLabel3;
@property (weak, nonatomic) IBOutlet UILabel *segmentLabel4;

- (IBAction)yearEarnAction:(id)sender;
- (IBAction)deadlineAction:(id)sender;
- (IBAction)totalMoneyAction:(id)sender;
- (IBAction)investmentProgressAction:(id)sender;
- (IBAction)segmentAction1:(id)sender;
- (IBAction)segmentAction2:(id)sender;
- (IBAction)pushMain:(id)sender;
- (IBAction)pushUser:(id)sender;
- (IBAction)pushMore:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *segmentView1;
@property (weak, nonatomic) IBOutlet UIView *segmentView2;

- (void)didSelectSegmentAtIndex:(int)index;
@end
