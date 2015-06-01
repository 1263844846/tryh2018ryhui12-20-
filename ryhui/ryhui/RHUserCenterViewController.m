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

@property (weak, nonatomic) IBOutlet UILabel *mobileLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;

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
}



- (IBAction)logoutAction:(id)sender {
    
    UIAlertView* alertView=[[UIAlertView alloc]initWithTitle:@"退出确认"
                                                     message:@"您确定要退出当前账号？"
                                                    delegate:self
                                           cancelButtonTitle:@"确定"
                                           otherButtonTitles:@"取消", nil];
    alertView.tag=999;
    [alertView show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        if (alertView.tag==999) {
            [[RHUserManager sharedInterface] logout];
        }else{
            [[RHUserManager sharedInterface] logout];
            [[RHTabbarManager sharedInterface] selectALogin];
        }
    }
}

- (IBAction)pushMain:(id)sender {
    
    [[[RHTabbarManager sharedInterface] selectTabbarMain] popToRootViewControllerAnimated:NO];
    
}

- (IBAction)pushUserCenter:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)pushMore:(id)sender {
    [[[RHTabbarManager sharedInterface] selectTabbarMore] popToRootViewControllerAnimated:NO];
}

- (IBAction)changePasswordAction:(id)sender {

    RHForgotPasswordViewController* controller=[[RHForgotPasswordViewController alloc]initWithNibName:@"RHForgotPasswordViewController" bundle:nil];
    
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)changePanPasswordAction:(id)sender {
    
    UIAlertView* alertView=[[UIAlertView alloc]initWithTitle:nil
                                                     message:@"修改手势密码需要退出登录验证账号密码"
                                                    delegate:self
                                           cancelButtonTitle:@"确定"
                                           otherButtonTitles:@"取消", nil];
    alertView.tag=998;
    [alertView show];

//    RHGesturePasswordViewController* controller=[[RHGesturePasswordViewController alloc]init];
//    controller.isReset=YES;
//    [self.navigationController pushViewController:controller animated:YES];
}
@end
