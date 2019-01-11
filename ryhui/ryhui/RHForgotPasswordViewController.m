//
//  RHForgotPasswordViewController.m
//  ryhui
//
//  Created by jufenghudong on 15/3/29.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHForgotPasswordViewController.h"
#import "RHAccountValidateViewController.h"

@interface RHForgotPasswordViewController ()<UIAlertViewDelegate>
{
    float changeY;
    float keyboardHeight;
}
@property (weak, nonatomic) IBOutlet UITextField *oldPasswordTF;
@property (weak, nonatomic) IBOutlet UITextField *rnewPasswordTF;
@property (weak, nonatomic) IBOutlet UITextField *captchaTF;
@property (weak, nonatomic) IBOutlet UITextField *nnewPasswordTF;
@property (weak, nonatomic) IBOutlet UIImageView *captchaImageView;
@property (weak, nonatomic) IBOutlet UIButton *querenbtn;

@end

@implementation RHForgotPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configBackButton];
    
    [self configTitleWithString:@"修改登录密码"];
    self.querenbtn.layer.masksToBounds=YES;
    self.querenbtn.layer.cornerRadius=6;
    
    self.oldPasswordTF.secureTextEntry=YES;
    self.nnewPasswordTF.secureTextEntry=YES;
    self.rnewPasswordTF.secureTextEntry=YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textBegin:) name:UITextFieldTextDidBeginEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
     [self changeCaptcha];
}

-(void)textBegin:(NSNotification*)not
{
//    DLog(@"%@",not.object);
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
//    DLog(@"%@",not.userInfo);
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

-(void)changeCaptcha
{
    AFHTTPRequestOperationManager* manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[[AFImageResponseSerializer alloc]init];
    manager.securityPolicy = [[RHNetworkService instance] customSecurityPolicy];
    [manager POST:[NSString stringWithFormat:@"%@%@",[RHNetworkService instance].newdoMain,@"app/common/user/appGeneral/captcha?type=CAPTCHA_EDITPWD"] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

-(void)getloginpassword{
    
    NSDictionary *parameters = @{@"password":self.nnewPasswordTF.text};
    [[RHNetworkService instance] POST:@"app/common/user/appRegister/checkPassword" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        DLog(@"%@",responseObject);
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            if ([responseObject[@"msg"] isEqualToString:@"success"]) {
                [self getsuccesspassword];
            }
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

-(void)getsuccesspassword{
    
    NSDictionary *parameters = @{@"oldPassword":self.oldPasswordTF.text,@"newPassword":self.nnewPasswordTF.text,@"repeatPassword":self.rnewPasswordTF.text,@"captcha":self.captchaTF.text};
    
    [[RHNetworkService instance] POST:@"app/common/user/appUpdateUser/appEditPassword" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSString* result=[responseObject objectForKey:@"msg"];
            if (result&&[result length]>0) {
                if ([result isEqualToString:@"success"]) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"密码修改成功，请重新登录" delegate:self cancelButtonTitle:@"登录" otherButtonTitles: nil];
                    [alert show];
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

- (IBAction)changeAction:(id)sender {
    if ([self.oldPasswordTF.text length]<=0) {
        [RHUtility showTextWithText:@"请输入原密码"];
        return;
    }
    if ([self.nnewPasswordTF.text length]<=0) {
        [RHUtility showTextWithText:@"请输入新密码"];
        return;
    }
    if ([self.rnewPasswordTF.text length]<=0) {
        [RHUtility showTextWithText:@"请输入确认密码"];
        return;
    }
    if ([self.captchaTF.text length]<=0) {
        [RHUtility showTextWithText:@"请输入验证码"];
        return;
    }
    if ([self.nnewPasswordTF.text length]<6||[self.nnewPasswordTF.text length]>16) {
        [RHUtility showTextWithText:@"新密码长度必须为8-16位字符之间"];
        return;
    }
    if ([self.rnewPasswordTF.text length]<6||[self.rnewPasswordTF.text length]>16) {
        [RHUtility showTextWithText:@"确认密码长度必须为8-16位字符之间"];
        return;
    }
    
    [self getloginpassword];
   
    
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [[RHUserManager sharedInterface] logout];
    } else {
//        [self changeCaptcha];
       // [[RHUserManager sharedInterface] logout];
    }
}                        

-(void)loginOut {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"RHcustId"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"RHemail"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"RHinfoType"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"RHmd5"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"RHtelephone"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"RHUSERNAME"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"RHUSERID"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"RHSESSION"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"RHMessageNumSave"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RHMessageNum" object:@"0"];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:[NSString stringWithFormat:@"%@Gesture",[RHUserManager sharedInterface].username]];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [RHUserManager sharedInterface].custId = nil;
    [RHUserManager sharedInterface].email = nil;
    [RHUserManager sharedInterface].infoType = nil;
    [RHUserManager sharedInterface].md5 = nil;
    [RHUserManager sharedInterface].telephone = nil;
    [RHUserManager sharedInterface].userId = nil;
    [RHUserManager sharedInterface].username = nil;

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
- (IBAction)forgetpassword:(id)sender {
    
    
    RHAccountValidateViewController* controller=[[RHAccountValidateViewController alloc]initWithNibName:@"RHAccountValidateViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}
- (IBAction)button:(id)sender {
    [self changeCaptcha];
}

@end
