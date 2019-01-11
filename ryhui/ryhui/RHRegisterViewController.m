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
#import "RHRegisterSecondViewController.h"
#import "RHOpenCountViewController.h"
#import "RHXYWebviewViewController.h"
@interface RHRegisterViewController ()
{
    int secondsCountDown;
    NSTimer* countDownTimer;
    float changeY;
    float keyboardHeight;
    UITextField* currentSelectTF;
}

@property (weak, nonatomic) IBOutlet UIScrollView *createAccountView;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (weak, nonatomic) IBOutlet UIView *webRegisterView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIView *otherRegisterView;
@property (weak, nonatomic) IBOutlet UIImageView *webRegisterSbg;
@property (weak, nonatomic) IBOutlet UILabel *webRegisterLab;
@property (weak, nonatomic) IBOutlet UIImageView *ohterRegisterSbg;
@property (weak, nonatomic) IBOutlet UILabel *otherRegisterLab;
@property (weak, nonatomic) IBOutlet UIImageView *captchaImageView;
//@property (weak, nonatomic) IBOutlet UITextField *accountTF;
//@property (weak, nonatomic) IBOutlet UITextField *passwordTF1;
//@property (weak, nonatomic) IBOutlet UITextField *passwordTF2;
//常用手机号

@property (weak, nonatomic) IBOutlet UITextField *phoneNumTF;
//验证码
@property (weak, nonatomic) IBOutlet UITextField *captchaImageTF;
//手机验证码

@property (weak, nonatomic) IBOutlet UITextField *captchaPhoneTF;
@property (weak, nonatomic) IBOutlet UIButton *captchaPhoneButton;
@property (weak, nonatomic) IBOutlet UIButton *captchaImageButton;
//邀请码
@property (weak, nonatomic) IBOutlet UITextField *InvitationCodeTF;
@property (weak, nonatomic) IBOutlet UIView *agreementView;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UIView *telNoticeView;
@property (strong, nonatomic) IBOutlet UIView *kaihuAndPhoneView;

//红包设置

@property (strong, nonatomic) IBOutlet UIView *giftView;
@property (weak, nonatomic) IBOutlet UIImageView *typeImageView;
@property (weak, nonatomic) IBOutlet UILabel *giftMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *giftNoticeLabel;
@property (weak, nonatomic) IBOutlet UIButton *userbtn;

@property(nonatomic,copy)NSString * userstring;
@end

@implementation RHRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initFrame];
    
    [self configBackButton];
    
    [self configTitleWithString:@"注册"];
    
   [self selectWeb:YES];
//    
   [self selectOther:NO];
//
    self.createAccountView.hidden=YES;
   self.scrollView.hidden=NO;

   [self changeCaptcha];
    
    [self configRightButtonWithTitle:@"登录" action:@selector(pushLogin)];

//    self.passwordTF1.secureTextEntry=YES;
//    self.passwordTF2.secureTextEntry=YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textBegin:) name:UITextFieldTextDidBeginEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameChange:) name:UIKeyboardWillChangeFrameNotification object:nil];

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(characterDidChanged:) name:UITextFieldTextDidChangeNotification object:nil];

    
//    CGRect rect=self.agreementView.frame;
//    rect.origin.x=([UIScreen mainScreen].bounds.size.width-320)/2.0;
//    self.agreementView.frame=rect;
    
    self.captchaPhoneButton.layer.cornerRadius=9;
    self.captchaPhoneButton.layer.masksToBounds=YES;
    
    [self setTheAttributeString:self.giftMoneyLabel.text];
    self.telNoticeView.hidden = YES;
    self.registerButton.layer.masksToBounds = YES;
    self.registerButton.layer.cornerRadius = 5;
//    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(phoneNumberTaped:)];
    [self.phoneLabel addGestureRecognizer:tap];
    
    self.userstring = @"2";
}

-(void)phoneNumberTaped:(UITapGestureRecognizer *)tap {
    
    if (tap.state == UIGestureRecognizerStateBegan) {
        self.phoneLabel.textColor = [UIColor blueColor];
    } else if (tap.state == UIGestureRecognizerStateEnded) {
        [self.view bringSubviewToFront:self.telNoticeView];
        self.telNoticeView.hidden = NO;
        self.phoneLabel.textColor = [UIColor colorWithRed:36.0/255 green:108.0/255 blue:161.0/255 alpha:1.0];
    } else if (tap.state == UIGestureRecognizerStateCancelled) {
        self.phoneLabel.textColor = [UIColor colorWithRed:36.0/255 green:108.0/255 blue:161.0/255 alpha:1.0];
    }
}


- (IBAction)cancleButtonClicked:(UIButton *)sender {
    self.telNoticeView.hidden = YES;
}

- (IBAction)callNumberButtonClicked:(UIButton *)sender {
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:4000104001"]];
}



-(void)setTheAttributeString:(NSString *)string {
    NSDictionary *attribute = @{NSForegroundColorAttributeName : [UIColor colorWithRed:249.0/255 green:212.0/255 blue:37.0/255 alpha:1.0], NSFontAttributeName: [UIFont systemFontOfSize:22.0]};
    NSDictionary *attribute1 = @{NSForegroundColorAttributeName : [UIColor colorWithRed:249.0/255 green:212.0/255 blue:37.0/255 alpha:1.0]};
    
    NSString *subString = [string componentsSeparatedByString:@"元"][0];
    
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:string];
    
    [attributeString setAttributes:attribute range:NSMakeRange(0, subString.length)];
    [attributeString setAttributes:attribute1 range:NSMakeRange(subString.length, 1)];
    self.giftMoneyLabel.attributedText = attributeString;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//-(void)back
//{
//    [self.navigationController popToRootViewControllerAnimated:YES];
//}


-(void)pushLogin
{
    RHALoginViewController* controller=[[RHALoginViewController alloc] initWithNibName:@"RHALoginViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
    
}

-(void)initFrame
{
    self.headerView.frame=CGRectMake(([UIScreen mainScreen].bounds.size.width-self.headerView.frame.size.width)/2.0, 0, self.headerView.frame.size.width, self.headerView.frame.size.height);
    
//    self.agreementView.frame=CGRectMake(30, self.agreementView.frame.origin.y, [UIScreen mainScreen].bounds.size.width-60, self.agreementView.frame.size.height);
//    
    self.scrollView.contentSize=CGSizeMake(self.scrollView.contentSize.width, 420);
    
    self.scrollView.frame=CGRectMake(0,0, self.scrollView.frame.size.width, [UIScreen mainScreen].bounds.size.height-44-44-20);
    
    self.createAccountView.frame=CGRectMake(0,44, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-44-44-20 - 71);
    self.createAccountView.contentSize=CGSizeMake(self.createAccountView.contentSize.width, 370);
    
    self.captchaPhoneButton.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-8-90, self.captchaPhoneButton.frame.origin.y, 80, 40);
    
    self.captchaImageView.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-8-90, self.captchaImageView.frame.origin.y, 80, 40);
    
    self.captchaImageButton.frame=self.captchaImageView.frame;
    
}

-(void)changeCaptcha
{
   /* AFHTTPRequestOperationManager* manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[[AFImageResponseSerializer alloc]init];
    [manager POST:[NSString stringWithFormat:@"%@%@",[RHNetworkService instance].doMain,@"common/user/general/captcha?type=CAPTCHA_REGISTER"] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject isKindOfClass:[UIImage class]]) {
            self.captchaImageView.image=responseObject;
        }
        NSArray* array=[[operation.response.allHeaderFields objectForKey:@"Set-Cookie"] componentsSeparatedByString:@";"];
        [[NSUserDefaults standardUserDefaults] setObject:[array objectAtIndex:0] forKey:@"RHSESSION"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        NSLog(@"88989989889");
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
*/
    
    AFHTTPRequestOperationManager* manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[[AFImageResponseSerializer alloc]init];
    manager.securityPolicy = [[RHNetworkService instance] customSecurityPolicy];
    [manager POST:[NSString stringWithFormat:@"%@%@",[[RHNetworkService instance] newdoMain],@"app/common/user/appGeneral/captcha?type=CAPTCHA_REGISTER"] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject isKindOfClass:[UIImage class]]) {
            self.captchaImageView.image=responseObject;
            
            
        }
        NSArray* array=[[operation.response.allHeaderFields objectForKey:@"Set-Cookie"] componentsSeparatedByString:@";"];
        //        array = @[];
        for (NSString * str in array) {
            if(str.length>12){
                
                
                if ([str rangeOfString:@"JSESSIONID="].location != NSNotFound) {
                    
                    NSArray *array1 = [str componentsSeparatedByString:@"="];
                    
                    NSString * string = [NSString stringWithFormat:@"JSESSIONID=%@",array1[1]];
                    [[NSUserDefaults standardUserDefaults] setObject:string forKey:@"RHSESSION"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                }
                if ([str rangeOfString:@"MYSESSIONID="].location != NSNotFound) {
                    
                    NSArray *array1 = [str componentsSeparatedByString:@"="];
                    
                    NSString * string = [NSString stringWithFormat:@"MYSESSIONID=%@",array1[1]];
                    [[NSUserDefaults standardUserDefaults] setObject:string forKey:@"RHNEWMYSESSION"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                }
            }
        }
        
        NSLog(@"88989989889");
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        NSLog(@"%@",error);
        
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
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.phoneNumTF resignFirstResponder];
    [self.captchaImageTF resignFirstResponder];
    [self.captchaPhoneTF resignFirstResponder];
    [self.InvitationCodeTF resignFirstResponder];
//    [self.textField resignFirstResponder];
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
    } else if ([self.captchaImageTF.text length]<=0) {
        [RHUtility showTextWithText:@"请输入图片验证码"];
        return;
    } else {
        NSDictionary* parameters=@{@"telephone":self.phoneNumTF.text};
        
        AFHTTPRequestOperationManager* manager=[AFHTTPRequestOperationManager manager];
        manager.responseSerializer=[[AFCompoundResponseSerializer alloc]init];
        manager.securityPolicy = [[RHNetworkService instance] customSecurityPolicy];
        [manager POST:[NSString stringWithFormat:@"%@app/common/user/appRegister/checkTelephoneExists",[RHNetworkService instance].newdoMain] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            DLog(@"result==%@ <<<",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
            if ([responseObject isKindOfClass:[NSData class]]) {
                NSString* restult=[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                if ([restult isEqualToString:@"true"]) {
                    //手机号没有绑定
//                    NSDictionary *parameters = @{@"telephone":self.phoneNumTF.text,@"type":@"SMS_CAPTCHA_REGISTER",@"captcha":self.captchaImageTF.text};
//                    AFHTTPRequestOperationManager* manager=[AFHTTPRequestOperationManager manager];
//                    manager.responseSerializer=[[AFCompoundResponseSerializer alloc]init];
//                    [manager POST:[NSString stringWithFormat:@"%@common/user/general/registerTel",[RHNetworkService instance].doMain] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//                        DLog(@"result==%@ <<<",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
//                        if ([responseObject isKindOfClass:[NSData class]]) {
//                            NSString* restult=[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//                            if ([restult isEqualToString:@"{\"msg\":\"手机验证码发送成功\"}"]||[restult isEqualToString:@"{\"msg\":\"success\"}"]) {
//                                //短信发送成功
//                                [RHUtility showTextWithText:@"验证码已发送至您的手机"];
//                                [self reSendMessage];
//                            }else{
//                                NSDictionary* errorDic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//                                if ([errorDic objectForKey:@"msg"]) {
//                                    //DLog(@"%@",[errorDic objectForKey:@"msg"]);
//                                    if ([[errorDic objectForKey:@"msg"] isEqualToString:@"图片验证码错误"]) {
//                                    }
//                                    [RHUtility showTextWithText:[errorDic objectForKey:@"msg"]];
//                                }
//                            }
//                        }
//                        
//                    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                        if ([error.userInfo.allKeys containsObject:@"com.alamofire.serialization.response.error.data"]) {
//                            NSDictionary* errorDic=[NSJSONSerialization JSONObjectWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] options:NSJSONReadingMutableContainers error:nil];
//                            if ([errorDic objectForKey:@"msg"]) {
//                                //DLog(@"%@",[errorDic objectForKey:@"msg"]);
//                                if ([[errorDic objectForKey:@"msg"] isEqualToString:@"图片验证码错误"]) {
//                                    [self changeCaptcha];
//                                }
//                                [RHUtility showTextWithText:[errorDic objectForKey:@"msg"]];
//                            }
//                        }
//                    }];
                    
                    NSDictionary *parameters = @{@"telephone":self.self.phoneNumTF.text,@"type":@"SMS_CAPTCHA_REGISTER",@"captcha":self.captchaImageTF.text};
                    AFHTTPRequestOperationManager* manager=[AFHTTPRequestOperationManager manager];
                    manager.securityPolicy = [[RHNetworkService instance] customSecurityPolicy];
                    manager.responseSerializer=[[AFCompoundResponseSerializer alloc]init];
                    [manager POST:[NSString stringWithFormat:@"%@app/common/user/appGeneral/registerTel",[RHNetworkService instance].newdoMain] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
                    
                } else {
                    [RHUtility showTextWithText:@"该手机号已被注册"];
                }
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //        DLog(@"%@",error);
        }];
    }

}


-(void)reSendMessage
{
    if (countDownTimer) {
        [countDownTimer invalidate];
        countDownTimer = nil;
    }
    secondsCountDown=60;
    self.captchaPhoneButton.enabled=NO;
    countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
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
    [self.captchaPhoneButton setTitle:[NSString stringWithFormat:@"重新发送(%d)",secondsCountDown] forState:UIControlStateDisabled];
    if (secondsCountDown==0) {
        secondsCountDown = 60;
        self.captchaPhoneButton.enabled=YES;
        [self.captchaPhoneButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [countDownTimer invalidate];
    }
    
}

- (IBAction)changeCaptchaAction:(id)sender {
    [self changeCaptcha];
}
- (IBAction)agreement1Action:(id)sender {
//    RHRegisterSecondViewController * vc = [[RHRegisterSecondViewController alloc]initWithNibName:@"RHRegisterSecondViewController" bundle:nil];
//    [self.navigationController pushViewController:vc animated:YES];
//    return;
    RHRegisterAgreenWebViewController* controller=[[RHRegisterAgreenWebViewController alloc] initWithNibName:@"RHRegisterAgreenWebViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)agreement2Action:(id)sender {
    RHAgreement2ViewController* controller=[[RHAgreement2ViewController alloc] initWithNibName:@"RHAgreement2ViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)registerAction:(id)sender {
    if ([self.phoneNumTF.text length]<=0) {
        [RHUtility showTextWithText:@"请输入手机号"];
        return;
    }
    if([self.captchaImageTF.text length]<=0) {
        [RHUtility showTextWithText:@"请输入图片验证码"];
        return;
    }
    if ([self.captchaPhoneTF.text length]<=0) {
        [RHUtility showTextWithText:@"请输入短信验证码"];
        return;
    }
    if (![self.userstring isEqualToString:@"1"]) {
        [RHUtility showTextWithText:@"请先同意融益汇注册服务协议"];
        return;
    }
    

    
    
    NSMutableDictionary* parameters=[[NSMutableDictionary alloc]initWithCapacity:0];
//    [parameters setObject:self.accountTF.text forKey:@"username"];
//    [parameters setObject:self.passwordTF1.text forKey:@"password"];
//    [parameters setObject:self.passwordTF2.text forKey:@"passwordRepeat"];
    [parameters setObject:self.phoneNumTF.text forKey:@"telephone"];
    [parameters setObject:self.captchaImageTF.text forKey:@"captcha"];
    [parameters setObject:self.captchaPhoneTF.text forKey:@"telCaptcha"];
    if (self.InvitationCodeTF.text.length > 0) {
        [parameters setObject:self.InvitationCodeTF.text forKey:@"invitationCode"];
    }else{
        [parameters setObject:@"" forKey:@"invitationCode"];
    }
    
//    DLog(@"%@",parameters);
    
    [[RHNetworkService instance] POST:@"app/common/user/appRegister/nextStep1" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        DLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
                RHRegisterSecondViewController * vc = [[RHRegisterSecondViewController alloc]initWithNibName:@"RHRegisterSecondViewController" bundle:nil];
                [self.navigationController pushViewController:vc animated:YES];        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
//        DLog(@"%@",operation.responseObject);
        if ([operation.responseObject isKindOfClass:[NSDictionary class]]) {
            NSString* msg=[operation.responseObject objectForKey:@"msg"];
            if ([msg isEqualToString:@"验证码错误"]||[msg isEqualToString:@"手机验证码错误"]) {
                [self changeCaptcha];
            }
            [RHUtility showTextWithText:msg];
        }
    }];

    
    
}

//检查是否发红包
-(void)cheTheGift {
    AFHTTPRequestOperationManager* manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[[AFCompoundResponseSerializer alloc]init];
    manager.securityPolicy = [[RHNetworkService instance] customSecurityPolicy];
    NSString* session=[[NSUserDefaults standardUserDefaults] objectForKey:@"RHSESSION"];
    NSLog(@"------------------%@",session);
    NSString* session1=[[NSUserDefaults standardUserDefaults] objectForKey:@"RHNEWMYSESSION"];
    
    if (session1.length>12) {
        session = [NSString stringWithFormat:@"%@,%@",session,session1];
    }
    if (session&&[session length]>0) {
        [manager.requestSerializer setValue:session forHTTPHeaderField:@"cookie"];
    }
    [manager POST:[NSString stringWithFormat:@"%@app/front/payment/appAccount/queryAccountFinishedBonuses",[RHNetworkService instance].newdoMain] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"------------------%@",responseObject);
        
        if ([responseObject isKindOfClass:[NSData class]]) {
            NSDictionary* dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"------------------%@",dic);
            NSString* amount=[dic objectForKey:@"money"];
            if (amount&&[amount length]>0) {
                self.giftView.frame = CGRectMake(0, -20, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) + 64);
               self.giftMoneyLabel.text = [NSString stringWithFormat:@"%d元红包券已放入账户",[amount intValue]];
                [self setTheAttributeString:self.giftMoneyLabel.text];
                [self.navigationController.navigationBar addSubview:self.giftView];
                [self performSelector:@selector(fiftCloseButtonClicked:) withObject:nil afterDelay:15.0];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                DLog(@"%@",[[NSString alloc] initWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
    }];
}


- (void)setNavigationBackButton {
    UIButton* button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(backToGusture:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"icon_back.png"] forState:UIControlStateNormal];
    button.frame=CGRectMake(0, 0, 11, 17);
    self.navigationItem.leftBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)backToGusture:(UIButton *)btn {
    RHGesturePasswordViewController* controller=[[RHGesturePasswordViewController alloc]init];
    [self.navigationController pushViewController:controller animated:NO];
}

- (IBAction)CreateAccount:(id)sender {
    RHRegisterWebViewController* controller=[[RHRegisterWebViewController alloc]initWithNibName:@"RHRegisterWebViewController" bundle:nil];
    controller.isUserCenterTurn = NO;
    [self.navigationController pushViewController:controller animated:YES];
    
    
    
}

-(void)textBegin:(NSNotification*)not
{
//    DLog(@"%@",not.object);
    
    currentSelectTF=not.object;
    CGRect tfRect=[currentSelectTF convertRect:currentSelectTF.bounds toView:self.view];
    changeY=tfRect.origin.y+tfRect.size.height+5;
    if (changeY>(self.view.frame.size.height-keyboardHeight)) {
        CGRect viewRect=self.view.frame;
        if (currentSelectTF == _InvitationCodeTF) {
            viewRect.origin.y=(self.view.frame.size.height-keyboardHeight)-changeY + 46;
        }else{
            viewRect.origin.y=(self.view.frame.size.height-keyboardHeight)-changeY;
        }
        self.view.frame=viewRect;
    }
    
}

-(void)keyboardShow:(NSNotification*)not
{
//    DLog(@"%@",not.userInfo);
    NSValue* value=[not.userInfo objectForKey:@"UIKeyboardBoundsUserInfoKey"];
    
    CGRect rect=[value CGRectValue];
    keyboardHeight=rect.size.height;
}

-(void)keyboardFrameChange:(NSNotification*)not
{
    return;
//    DLog(@"%@",not.userInfo);
    NSValue* value=[not.userInfo objectForKey:@"UIKeyboardBoundsUserInfoKey"];
    
    NSValue* endValue=[not.userInfo objectForKey:@"UIKeyboardFrameEndUserInfoKey"];
    CGRect endRect=[endValue CGRectValue];
    if (endRect.origin.y>=[UIScreen mainScreen].bounds.size.height) {
        return;
    }
    CGRect rect=[value CGRectValue];
    keyboardHeight=rect.size.height;

    CGRect tfRect=[currentSelectTF convertRect:currentSelectTF.bounds toView:self.view];
    changeY=tfRect.origin.y+tfRect.size.height+5;
    if (changeY>(self.view.frame.size.height-keyboardHeight)) {
        CGRect viewRect=self.view.frame;
        if (currentSelectTF == _InvitationCodeTF) {
            viewRect.origin.y=(self.view.frame.size.height-keyboardHeight)-changeY + 46;
        }else{
            viewRect.origin.y=(self.view.frame.size.height-keyboardHeight)-changeY;
        }
        self.view.frame=viewRect;
    }

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    CGRect rect=self.view.frame;
    rect.origin.y=64;
    self.view.frame=rect;
    
    [textField resignFirstResponder];
    
    return YES;
}

-(void)characterDidChanged:(NSNotification *)notif
{
//    _accountTF.text = [_accountTF.text stringByReplacingOccurrencesOfString:@" " withString:@""];
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


//gift 操作
- (IBAction)fiftCloseButtonClicked:(UIButton *)sender {

    [self.giftView removeFromSuperview];
}
- (IBAction)readingbtn:(id)sender {
    
    if ([self.userstring isEqualToString:@"1"]) {
        self.userstring = @"2";
        
        [self.userbtn setImage:[UIImage imageNamed:@"未选中状态icon"] forState:UIControlStateNormal];
        
    }else{
        [self.userbtn setImage:[UIImage imageNamed:@"选中状态icon"] forState:UIControlStateNormal];
        self.userstring = @"1";
    }
    
}
- (IBAction)yinsizhengce:(id)sender {
    
    UIButton * btn = sender;
    RHXYWebviewViewController * controller = [[RHXYWebviewViewController alloc]initWithNibName:@"RHXYWebviewViewController" bundle:nil];
    
    NSString * str = btn.titleLabel.text;
    
    NSString *stringWithoutQuotation = [str
                                        stringByReplacingOccurrencesOfString:@"《" withString:@""];
    str =  [stringWithoutQuotation stringByReplacingOccurrencesOfString:@"》" withString:@""];
    controller.namestr = str;
//    controller.projectid = self.firstid;
    
    [self.navigationController pushViewController:controller animated:YES];
    
}

@end
