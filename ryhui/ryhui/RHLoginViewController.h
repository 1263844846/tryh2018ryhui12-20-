//
//  RHLoginViewController.h
//  ryhui
//
//  Created by stefan on 15/2/13.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHBaseViewController.h"

@interface RHLoginViewController : RHBaseViewController

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

@property (weak, nonatomic) IBOutlet UIView *buttonView;

@property (nonatomic,strong)UINavigationController* nav;

- (IBAction)loginAction:(id)sender;
- (IBAction)registerAction:(id)sender;
- (IBAction)qRegisterAction:(id)sender;
@end
