//
//  RHMyGiftViewCell.m
//  ryhui
//
//  Created by jufenghudong on 15/4/14.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHMyGiftViewCell.h"

@implementation RHMyGiftViewCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;

}
//activityId = 3;
//activityName = "\U63d0\U793a\U6d4b\U8bd52";
//exp = "2015-05-09";
//giftType = "\U62b5\U73b0\U5377";
//id = 971;
//investMoney = "<null>";
//money = 88;
//pd = "2015-04-09";
//projectId = "<null>";
//projectName = "<null>";
//status = init;
//threshold = 888;
//userId = 126;
//usingTime = "<n
-(void)updateCell:(NSDictionary*)dic with:(NSString*)type
{
    DLog(@"%@",dic);
    
    if ([type isEqualToString:@"front/payment/account/myInitGiftListData"]) {
        self.bgImageView.image=[UIImage imageNamed:@"giftcellBg.png"];
        self.iconimageView.hidden=YES;
        self.moneyLabel.textColor=[RHUtility colorForHex:@"df3121"];
    }
    if ([type isEqualToString:@"front/payment/account/myUsedGiftListData"]) {
        self.bgImageView.image=[UIImage imageNamed:@"giftbg2.png"];
        self.iconimageView.hidden=NO;
        self.iconimageView.image=[UIImage imageNamed:@"giftPass.png"];
        self.moneyLabel.textColor=[UIColor whiteColor];
        
    }
    if ([type isEqualToString:@"front/payment/account/myPastGiftListData"]) {
        self.bgImageView.image=[UIImage imageNamed:@"giftbg2.png"];
        self.iconimageView.hidden=NO;
        self.iconimageView.image=[UIImage imageNamed:@"giftPass1.png"];
        self.moneyLabel.textColor=[UIColor whiteColor];
    }
    
    NSString* threshold=@"";
    if (![[dic objectForKey:@"threshold"] isKindOfClass:[NSNull class]]) {
        if ([[dic objectForKey:@"threshold"] isKindOfClass:[NSNumber class]]) {
            threshold=[NSString stringWithFormat:@"单笔投资满%@元",[[dic objectForKey:@"threshold"] stringValue]];
        }else{
            threshold=[NSString stringWithFormat:@"单笔投资满%@元",[dic objectForKey:@"threshold"]];
        }
    }
    self.threshodLabel.text=threshold;
    
    self.activityNameLabel.text=[dic objectForKey:@"activityName"];
    
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
