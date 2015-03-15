//
//  RHRegisterViewController.h
//  ryhui
//
//  Created by stefan on 15/2/27.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHBaseViewController.h"

@interface RHRegisterViewController : RHBaseViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *createAccountView;

@property (weak, nonatomic) IBOutlet UIView *webRegisterView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *webButton;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIView *otherRegisterView;
@property (weak, nonatomic) IBOutlet UIButton *otherButton;

@property (weak, nonatomic) IBOutlet UIImageView *webRegisterSbg;
@property (weak, nonatomic) IBOutlet UILabel *webRegisterLab;
@property (weak, nonatomic) IBOutlet UIImageView *ohterRegisterSbg;
@property (weak, nonatomic) IBOutlet UILabel *otherRegisterLab;
@property (weak, nonatomic) IBOutlet UIImageView *captchaImageView;

@property (weak, nonatomic) IBOutlet UITextField *accountTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF1;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF2;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTF;
@property (weak, nonatomic) IBOutlet UITextField *captchaImageTF;
@property (weak, nonatomic) IBOutlet UITextField *captchaPhoneTF;
@property (weak, nonatomic) IBOutlet UIButton *captchaPhoneButton;
@property (weak, nonatomic) IBOutlet UIButton *captchaImageButton;


- (IBAction)selectOtherAciton:(id)sender;
- (IBAction)selectWebAction:(id)sender;

- (IBAction)getCaptchaAction:(id)sender;
- (IBAction)changeCaptchaAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *agreementView;
- (IBAction)agreement1Action:(id)sender;
- (IBAction)agreement2Action:(id)sender;
- (IBAction)registerAction:(id)sender;

- (IBAction)CreateAccount:(id)sender;
@end
