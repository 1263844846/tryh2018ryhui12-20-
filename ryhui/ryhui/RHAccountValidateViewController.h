//
//  RHAccountValidateViewController.h
//  ryhui
//
//  Created by jufenghudong on 15/3/29.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHBaseViewController.h"

@interface RHAccountValidateViewController : RHBaseViewController

@property (weak, nonatomic) IBOutlet UITextField *accountTF;
@property (weak, nonatomic) IBOutlet UITextField *captchaTF;
@property (weak, nonatomic) IBOutlet UIImageView *captchaImageView;
- (IBAction)nextAction:(id)sender;
- (IBAction)changeCaptcha:(id)sender;
@end
