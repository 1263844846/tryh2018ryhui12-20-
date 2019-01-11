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
#import "RHUserCountViewController.h"


@interface RHUserCenterViewController ()

@property (weak, nonatomic) IBOutlet UILabel *mobileLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;

@end

@implementation RHUserCenterViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[RHNetworkService instance] POST:@"app/front/payment/account/countUnReadMessage" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        DLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSString* numStr=nil;
            if (![[responseObject objectForKey:@"msgCount"] isKindOfClass:[NSNull class]]) {
                if ([[responseObject objectForKey:@"msgCount"] isKindOfClass:[NSNumber class]]) {
                    numStr=[[responseObject objectForKey:@"msgCount"] stringValue];
                }else{
                    numStr=[responseObject objectForKey:@"msgCount"];
                }
            }
            if (numStr) {
                [[NSUserDefaults standardUserDefaults] setObject:numStr forKey:@"RHMessageNumSave"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"RHMessageNum" object:numStr];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
    
    
}

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


//退出登录
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
    

    
    RHUserCountViewController * vc = [[RHUserCountViewController alloc]initWithNibName:@"RHUserCountViewController" bundle:nil];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}
@end
