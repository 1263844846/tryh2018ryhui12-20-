//
//  RHBFbankcardCell.m
//  ryhui
//
//  Created by 糊涂虫 on 2018/1/18.
//  Copyright © 2018年 stefan. All rights reserved.
//

#import "RHBFbankcardCell.h"

@implementation RHBFbankcardCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

-(void)updatemydata:(NSDictionary *)dic{
    
    if ([self.ress isEqualToString:@"hidden"]) {
        self.removeview.hidden = YES;
    }else{
        self.removeview.hidden = NO;
    }
    
    
}
@end
