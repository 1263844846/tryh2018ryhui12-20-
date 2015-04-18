//
//  RHInvestDetailViewController.h
//  ryhui
//
//  Created by jufenghudong on 15/4/9.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHBaseViewController.h"
#import "EGORefreshTableHeaderView.h"
#import "AITableFooterVew.h"

@interface RHInvestDetailViewController : RHBaseViewController<EGORefreshTableHeaderDelegate>
{
    EGORefreshTableHeaderView *_headerView;
    AITableFooterVew *_footerView;
    BOOL _reloading;
    BOOL showLoadMoreButton;
}
@property (nonatomic, assign) int currentPageIndex;
@property(nonatomic,strong)NSMutableArray* dataArray;
@property  (nonatomic,strong)NSString* projectId;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end
