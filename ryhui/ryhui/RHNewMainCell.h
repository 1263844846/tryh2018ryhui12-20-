//
//  RHNewMainCell.h
//  ryhui
//
//  Created by 糊涂虫 on 16/1/20.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircleProgressView.h"
@interface RHNewMainCell : UITableViewCell
@property(nonatomic,strong)CircleProgressView* progressView;
//nianhua
@property (weak, nonatomic) IBOutlet UILabel *RHrate;

@property (weak, nonatomic) IBOutlet UILabel *RHpct;
//qixian
@property (weak, nonatomic) IBOutlet UILabel *RHmouth;

@property (weak, nonatomic) IBOutlet UILabel *qitoulab;

@property (weak, nonatomic) IBOutlet UILabel *mouth;
@property (weak, nonatomic) IBOutlet UILabel *RHmoney;
@property (weak, nonatomic) IBOutlet UILabel *wan;
@property (weak, nonatomic) IBOutlet UILabel *mouthordaylab;

-(void)updataNewPeopleCell:(NSDictionary *)dic;
@end
