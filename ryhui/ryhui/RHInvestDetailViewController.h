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

@property  (nonatomic,strong)NSString* projectId;
@property(nonatomic,assign)int res;
@end
