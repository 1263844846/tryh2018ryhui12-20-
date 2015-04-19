//
//  RHAccountValidateViewController.m
//  ryhui
//
//  Created by jufenghudong on 15/3/29.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHAccountValidateViewController.h"
#import "RHPhoneValidateViewController.h"

@interface RHAccountValidateViewController ()

@end

@implementation RHAccountValidateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configBackButton];
    [self configTitleWithString:@"用户名验证"];
    
    [self changeCaptcha];
}

-(void)changeCaptcha
{
    AFHTTPRequestOperationManager* manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[[AFImageResponseSerializer alloc]init];
    [manager POST:[NSString stringWithFormat:@"%@%@",[RHNetworkService instance].doMain,@"common/user/general/captcha?type=CAPTCHA_GETPWDBACK"] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
        [RHUtility showTextWithText:@"请输入用户名"];
        return;
    }
    if ([self.captchaTF.text length]<=0) {
        [RHUtility showTextWithText:@"请输入验证码"];
        return;
    }
    NSDictionary *parameters = @{@"username":self.accountTF.text,@"captcha":self.captchaTF.text};
    
    [[RHNetworkService instance] POST:@"common/user/pwdBack/findPwdBack1" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSString* result=[responseObject objectForKey:@"msg"];
            if (result&&[result length]>0) {
                if ([result isEqualToString:@"success"]) {
                    
                    [self pushPhoneValidate];
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
@end
