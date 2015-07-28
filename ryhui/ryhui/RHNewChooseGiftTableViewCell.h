//
//  RHNewChooseGiftTableViewCell.h
//  ryhui
//
//  Created by 糊涂虫 on 15/7/22.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RHNewChooseGiftTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *backImage;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *valideTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *conditionLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyNoticeLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;

@property (nonatomic,assign)int investNum;

-(void)updateCell:(NSDictionary*)dic;

@end
