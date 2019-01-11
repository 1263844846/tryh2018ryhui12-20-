//
//  RHProjectDetailViewCell.m
//  ryhui
//
//  Created by stefan on 15/3/15.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHProjectDetailViewCell.h"

@implementation RHProjectDetailViewCell

- (void)awakeFromNib {
    // Initialization code
    
}

-(void)updateCell:(NSDictionary*)dic
{
   
    NSString *username = [dic objectForKey:@"username"];
    if (username && username != nil && ![username isKindOfClass:[NSNull class]] && ![username isEqualToString:@"<null>"]) {
        self.nameLabel.text = username;
        CGSize size = [username drawInRect:CGRectMake(self.nameLabel.frame.origin.x, self.nameLabel.frame.origin.y, 200, 100) withFont:self.nameLabel.font lineBreakMode:NSLineBreakByCharWrapping];
        self.noticeWidth.constant = size.width + 1;
    }
    
    NSString *investTime = [dic objectForKey:@"investTime"];
    if (investTime && investTime != nil && ![investTime isKindOfClass:[NSNull class]] && ![investTime isEqualToString:@"<null>"]) {
        self.timeLabel.text = investTime;
    }
    
    NSString *investMoney = [[dic objectForKey:@"investMoney"] stringValue];
    if (investMoney && investMoney != nil && ![investMoney isKindOfClass:[NSNull class]] && ![investMoney isEqualToString:@"<null>"]) {
        self.priceLabel.text = investMoney;
    }
    
    self.isPhoneInvest.hidden = YES;
    NSString *platform = [dic objectForKey:@"investType"];
    if (platform && platform != nil && ![platform isKindOfClass:[NSNull class]] && ![platform isEqualToString:@"<null>"]) {
        if ([platform isEqualToString:@"App"]) {
            self.isPhoneInvest.hidden = NO;
        }
    }
}
@end
