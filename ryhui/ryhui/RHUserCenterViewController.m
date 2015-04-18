//
//  RHUserCenterViewController.m
//  ryhui
//
//  Created by stefan on 15/3/15.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHUserCenterViewController.h"
#import "RHMainViewController.h"
#import "RHForgotPasswordViewController.h"
#import "RHGesturePasswordViewController.h"

@interface RHUserCenterViewController ()

@end

@implementation RHUserCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configBackButton];
    [self configTitleWithString:@"账户信息"];
    if ([RHUserManager sharedInterface].telephone) {
        self.mobileLabel.text=[RHUserManager sharedInterface].telephone;
    }
    if ([RHUserManager sharedInterface].email) {
        self.emailLabel.text=[RHUserManager sharedInterface].email;
    }else{
        self.emailLabel.text=@"请登录网站绑定";
    }
        
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refesh) name:UIApplicationWillEnterForegroundNotification object:nil];

}



- (IBAction)logoutAction:(id)sender {
    [[RHUserManager sharedInterface] logout];
}

- (IBAction)pushMain:(id)sender {
    
    [[RHTabbarManager sharedInterface] selectTabbarMain];
    
}

- (IBAction)pushUserCenter:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)pushMore:(id)sender {
    [[RHTabbarManager sharedInterface] selectTabbarMore];
}

- (IBAction)changePasswordAction:(id)sender {
    RHForgotPasswordViewController* controller=[[RHForgotPasswordViewController alloc]initWithNibName:@"RHForgotPasswordViewController" bundle:nil];
    
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)changePanPasswordAction:(id)sender {
    RHGesturePasswordViewController* controller=[[RHGesturePasswordViewController alloc]init];
    controller.isReset=YES;
    [self.navigationController pushViewController:controller animated:YES];
}
@end
