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
typedef void(^myblock)();
@protocol chooseGiftDelegate <NSObject>

-(void)chooseGiftWithnNum:(NSString*)num threshold:(NSString*)threshold giftId:(NSString*)giftId giftTP:(NSString *)TP;

@end
//typedf redefintion with different tyoes ('void(^)(int)')vs 'void(^)()')
@interface RHChooseGiftViewController : RHBaseViewController<EGORefreshTableHeaderDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,assign)int investNum;
@property (nonatomic,assign)id <chooseGiftDelegate> delegate;
@property(nonatomic,assign)CGFloat mouthNum;
@property(nonatomic,copy)myblock myblock;
@property(nonatomic,copy)NSString * dayormonth;
@end
