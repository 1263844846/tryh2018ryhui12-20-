//
//  RHPhoneValidateViewController.h
//  ryhui
//
//  Created by 江 云龙 on 15/3/29.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHBaseViewController.h"

@interface RHPhoneValidateViewController : RHBaseViewController

@property (weak, nonatomic) IBOutlet UIButton *captchaButton;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *captchaTF;
- (IBAction)nextAction:(id)sender;
- (IBAction)getCaptchaAction:(id)sender;
@end
