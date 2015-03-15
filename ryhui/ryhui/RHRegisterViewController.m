//
//  RHRegisterViewController.m
//  ryhui
//
//  Created by stefan on 15/2/27.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHRegisterViewController.h"
#import "RHAgreement1ViewController.h"
#import "RHAgreement2ViewController.h"
#import "RHRegisterWebViewController.h"

@interface RHRegisterViewController ()
{
    int secondsCountDown;
    NSTimer* countDownTimer;
}
@end

@implementation RHRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initFrame];
    
    [self configBackButton];
    
    [self configTitleWithString:@"注册"];
    
    [self selectWeb:YES];
    
    [self selectOther:NO];
    
    self.createAccountView.hidden=YES;
    self.scrollView.hidden=NO;
    
    [self changeCaptcha];
}

-(void)initFrame
{
    self.headerView.frame=CGRectMake(([UIScreen mainScreen].bounds.size.width-self.headerView.frame.size.width)/2.0, 0, self.headerView.frame.size.width, self.headerView.frame.size.height);
    
    self.agreementView.frame=CGRectMake(([UIScreen mainScreen].bounds.size.width-self.agreementView.frame.size.width)/2.0, self.agreementView.frame.origin.y, self.agreementView.frame.size.width, self.agreementView.frame.size.height);
    
    self.scrollView.contentSize=CGSizeMake(self.scrollView.contentSize.width, 370);
    
    self.scrollView.frame=CGRectMake(0,44, self.scrollView.frame.size.height, [UIScreen mainScreen].bounds.size.height-44-44-20);
    
    self.captchaPhoneButton.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-8-80, self.captchaPhoneButton.frame.origin.y, 80, 40);
    
    self.captchaImageView.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-8-80, self.captchaImageView.frame.origin.y, 80, 40);
    
    self.captchaImageButton.frame=self.captchaImageView.frame;
}

-(void)changeCaptcha
{
    AFHTTPRequestOperationManager* manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[[AFImageResponseSerializer alloc]init];
    [manager POST:[NSString stringWithFormat:@"%@%@",[RHNetworkService instance].doMain,@"common/user/general/captcha?type=CAPTCHA_LOGIN"] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject isKindOfClass:[UIImage class]]) {
            self.captchaImageView.image=responseObject;
        }
        NSArray* array=[[operation.response.allHeaderFields objectForKey:@"Set-Cookie"] componentsSeparatedByString:@";"];
        [RHNetworkService instance].session=[array objectAtIndex:0];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}


-(void)selectWeb:(BOOL)isSelect
{
    if (isSelect) {
        self.webRegisterSbg.image=[UIImage imageNamed:@"registerSelect.png"];
        self.webRegisterLab.textColor=[RHUtility colorForHex:@"#3d3d3d"];
    }else{
        self.webRegisterSbg.image=[UIImage imageNamed:@"registerEnSelect.png"];
        self.webRegisterLab.textColor=[RHUtility colorForHex:@"#c6c6c6"];
    }

}

-(void)selectOther:(BOOL)isSelect
{
    if (isSelect) {
        self.ohterRegisterSbg.image=[UIImage imageNamed:@"registerSelect.png"];
        self.otherRegisterLab.textColor=[RHUtility colorForHex:@"#3d3d3d"];
    }else{
        self.ohterRegisterSbg.image=[UIImage imageNamed:@"registerEnSelect.png"];
        self.otherRegisterLab.textColor=[RHUtility colorForHex:@"#c6c6c6"];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)selectOtherAciton:(id)sender {
 
    [self selectOther:YES];
    [self selectWeb:NO];
    
    self.createAccountView.hidden=NO;
    self.scrollView.hidden=YES;
}

- (IBAction)selectWebAction:(id)sender {
    
    [self selectOther:NO];
    [self selectWeb:YES];
    
    self.createAccountView.hidden=YES;
    self.scrollView.hidden=NO;
}

- (IBAction)getCaptchaAction:(id)sender {
    if ([self.phoneNumTF.text length]<=0) {
        [RHUtility showTextWithText:@"请输入手机号"];
        return;
    }
    
    NSDictionary* parameters=@{@"telephone":self.phoneNumTF.text};

    AFHTTPRequestOperationManager* manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[[AFCompoundResponseSerializer alloc]init];
    
    [manager POST:[NSString stringWithFormat:@"%@common/user/register/checkTelephoneExists",[RHNetworkService instance].doMain] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"result==%@ <<<",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        if ([responseObject isKindOfClass:[NSData class]]) {
            NSString* restult=[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            if ([restult isEqualToString:@"true"]) {
                //手机号没有绑定
                NSDictionary *parameters = @{@"telephone":self.phoneNumTF.text,@"type":@"SMS_CAPTCHA_REGISTER"};
                AFHTTPRequestOperationManager* manager=[AFHTTPRequestOperationManager manager];
                manager.responseSerializer=[[AFCompoundResponseSerializer alloc]init];
                [manager POST:[NSString stringWithFormat:@"%@common/user/general/registerTel",[RHNetworkService instance].doMain] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    DLog(@"result==%@ <<<",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
                    if ([responseObject isKindOfClass:[NSData class]]) {
                        NSString* restult=[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                        if ([restult isEqualToString:@"success"]) {
                            //短信发送成功
                            [RHUtility showTextWithText:@"短信发送成功"];
                            [self reSendMessage];
                        }
                    }

                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    DLog(@"%@",error);
                }];
            }else{
                
                [BDKNotifyHUD notifyHUDWithView:self.view text:@"该手机号已经绑定"];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"%@",error);
    }];
}

-(void)reSendMessage
{
    secondsCountDown=60;
    self.captchaPhoneButton.enabled=NO;
    countDownTimer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
}
-(void)timeFireMethod
{
    secondsCountDown--;
    [self.captchaPhoneButton setTitle:[NSString stringWithFormat:@"%d后重新发送",secondsCountDown] forState:UIControlStateNormal];
    if (secondsCountDown==0) {
        self.captchaPhoneButton.enabled=YES;
        [self.captchaPhoneButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [countDownTimer invalidate];
    }
    
}

- (IBAction)changeCaptchaAction:(id)sender {
    [self changeCaptcha];
}
- (IBAction)agreement1Action:(id)sender {
    RHAgreement1ViewController* controller=[[RHAgreement1ViewController alloc] initWithNibName:@"RHAgreement1ViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)agreement2Action:(id)sender {
    RHAgreement2ViewController* controller=[[RHAgreement2ViewController alloc] initWithNibName:@"RHAgreement2ViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)registerAction:(id)sender {
    if ([self.captchaPhoneTF.text length]<=0) {
        [RHUtility showTextWithText:@"请输入短信验证码"];
        return;
    }
    if ([self.accountTF.text length]<=0) {
        [RHUtility showTextWithText:@"请输入用户名"];
        return;
    }
    if ([self.passwordTF1.text length]<=0) {
        [RHUtility showTextWithText:@"请输入密码"];
        return;
    }
    if ([self.passwordTF2.text length]<=0) {
        [RHUtility showTextWithText:@"请输入确认密码"];
        return;
    }
    if ([self.captchaImageTF.text length]<=0) {
        [RHUtility showTextWithText:@"请输入图片验证码"];
        return;
    }
    
    NSMutableDictionary* parameters=[[NSMutableDictionary alloc]initWithCapacity:0];
    [parameters setObject:self.accountTF.text forKey:@"username"];
    [parameters setObject:self.passwordTF1.text forKey:@"password"];
    [parameters setObject:self.passwordTF2.text forKey:@"passwordRepeat"];
    [parameters setObject:self.phoneNumTF.text forKey:@"telephone"];
    [parameters setObject:self.captchaImageTF.text forKey:@"captcha"];
    [parameters setObject:self.captchaPhoneTF.text forKey:@"telCaptcha"];
    
    DLog(@"%@",parameters);
    
    [[RHNetworkService instance] POST:@"common/user/register/nextStep" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        DLog(@"%@",operation.responseObject);
        if ([operation.responseObject isKindOfClass:[NSDictionary class]]) {
            NSString* msg=[operation.responseObject objectForKey:@"msg"];
            [RHUtility showTextWithText:msg];
        }
    }];

}

- (IBAction)CreateAccount:(id)sender {
    RHRegisterWebViewController* controller=[[RHRegisterWebViewController alloc]initWithNibName:@"RHRegisterWebViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    if ([textField isEqual:self.captchaPhoneTF]) {
        [self registerAction:nil];
        return NO;
    }else{
        [textField resignFirstResponder];
    }
    return YES;
}

@end
