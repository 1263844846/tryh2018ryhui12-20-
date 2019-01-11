//
//  RHHelperCollectionViewCell.m
//  ryhui
//
//  Created by 糊涂虫 on 16/5/5.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import "RHHelperCollectionViewCell.h"

@implementation RHHelperCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)update:(NSString *)str{
    
    
    self.namelab.text = str;
}

@end
