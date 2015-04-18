//
//  RHMyMessageDetailViewController.h
//  ryhui
//
//  Created by jufenghudong on 15/4/12.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

@protocol RHMessageDetailDelegate <NSObject>

-(void)refresh;

@end

#import "RHBaseViewController.h"

@interface RHMyMessageDetailViewController : RHBaseViewController
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property(nonatomic,strong)NSString* ids;
@property(nonatomic,strong)NSString* titleStr;
@property(nonatomic,strong)NSString* contentStr;

@property(nonatomic,assign) id <RHMessageDetailDelegate> delegate;
@end
