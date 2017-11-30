//
//  RHProjectDetailViewCell.h
//  ryhui
//
//  Created by stefan on 15/3/15.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RHProjectDetailViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *isPhoneInvest;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *noticeWidth;

-(void)updateCell:(NSDictionary*)dic;

@end
