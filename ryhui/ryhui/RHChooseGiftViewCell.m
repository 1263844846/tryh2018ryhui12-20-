//
//  RHChooseGiftViewCell.m
//  ryhui
//
//  Created by jufenghudong on 15/4/14.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHChooseGiftViewCell.h"

@implementation RHChooseGiftViewCell
@synthesize investNum;

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;

}

-(void)updateCell:(NSDictionary*)dic
{
    DLog(@"%@",dic);
    
    NSString* threshold=@"";
    if (![[dic objectForKey:@"threshold"] isKindOfClass:[NSNull class]]) {
        if ([[dic objectForKey:@"threshold"] isKindOfClass:[NSNumber class]]) {
            threshold=[[dic objectForKey:@"threshold"] stringValue];
        }else{
            threshold=[dic objectForKey:@"threshold"];
        }
    }
    
    self.threshodLabel.text=[NSString stringWithFormat:@"单笔投资满%@元",threshold];
    if (investNum<[threshold intValue]) {
        self.bgImageView.image=[UIImage imageNamed:@"giftbg2.png"];
        self.moneyLabel.textColor=[UIColor whiteColor];
    }else{
        self.moneyLabel.textColor=[RHUtility colorForHex:@"df3121"];
        self.bgImageView.image=[UIImage imageNamed:@"giftcellBg.png"];
    }
    
    
    self.usingTimeLabel.text=[NSString stringWithFormat:@"%@至%@",[dic objectForKey:@"pd"],[dic objectForKey:@"exp"]];
    
    
    NSString* money=@"";
    if (![[dic objectForKey:@"money"] isKindOfClass:[NSNull class]]) {
        if ([[dic objectForKey:@"money"] isKindOfClass:[NSNumber class]]) {
            money=[NSString stringWithFormat:@"￥%@",[[dic objectForKey:@"money"] stringValue]];
        }else{
            money=[NSString stringWithFormat:@"￥%@",[dic objectForKey:@"money"]];
        }
    }
    
    self.moneyLabel.text=money;
}

@end
