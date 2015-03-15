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
    self.nameLabel.text=[dic objectForKey:@"username"];
    self.timeLabel.text=[dic objectForKey:@"investTime"];
    self.priceLabel.text=[[dic objectForKey:@"investMoney"] stringValue];
}
@end
