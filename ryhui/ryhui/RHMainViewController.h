//
//  RHMainViewController.h
//  ryhui
//
//  Created by stefan on 15/2/28.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHBaseViewController.h"
#import "RHSegmentView.h"

@interface RHMainViewController : RHBaseViewController<RHSegmentControlDelegate,UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *headerScrollView;
@property (strong, nonatomic) IBOutlet UIView *headerView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong)NSMutableArray* segment1Array;
@property (nonatomic,strong)NSMutableArray* segment2Array;
@property (nonatomic,strong)NSMutableArray* dataArray;
@property (nonatomic,strong)RHSegmentView* segmentView;
@property (nonatomic,strong)NSString* type;
- (IBAction)pushUserCenter:(id)sender;
- (IBAction)pushMore:(id)sender;
@end
