//
//  RHRechargeViewController.h
//  ryhui
//
//  Created by stefan on 15/3/15.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHBaseViewController.h"

@interface RHRechargeViewController : RHBaseViewController
@property(nonatomic,strong)NSString* balance;

@property (weak, nonatomic) IBOutlet UITextField *textField;
- (IBAction)recharge:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;
@end
