//
//  RHSTZFTableViewCell.m
//  ryhui
//
//  Created by 糊涂虫 on 2018/5/17.
//  Copyright © 2018年 stefan. All rights reserved.
//

#import "RHSTZFTableViewCell.h"

@implementation RHSTZFTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)sq:(id)sender {
    self.myblock();
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
