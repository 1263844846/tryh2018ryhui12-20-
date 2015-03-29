//
//  RHPasswordConfirmViewController.h
//  ryhui
//
//  Created by 江 云龙 on 15/3/29.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHBaseViewController.h"

@interface RHPasswordConfirmViewController : RHBaseViewController

@property (weak, nonatomic) IBOutlet UITextField *nnewPasswordTF;
@property (weak, nonatomic) IBOutlet UITextField *cPasswordTF;
- (IBAction)nextAction:(id)sender;
- (IBAction)showAction:(id)sender;
@end
