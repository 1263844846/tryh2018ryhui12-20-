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
typedef void(^myblock)() ;
@interface RHInvestmentContentViewController : RHBaseViewController<UITableViewDataSource,UITableViewDelegate,EGORefreshTableHeaderDelegate>

@property(nonatomic,assign)UINavigationController* nav;
@property (nonatomic,strong)NSMutableArray* dataArray;
@property (nonatomic,strong)NSString* type;
@property(nonatomic,assign)BOOL ressss;
@property(nonatomic,copy)myblock myblock;
@property(nonatomic,copy)myblock myblock1;
@property(nonatomic,copy)NSString *resstr;
-(void)getinvestListData;
-(void)startPost;

@end
