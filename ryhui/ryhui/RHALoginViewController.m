//
//  RHALoginViewController.m
//  ryhui
//
//  Created by stefan on 15/2/13.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHALoginViewController.h"
#import "RHGesturePasswordViewController.h"

@interface RHALoginViewController ()

@end

@implementation RHALoginViewController

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
    
    self.accountTextField.text=@"mayun523";
    self.passwordTextField.text=@"1q2w3e";
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



- (IBAction)loginAction:(id)sender {
    NSDictionary *parameters = @{@"account":self.accountTextField.text,@"password":self.passwordTextField.text,@"captcha":self.captchaTextField.text};

    [[RHNetworkService instance] POST:@"common/user/login/login" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSString* result=[responseObject objectForKeyedSubscript:@"md5"];
            if (result&&[result length]>0) {
                NSString* md5=[responseObject objectForKey:@"md5"];
                [RHNetworkService instance].niubiMd5=md5;
                
                [RHUserManager sharedInterface].username=self.accountTextField.text;
                
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
                
                RHGesturePasswordViewController* controller=[[RHGesturePasswordViewController alloc]init];
                [self.navigationController pushViewController:controller animated:NO];
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

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField isEqual:self.accountTextField]) {
        [self.passwordTextField becomeFirstResponder];
        return YES;
    }
    
    if ([textField isEqual:self.passwordTextField]) {
        [self.captchaTextField becomeFirstResponder];
        return YES;
    }
    
    if ([textField isEqual:self.captchaTextField]) {
        [self loginAction:nil];
        return NO;
    }
    
    return YES;
}
@end
