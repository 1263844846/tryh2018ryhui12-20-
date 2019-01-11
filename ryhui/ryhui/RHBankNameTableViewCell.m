//
//  RHBankNameTableViewCell.m
//  ryhui
//
//  Created by 糊涂虫 on 16/7/14.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import "RHBankNameTableViewCell.h"

@implementation RHBankNameTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)updateCell:(NSDictionary *)dic{
    
    NSString * str;
    if (![dic[@"bankName"] isKindOfClass:[NSNull class]]||!dic[@"bankName"]) {
        str = dic[@"bankName"];
    }
    if (![dic[@"quota"] isKindOfClass:[NSNull class]]||!dic[@"quota"]) {
        
//        str = [NSString stringWithFormat:@"%@(单笔限额%@",str,dic[@"quota"]];
        str = [NSString stringWithFormat:@"%@(单笔限额%.f万",str,[dic[@"quota"] floatValue]/10000 ];
    }
    if (![dic[@"quotaForDay"] isKindOfClass:[NSNull class]]||!dic[@"quotaForDay"]) {
        
//        str = [NSString stringWithFormat:@"%@，单日累计限额%@)",str,dic[@"quotaForDay"]];
        str = [NSString stringWithFormat:@" %@，单日累计限额%.f万)",str,[dic[@"quotaForDay"] floatValue]/10000];
        
    }
    self.labname.text = str;
}

@end
