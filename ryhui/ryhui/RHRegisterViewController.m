//
//  RHRegisterViewController.m
//  ryhui
//
//  Created by stefan on 15/2/27.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHRegisterViewController.h"
#import "RHRegisterAgreenWebViewController.h"
#import "RHAgreement2ViewController.h"
#import "RHRegisterWebViewController.h"
#import "RHALoginViewController.h"
#import "RHGesturePasswordViewController.h"

@interface RHRegisterViewController ()
{
    int secondsCountDown;
    NSTimer* countDownTimer;
    float changeY;
    float keyboardHeight;

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
    
    [self configRightButtonWithTitle:@"登录" action:@selector(pushLogin)];

    self.passwordTF1.secureTextEntry=YES;
    self.passwordTF2.secureTextEntry=YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textBegin:) name:UITextFieldTextDidBeginEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    
    CGRect rect=self.agreementView.frame;
    rect.origin.x=([UIScreen mainScreen].bounds.size.width-320)/2.0;
    self.agreementView.frame=rect;
    
    self.captchaPhoneButton.layer.cornerRadius=9;
    self.captchaPhoneButton.layer.masksToBounds=YES;
        
}

-(void)pushLogin
{
    RHALoginViewController* controller=[[RHALoginViewController alloc] initWithNibName:@"RHALoginViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
    
}

-(void)initFrame
{
    self.headerView.frame=CGRectMake(([UIScreen mainScreen].bounds.size.width-self.headerView.frame.size.width)/2.0, 0, self.headerView.frame.size.width, self.headerView.frame.size.height);
    
    self.agreementView.frame=CGRectMake(([UIScreen mainScreen].bounds.size.width-self.agreementView.frame.size.width)/2.0, self.agreementView.frame.origin.y, self.agreementView.frame.size.width, self.agreementView.frame.size.height);
    
    self.scrollView.contentSize=CGSizeMake(self.scrollView.contentSize.width, 370);
    
    self.scrollView.frame=CGRectMake(0,44, self.scrollView.frame.size.width, [UIScreen mainScreen].bounds.size.height-44-44-20);
    
    self.createAccountView.frame=CGRectMake(0,44, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-44-44-20);
    self.createAccountView.contentSize=CGSizeMake(self.createAccountView.contentSize.width, 433);
    
    self.captchaPhoneButton.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-8-80, self.captchaPhoneButton.frame.origin.y, 80, 40);
    
    self.captchaImageView.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-8-80, self.captchaImageView.frame.origin.y, 80, 40);
    
    self.captchaImageButton.frame=self.captchaImageView.frame;
}

-(void)changeCaptcha
{
    AFHTTPRequestOperationManager* manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[[AFImageResponseSerializer alloc]init];
    [manager POST:[NSString stringWithFormat:@"%@%@",[RHNetworkService instance].doMain,@"common/user/general/captcha?type=CAPTCHA_REGISTER"] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject isKindOfClass:[UIImage class]]) {
            self.captchaImageView.image=responseObject;
        }
        NSArray* array=[[operation.response.allHeaderFields objectForKey:@"Set-Cookie"] componentsSeparatedByString:@";"];
        [[NSUserDefaults standardUserDefaults] setObject:[array objectAtIndex:0] forKey:@"RHSESSION"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
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
    
//    [self configRightButtonWithTitle:nil action:nil];
    self.navigationItem.rightBarButtonItem= nil;

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
    if ([self.captchaImageTF.text length]<=0) {
        [RHUtility showTextWithText:@"请输入图片验证码"];
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
                NSDictionary *parameters = @{@"telephone":self.phoneNumTF.text,@"type":@"SMS_CAPTCHA_REGISTER",@"captcha":self.captchaImageTF.text};
                AFHTTPRequestOperationManager* manager=[AFHTTPRequestOperationManager manager];
                manager.responseSerializer=[[AFCompoundResponseSerializer alloc]init];
                [manager POST:[NSString stringWithFormat:@"%@common/user/general/registerTel",[RHNetworkService instance].doMain] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
                                DLog(@"%@",[errorDic objectForKey:@"msg"]);
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
                            DLog(@"%@",[errorDic objectForKey:@"msg"]);
                            if ([[errorDic objectForKey:@"msg"] isEqualToString:@"图片验证码错误"]) {
                                [self changeCaptcha];
                            }
                            [RHUtility showTextWithText:[errorDic objectForKey:@"msg"]];
                        }
                    }
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
    if (secondsCountDown>0) {
        secondsCountDown--;
    }else{
        self.captchaPhoneButton.enabled=YES;
        [self.captchaPhoneButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [countDownTimer invalidate];
    }
    [self.captchaPhoneButton setTitle:[NSString stringWithFormat:@"重新发送(%d)",secondsCountDown] forState:UIControlStateNormal];
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
    RHRegisterAgreenWebViewController* controller=[[RHRegisterAgreenWebViewController alloc] initWithNibName:@"RHRegisterAgreenWebViewController" bundle:nil];
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
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSString* result=[responseObject objectForKey:@"md5"];
            if (result&&[result length]>0) {
                NSString* md5=[responseObject objectForKey:@"md5"];
                [RHNetworkService instance].niubiMd5=md5;
                
                [RHUserManager sharedInterface].username=self.accountTF.text;
                
                [[NSUserDefaults standardUserDefaults] setObject:[RHUserManager sharedInterface].username forKey:@"RHUSERNAME"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                NSString* _custId=[responseObject objectForKey:@"custId"];
                if (![_custId isKindOfClass:[NSNull class]]&&_custId&&[_custId length]>0) {
                    [RHUserManager sharedInterface].custId=_custId;
                    [[NSUserDefaults standardUserDefaults] setObject:[RHUserManager sharedInterface].custId forKey:@"RHcustId"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                }
                
                NSString* _email=[responseObject objectForKey:@"email"];
                if (![_email isKindOfClass:[NSNull class]]&&_email&&[_email length]>0) {
                    [RHUserManager sharedInterface].email=_email;
                    [[NSUserDefaults standardUserDefaults] setObject:[RHUserManager sharedInterface].email forKey:@"RHemail"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                }
                
                NSString* _infoType=[responseObject objectForKey:@"infoType"];
                if (_infoType&&[_infoType length]>0) {
                    [RHUserManager sharedInterface].infoType=_infoType;
                    [[NSUserDefaults standardUserDefaults] setObject:[RHUserManager sharedInterface].infoType forKey:@"RHinfoType"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                }
                
                NSString* _md5=[responseObject objectForKey:@"md5"];
                if (_md5&&[_md5 length]>0) {
                    [RHUserManager sharedInterface].md5=_md5;
                    [[NSUserDefaults standardUserDefaults] setObject:[RHUserManager sharedInterface].md5 forKey:@"RHmd5"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                }
                
                NSString* _telephone=[responseObject objectForKey:@"telephone"];
                if (_telephone&&[_telephone length]>0) {
                    [RHUserManager sharedInterface].telephone=_telephone;
                    [[NSUserDefaults standardUserDefaults] setObject:[RHUserManager sharedInterface].telephone forKey:@"RHtelephone"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                }
                NSString* _userid=[[responseObject objectForKey:@"userId"] stringValue];
                if (_userid&&[_userid length]>0) {
                    [RHUserManager sharedInterface].userId=_userid;
                    [[NSUserDefaults standardUserDefaults] setObject:[RHUserManager sharedInterface].userId forKey:@"RHUSERID"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                }
                
                [RHUtility showTextWithText:@"注册成功"];
                
                [self selectOtherAciton:nil];
//                
//                if (!isPan) {
                RHGesturePasswordViewController* controller=[[RHGesturePasswordViewController alloc]init];
                controller.isRegister=YES;
                [self.navigationController pushViewController:controller animated:NO];
//                }else{
//                    [[RHTabbarManager sharedInterface] initTabbar];
//                    [[RHTabbarManager sharedInterface] selectTabbarMain];
//                }
                
            }
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        DLog(@"%@",operation.responseObject);
        if ([operation.responseObject isKindOfClass:[NSDictionary class]]) {
            NSString* msg=[operation.responseObject objectForKey:@"msg"];
            if ([msg isEqualToString:@"验证码错误"]||[msg isEqualToString:@"手机验证码错误"]) {
                [self changeCaptcha];
            }
            [RHUtility showTextWithText:msg];
        }
    }];

}

- (IBAction)CreateAccount:(id)sender {
    RHRegisterWebViewController* controller=[[RHRegisterWebViewController alloc]initWithNibName:@"RHRegisterWebViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)textBegin:(NSNotification*)not
{
    DLog(@"%@",not.object);
    UITextField* textField=not.object;
    changeY=textField.frame.origin.y+textField.frame.size.height+10;
    if (changeY>(self.view.frame.size.height-keyboardHeight)) {
        CGRect viewRect=self.view.frame;
        viewRect.origin.y=(self.view.frame.size.height-keyboardHeight)-changeY;
        self.view.frame=viewRect;
    }
    
}

-(void)keyboardShow:(NSNotification*)not
{
    DLog(@"%@",not.userInfo);
    NSValue* value=[not.userInfo objectForKey:@"UIKeyboardBoundsUserInfoKey"];
    
    CGRect rect=[value CGRectValue];
    keyboardHeight=rect.size.height;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    CGRect rect=self.view.frame;
    rect.origin.y=64;
    self.view.frame=rect;
    
    [textField resignFirstResponder];
    
    return YES;
}

@end
