//
//  RHALoginViewController.h
//  ryhui
//
//  Created by stefan on 15/2/13.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHBaseViewController.h"

@interface RHALoginViewController : RHBaseViewController<UITextFieldDelegate>

@property(nonatomic,assign)BOOL isForgotV;
@property(nonatomic,assign)BOOL isPan;


@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *captchaTextField;
@property (weak, nonatomic) IBOutlet UIImageView *captchaImageView;
- (IBAction)forgetAction:(id)sender;

- (IBAction)loginAction:(id)sender;
@end
