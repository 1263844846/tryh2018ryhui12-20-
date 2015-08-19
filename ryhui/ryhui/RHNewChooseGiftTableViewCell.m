//
//  RHNewChooseGiftTableViewCell.m
//  ryhui
//
//  Created by 糊涂虫 on 15/7/22.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHNewChooseGiftTableViewCell.h"

@implementation RHNewChooseGiftTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)updateCell:(NSDictionary*)dic {
    
    if (![dic[@"giftType"] isEqualToString:@"抵现卷"]){
        NSString* threshold=@"";
        if (![[dic objectForKey:@"threshold"] isKindOfClass:[NSNull class]]) {
            if ([[dic objectForKey:@"threshold"] isKindOfClass:[NSNumber class]]) {
                threshold=[[dic objectForKey:@"threshold"] stringValue];
            }else{
                threshold=[dic objectForKey:@"threshold"];
            }
        }
        self.conditionLabel.text=[NSString stringWithFormat:@"使用条件：单笔投资满%@元",threshold];
        if (_investNum < [threshold intValue]) {
            self.backImage.image=[UIImage imageNamed:@"giftChooseInvalide"];
            self.moneyLabel.textColor=[RHUtility colorForHex:@"878787"];
            self.moneyNoticeLabel.textColor = [RHUtility colorForHex:@"878787"];
            self.titleLabel.textColor = [RHUtility colorForHex:@"7a7a7a"];
            self.subTitleLabel.textColor = [RHUtility colorForHex:@"7a7a7a"];
        }else{
            self.moneyLabel.textColor=[RHUtility colorForHex:@"ff4a1f"];
            self.moneyNoticeLabel.textColor = [RHUtility colorForHex:@"ff4a1f"];
            self.backImage.image=[UIImage imageNamed:@"giftChooseInvest"];
            self.titleLabel.textColor = [RHUtility colorForHex:@"303030"];
            self.subTitleLabel.textColor = [RHUtility colorForHex:@"303030"];
        }
        
        self.subTitleLabel.text = @" [投资时使用]";
        self.titleLabel.text = @"投资现金";
        NSString *source = @"";
        NSString *temp = dic[@"activityName"];
        if ( temp && temp.length > 0 && (![temp isKindOfClass:[NSNull class]]) && (![temp isEqualToString:@"null"])) {
            source = temp;
        }
        self.sourceLabel.text = [NSString stringWithFormat:@"红包来源：%@",source];
        
        self.valideTimeLabel.text=[NSString stringWithFormat:@"有效期：%@至%@",[dic objectForKey:@"pd"],[dic objectForKey:@"exp"]];
        
        NSString* money=@"";
        if (![[dic objectForKey:@"money"] isKindOfClass:[NSNull class]]) {
            if ([[dic objectForKey:@"money"] isKindOfClass:[NSNumber class]]) {
                money= [NSString stringWithFormat:@"%@",[[dic objectForKey:@"money"] stringValue]];
            }else{
                money= [NSString stringWithFormat:@"%@",[dic objectForKey:@"money"]];
            }
        }
        money = [NSString stringWithFormat:@"%.2f",[money floatValue]];
        if (money.length >= 7) {
            self.moneyLabel.font = [UIFont fontWithName:@"Helvetica Neue Bold" size:14.0];
        } else if (money.length >= 6) {
            self.moneyLabel.font = [UIFont fontWithName:@"Helvetica Neue Bold" size:19.0];
        } else if (money.length >= 5) {
            self.moneyLabel.font = [UIFont fontWithName:@"Helvetica Neue Bold" size:22.0];
        } else {
            self.moneyLabel.font = [UIFont fontWithName:@"Helvetica Neue Bold" size:22.0];
        }
        self.moneyLabel.text = money;
    }
}
@end
