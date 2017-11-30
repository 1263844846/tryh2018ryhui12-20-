//
//  RHMyInvestmentViewCell.m
//  ryhui
//
//  Created by stefan on 15/3/15.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHMyInvestmentViewCell.h"
#import "RHContractViewContoller.h"
#import "RHInvestDetailViewController.h"

@implementation RHMyInvestmentViewCell
@synthesize nav;
@synthesize projectId;

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
   
    
}

-(void)updateCell:(NSDictionary*)dic
{
//    DLog(@"%@",dic);
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(regist)];
    self.nameLabel.text=[dic objectForKey:@"name"];
    self.projectId=[dic objectForKey:@"id"];
    
    NSString* investMoney=@"0.00";
    if (![[dic objectForKey:@"investMoney"] isKindOfClass:[NSNull class]]) {
        investMoney=[NSString stringWithFormat:@"%.2f",[[dic objectForKey:@"investMoney"] doubleValue]];
    }
    self.investMoneyLabel.text=investMoney;
    NSString* backMoney=@"0.00";
    if (![[dic objectForKey:@"backMoney"] isKindOfClass:[NSNull class]]) {
        backMoney=[NSString stringWithFormat:@"%.2f",[[dic objectForKey:@"backMoney"] doubleValue]];
    }
    self.backMoneyLabel.text=backMoney;
    
    self.profitMoneyLabel.text=[NSString stringWithFormat:@"%.2f",[[dic objectForKey:@"waitMoney"] doubleValue]];
}

//合同
- (IBAction)contractAction:(id)sender {
    RHContractViewContoller* controller=[[RHContractViewContoller alloc]initWithNibName:@"RHContractViewContoller" bundle:nil];
    controller.projectId=self.projectId;
    [nav pushViewController:controller animated:YES];
    
}

//还款计划
- (IBAction)pushInvestDetail:(id)sender {
    RHInvestDetailViewController* controller=[[RHInvestDetailViewController alloc] initWithNibName:@"RHInvestDetailViewController" bundle:nil];
    if ([self.type isEqualToString:@"{\"groupOp\":\"AND\",\"rules\":[{\"field\":\"projectStatus\",\"op\":\"in\",\"data\":[\"full\",\"loans\",\"published\",\"loans_audit\"]}]}"]) {
        controller.res = 3;
    }
    controller.projectId=self.projectId;
//    controller.myblock();
    [nav pushViewController:controller animated:YES];
}


@end
