//
//  RHInvestmentViewController.m
//  ryhui
//
//  Created by 江 云龙 on 15/3/18.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHInvestmentViewController.h"
#import "RHInvestmentWebViewController.h"
#import "RHRechargeViewController.h"

@interface RHInvestmentViewController ()

@end

@implementation RHInvestmentViewController
@synthesize projectId;
@synthesize dataDic;
@synthesize projectFund;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configBackButton];
    
    [self configTitleWithString:@"投资"];
    
    [self setupWithDic:self.dataDic];

    [self checkout];
}

-(void)setupWithDic:(NSDictionary*)dic
{
    self.projectId=[dic objectForKey:@"id"];
    self.nameLabel.text=[dic objectForKey:@"name"];
    self.investorRateLabel.text=[[dic objectForKey:@"investorRate"] stringValue];
    self.limitTimeLabel.text=[[dic objectForKey:@"limitTime"] stringValue];
    self.projectFundLabel.text=[NSString stringWithFormat:@"%.1f",([[dic objectForKey:@"projectFund"] floatValue]/10000.0)];
}

- (void)checkout
{
    [[RHNetworkService instance] POST:@"front/payment/account/queryBalance" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSString* AvlBal=[responseObject objectForKey:@"AvlBal"];
            if (AvlBal&&[AvlBal length]>0) {
                self.balanceLabel.text=AvlBal;
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"%@",error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)pushAreegment:(id)sender {
}
- (IBAction)Investment:(id)sender {
    int amount=[self.textFiled.text intValue];
    if (amount%100!=0||amount==0) {
        [RHUtility showTextWithText:@"投资金额需为100的整数倍"];
        return;
    }
    RHInvestmentWebViewController* controller=[[RHInvestmentWebViewController alloc]initWithNibName:@"RHInvestmentWebViewController" bundle:nil];
    controller.price=self.textFiled.text;
    controller.projectId=self.projectId;
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)allIn:(id)sender {
    int balance=[[RHUserManager sharedInterface].balance intValue];
    int allinAmount=(balance/100)*100;
    
    int project=(projectFund/100)*100;
    
    if (allinAmount>project) {
        
        self.textFiled.text=[NSString stringWithFormat:@"%d",project];
    }else{
        self.textFiled.text=[NSString stringWithFormat:@"%d",project];
    }
}

- (IBAction)recharge:(id)sender {
    RHRechargeViewController* controller=[[RHRechargeViewController alloc]initWithNibName:@"RHRechargeViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}
@end
