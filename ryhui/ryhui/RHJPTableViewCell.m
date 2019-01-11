//
//  RHJPTableViewCell.m
//  ryhui
//
//  Created by 糊涂虫 on 16/4/15.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import "RHJPTableViewCell.h"

@implementation RHJPTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updata:(NSDictionary *)dic{
    
    
    if (dic[@"awardName"]) {
        self.giftname.text = [NSString stringWithFormat:@"%@",dic[@"awardName"]];
    }else{
        
        self.giftname.text = @"获取奖品名失败";
    }
    
    if (dic[@"createTime"]) {
        self.datetime.text = [NSString stringWithFormat:@"%@",dic[@"createTime"]];
    }else{
        
        
    }
    
    if (dic[@"activityName"]) {
        self.onfromlab.text = [NSString stringWithFormat:@"%@",dic[@"activityName"]];
    }else{
        
    }
    
    if (!dic[@"express"]|| ![dic[@"express"] isKindOfClass:[NSNull class]]) {
        self.mailmethod.text = [NSString stringWithFormat:@"%@",dic[@"express"]];
    }else{
        self.mailmethod.text = @"";
    }
    
}
@end
