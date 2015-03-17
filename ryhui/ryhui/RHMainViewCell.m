//
//  RHMainViewCell.m
//  ryhui
//
//  Created by stefan on 15/3/14.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHMainViewCell.h"
#import "CircleProgressView.h"

@implementation RHMainViewCell
@synthesize progressView;

- (void)awakeFromNib {
    self.backgroundColor=[UIColor clearColor];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    // Initialization code
    self.progressView = [[CircleProgressView alloc]
                         initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-18-5-60, 23, 60, 60)
                         withCenter:CGPointMake(50.0 / 2.0, 54 / 2.0)
                         Radius:40 / 2.0
                         lineWidth:4];

    [self.customView addSubview:progressView];
    
    self.pointImageView.layer.cornerRadius=10;
    
}
//available = 0;
//fullTime = "2015-03-13 17:09:28";
//id = 36;
//insuranceId = 24;
//insuranceLogo = "pubNews/56b21a0f-4fa3-472d-bd5c-8c63453c9ba9.png";
//insuranceMethod = "\U4e91\U5357\U5408\U5174\U878d\U8d44\U62c5\U4fdd\U80a1\U4efd\U6709\U9650\U516c\U53f8";
//investorRate = 10;
//limitTime = 6;
//logo = "<null>";
//name = "\U755c\U4ea7\U54c1\U751f\U4ea7\U4f01\U4e1a\U6cd5\U4eba\U4ee3\U8868\U7ecf\U8425\U6027\U501f\U6b3e";
//paymentName = "\U6309\U6708\U4ed8\U606f\U3001\U5230\U671f\U8fd8\U672c";
//percent = 100;
//projectFund = 2000000;
//projectStatus = "repayment_normal";
//studentLoan = 0;
-(void)updateCell:(NSDictionary*)dic
{
    NSString* name=@"";
    if (![[dic objectForKey:@"name"] isKindOfClass:[NSNull class]]) {
        name=[dic objectForKey:@"name"];
    }
    self.nameLabel.text=name;
    NSString* paymentName=@"";
    if (![[dic objectForKey:@"paymentName"] isKindOfClass:[NSNull class]]) {
        paymentName=[dic objectForKey:@"paymentName"];
    }
    self.paymentNameLabel.text=paymentName;
    NSString* investorRate=@"0";
    if (![[dic objectForKey:@"investorRate"] isKindOfClass:[NSNull class]]) {
        investorRate=[[dic objectForKey:@"investorRate"] stringValue];
    }
    self.investorRateLabel.text=investorRate;
    NSString* limitTime=@"0";
    if (![[dic objectForKey:@"limitTime"] isKindOfClass:[NSNull class]]) {
        limitTime=[[dic objectForKey:@"limitTime"] stringValue];
    }
    self.limitTimeLabel.text=limitTime;
    NSString* projectFund=@"0";
    if (![[dic objectForKey:@"projectFund"] isKindOfClass:[NSNull class]]) {
        projectFund=[NSString stringWithFormat:@"%.1f",([[dic objectForKey:@"projectFund"] floatValue]/10000.0)];
    }
    self.projectFundLabel.text=projectFund;
    NSString* insuranceMethod=@"";
    if (![[dic objectForKey:@"insuranceMethod"] isKindOfClass:[NSNull class]]) {
        insuranceMethod=[dic objectForKey:@"insuranceMethod"];
    }
    self.insuranceMethodLabel.text=insuranceMethod;
    [self.logoImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[RHNetworkService instance].doMain,[dic objectForKey:@"insuranceLogo"]]]];
    CGFloat percent=0;
    if (![[dic objectForKey:@"percent"] isKindOfClass:[NSNull class]]) {
        percent=[[dic objectForKey:@"percent"] floatValue]/100.0;
    }
    [self.progressView setProgress:percent];
}
@end
