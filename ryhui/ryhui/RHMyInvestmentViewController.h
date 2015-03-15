//
//  RHMyInvestmentViewController.h
//  ryhui
//
//  Created by stefan on 15/3/15.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHBaseViewController.h"

@interface RHMyInvestmentViewController : RHBaseViewController

@property (nonatomic,strong)NSMutableArray* dataArray;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIView *segmentView1;
@property (weak, nonatomic) IBOutlet UIView *segmentView2;
@property (weak, nonatomic) IBOutlet UIView *segmentView3;
- (IBAction)segmentAction1:(id)sender;
- (IBAction)segmentAction2:(id)sender;
- (IBAction)segmentAction3:(id)sender;

- (IBAction)pushMain:(id)sender;

- (IBAction)pushUser:(id)sender;
- (IBAction)pushMore:(id)sender;

@end
