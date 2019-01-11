//
//  RHDetailJLTableViewCell.m
//  ryhui
//
//  Created by 糊涂虫 on 16/4/12.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import "RHDetailJLTableViewCell.h"

@implementation RHDetailJLTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateCell:(NSDictionary*)dic
{
    
    NSString *username = [dic objectForKey:@"username"];
    if (username && username != nil && ![username isKindOfClass:[NSNull class]] && ![username isEqualToString:@"<null>"]) {
        self.nameLabel.text = username;
//        CGSize size = [username drawInRect:CGRectMake(self.nameLabel.frame.origin.x, self.nameLabel.frame.origin.y, 200, 100) withFont:self.nameLabel.font lineBreakMode:NSLineBreakByCharWrapping];
//        self.noticeWidth.constant = size.width + 1;
        CGSize size = [self.nameLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:self.nameLabel.font,NSFontAttributeName, nil]];
        CGFloat nameW = size.width;
        //    self.coinView.namelab.font = [UIFont fontWithName:@"Helvetica Neue Bold" size:25+a*3];
//        self.nameLabel.backgroundColor = [UIColor redColor];
        self.nameLabel.frame = CGRectMake(self.nameLabel.frame.origin.x, self.nameLabel.frame.origin.y, nameW, self.nameLabel.frame.size.height);
        self.isPhoneInvest.frame = CGRectMake(CGRectGetMaxX(self.nameLabel.frame)+5, 10, self.isPhoneInvest.frame.size.width, self.isPhoneInvest.frame.size.height);
        
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
