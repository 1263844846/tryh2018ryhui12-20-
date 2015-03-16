//
//  RHTradViewCell.m
//  ryhui
//
//  Created by stefan on 15/3/15.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHTradViewCell.h"

@implementation RHTradViewCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
}

-(void)updateCell:(NSDictionary*)dic
{
    self.typeLabel.text=[self typeWithKey:[dic objectForKey:@"type"]];
    self.timeLabel.text=[dic objectForKey:@"dateCreated"];
    NSString* price=nil;
    switch ([self isAddTypeWithType:[dic objectForKey:@"type"]]) {
        case 0:
            price=@"+";
            self.priceLabel.textColor=[RHUtility colorForHex:@"#40b5b8"];
            break;
        case 1:
            price=@"-";
            self.priceLabel.textColor=[RHUtility colorForHex:@"#ff5d25"];
            break;

        case 2:
            price=@"";
            self.priceLabel.textColor=[RHUtility colorForHex:@"#c6c6c6"];
            break;
        default:
            break;
    }
    self.priceLabel.text=[NSString stringWithFormat:@"%@%@",price,[[dic objectForKey:@"money"] stringValue]];
}

-(NSString*)typeWithKey:(NSString*)type
{
    if ([type isEqualToString:@"Recharge"]) {
        return @"充值";
    }
    if ([type isEqualToString:@"InitiativeTender"]) {
        return @"投资金额冻结";
    }
    if ([type isEqualToString:@"TenderCancel"]) {
        return @"投资金额解冻";
    }
    if ([type isEqualToString:@"Loans"]) {
        return @"投资放款";
    }
    if ([type isEqualToString:@"Capital"]) {
        return @"还本";
    }
    if ([type isEqualToString:@"Interest"]) {
        return @"付息";
    }
    if ([type isEqualToString:@"PenaltyInterest"]) {
        return @"逾期罚息";
    }
    if ([type isEqualToString:@"Cash"]) {
        return @"提现";
    }
    if ([type isEqualToString:@"Cash_Fee"]) {
        return @"提现手续费";
    }
    return @"";
}

-(int)isAddTypeWithType:(NSString*)type
{
    if ([type isEqualToString:@"Recharge"]||[type isEqualToString:@"Interest"]||[type isEqualToString:@"Capital"]||[type isEqualToString:@"PenaltyInterest"]) {
        return 0;
    }
    if ([type isEqualToString:@"Cash"]||[type isEqualToString:@"Cash_Fee"]||[type isEqualToString:@"Loans"]) {
        return 1;
    }
    return 2;
}
@end
