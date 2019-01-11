//
//  RHShowGiftTableViewCell.m
//  ryhui
//
//  Created by 糊涂虫 on 17/4/12.
//  Copyright © 2017年 stefan. All rights reserved.
//

#import "RHShowGiftTableViewCell.h"

@implementation RHShowGiftTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setGiftData:(NSDictionary *)dic{
    NSString *money ;
    NSString *threshold ;
    NSString *qixoan ;
    NSString *name;
//    NSString * gift;
    NSString * shiyong;
    if (![dic[@"exp"] isKindOfClass:[NSNull class]]) {
        qixoan = [NSString stringWithFormat:@"%@", dic[@"exp"]];
    }
    if (![dic[@"money"] isKindOfClass:[NSNull class]]) {
        money = [NSString stringWithFormat:@"%@", dic[@"money"]];
    }
    if (![dic[@"threshold"] isKindOfClass:[NSNull class]]) {
        threshold = [NSString stringWithFormat:@"%@", dic[@"threshold"]];
    }
    
    
    if ([dic[@"giftTypeId"] isEqualToString:@"instead_cash"]) {
        //投资
        self.MoneyLab.text = [NSString stringWithFormat:@"¥ %@",money];
        self.MoneyLab.textColor = [RHUtility colorForHex:@"#ea866f"];
        
        self.XianZhiLab.text = [NSString stringWithFormat:@"单笔出借满%@元可用",threshold];
        self.TimeLab.text = [NSString stringWithFormat:@"有效期至：%@",qixoan];
    }else if ([dic[@"giftTypeId"] isEqualToString:@"rebate_cash"]){
        //返利
        self.GiftImage.image = [UIImage imageNamed:@"PNG_APP红包底__黄"];
        self.GiftName.text = @"返利现金";
        self.MoneyLab.text = [NSString stringWithFormat:@"¥%@",money];
        self.MoneyLab.textColor = [RHUtility colorForHex:@"#ffb618"];
        self.XianZhiLab.hidden = YES;
        self.tytelab.text = @"可直接兑换";
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        
        // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
        
        [formatter setDateFormat:@"YYYY-MM-dd "];
        
        //现在时间,你可以输出来看下是什么格式
        
        NSDate *datenow = [NSDate date];
        
        //----------将nsdate按formatter格式转成nsstring
        
        NSString *nowtimeStr = [formatter stringFromDate:datenow];
        

        self.TimeLab.text = [NSString stringWithFormat:@"发放日期：%@",nowtimeStr];
    }else{
        //加息
        self.GiftName.text = @"加息券";
        self.GiftImage.image = [UIImage imageNamed:@"PNG_APP红包底_绿"];
        self.MoneyLab.textColor = [RHUtility colorForHex:@"#09aeb0"];
        if (![[dic objectForKey:@"rate"] isKindOfClass:[NSNull class]]) {
            if ([[dic objectForKey:@"rate"] isKindOfClass:[NSNumber class]]) {
                money=[NSString stringWithFormat:@"%@",[[dic objectForKey:@"rate"] stringValue]];
            }else{
                money=[NSString stringWithFormat:@"%@",[dic objectForKey:@"rate"]];
                
                
                
            }
        }
        if (![dic[@"upperMoney"] isKindOfClass:[NSNull class]]) {
            threshold = [NSString stringWithFormat:@"%@", dic[@"upperMoney"]];
        }
        self.MoneyLab.text = [NSString stringWithFormat:@"%@ %%",money];
        self.XianZhiLab.text = [NSString stringWithFormat:@"加息本金上限%@元",threshold];
        self.TimeLab.text = [NSString stringWithFormat:@"有效期至：%@",qixoan];
        
    }
    
}

@end
