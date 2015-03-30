//
//  RHInvestmentContentViewController.h
//  ryhui
//
//  Created by 江 云龙 on 15/3/16.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHBaseViewController.h"
#import "EGORefreshTableHeaderView.h"
#import "AITableFooterVew.h"
@interface RHInvestmentContentViewController : RHBaseViewController<UITableViewDataSource,UITableViewDelegate,EGORefreshTableHeaderDelegate>
{
    EGORefreshTableHeaderView *_headerView;
    AITableFooterVew *_footerView;
    BOOL _reloading;
    BOOL showLoadMoreButton;
}
@property(nonatomic,assign)UINavigationController* nav;

@property(nonatomic,strong)UITableView* tableView;
@property (nonatomic,strong)NSMutableArray* dataArray;
@property (nonatomic,strong)NSString* type;
@property (nonatomic, assign) int currentPageIndex;
-(void)getinvestListData;
-(void)startPost;
@end
