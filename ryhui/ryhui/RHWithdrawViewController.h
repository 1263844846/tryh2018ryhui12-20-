//
//  RHWithdrawViewController.h
//  ryhui
//
//  Created by 江 云龙 on 15/3/29.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHBaseViewController.h"

@interface RHWithdrawViewController : RHBaseViewController<UITextFieldDelegate>
{
    double free;
}
- (IBAction)hiddenKeyBorad:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *overView;

@property (weak, nonatomic) IBOutlet UIButton *captchaButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *cardLabel;
@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;
@property (weak, nonatomic) IBOutlet UITextField *withdrawTF;
@property (weak, nonatomic) IBOutlet UILabel *freeLabel;
@property (weak, nonatomic) IBOutlet UILabel *getAmountLabel;
@property (weak, nonatomic) IBOutlet UITextField *captchaTF;
- (IBAction)withdrawAction:(id)sender;
- (IBAction)bindCardAction:(id)sender;

- (IBAction)pushMain:(id)sender;
- (IBAction)pushUser:(id)sender;
- (IBAction)pushMore:(id)sender;
@end
