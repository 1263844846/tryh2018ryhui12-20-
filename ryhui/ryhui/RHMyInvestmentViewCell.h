//
//  RHMyInvestmentViewCell.h
//  ryhui
//
//  Created by stefan on 15/3/15.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RHMyInvestmentViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *xmjbtn;

@property(nonatomic,strong)NSString* projectId;
@property(nonatomic,assign)UINavigationController* nav;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *investMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *backMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *profitMoneyLabel;
@property(nonatomic,strong)NSString * type;
-(void)updateCell:(NSDictionary*)dic;

@end
