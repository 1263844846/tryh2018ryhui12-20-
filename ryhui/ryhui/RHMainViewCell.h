//
//  RHMainViewCell.h
//  ryhui
//
//  Created by stefan on 15/3/14.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircleProgressView.h"

@interface RHMainViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *customView;
@property(nonatomic,strong)CircleProgressView* progressView;
@property (weak, nonatomic) IBOutlet UILabel *limitTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *investorRateLabel;
@property (weak, nonatomic) IBOutlet UILabel *insuranceMethodLabel;
@property (weak, nonatomic) IBOutlet UILabel *projectFundLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *paymentNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *pointImageView;

-(void)updateCell:(NSDictionary*)dic;

@end
