//
//  RHProjectListContentViewController.h
//  ryhui
//
//  Created by 江 云龙 on 15/3/17.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
#import "AITableFooterVew.h"
typedef void(^QiangGegeBlock)(NSDictionary * dic);
@interface RHProjectListContentViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,EGORefreshTableHeaderDelegate>
@property(nonatomic,copy)QiangGegeBlock myblock;
@property(nonatomic,assign)UINavigationController* prarentNav;
@property (nonatomic,strong)NSString* type;
@property(nonatomic,strong)UITableView* tableView;
@property (nonatomic,strong)NSMutableArray* dataArray;

-(void)sordListWithSidx:(NSString*)sidx sord:(NSString*)sord;
-(void)startPost;
-(void)getinvestListData;
-(void)refreshWithData:(NSString*)data;

@end
