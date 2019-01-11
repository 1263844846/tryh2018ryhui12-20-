//
//  RHXMJXQTableViewCell.m
//  ryhui
//
//  Created by 糊涂虫 on 2018/6/21.
//  Copyright © 2018年 stefan. All rights reserved.
//

#import "RHXMJXQTableViewCell.h"

@implementation RHXMJXQTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}
-(void)updatemydata:(NSDictionary * )dic{
    
    if (dic[@"projectMoney"]&&![dic[@"projectMoney"]isKindOfClass:[NSNull class]]) {
        self.zongelab.text = [NSString stringWithFormat:@"%@",dic[@"projectMoney"]];
    }
    if (dic[@"remainMoney"]&&![dic[@"remainMoney"]isKindOfClass:[NSNull class]]) {
        self.yuelab.text = [NSString stringWithFormat:@"%@",dic[@"remainMoney"]];
    }
    if (dic[@"projectName"]&&![dic[@"projectName"]isKindOfClass:[NSNull class]]) {
        self.namelab.text = [NSString stringWithFormat:@"%@",dic[@"projectName"]];
    }
    
}
@end
