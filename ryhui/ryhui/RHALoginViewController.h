//
//  RHALoginViewController.h
//  ryhui
//
//  Created by 江 云龙 on 15/2/13.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHBaseViewController.h"

@interface RHALoginViewController : RHBaseViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *captchaTextField;
@property (weak, nonatomic) IBOutlet UIImageView *captchaImageView;

- (IBAction)loginAction:(id)sender;
@end
