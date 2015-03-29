//
//  RHForgotPasswordViewController.m
//  ryhui
//
//  Created by jufenghudong on 15/3/29.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHForgotPasswordViewController.h"

@interface RHForgotPasswordViewController ()

@end

@implementation RHForgotPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configBackButton];
    
    [self configTitleWithString:@"修改密码"];
    
    [self changeCaptcha];
}

-(void)changeCaptcha
{
    AFHTTPRequestOperationManager* manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[[AFImageResponseSerializer alloc]init];
    [manager POST:[NSString stringWithFormat:@"%@%@",[RHNetworkService instance].doMain,@"common/user/general/captcha?type=CAPTCHA_EDITPWD"] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject isKindOfClass:[UIImage class]]) {
            self.captchaImageView.image=responseObject;
        }
        NSArray* array=[[operation.response.allHeaderFields objectForKey:@"Set-Cookie"] componentsSeparatedByString:@";"];
        [[NSUserDefaults standardUserDefaults] setObject:[array objectAtIndex:0] forKey:@"RHSESSION"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
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
    NSDictionary *parameters = @{@"oldPassword":self.oldPasswordTF.text,@"newPassword":self.nnewPasswordTF.text,@"repeatPassword":self.rnewPasswordTF.text,@"captcha":self.captchaTF.text};
    
    [[RHNetworkService instance] POST:@"front/payment/account/editPassword" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSString* result=[responseObject objectForKey:@"msg"];
            if (result&&[result length]>0) {
                if ([result isEqualToString:@"success"]) {
                    [RHUtility showTextWithText:@"修改成功"];
                    [self.navigationController popViewControllerAnimated:YES];
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
@end
