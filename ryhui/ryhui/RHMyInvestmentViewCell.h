//
//  RHMyInvestmentViewCell.h
//  ryhui
//
//  Created by stefan on 15/3/15.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RHMyInvestmentViewCell : UITableViewCell

-(void)updateCell:(NSDictionary*)dic;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *investMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *backMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *profitMoneyLabel;
@end
