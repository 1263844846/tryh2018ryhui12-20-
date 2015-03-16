//
//  RHUserCenterMainViewController.h
//  ryhui
//
//  Created by stefan on 15/3/15.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHBaseViewController.h"

@interface RHUserCenterMainViewController : RHBaseViewController

@property(nonatomic,strong)NSString* balance;

@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *ryUsername;

@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;
- (IBAction)pushAccountInfo:(id)sender;
- (IBAction)pushMyAccount:(id)sender;
- (IBAction)pushTradingRecord:(id)sender;
- (IBAction)pushMyInvestment:(id)sender;

- (IBAction)pushMain:(id)sender;
- (IBAction)pushUser:(id)sender;
- (IBAction)pushMore:(id)sender;

- (IBAction)pushPay:(id)sender;
- (IBAction)extractPayment:(id)sender;
@end
