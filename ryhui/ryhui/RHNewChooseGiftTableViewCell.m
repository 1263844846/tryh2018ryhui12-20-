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
            self.titleLabel.textColor = [RHUtility colorForHex:@"878787"];
            self.subTitleLabel.textColor = [RHUtility colorForHex:@"878787"];
        }else{
            self.moneyLabel.textColor=[RHUtility colorForHex:@"df3121"];
            self.moneyNoticeLabel.textColor = [RHUtility colorForHex:@"df3121"];
            self.backImage.image=[UIImage imageNamed:@"giftChooseInvest"];
            self.titleLabel.textColor = [RHUtility colorForHex:@"555555"];
            self.subTitleLabel.textColor = [RHUtility colorForHex:@"555555"];
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
                money=[NSString stringWithFormat:@"%@",[[dic objectForKey:@"money"] stringValue]];
            }else{
                money=[NSString stringWithFormat:@"%@",[dic objectForKey:@"money"]];
            }
        }
        self.moneyLabel.text=money;
    }
}
@end
