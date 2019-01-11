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
//    self.zhilab.layer
    [self.zhilab.layer  setMasksToBounds:YES];
    [self.zhilab.layer setCornerRadius:15.0];
}

-(void)updateCell:(NSDictionary*)dic
{
    
    self.timeLabel.text=[dic objectForKey:@"dateCreated"];
    NSString* price=nil;
    switch ([self isAddTypeWithType:[dic objectForKey:@"lendingLogo"]]) {
        case 0:
            price=@"+";
            self.zhilab.text = @"收";
            self.zhilab.backgroundColor = [RHUtility colorForHex:@"#f89779"];
         //   self.priceLabel.text = [NSString stringWithFormat:@"+%@",self.priceLabel.text];
            self.priceLabel.textColor=[RHUtility colorForHex:@"#f89779"];
            self.priceLabel.text=[NSString stringWithFormat:@"+%.2f",[[dic objectForKey:@"money"] floatValue]];
           // self.priceLabel.textColor=[RHUtility colorForHex:@"#40b5b8"];
            break;
        case 1:
            price=@"-";
            self.zhilab.text = @"支";
            self.zhilab.backgroundColor = [RHUtility colorForHex:@"#32CD32"];
           // self.priceLabel.text = [NSString stringWithFormat:@"-%@",self.priceLabel.text];
            self.priceLabel.textColor=[RHUtility colorForHex:@"#32CD32"];
            self.priceLabel.text=[NSString stringWithFormat:@"-%.2f",[[dic objectForKey:@"money"] floatValue]];
            break;

        case 2:
            price=@"";
            self.zhilab.text = @"冻";
            self.zhilab.backgroundColor = [RHUtility colorForHex:@"#7093DB"];
            
            self.priceLabel.textColor=[RHUtility colorForHex:@"#c6c6c6"];
            self.priceLabel.text=[NSString stringWithFormat:@"%.2f",[[dic objectForKey:@"money"] floatValue]];
            break;
        case 3:
            price=@"";
            self.zhilab.text = @"解";
            self.zhilab.backgroundColor = [RHUtility colorForHex:@"#EBC79E"];
            self.priceLabel.textColor=[RHUtility colorForHex:@"#c6c6c6"];
            self.priceLabel.text=[NSString stringWithFormat:@"%.2f",[[dic objectForKey:@"money"] floatValue]];
            break;
        case 4:
            price=@"";
            self.zhilab.text = @"平";
            self.zhilab.backgroundColor = [RHUtility colorForHex:@"#F8CD6C"];
            self.priceLabel.textColor=[RHUtility colorForHex:@"#c6c6c6"];
            self.priceLabel.text=[NSString stringWithFormat:@"%.2f",[[dic objectForKey:@"money"] floatValue]];
            break;
        case 5:
            price=@"";
            // self.priceLabel.textColor=[RHUtility colorForHex:@"#c6c6c6"];
            self.zhilab.backgroundColor = [RHUtility colorForHex:@"#7093DB"];
            
            self.priceLabel.textColor=[RHUtility colorForHex:@"#c6c6c6"];
            break;
        default:
            break;
    }
 //   self.priceLabel.text=[NSString stringWithFormat:@"%.2f",[[dic objectForKey:@"money"] floatValue]];
    self.typeLabel.text=[NSString stringWithFormat:@"%@",[dic objectForKey:@"type"] ];
}

-(NSString*)typeWithKey:(NSString*)type
{
    
    
    if ([type isEqualToString:@"Recharge"]) {
        self.zhilab.text = @"收";
        self.zhilab.backgroundColor = [RHUtility colorForHex:@"#f89779"];
        self.priceLabel.text = [NSString stringWithFormat:@"+%@",self.priceLabel.text];
        self.priceLabel.textColor=[RHUtility colorForHex:@"#f89779"];
        return @"快捷充值";
    }
    if ([type isEqualToString:@"OfflineRecharge"]) {
        self.zhilab.text = @"收";
        self.zhilab.backgroundColor = [RHUtility colorForHex:@"#f89779"];
        self.priceLabel.text = [NSString stringWithFormat:@"+%@",self.priceLabel.text];
        self.priceLabel.textColor=[RHUtility colorForHex:@"#f89779"];
        return @"转账充值";
    }
    if ([type isEqualToString:@"TenderGift"]) {
        self.zhilab.text = @"收";
        self.zhilab.backgroundColor = [RHUtility colorForHex:@"#f89779"];
        self.priceLabel.text = [NSString stringWithFormat:@"+%@",self.priceLabel.text];
        self.priceLabel.textColor=[RHUtility colorForHex:@"#f89779"];
        return @"出借红包";
    }
    if ([type isEqualToString:@"InitiativeTender"]) {
        self.zhilab.text = @"冻";
        self.zhilab.backgroundColor = [RHUtility colorForHex:@"#7093DB"];
        
        self.priceLabel.textColor=[RHUtility colorForHex:@"#c6c6c6"];
        return @"出借金额冻结";
    }
//    if ([type isEqualToString:@"TenderCancel"]) {
//        return @"出借金额解冻";
//    }
    if ([type isEqualToString:@"Loans"]) {
        self.zhilab.text = @"支";
        self.zhilab.backgroundColor = [RHUtility colorForHex:@"#32CD32"];
        self.priceLabel.text = [NSString stringWithFormat:@"-%@",self.priceLabel.text];
        self.priceLabel.textColor=[RHUtility colorForHex:@"#32CD32"];
        return @"出借放款";
    }
    if ([type isEqualToString:@"Capital"]) {
        self.zhilab.text = @"收";
        self.zhilab.backgroundColor = [RHUtility colorForHex:@"#f89779"];
        self.priceLabel.text = [NSString stringWithFormat:@"+%@",self.priceLabel.text];
        self.priceLabel.textColor=[RHUtility colorForHex:@"#f89779"];
        return @"还本";
    }
    if ([type isEqualToString:@"Interest"]) {
        self.zhilab.text = @"收";
        self.zhilab.backgroundColor = [RHUtility colorForHex:@"#f89779"];
        self.priceLabel.text = [NSString stringWithFormat:@"+%@",self.priceLabel.text];
        self.priceLabel.textColor=[RHUtility colorForHex:@"#f89779"];
        return @"利息";
    }
    if ([type isEqualToString:@"PenaltyInterest"]) {
        self.zhilab.text = @"收";
        self.zhilab.backgroundColor = [RHUtility colorForHex:@"#f89779"];
        self.priceLabel.text = [NSString stringWithFormat:@"+%@",self.priceLabel.text];
        self.priceLabel.textColor=[RHUtility colorForHex:@"#f89779"];
        return @"逾期罚息";
    }
    if ([type isEqualToString:@"Cash"]) {
        self.zhilab.text = @"支";
        self.zhilab.backgroundColor = [RHUtility colorForHex:@"#32CD32"];
        self.priceLabel.text = [NSString stringWithFormat:@"-%@",self.priceLabel.text];
        self.priceLabel.textColor=[RHUtility colorForHex:@"#32CD32"];
        return @"提现";
    }
    if ([type isEqualToString:@"CashFee"]||[type isEqualToString:@"CashFee"]) {
        self.zhilab.text = @"支";
        self.zhilab.backgroundColor = [RHUtility colorForHex:@"#32CD32"];
        self.priceLabel.text = [NSString stringWithFormat:@"-%@",self.priceLabel.text];
        self.priceLabel.textColor=[RHUtility colorForHex:@"#32CD32"];
        return @"提现手续费";
    }
    if ([type isEqualToString:@"PrepaymentPenalty"]) {
        self.zhilab.text = @"收";
        self.zhilab.backgroundColor = [RHUtility colorForHex:@"#f89779"];
        self.priceLabel.text = [NSString stringWithFormat:@"+%@",self.priceLabel.text];
        self.priceLabel.textColor=[RHUtility colorForHex:@"#f89779"];
        return @"提前还款利息违约金";
    }
    if ([type isEqualToString:@"SubsidyInterest"]) {
        self.zhilab.text = @"收";
        self.zhilab.backgroundColor = [RHUtility colorForHex:@"#f89779"];
        self.priceLabel.text = [NSString stringWithFormat:@"+%@",self.priceLabel.text];
        self.priceLabel.textColor=[RHUtility colorForHex:@"#f89779"];
        return @"贴息";
    }
    if ([type isEqualToString:@"AddInterest"]) {
        self.zhilab.text = @"收";
        self.zhilab.backgroundColor = [RHUtility colorForHex:@"#f89779"];
        self.priceLabel.text = [NSString stringWithFormat:@"+%@",self.priceLabel.text];
        self.priceLabel.textColor=[RHUtility colorForHex:@"#f89779"];
        return @"加息";
    }
    if ([type isEqualToString:@"PublishedFloatAway"]) {
        self.zhilab.text = @"解";
        self.zhilab.backgroundColor = [RHUtility colorForHex:@"#EBC79E"];
        self.priceLabel.textColor=[RHUtility colorForHex:@"#c6c6c6"];
        return @"出借金额解冻";
    }
    if ([type isEqualToString:@"FssTransIn"]) {
        self.zhilab.text = @"支";
        self.zhilab.backgroundColor = [RHUtility colorForHex:@"#32CD32"];
        self.priceLabel.text = [NSString stringWithFormat:@"-%@",self.priceLabel.text];
        self.priceLabel.textColor=[RHUtility colorForHex:@"#32CD32"];
        return @"转入生利宝";
    }
    if ([type isEqualToString:@"FssTransOut"]) {
        self.zhilab.text = @"收";
        self.zhilab.backgroundColor = [RHUtility colorForHex:@"#f89779"];
        self.priceLabel.text = [NSString stringWithFormat:@"+%@",self.priceLabel.text];
        self.priceLabel.textColor=[RHUtility colorForHex:@"#f89779"];
        return @"转出生利宝";
    }
    if ([type isEqualToString:@"DirecTrfIn"]) {
        self.zhilab.text = @"收";
        self.zhilab.backgroundColor = [RHUtility colorForHex:@"#f89779"];
        self.priceLabel.text = [NSString stringWithFormat:@"+%@",self.priceLabel.text];
        self.priceLabel.textColor=[RHUtility colorForHex:@"#f89779"];
        return @"定向转入";
    }
    if ([type isEqualToString:@"DirecTrfOut"]) {
        self.zhilab.text = @"支";
        self.zhilab.backgroundColor = [RHUtility colorForHex:@"#32CD32"];
        self.priceLabel.text = [NSString stringWithFormat:@"-%@",self.priceLabel.text];
        self.priceLabel.textColor=[RHUtility colorForHex:@"#32CD32"];
        return @"定向转出";
    }
    if ([type isEqualToString:@"RebateCash"]) {
        self.zhilab.text = @"收";
        self.zhilab.backgroundColor = [RHUtility colorForHex:@"#f89779"];
        self.priceLabel.text = [NSString stringWithFormat:@"+%@",self.priceLabel.text];
        self.priceLabel.textColor=[RHUtility colorForHex:@"#f89779"];
        return @"返现兑换";
    }
    if ([type isEqualToString:@"CheckIn"]) {
        self.zhilab.text = @"收";
        self.zhilab.backgroundColor = [RHUtility colorForHex:@"#f89779"];
        self.priceLabel.text = [NSString stringWithFormat:@"+%@",self.priceLabel.text];
        self.priceLabel.textColor=[RHUtility colorForHex:@"#f89779"];
        return @"调账转入";
    }
    if ([type isEqualToString:@"CheckOut"]) {
        self.zhilab.text = @"支";
        self.zhilab.backgroundColor = [RHUtility colorForHex:@"#32CD32"];
        self.priceLabel.text = [NSString stringWithFormat:@"-%@",self.priceLabel.text];
        self.priceLabel.textColor=[RHUtility colorForHex:@"#32CD32"];

        return @"调账转出";
    }
    if ([type isEqualToString:@"CashFail"]) {
        self.zhilab.text = @"收";
        self.zhilab.backgroundColor = [RHUtility colorForHex:@"#f89779"];
        self.priceLabel.text = [NSString stringWithFormat:@"+%@",self.priceLabel.text];
        self.priceLabel.textColor=[RHUtility colorForHex:@"#f89779"];
        return @"取现失败返还";
    }
    
    
    
    
    if ([type isEqualToString:@"AutoTender"]) {
        self.zhilab.text = @"冻";
        self.zhilab.backgroundColor = [RHUtility colorForHex:@"#7093DB"];
        
        self.priceLabel.textColor=[RHUtility colorForHex:@"#c6c6c6"];
        return @"自动投标";
    }
    if ([type isEqualToString:@"LoansBorrower"]) {
        self.zhilab.text = @"收";
        self.zhilab.backgroundColor = [RHUtility colorForHex:@"#f89779"];
        self.priceLabel.text = [NSString stringWithFormat:@"+%@",self.priceLabel.text];
        self.priceLabel.textColor=[RHUtility colorForHex:@"#f89779"];
        return @"放款-借款人";
    }
    if ([type isEqualToString:@"FeeBorrower"]) {
        self.zhilab.text = @"支";
        self.zhilab.backgroundColor = [RHUtility colorForHex:@"#32CD32"];
        self.priceLabel.text = [NSString stringWithFormat:@"-%@",self.priceLabel.text];
        self.priceLabel.textColor=[RHUtility colorForHex:@"#32CD32"];
        return @"服务费-借款人";
    }
    if ([type isEqualToString:@"CapitalBorrower"]) {
        self.zhilab.text = @"支";
        self.zhilab.backgroundColor = [RHUtility colorForHex:@"#32CD32"];
        self.priceLabel.text = [NSString stringWithFormat:@"-%@",self.priceLabel.text];
        self.priceLabel.textColor=[RHUtility colorForHex:@"#32CD32"];
        return @"还本-借款人";
    }
    if ([type isEqualToString:@"InterestBorrower"]) {
        self.zhilab.text = @"支";
        self.zhilab.backgroundColor = [RHUtility colorForHex:@"#32CD32"];
        self.priceLabel.text = [NSString stringWithFormat:@"-%@",self.priceLabel.text];
        self.priceLabel.textColor=[RHUtility colorForHex:@"#32CD32"];
        return @"付息-借款人";
    }
    
    if ([type isEqualToString:@"PenaltyInterestBorrower"]) {
        self.zhilab.text = @"支";
        self.zhilab.backgroundColor = [RHUtility colorForHex:@"#32CD32"];
        self.priceLabel.text = [NSString stringWithFormat:@"-%@",self.priceLabel.text];
        self.priceLabel.textColor=[RHUtility colorForHex:@"#32CD32"];
        return @"逾期罚息-借款人";
    }
    if ([type isEqualToString:@"PenaltyBorrower"]) {
        self.zhilab.text = @"支";
        self.zhilab.backgroundColor = [RHUtility colorForHex:@"#32CD32"];
        self.priceLabel.text = [NSString stringWithFormat:@"-%@",self.priceLabel.text];
        self.priceLabel.textColor=[RHUtility colorForHex:@"#32CD32"];
        return @"逾期违约金-借款人";
    }
    if ([type isEqualToString:@"PrepaymentPenaltyBorrower"]) {
        self.zhilab.text = @"支";
        self.zhilab.backgroundColor = [RHUtility colorForHex:@"#32CD32"];
        self.priceLabel.text = [NSString stringWithFormat:@"-%@",self.priceLabel.text];
        self.priceLabel.textColor=[RHUtility colorForHex:@"#32CD32"];
        return @"提前还款利息违约金-借款人";
    }
    return @"";
    
    
    
    
    
}

-(int)isAddTypeWithType:(NSString*)type
{
    if ([type isKindOfClass:[NSNull class]]||!type) {
        return 5;
    }
    if ([type isEqualToString:@"income"]) {
        return 0;
    }
    if ([type isEqualToString:@"pay"]) {
        return 1;
    }
    if ([type isEqualToString:@"freeze"]) {
        return 2;
    }
    if ([type isEqualToString:@"unfreeze"]) {
        return 3;
    }
    if ([type isEqualToString:@"flat"]) {
        return 4;
    }
    return 5;
}
@end
