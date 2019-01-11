//
//  RHDetailJLTableViewCell.h
//  ryhui
//
//  Created by 糊涂虫 on 16/4/12.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RHDetailJLTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *isPhoneInvest;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *noticeWidth;

-(void)updateCell:(NSDictionary*)dic;

@end
