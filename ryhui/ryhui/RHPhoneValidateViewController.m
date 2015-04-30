//
//  RHPhoneValidateViewController.m
//  ryhui
//
//  Created by 江 云龙 on 15/3/29.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHPhoneValidateViewController.h"
#import "RHPasswordConfirmViewController.h"

@interface RHPhoneValidateViewController ()
{
    int secondsCountDown;
    NSTimer* countDownTimer;
}

@end

@implementation RHPhoneValidateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.captchaButton.layer.cornerRadius=6;
    
    [self configBackButton];
    
    [self configTitleWithString:@"手机验证"];
    
    [self.phoneTF becomeFirstResponder];
    
    self.captchaButton.layer.cornerRadius=9;
    
}
-(void)back
{
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
}


- (IBAction)getCaptchaAction:(id)sender {
    [self.phoneTF resignFirstResponder];
    
    if ([self.phoneTF.text length]<=0) {
        [RHUtility showTextWithText:@"请输入手机号"];
        return;
    }
    
    NSDictionary *parameters = @{@"telephone":self.phoneTF.text,@"type":@"SMS_CAPTCHA_GETPWDBACK"};
    AFHTTPRequestOperationManager* manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[[AFCompoundResponseSerializer alloc]init];
    [manager POST:[NSString stringWithFormat:@"%@common/user/general/sendPwdBackTelCaptchaNoLogin",[RHNetworkService instance].doMain] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"result==%@ <<<",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        if ([responseObject isKindOfClass:[NSData class]]) {
            NSString* restult=[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            if ([restult isEqualToString:@"{\"msg\":\"手机验证码发送成功\"}"]||[restult isEqualToString:@"{\"msg\":\"success\"}"]) {
                //短信发送成功
                [RHUtility showTextWithText:@"验证码已发送至您的手机"];
                [self reSendMessage];
            }
        }else{
            NSDictionary* errorDic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            if ([errorDic objectForKey:@"msg"]) {
                [RHUtility showTextWithText:[errorDic objectForKey:@"msg"]];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"%@",error);
        if ([error.userInfo.allKeys containsObject:@"com.alamofire.serialization.response.error.data"]) {
            NSDictionary* errorDic=[NSJSONSerialization JSONObjectWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] options:NSJSONReadingMutableContainers error:nil];
            if ([errorDic objectForKey:@"msg"]) {
                [RHUtility showTextWithText:[errorDic objectForKey:@"msg"]];
            }
        }
    }];
}

-(void)reSendMessage
{
    secondsCountDown=60;
    self.captchaButton.enabled=NO;
    countDownTimer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
}
-(void)timeFireMethod
{
    secondsCountDown--;
    [self.captchaButton setTitle:[NSString stringWithFormat:@"重新发送(%d)",secondsCountDown] forState:UIControlStateNormal];
    if (secondsCountDown==0) {
        self.captchaButton.enabled=YES;
        [self.captchaButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [countDownTimer invalidate];
    }
    
}


- (IBAction)nextAction:(id)sender {
    
    if ([self.phoneTF.text length]<=0) {
        [RHUtility showTextWithText:@"请输入手机号码"];
        return;
    }
    if ([self.captchaTF.text length]<=0) {
        [RHUtility showTextWithText:@"请输入验证码"];
        return;
    }
    NSDictionary *parameters = @{@"telephone":self.phoneTF.text,@"telCaptcha":self.captchaTF.text};
    
    [[RHNetworkService instance] POST:@"common/user/pwdBack/findPwdBack2" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSString* result=[responseObject objectForKey:@"msg"];
            if (result&&[result length]>0) {
                if ([result isEqualToString:@"success"]) {
                    
                    [self pushChangePassword];
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

-(void)pushChangePassword
{
    RHPasswordConfirmViewController* controller=[[RHPasswordConfirmViewController alloc] initWithNibName:@"RHPasswordConfirmViewController" bundle:nil];
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
