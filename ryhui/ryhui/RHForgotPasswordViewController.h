//
//  RHForgotPasswordViewController.h
//  ryhui
//
//  Created by jufenghudong on 15/3/29.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHBaseViewController.h"

@interface RHForgotPasswordViewController : RHBaseViewController
@property (weak, nonatomic) IBOutlet UITextField *oldPasswordTF;
@property (weak, nonatomic) IBOutlet UITextField *rnewPasswordTF;
@property (weak, nonatomic) IBOutlet UITextField *captchaTF;
@property (weak, nonatomic) IBOutlet UITextField *nnewPasswordTF;
@property (weak, nonatomic) IBOutlet UIImageView *captchaImageView;
- (IBAction)changeAction:(id)sender;

@end
