//
//  RHMyMessageCell.m
//  ryhui
//
//  Created by 江 云龙 on 15/3/29.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHMyMessageCell.h"

@implementation RHMyMessageCell

- (void)awakeFromNib {
    // Initialization code
}
//content = "\U60a8\U4e8e2015-03-12 13:53:08\U6210\U529f\U5145\U503c891.65\U5143\Uff0c\U53ef\U5230\U8d26\U6237\U4e2d\U5fc3\U67e5\U770b\U660e\U7ec6\U3002";
//id = 1317;
//postDate = "2015-03-12 13:53:09";
//recId = mayun523;
//sendId = admin;
//state = 1;
//title = "\U5145\U503c\U6210\U529f";
//type = 2;
-(void)updateCell:(NSDictionary *)dic{
    self.titleLabel.text = [dic objectForKey:@"content"];
    self.timeLabel.text = [dic objectForKey:@"postDate"];
    NSString *type = nil;
    if ([[dic objectForKey:@"state"] isKindOfClass:[NSNumber class]]) {
        type = [[dic objectForKey:@"state"] stringValue];
    }else{
        type = [dic objectForKey:@"state"];
    }
    
    if ([type isEqualToString:@"2"]) {
        self.typeImageView.image = [UIImage imageNamed:@"message1"];
    }else{
        self.typeImageView.image = [UIImage imageNamed:@"message2"];
    }
}

@end
