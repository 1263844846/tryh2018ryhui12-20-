//
//  RHXFDTableViewCell.m
//  ryhui
//
//  Created by 糊涂虫 on 16/9/1.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import "RHXFDTableViewCell.h"

@implementation RHXFDTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updata:(NSDictionary *)dic withnum:(NSInteger)inter{
    
    if (dic[@"loanName"]) {
        self.namelab.text = dic[@"loanName"];
      //  NSString * laststr = [self.namelab.text substringFromIndex:str.length - 4];
        NSString * firststr = [dic[@"loanName"] substringToIndex:1];
        self.namelab.text = [NSString stringWithFormat:@"%@**",firststr];
    }
    if (dic[@"idCard"]) {
        NSString * str = dic[@"idCard"];
        NSString * laststr = [dic[@"idCard"] substringFromIndex:str.length - 2];
        NSString * firststr = [dic[@"idCard"] substringToIndex:3];
        
        self.numberlab.text = [NSString stringWithFormat:@"%@*******%@",firststr,laststr];
    }
    if (dic[@"money"]) {
        self.monlab.text =[NSString stringWithFormat:@"%@.00",dic[@"money"]];
    }
    self.firstlab.text = [NSString stringWithFormat:@"%ld",(long)inter];
    
    if ([UIScreen mainScreen].bounds.size.width<321) {
        self.namelab.frame = CGRectMake(self.namelab.frame.origin.x-10, self.namelab.frame.origin.y, self.namelab.frame.size.width, self.namelab.frame.size.height);
        self.numberlab.frame = CGRectMake(self.numberlab.frame.origin.x-18, self.numberlab.frame.origin.y, self.numberlab.frame.size.width, self.numberlab.frame.size.height);
    }
    
}
@end
