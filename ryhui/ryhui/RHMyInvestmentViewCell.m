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
    DLog(@"%@",dic);
    self.nameLabel.text=[dic objectForKey:@"name"];
    self.projectId=[dic objectForKey:@"id"];

    NSString* investMoney=@"0.00";
    if (![[dic objectForKey:@"investMoney"] isKindOfClass:[NSNull class]]) {
        investMoney=[NSString stringWithFormat:@"%.2f",[[dic objectForKey:@"investMoney"] floatValue]];
    }
    self.investMoneyLabel.text=investMoney;
    NSString* backMoney=@"0.00";
    if (![[dic objectForKey:@"backMoney"] isKindOfClass:[NSNull class]]) {
        backMoney=[NSString stringWithFormat:@"%.2f",[[dic objectForKey:@"backMoney"] floatValue]];
    }
    self.backMoneyLabel.text=backMoney;
    
    self.profitMoneyLabel.text=[NSString stringWithFormat:@"%@",[dic objectForKey:@"waitMoney"]];
}

- (IBAction)contractAction:(id)sender {
    RHContractViewContoller* controller=[[RHContractViewContoller alloc]initWithNibName:@"RHContractViewContoller" bundle:nil];
    controller.projectId=self.projectId;
    [nav pushViewController:controller animated:YES];
}

- (IBAction)pushInvestDetail:(id)sender {
    RHInvestDetailViewController* controller=[[RHInvestDetailViewController alloc] initWithNibName:@"RHInvestDetailViewController" bundle:nil];
    controller.projectId=self.projectId;
    [nav pushViewController:controller animated:YES];
}
@end
