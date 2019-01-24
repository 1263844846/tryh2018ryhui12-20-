//
//  RHALoginViewController.m
//  ryhui
//
//  Created by stefan on 15/2/13.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHALoginViewController.h"
#import "RHGesturePasswordViewController.h"
#import "RHAccountValidateViewController.h"
#import "RHRegisterViewController.h"
#import "MBProgressHUD.h"
#import "RYHViewController.h"
#import "RHMainViewController.h"

@interface RHALoginViewController ()
{
    float changeY;
    float keyboardHeight;
    UITextField* currentSelectTF;
}
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *captchaTextField;
@property (weak, nonatomic) IBOutlet UIImageView *captchaImageView;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property(nonatomic,assign)CGFloat loginNum;

@property (weak, nonatomic) IBOutlet UIImageView *hideimage;
@property (weak, nonatomic) IBOutlet UIImageView *hidenimag;
@end

@implementation RHALoginViewController
@synthesize isForgotV;
@synthesize isPan;
-(void)viewWillAppear:(BOOL)animated{
    
     [RYHViewController Sharedbxtabar].tarbar.hidden = YES;
    [super viewWillAppear:animated];
    self.loginNum = 0;
    if (self.loginNum <2) {
        self.hideimage.hidden = YES;
        self.hidenimag.hidden = YES;
        self.captchaImageView.hidden = YES;
        self.captchaTextField.hidden = YES;
    }
    
}
- (void)viewDidLoad {
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
  // [ UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [super viewDidLoad];
//     [RYHViewController Sharedbxtabar].tarbar.hidden = NO;
    
    NSString* session=[[NSUserDefaults standardUserDefaults] objectForKey:@"RHSESSION"];
    NSLog(@"------------------%@",session);
    
    UIControl* control=[[UIControl alloc]initWithFrame:self.captchaImageView.bounds];
    [control addTarget:self action:@selector(changeCaptcha) forControlEvents:UIControlEventTouchUpInside];
    self.accountTextField.text = nil;
    self.captchaTextField.text = nil;
    self.passwordTextField.text = nil;
    [self.captchaImageView addSubview:control];
    self.captchaImageView.userInteractionEnabled=YES;
    
    [self changeCaptcha];
    
    [self.accountTextField becomeFirstResponder];
    
    self.button.layer.masksToBounds=YES;
    self.button.layer.cornerRadius=6;
    
    [self configTitleWithString:@"登录"];
    
    self.passwordTextField.secureTextEntry=YES;
    
    [self configRightButtonWithTitle:@"注册" action:@selector(pushRigster)];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textBegin:) name:UITextFieldTextDidBeginEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    if ([self.str isEqualToString:@"cbx"]) {
        
        UIButton* button=[UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        //    UIImage * image = [UIImage imageNamed:@"back.png"];
        
        [button setImage:[UIImage imageNamed:@"icon_back.png"] forState:UIControlStateNormal];
        button.frame=CGRectMake(0, 0, 11, 17);
        
        button.hidden = YES;
        // button.backgroundColor = [UIColor colorWithHexString:@"44bbc1"];
        self.navigationItem.leftBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:button];
    }else{
        //[self configBackButton];
    }
    [self configBackButton];
    
    NSString * usernamestr = [[NSUserDefaults standardUserDefaults] objectForKey:@"RHUSERNAME"];
    
    if (usernamestr.length>3) {
        self.accountTextField.text = usernamestr;
    }
    [self.passwordTextField addTarget:self action:@selector(searchTextFieldChange:) forControlEvents:UIControlEventEditingChanged];
}




- (void)searchTextFieldChange:(UITextField *)textField{
    
    textField.text =[textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    
    
}
- (void)configBackButton
{
    UIButton* button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    //    UIImage * image = [UIImage imageNamed:@"back.png"];
    
    [button setImage:[UIImage imageNamed:@"icon_back.png"] forState:UIControlStateNormal];
     button.frame=CGRectMake(0, 0, 25, 40);
    
    // button.backgroundColor = [UIColor colorWithHexString:@"44bbc1"];
    self.navigationItem.leftBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:button];
}

-(void)back
{
//    if ([self.str isEqualToString:@"cbx"]) {
    [[RHTabbarManager sharedInterface] initTabbar];
        RHMainViewController *controller = [[RHMainViewController alloc]initWithNibName:@"RHMainViewController" bundle:nil];
//        controller.type = @"0";
        //    [nav pushViewController:controller animated:YES];
        [[RYHViewController Sharedbxtabar]tabBar:(RYHView *)controller.view didSelectedIndex:0];
        UIButton *btn = [[UIButton alloc]init];
        btn.tag = 0;
        [[RYHView Shareview] btnClick:btn];
        
//    }else{
//        [self.navigationController popToRootViewControllerAnimated:YES];
//    }
}

-(void)changeCaptcha
{
    NSString * str = @"app/common/user/appGeneral/captcha?type=CAPTCHA_LOGIN";
    NSString * str1 = @"common/user/general/captcha?type=CAPTCHA_LOGIN";

    AFHTTPRequestOperationManager* manager=[AFHTTPRequestOperationManager manager];
    
    [manager setSecurityPolicy:[[RHNetworkService instance] customSecurityPolicy]];
    manager.responseSerializer=[[AFImageResponseSerializer alloc]init];
    [manager POST:[NSString stringWithFormat:@"%@%@",[RHNetworkService instance].newdoMain,str] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingMutableContainers)  error:nil];
        
        if ([responseObject isKindOfClass:[UIImage class]]) {
            self.captchaImageView.image=responseObject;
        }
        NSArray* array=[[operation.response.allHeaderFields objectForKey:@"Set-Cookie"] componentsSeparatedByString:@";"];
        [[NSUserDefaults standardUserDefaults] setObject:[array objectAtIndex:0] forKey:@"RHSESSION"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

-(void)pushRigster
{
    RHRegisterViewController* contoller=[[RHRegisterViewController alloc] initWithNibName:@"RHRegisterViewController" bundle:nil];
    [self.navigationController pushViewController:contoller animated:YES];
}


- (IBAction)forgetAction:(id)sender {
 
    [self findPassword];
}

- (IBAction)loginAction:(id)sender {
    //11
    //NSString * tes = self.accountTextField.text;
    
    
   
    if (!self.accountTextField.text.length) {
        [RHUtility showTextWithText:@"账号不能为空"];
        return;
    }
    if (!self.passwordTextField.text.length) {
        [RHUtility showTextWithText:@"密码不能为空"];
        return;
    }
    
    if (self.captchaTextField.hidden == YES) {
        self.captchaTextField.text = @"";
    }else{
        
        if (self.captchaTextField.text.length <1) {
            [RHUtility showTextWithText:@"验证码不能为空"];
            return;
        }
        
    }
//    if (!self.captchaTextField.text.length) {
//        [RHUtility showTextWithText:@"验证码不能为空"];
//        return;
//    }
    
    self.loginNum++;
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"RHSESSION"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"RHNEWMYSESSION"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSString * str = @"app/common/user/appLogin/login";
    NSString * str1 = @"common/user/login/login";
    NSDictionary *parameters = @{@"account":self.accountTextField.text,@"password":self.passwordTextField.text,@"captcha":self.captchaTextField.text};

    [[RHNetworkService instance] POST:str parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        DLog(@"%@",responseObject);
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
        
        if (responseObject[@"isCompany"]) {
            if ([responseObject[@"isCompany"] isEqualToString:@"true"]) {
                [RHUtility showTextWithText:@"企业借款人暂不支持APP登录，请通过融益汇网站登录"];
                return ;
            }
          
            
        }else{
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSString* result=[responseObject objectForKey:@"md5"];
            if (result&&[result length]>0) {
                NSString* md5=[responseObject objectForKey:@"md5"];
                [RHNetworkService instance].niubiMd5=md5;
                
                [RHUserManager sharedInterface].username=[responseObject objectForKey:@"username"];
                
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
                NSString * _headUrl = [responseObject objectForKey:@"headUrl"];
                
                if (_headUrl&&_headUrl.length >0) {
                    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@common/main/attachment/%@",[RHNetworkService instance].newdoMain,_headUrl] forKey:@"headUrl"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                }
                
//                [self getMyAccountData];
//                return;
                if (!isPan) {
                    if (self.isForgotV) {
                        RHGesturePasswordViewController* controller=[[RHGesturePasswordViewController alloc]init];
                        controller.isForgotV=self.isForgotV;
                        [self.navigationController pushViewController:controller animated:NO];
                    }else{
                        RHGesturePasswordViewController* controller=[[RHGesturePasswordViewController alloc]init];
                        [self.navigationController pushViewController:controller animated:NO];
                    }
           
                }else{
                    [[RHTabbarManager sharedInterface] initTabbar];
                    [[[RHTabbarManager sharedInterface] selectTabbarMain] popToRootViewControllerAnimated:NO];
                }
            }
        }
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        DLog(@"%@",error);
        if (self.loginNum >=2) {
            self.hideimage.hidden = NO;
            self.hidenimag.hidden = NO;
            self.captchaImageView.hidden = NO;
            self.captchaTextField.hidden = NO;
        }
        if ([error.userInfo.allKeys containsObject:@"com.alamofire.serialization.response.error.data"]) {
            NSDictionary* errorDic=[NSJSONSerialization JSONObjectWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] options:NSJSONReadingMutableContainers error:nil];
            if ([errorDic objectForKey:@"msg"]) {
                if ([[errorDic objectForKey:@"msg"] isEqualToString:@"验证码错误"]) {
                    [self changeCaptcha];
                }
                [RHUtility showTextWithText:[errorDic objectForKey:@"msg"]];
            }
        }
    }];
}
-(void)getMyAccountData
{
    
    NSString * str = @"app/front/payment/appJxAccount/myAccountData";
    //    NSString * newstr = @"app/front/payment/appAccount/appMyAccountData";
    NSString* session=[[NSUserDefaults standardUserDefaults] objectForKey:@"RHSESSION"];
    if (session&&[session length]>0) {
        // [manager.requestSerializer setValue:session forHTTPHeaderField:@"cookie"];
        
    }
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[RHNetworkService instance] POST:str parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"%@",responseObject);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //        DLog(@"%@",error);
        
        [[RHUserManager sharedInterface] logout];
        [[RHTabbarManager sharedInterface] selectALogin];
        DLog(@"2222%@",[[NSString alloc] initWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
    }];
}
-(void)getloginpassword{
    
    NSDictionary *parameters = @{@"password":self.passwordTextField.text};
    [[RHNetworkService instance] POST:@"app/common/user/appRegister/checkPassword" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        DLog(@"%@",responseObject);
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
        }
       
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //        DLog(@"%@",error);
       
        if ([error.userInfo.allKeys containsObject:@"com.alamofire.serialization.response.error.data"]) {
            NSDictionary* errorDic=[NSJSONSerialization JSONObjectWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] options:NSJSONReadingMutableContainers error:nil];
            if ([errorDic objectForKey:@"msg"]) {
               
                [RHUtility showTextWithText:[errorDic objectForKey:@"msg"]];
            }
        }
    }];
}
-(void)getloignpasswordsuo{
    
    
}
-(void)textBegin:(NSNotification*)not
{
//    DLog(@"%@",not.object);
    currentSelectTF=not.object;
    CGRect tfRect=[currentSelectTF convertRect:currentSelectTF.bounds toView:self.view];
    changeY=tfRect.origin.y+tfRect.size.height+5;
    if (changeY>(self.view.frame.size.height-keyboardHeight)) {
        CGRect viewRect=self.view.frame;
        viewRect.origin.y=(self.view.frame.size.height-keyboardHeight)-changeY;
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
        viewRect.origin.y=(self.view.frame.size.height-keyboardHeight)-changeY;
        self.view.frame=viewRect;
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.passwordTextField resignFirstResponder];
    [self.captchaTextField resignFirstResponder];
    [self.accountTextField resignFirstResponder];
//   [self.InvitationCodeTF resignFirstResponder];
    //    [self.textField resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    CGRect rect=self.view.frame;
    rect.origin.y=64;
    self.view.frame=rect;
    
    [textField resignFirstResponder];
    
    return YES;
}

-(void)findPassword
{
    RHAccountValidateViewController* controller=[[RHAccountValidateViewController alloc]initWithNibName:@"RHAccountValidateViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
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
