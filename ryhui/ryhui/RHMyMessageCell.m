//
//  RHMyMessageCell.m
//  ryhui
//
//  Created by 江 云龙 on 15/3/29.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHMyMessageCell.h"
#import "UIColor+ZXLazy.h"
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
    if ([dic objectForKey:@"title"]&&![[dic objectForKey:@"title"] isKindOfClass:[NSNull class]]) {
        self.titleLabel.text = [dic objectForKey:@"title"];
    }else{
        self.titleLabel.text = @"";
    }
    
    
    NSString * timestr = [[dic objectForKey:@"postDate"] substringToIndex:10];
    self.timeLabel.text = timestr;
    self.namelab.text = [dic objectForKey:@"content"];
    NSString *type = nil;
    if ([[dic objectForKey:@"state"] isKindOfClass:[NSNumber class]]) {
        type = [[dic objectForKey:@"state"] stringValue];
    }else{
        type = [dic objectForKey:@"state"];
    }
    
    if ([type isEqualToString:@"2"]) {
        //self.typeImageView.image = [UIImage imageNamed:@"message1"];
        self.titleLabel.textColor = [UIColor colorWithHexString:@"c7c7c7"];
        self.timeLabel.textColor = [UIColor colorWithHexString:@"c7c7c7"];
        self.namelab.textColor = [UIColor colorWithHexString:@"c7c7c7"];
    }else{
        self.typeImageView.image = [UIImage imageNamed:@"message2"];
//        self.namelab.textColor = [UIColor redColor];
    }
}

@end
