//
//  RHChooseGiftViewController.h
//  ryhui
//
//  Created by jufenghudong on 15/4/14.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHBaseViewController.h"
#import "EGORefreshTableHeaderView.h"
#import "AITableFooterVew.h"

@protocol chooseGiftDelegate <NSObject>

-(void)chooseGiftWithnNum:(NSString*)num threshold:(NSString*)threshold giftId:(NSString*)giftId;

@end

@interface RHChooseGiftViewController : RHBaseViewController<EGORefreshTableHeaderDelegate,UITableViewDataSource,UITableViewDelegate>
{
    EGORefreshTableHeaderView *_headerView;
    AITableFooterVew *_footerView;
    BOOL _reloading;
    BOOL showLoadMoreButton;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) int currentPageIndex;
@property(nonatomic,strong)NSMutableArray* dataArray;

@property (nonatomic,assign)int investNum;

@property (nonatomic,assign)id <chooseGiftDelegate> delegate;
- (IBAction)pushMain:(id)sender;
- (IBAction)pushUser:(id)sender;
- (IBAction)pushMore:(id)sender;


@end
