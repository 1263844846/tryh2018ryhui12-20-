//
//  RHTXTableViewCell.m
//  ryhui
//
//  Created by 糊涂虫 on 16/3/21.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import "RHTXTableViewCell.h"

@implementation RHTXTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)yincanghidden:(id)sender {
    
    self.myblock();
    
   
}

-(void)updateCell:(NSDictionary*)dic{
    
    self.yhanglab.text = dic[@"yh"];
    NSString *  str = dic[@"kh"];
    
    NSString * laststr = [str substringFromIndex:str.length - 4];
    NSString * firststr = [str substringToIndex:4];
    
    self.kahaolab.text = [NSString stringWithFormat:@"  %@  ****  %@  ",firststr,laststr];
}


@end
