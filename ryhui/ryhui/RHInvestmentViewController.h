//
//  RHInvestmentViewController.h
//  ryhui
//
//  Created by 江 云龙 on 15/3/18.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHBaseViewController.h"

@interface RHInvestmentViewController : RHBaseViewController<UITextFieldDelegate>

@property(nonatomic,strong)NSString* projectId;

@property(nonatomic,strong)NSDictionary* dataDic;

@property(nonatomic,assign)int projectFund;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *investorRateLabel;
@property (weak, nonatomic) IBOutlet UILabel *limitTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *projectFundLabel;
@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;
- (IBAction)pushAreegment:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *textFiled;
- (IBAction)Investment:(id)sender;
- (IBAction)allIn:(id)sender;
- (IBAction)recharge:(id)sender;
@end
