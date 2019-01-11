//
//  RHBANKTableViewCell.m
//  ryhui
//
//  Created by 糊涂虫 on 16/4/20.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import "RHBANKTableViewCell.h"


@implementation RHBANKTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    [self.lab.layer setMasksToBounds:YES];
    [self.lab.layer setCornerRadius:5.0];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)updatacell:(NSArray *)dic{
    
    if (!(dic[1]==nil) || ![dic[1] isKindOfClass:[NSNull class]]) {
       NSString *str = [NSString stringWithFormat:@"%@",dic[1]];
        
        NSString * laststr = [str substringFromIndex:str.length - 4];
        NSString * firststr = [str substringToIndex:4];
        
        self.bankcard.text = [NSString stringWithFormat:@"  %@  ****  %@  ",firststr,laststr];
    }
   
    if (dic[0]!=nil || ![dic[0] isKindOfClass:[NSNull class]]) {
        self.bankname.text = [NSString stringWithFormat:@"%@",dic[0]];
    }
//    self.bankname.text = dic[0];
    [self.bankimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@assets/img/bankicon/%@.jpg",[RHNetworkService instance].newdoMain,dic[0]]]];
    
}
@end
