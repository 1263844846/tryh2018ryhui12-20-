//
//  RHTradingViewController.h
//  ryhui
//
//  Created by stefan on 15/3/15.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHBaseViewController.h"
#import "EGORefreshTableHeaderView.h"
#import "AITableFooterVew.h"

@interface RHTradingViewController : RHBaseViewController<EGORefreshTableHeaderDelegate>
{
    EGORefreshTableHeaderView *_headerView;
    AITableFooterVew *_footerView;
    BOOL _reloading;
    BOOL showLoadMoreButton;
}
@property (nonatomic, assign) int currentPageIndex;
@property(nonatomic,strong)NSMutableArray* dataArray;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)pushMain:(id)sender;

- (IBAction)pushUser:(id)sender;
- (IBAction)pushMore:(id)sender;
@end
