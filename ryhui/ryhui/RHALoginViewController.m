//
//  RHALoginViewController.m
//  ryhui
//
//  Created by 江 云龙 on 15/2/13.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHALoginViewController.h"

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
    
    self.accountTextField.text=@"weixidream1";
    self.passwordTextField.text=@"123456";
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



- (IBAction)loginAction:(id)sender {
    NSDictionary *parameters = @{@"account":self.accountTextField.text,@"password":self.passwordTextField.text,@"captcha":self.captchaTextField.text};

    [[RHNetworkService instance] POST:@"common/user/login/login" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSString* result=[responseObject objectForKeyedSubscript:@"msg"];
            if ([result isEqualToString:@"1"]) {
                NSString* md5=[responseObject objectForKey:@"md5"];
                [RHNetworkService instance].niubiMd5=md5;
                
                [self.navigationController dismissViewControllerAnimated:NO completion:^{
                    
                }];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
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
