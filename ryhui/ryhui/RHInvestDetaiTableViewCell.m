//
//  RHInvestDetaiTableViewCell.m
//  ryhui
//
//  Created by jufenghudong on 15/4/9.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHInvestDetaiTableViewCell.h"

@implementation RHInvestDetaiTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

//id = 675;
//money = "1622.36";
//payDate = "2015-06-10";
//status = 1;
//type = interest;
//typeName = "\U5229\U606f";

-(void)updateCell:(NSDictionary*)dic
{
    NSString* status=nil;
    if ([[dic objectForKey:@"status"] isKindOfClass:[NSNumber class]]) {
        status=[[dic objectForKey:@"status"] stringValue];
    }else{
        status=[dic objectForKey:@"status"];
    }
    NSString*type =[dic objectForKey:@"type"];
    if ([type isEqualToString:@"capital"]) {
        [self.iconImageView setImage:[UIImage imageNamed:@"RepaymentSchedule2"]];
      //  self.typeLabel.textColor=[RHUtility colorForHex:@"318fc5"];
        self.namelab.text = @"本金";
    }else{
        //self.typeLabel.textColor=[RHUtility colorForHex:@"ff5d25"];
        [self.iconImageView setImage:[UIImage imageNamed:@"RepaymentSchedule1"]];
        if ([type isEqualToString:@"subsidy_interest"]) {
            self.namelab.text = dic[@"typeName"];
        }else if ([type isEqualToString:@"Penalty_interest"]){
            self.namelab.text = @"罚息";
        }else if ([type isEqualToString:@"Prepayment_Penalty"]){
            self.namelab.text = @"违约利息";
            
        }else{
        self.namelab.text = dic[@"typeName"];
        }
        //lixi
    }
    
    if ([status isEqualToString:@"0"]) {
   
        self.typeImagView.image= [UIImage imageNamed:@"融益汇app完整wh"];
    }else{

        self.typeImagView.image= [UIImage imageNamed:@"融益汇app完整hk"];
    }
    NSString* money=nil;
    if ([[dic objectForKey:@"money"] isKindOfClass:[NSNumber class]]) {
        money=[[dic objectForKey:@"money"] stringValue];
    }else{
        money=[dic objectForKey:@"money"];
    }
    
    self.typeLabel.text=[NSString stringWithFormat:@"%.2f",[money floatValue]];
    self.timeLabel.text=[dic objectForKey:@"payDate"];
}


@end
