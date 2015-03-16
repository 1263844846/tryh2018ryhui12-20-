//
//  RHMyAccountViewController.h
//  ryhui
//
//  Created by stefan on 15/3/15.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHBaseViewController.h"
#import "RHRechargeViewController.h"

@interface RHMyAccountViewController : RHBaseViewController
@property(nonatomic,strong)NSString* balance;

- (IBAction)pushMain:(id)sender;
- (IBAction)pushUser:(id)sender;
- (IBAction)pushMore:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *collectCapitalLabel;
@property (weak, nonatomic) IBOutlet UILabel *averageLabel;
@property (weak, nonatomic) IBOutlet UILabel *earnInterestLabel;
@property (weak, nonatomic) IBOutlet UILabel *collectInterestLabel;
@property (weak, nonatomic) IBOutlet UILabel *collectPrepaymentPenaltyLabel;
@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;
- (IBAction)pushPay:(id)sender;
@end
