//
//  RHProjectDetailViewController.h
//  ryhui
//
//  Created by stefan on 15/3/14.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHBaseViewController.h"
#import "RHProjectDetailViewCell.h"
#import "RHInvestmentViewController.h"

@interface RHProjectDetailViewController : RHBaseViewController

@property(nonatomic,strong)NSString* type;
@property(nonatomic,strong)NSDictionary* dataDic;

@end
