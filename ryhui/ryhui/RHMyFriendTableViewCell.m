//
//  RHMyFriendTableViewCell.m
//  ryhui
//
//  Created by 糊涂虫 on 16/7/7.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import "RHMyFriendTableViewCell.h"

@implementation RHMyFriendTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updata:(NSDictionary *)dic{
    
    if (![dic[@"username"] isKindOfClass:[NSNull class]]||!dic[@"username"]) {
        self.namelab.text = [NSString stringWithFormat:@"%@",dic[@"username"]];
    }
    if (![dic[@"dateCreated"] isKindOfClass:[NSNull class]]||!dic[@"dateCreated"]) {
        self.Llisttime.text = [NSString stringWithFormat:@"%@",dic[@"dateCreated"]];
    }
    if (![dic[@"friendAward"] isKindOfClass:[NSNull class]]||!dic[@"friendAward"]) {
        self.friendmoney.text = [NSString stringWithFormat:@"%@",dic[@"friendAward"]];
    }
    if (![dic[@"myAward"] isKindOfClass:[NSNull class]]||!dic[@"myAward"]) {
        CGFloat a = [dic[@"myAward"] doubleValue];
        
        self.mymoney.text = [NSString stringWithFormat:@"%.2f",a];
    }
    
}

@end
