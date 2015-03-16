//
//  RHMyInvestmentViewCell.m
//  ryhui
//
//  Created by stefan on 15/3/15.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHMyInvestmentViewCell.h"

@implementation RHMyInvestmentViewCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
}

-(void)updateCell:(NSDictionary*)dic
{
    self.nameLabel.text=[dic objectForKey:@"name"];
    
    NSString* investMoney=@"0";
    if (![[dic objectForKey:@"investMoney"] isKindOfClass:[NSNull class]]) {
        investMoney=[[dic objectForKey:@"investMoney"] stringValue];
    }
    self.investMoneyLabel.text=investMoney;
    NSString* backMoney=@"0";
    if (![[dic objectForKey:@"backMoney"] isKindOfClass:[NSNull class]]) {
        backMoney=[[dic objectForKey:@"backMoney"] stringValue];
    }
    self.backMoneyLabel.text=backMoney;
    
    int profitMoney=0;
    if (![[dic objectForKey:@"profitMoney"] isKindOfClass:[NSNull class]]) {
        profitMoney=[[dic objectForKey:@"profitMoney"] intValue];
    }
    int penaltyMoney=0;
    if (![[dic objectForKey:@"penaltyMoney"] isKindOfClass:[NSNull class]]) {
        penaltyMoney=[[dic objectForKey:@"penaltyMoney"] intValue];
    }
    
    self.profitMoneyLabel.text=[NSString stringWithFormat:@"%d",profitMoney+penaltyMoney];
}

@end
