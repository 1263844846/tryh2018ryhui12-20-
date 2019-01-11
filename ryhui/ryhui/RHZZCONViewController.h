//
//  RHZZCONViewController.h
//  ryhui
//
//  Created by 糊涂虫 on 16/3/18.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
#import "AITableFooterVew.h"

@interface RHZZCONViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,EGORefreshTableHeaderDelegate>

@property(nonatomic,assign)UINavigationController* nav;
@property (nonatomic,strong)NSMutableArray* dataArray;
@property (nonatomic,strong)NSString* type;
@property(nonatomic,copy)NSString * test;
-(void)getinvestListData;
-(void)startPost;
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView;
@end
