//
//  RHMyMessageViewController.h
//  ryhui
//
//  Created by 江 云龙 on 15/3/29.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHBaseViewController.h"
#import "EGORefreshTableHeaderView.h"
#import "AITableFooterVew.h"
#import "RHMyMessageDetailViewController.h"

@interface RHMyMessageViewController : RHBaseViewController<EGORefreshTableHeaderDelegate,UITableViewDataSource,UITableViewDelegate,RHMessageDetailDelegate>
{
    EGORefreshTableHeaderView *_headerView;
    AITableFooterVew *_footerView;
    BOOL _reloading;
    BOOL showLoadMoreButton;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) int currentPageIndex;
@property(nonatomic,strong)NSMutableArray* dataArray;

- (IBAction)pushMain:(id)sender;
- (IBAction)pushUser:(id)sender;
- (IBAction)pushMore:(id)sender;

-(void)updateCell:(NSDictionary*)dic;

@end
