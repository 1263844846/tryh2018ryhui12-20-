//
//  RHInvestmentViewController.h
//  ryhui
//
//  Created by 江 云龙 on 15/3/18.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHBaseViewController.h"
#import "RHChooseGiftViewController.h"

@interface RHInvestmentViewController : RHBaseViewController<UITextFieldDelegate,chooseGiftDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *textBG;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UIImageView *gifticon;
@property (weak, nonatomic) IBOutlet UIView *giftSupperView;
@property(nonatomic,strong)NSString* projectId;
@property(nonatomic,strong)NSString* giftId;

@property(nonatomic,strong)NSDictionary* dataDic;

@property(nonatomic,assign)int projectFund;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *investorRateLabel;
@property (weak, nonatomic) IBOutlet UILabel *limitTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *projectFundLabel;
@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;
- (IBAction)pushAreegment:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *textFiled;
@property (weak, nonatomic) IBOutlet UIView *giftView;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label0;
@property (weak, nonatomic) IBOutlet UIButton *chooseButton;
- (IBAction)Investment:(id)sender;
- (IBAction)allIn:(id)sender;
- (IBAction)recharge:(id)sender;
- (IBAction)chooseGift:(id)sender;
@end
