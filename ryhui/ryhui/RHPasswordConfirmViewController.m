//
//  RHPasswordConfirmViewController.m
//  ryhui
//
//  Created by 江 云龙 on 15/3/29.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHPasswordConfirmViewController.h"
#import "RHFindPWDoneViewController.h"

@interface RHPasswordConfirmViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nnewPasswordTF;
@property (weak, nonatomic) IBOutlet UITextField *cPasswordTF;

@end

@implementation RHPasswordConfirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configBackButton];
    
    [self configTitleWithString:@"确认密码"];

    self.nnewPasswordTF.secureTextEntry=YES;
    
    self.cPasswordTF.secureTextEntry=YES;
    
    [self.nnewPasswordTF becomeFirstResponder];
}

-(void)back
{
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
}


- (IBAction)nextAction:(id)sender {
    
    [self.nnewPasswordTF resignFirstResponder];
    [self.cPasswordTF resignFirstResponder];
    if ([self.nnewPasswordTF.text length]<=0) {
        [RHUtility showTextWithText:@"请输入新密码"];
        return;
    }
    if ([self.cPasswordTF.text length]<=0) {
        [RHUtility showTextWithText:@"请输入确认密码"];
        return;
    }
    NSDictionary *parameters = @{@"password":self.nnewPasswordTF.text,@"passwordRepeat":self.cPasswordTF.text};
    
    [[RHNetworkService instance] POST:@"common/user/pwdBack/findPwdBack3" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        DLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSString* result=[responseObject objectForKey:@"msg"];
            if (result&&[result length]>0) {
                if ([result isEqualToString:@"success"]) {
                    
                    [self pushChangeSucceed];
                }
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if ([error.userInfo.allKeys containsObject:@"com.alamofire.serialization.response.error.data"]) {
            NSDictionary* errorDic=[NSJSONSerialization JSONObjectWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] options:NSJSONReadingMutableContainers error:nil];
            if ([errorDic objectForKey:@"msg"]) {
                [RHUtility showTextWithText:[errorDic objectForKey:@"msg"]];
            }
        }
    }];
}

- (IBAction)showAction:(id)sender {
    UIButton* button=sender;
    
    if ([button.titleLabel.text isEqualToString:@"显示"]) {
        self.nnewPasswordTF.secureTextEntry=NO;
        self.cPasswordTF.secureTextEntry=NO;
        [button setTitle:@"隐藏" forState:UIControlStateNormal];
    }else{
        self.nnewPasswordTF.secureTextEntry=YES;
        self.cPasswordTF.secureTextEntry=YES;
        [button setTitle:@"显示" forState:UIControlStateNormal];
    }
}

-(void)pushChangeSucceed
{
    RHFindPWDoneViewController* controller=[[RHFindPWDoneViewController alloc]initWithNibName:@"RHFindPWDoneViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    for (UIView *subView in [UIApplication sharedApplication].keyWindow.subviews) {
        if (subView.tag == 1000) {
            [subView removeFromSuperview];
        }
    }
    [super viewWillDisappear:animated];
}
@end
