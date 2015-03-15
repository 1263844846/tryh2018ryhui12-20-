//
//  RHUserCenterViewController.h
//  ryhui
//
//  Created by stefan on 15/3/15.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHBaseViewController.h"

@interface RHUserCenterViewController : RHBaseViewController
@property (weak, nonatomic) IBOutlet UILabel *mobileLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;

- (IBAction)logoutAction:(id)sender;
- (IBAction)pushMain:(id)sender;
- (IBAction)pushUserCenter:(id)sender;
- (IBAction)pushMore:(id)sender;
- (IBAction)changePasswordAction:(id)sender;
- (IBAction)changePanPasswordAction:(id)sender;
@end
