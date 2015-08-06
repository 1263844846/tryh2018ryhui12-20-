//
//  RHMyNewGiftTableViewCell.m
//  ryhui
//
//  Created by 糊涂虫 on 15/7/20.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHMyNewGiftTableViewCell.h"
@implementation RHMyNewGiftTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)updateCell:(NSDictionary*)dic with:(NSString*)type {
    //可以使用
    if ([type isEqualToString:@"front/payment/account/myInitGiftListData"]) {
        
        self.giftTypeButton.hidden=NO;
        if ([dic[@"giftType"] isEqualToString:@"投资现金"]) {
//            投资
            self.backGroundImage.image=[UIImage imageNamed:@"giftChooseInvest"];
            [self.giftTypeButton setBackgroundImage:[UIImage imageNamed:@"giftInvestButton"] forState:UIControlStateNormal];
            self.clickButton.tag = 10;
            self.moneyLabel.textColor=[RHUtility colorForHex:@"ff4a1f"];
            self.RMBLabel.textColor = [RHUtility colorForHex:@"ff4a1f"];
            self.validTimeLabel.text=[NSString stringWithFormat:@"有效期：%@至%@",[dic objectForKey:@"pd"],[dic objectForKey:@"exp"]];
        } else {
//            兑换
            self.moneyLabel.textColor=[RHUtility colorForHex:@"ffb618"];
            self.RMBLabel.textColor = [RHUtility colorForHex:@"ffb618"];
            self.backGroundImage.image=[UIImage imageNamed:@"giftChooseCharge"];
            self.clickButton.tag = [dic[@"id"] integerValue];
             [self.giftTypeButton setBackgroundImage:[UIImage imageNamed:@"giftChargeButton"] forState:UIControlStateNormal];
            self.validTimeLabel.text=[NSString stringWithFormat:@"获得日期：%@",[dic objectForKey:@"pd"]];
        }
        
        self.typeLabel.textColor = [RHUtility colorForHex:@"303030"];
        self.effectNoticeLabel.textColor = [RHUtility colorForHex:@"303030"];
    }
    
    //已使用
    if ([type isEqualToString:@"front/payment/account/myUsedGiftListData"]) {
        self.backGroundImage.image=[UIImage imageNamed:@"giftUsed"];
        self.giftTypeButton.hidden=YES;
        self.clickButton.hidden = YES;
        self.moneyLabel.textColor=[RHUtility colorForHex:@"878787"];
        self.RMBLabel.textColor = [RHUtility colorForHex:@"878787"];
        self.typeLabel.textColor = [RHUtility colorForHex:@"7a7a7a"];
        self.effectNoticeLabel.textColor = [RHUtility colorForHex:@"7a7a7a"];
        NSString *useTime = [dic objectForKey:@"usingTime"];
        useTime = [useTime componentsSeparatedByString:@" "][0];
        self.validTimeLabel.text= [NSString stringWithFormat:@"%@已使用",useTime];
    }
    
    //已过期
    if ([type isEqualToString:@"front/payment/account/myPastGiftListData"]) {
        self.backGroundImage.image=[UIImage imageNamed:@"giftInvalid"];
        self.giftTypeButton.hidden=YES;
        self.clickButton.hidden = YES;
        self.moneyLabel.textColor=[RHUtility colorForHex:@"878787"];
        self.RMBLabel.textColor = [RHUtility colorForHex:@"878787"];
        self.typeLabel.textColor = [RHUtility colorForHex:@"7a7a7a"];
        self.effectNoticeLabel.textColor = [RHUtility colorForHex:@"7a7a7a"];
        self.validTimeLabel.text=[NSString stringWithFormat:@"有效期：%@至%@",[dic objectForKey:@"pd"],[dic objectForKey:@"exp"]];
    }
    
    if ([dic[@"giftType"] isEqualToString:@"投资现金"]) {
        self.effectNoticeLabel.text = @" [投资时使用]";
        self.typeLabel.text = @"投资现金";
        NSString* threshold=@"";
        if (![[dic objectForKey:@"threshold"] isKindOfClass:[NSNull class]]) {
            if ([[dic objectForKey:@"threshold"] isKindOfClass:[NSNumber class]]) {
                threshold=[NSString stringWithFormat:@"使用条件：单笔投资满%@元",[[dic objectForKey:@"threshold"] stringValue]];
            }else{
                threshold=[NSString stringWithFormat:@"使用条件：单笔投资满%@元",[dic objectForKey:@"threshold"]];
            }
        }
        self.conditionLabel.text=threshold;
        
        self.sourceLabel.text = [NSString stringWithFormat:@"红包来源：%@",dic[@"activityName"]];
    } else {
        self.typeLabel.text = @"返利现金";
        self.effectNoticeLabel.text = @" [可直接兑现为余额]";
        self.conditionLabel.text = [NSString stringWithFormat:@"红包来源：%@",dic[@"activityName"]];
        self.sourceLabel.text = @"";
    }
    
    NSString* money=@"";
    if (![[dic objectForKey:@"money"] isKindOfClass:[NSNull class]]) {
        if ([[dic objectForKey:@"money"] isKindOfClass:[NSNumber class]]) {
            money=[NSString stringWithFormat:@"%@",[[dic objectForKey:@"money"] stringValue]];
        }else{
            money=[NSString stringWithFormat:@"%@",[dic objectForKey:@"money"]];
        }
    }
    
//     22.0
    
   
    money = [NSString stringWithFormat:@"%.2f",[money floatValue]];
     NSLog(@"=========%lu",(unsigned long)money.length);
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

@end
