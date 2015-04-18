//
//  RHMyGiftContentViewController.h
//  ryhui
//
//  Created by jufenghudong on 15/4/14.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
#import "AITableFooterVew.h"

@interface RHMyGiftContentViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,EGORefreshTableHeaderDelegate>
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
