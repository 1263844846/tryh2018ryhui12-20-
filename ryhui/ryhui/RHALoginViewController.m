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

@end

@implementation RHALoginViewController
@synthesize isForgotV;
@synthesize isPan;

- (void)viewDidLoad {
    [super viewDidLoad];
    UIControl* control=[[UIControl alloc]initWithFrame:self.captchaImageView.bounds];
    [control addTarget:self action:@selector(changeCaptcha) forControlEvents:UIControlEventTouchUpInside];
    [self.captchaImageView addSubview:control];
    self.captchaImageView.userInteractionEnabled=YES;
    
    [self changeCaptcha];
    
    [self.accountTextField becomeFirstResponder];
    
    [self configBackButton];
    
    [self configTitleWithString:@"登录"];
    
    self.passwordTextField.secureTextEntry=YES;
    
    [self configRightButtonWithTitle:@"注册" action:@selector(pushRigster)];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textBegin:) name:UITextFieldTextDidBeginEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

-(void)back
{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
    NSDictionary *parameters = @{@"account":self.accountTextField.text,@"password":self.passwordTextField.text,@"captcha":self.captchaTextField.text};

    [[RHNetworkService instance] POST:@"common/user/login/login" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        DLog(@"%@",responseObject);
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
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        DLog(@"%@",error);
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
