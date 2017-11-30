//
//  RHAccountValidateViewController.m
//  ryhui
//
//  Created by jufenghudong on 15/3/29.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHAccountValidateViewController.h"
#import "RHPhoneValidateViewController.h"
#import "MBProgressHUD.h"
#import "RHALoginViewController.h"
@interface RHAccountValidateViewController ()
{
    int secondsCountDown;
    NSTimer *countDownTimer;
    
}

@property (weak, nonatomic) IBOutlet UITextField *accountTF;
@property (weak, nonatomic) IBOutlet UITextField *captchaTF;
@property (weak, nonatomic) IBOutlet UIImageView *captchaImageView;
@property (weak, nonatomic) IBOutlet UITextField *yanzhengmaTF;
@property (weak, nonatomic) IBOutlet UITextField *newpdTF;
@property (weak, nonatomic) IBOutlet UIImageView *mingwenimage;
@property (weak, nonatomic) IBOutlet UIButton *catcpbutton;
@property (weak, nonatomic) IBOutlet UIButton *nextbutton;
@property(nonatomic,assign)BOOL res;

@end

@implementation RHAccountValidateViewController

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.accountTF resignFirstResponder];
    [self.captchaTF resignFirstResponder];
    [self.yanzhengmaTF resignFirstResponder];
    [self.newpdTF resignFirstResponder];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configBackButton];
    [self configTitleWithString:@"找回密码"];
    self.mingwenimage.userInteractionEnabled  = YES;
    
    UITapGestureRecognizer * tap  =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(mingwen)];
    
    [self.mingwenimage addGestureRecognizer:tap];
    self.catcpbutton.layer.masksToBounds=YES;
    self.catcpbutton.layer.cornerRadius=3;
    self.nextbutton.layer.masksToBounds=YES;
    self.nextbutton.layer.cornerRadius=5;
    self.newpdTF.secureTextEntry = YES;
}

-(void)mingwen{
    
    NSLog(@"mingwen");
    
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self changeCaptcha];
}

-(void)changeCaptcha
{
    AFHTTPRequestOperationManager* manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[[AFImageResponseSerializer alloc]init];
    manager.securityPolicy = [[RHNetworkService instance] customSecurityPolicy];
    [manager POST:[NSString stringWithFormat:@"%@%@",[RHNetworkService instance].newdoMain,@"app/common/user/appGeneral/captcha?type=CAPTCHA_GETPWDBACK"] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject isKindOfClass:[UIImage class]]) {
            self.captchaImageView.image=responseObject;
        }
        NSArray* array=[[operation.response.allHeaderFields objectForKey:@"Set-Cookie"] componentsSeparatedByString:@";"];
        [[NSUserDefaults standardUserDefaults] setObject:[array objectAtIndex:0] forKey:@"RHSESSION"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

- (IBAction)nextAction:(id)sender {
    
    
    [self.accountTF resignFirstResponder];
    [self.captchaTF resignFirstResponder];
    
    if ([self.accountTF.text length]<=0) {
        [RHUtility showTextWithText:@"请输入手机号"];
        return;
    }
    
    if ([self.captchaTF.text length]<=0) {
        [RHUtility showTextWithText:@"请输入图片验证码"];
        return;
    }if ([self.yanzhengmaTF.text length]<=0) {
        [RHUtility showTextWithText:@"请输入手机验证码"];
        return;
    }
    if ([self.newpdTF.text length]<=0) {
        [RHUtility showTextWithText:@"请输入新密码"];
        return;
    }
    
    if (![self.accountTF.text isEqualToString:[RHUserManager sharedInterface].telephone]&&[RHUserManager sharedInterface].telephone) {
        [RHUtility showTextWithText:@"手机号输入有误"];
        return;
    }
    
    NSDictionary *parameters = @{@"telephone":self.accountTF.text,@"captcha":self.captchaTF.text,@"telCaptcha":self.yanzhengmaTF.text,@"password":self.newpdTF.text};
    
    [[RHNetworkService instance] POST:@"app/common/user/appUpdateUser/appFindPWd" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        DLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSString* result=[responseObject objectForKey:@"msg"];
            if (result&&[result length]>0) {
                if ([result isEqualToString:@"success"]) {
                    
                   // [self pushPhoneValidate];
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    [RHUtility showTextWithText:@"密码找回成功     跳转登录页面"];
                    
                    
                    [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(delayMethod) userInfo:nil repeats:NO];
                    
                  
        
                    
                    
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
-(void)delayMethod{
    [[RHUserManager sharedInterface] logout];
    RHALoginViewController * vc = [[RHALoginViewController alloc]initWithNibName:@"RHALoginViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)pushPhoneValidate
{
    RHPhoneValidateViewController* controller=[[RHPhoneValidateViewController alloc]initWithNibName:@"RHPhoneValidateViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
    
}

- (IBAction)changeCaptcha:(id)sender {
    [self changeCaptcha];
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

- (IBAction)huoquyanzhengma:(id)sender {
    //'15878888888
    if (![self.accountTF.text isEqualToString:[RHUserManager sharedInterface].telephone]&&[RHUserManager sharedInterface].telephone) {
        [RHUtility showTextWithText:@"手机号输入有误"];
        return;
    }
    NSDictionary *parameters = @{@"telephone":self.self.accountTF.text,@"type":@"SMS_CAPTCHA_GETPWDBACK"};
    AFHTTPRequestOperationManager* manager=[AFHTTPRequestOperationManager manager];
    manager.securityPolicy = [[RHNetworkService instance] customSecurityPolicy];
    manager.responseSerializer=[[AFCompoundResponseSerializer alloc]init];
    
    [manager POST:[NSString stringWithFormat:@"%@app/common/user/appGeneral/appSendPwdBackTelCaptcha",[RHNetworkService instance].newdoMain] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"result==%@ <<<",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        if ([responseObject isKindOfClass:[NSData class]]) {
            NSString* restult=[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            if ([restult isEqualToString:@"{\"msg\":\"手机验证码发送成功\"}"]||[restult isEqualToString:@"{\"msg\":\"success\"}"]) {
                //短信发送成功
                [RHUtility showTextWithText:@"验证码已发送至您的手机"];
                [self reSendMessage];
            }else{
                NSDictionary* errorDic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                if ([errorDic objectForKey:@"msg"]) {
                    //DLog(@"%@",[errorDic objectForKey:@"msg"]);
                    if ([[errorDic objectForKey:@"msg"] isEqualToString:@"图片验证码错误"]) {
                    }
                    [RHUtility showTextWithText:[errorDic objectForKey:@"msg"]];
                }
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if ([error.userInfo.allKeys containsObject:@"com.alamofire.serialization.response.error.data"]) {
            NSDictionary* errorDic=[NSJSONSerialization JSONObjectWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] options:NSJSONReadingMutableContainers error:nil];
            if ([errorDic objectForKey:@"msg"]) {
                //DLog(@"%@",[errorDic objectForKey:@"msg"]);
                if ([[errorDic objectForKey:@"msg"] isEqualToString:@"图片验证码错误"]) {
                    [self changeCaptcha];
                }
                [RHUtility showTextWithText:[errorDic objectForKey:@"msg"]];
            }
        }
    }];
    
    
    
}


- (IBAction)mingwen:(id)sender {
    
    if (!self.res) {
        self.mingwenimage.image = [UIImage imageNamed:@"PNG_注册-可见1"];
        self.res = YES;
        self.newpdTF.secureTextEntry = NO;
    }else{
        self.mingwenimage.image = [UIImage imageNamed:@"PNG_注册-不可见"];
        self.res = NO;
        self.newpdTF.secureTextEntry = YES;
    }
}


- (void)reSendMessage {
    secondsCountDown = 60;
    self.catcpbutton.enabled = NO;
    countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
}

- (void)timeFireMethod {
    secondsCountDown --;
    [self.catcpbutton setTitle:[NSString stringWithFormat:@"重新发送(%d)",secondsCountDown] forState:UIControlStateDisabled];
    if (secondsCountDown == 0) {
        self.catcpbutton.enabled = YES;
        [self.catcpbutton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [countDownTimer invalidate];
    }
}

@end
