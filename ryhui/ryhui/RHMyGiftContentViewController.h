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
typedef void(^myblock)() ;
typedef void(^myduihuanblock)() ;

@interface RHMyGiftContentViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,EGORefreshTableHeaderDelegate>

@property(nonatomic,assign)UINavigationController* nav;
@property (nonatomic,strong)NSMutableArray* dataArray;
@property (nonatomic,strong)NSString* type;
@property(nonatomic,copy)myblock myblock;
@property(nonatomic,copy)myduihuanblock duihuanblock;

-(void)getinvestListData;
-(void)startPost;
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView;
@end
