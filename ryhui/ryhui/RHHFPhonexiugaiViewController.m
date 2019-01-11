//
//  RHHFPhonexiugaiViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 16/3/3.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import "RHHFPhonexiugaiViewController.h"

@interface RHHFPhonexiugaiViewController ()
{
    
    int secondsCountDown;
    NSTimer* countDownTimer;
}
@property (weak, nonatomic) IBOutlet UIView *tishiview;
@property (weak, nonatomic) IBOutlet UIButton *yanzhengmabtn;
@property (weak, nonatomic) IBOutlet UIButton *querenbtn;
@property (weak, nonatomic) IBOutlet UITextField *phonenumber;
@property (weak, nonatomic) IBOutlet UITextField *catpcat;

@end

@implementation RHHFPhonexiugaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tishiview.hidden = YES;
    [self.tishiview.layer setMasksToBounds:YES];
    [self.tishiview.layer setCornerRadius:10.0];
    [self.yanzhengmabtn.layer setMasksToBounds:YES];
    [self.yanzhengmabtn.layer setCornerRadius:5.0];
    [self.querenbtn.layer setMasksToBounds:YES];
    [self.querenbtn.layer setCornerRadius:10.0];
    
    [self configBackButton];
    [self configTitleWithString:@"修改手机号"];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.phonenumber resignFirstResponder];
    [self.catpcat resignFirstResponder];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)yanzhengma:(id)sender {
    
    if (self.phonenumber.text.length <1) {
         [RHUtility showTextWithText:@"手机号不能为空"];
        return;
    }
    
   
                
    
                
    
    
//   NSDictionary *parameters = @{@"srvAuthType":@"mobileModifyPlus",@"mobile":self.phonenumber.text};
    NSDictionary *parameters = @{@"telephone":self.phonenumber.text,@"type":@"SMS_CAPTCHA_CHANGE_PHONE"};
    [[RHNetworkService instance]POST:@"app/common/user/appGeneral/changePhoneTelNew" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            if (responseObject[@"msg"]&&[responseObject[@"msg"]isEqualToString:@"success"]) {
                [RHUtility showTextWithText:@"验证码已发送至您的手机"];
                
                [self reSendMessage];
            }else{
                
                 [RHUtility showTextWithText:@"验证码已发送至您的手机"];
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
- (IBAction)queren:(id)sender {
    
    if (self.phonenumber.text.length <1) {
        [RHUtility showTextWithText:@"手机号不能为空"];
        return;
    }
    if (self.catpcat.text.length <1) {
        [RHUtility showTextWithText:@"手机验证码不能为空"];
        return;
    }
    
    NSString * beforephone = [RHUserManager sharedInterface].telephone;
    
    NSDictionary *parameters = @{@"mobile":self.phonenumber.text,@"telCaptcha":self.catpcat.text};
    AFHTTPRequestOperationManager* manager=[AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer=[[AFCompoundResponseSerializer alloc]init];
    manager.securityPolicy = [[RHNetworkService instance] customSecurityPolicy];
    [manager POST:[NSString stringWithFormat:@"%@front/payment/reformAccountJx/modifyPhoneNotOpen",[RHNetworkService instance].newdoMain] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"%@",responseObject);
        NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSRange range = [result rangeOfString:@"success"];
        if (range.location != NSNotFound) {
            self.tishiview.hidden = NO;
            [RHUserManager sharedInterface].telephone = self.phonenumber.text;
            [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(timerFired) userInfo:nil repeats:NO];
            
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

- (void)timerFired{
    
    self.tishiview.hidden = YES;
}


- (void)reSendMessage {
    secondsCountDown = 60;
    self.yanzhengmabtn.enabled = NO;
    countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
}

- (void)timeFireMethod {
    secondsCountDown --;
    self.yanzhengmabtn.titleLabel.text = [NSString stringWithFormat:@"重新发送(%d)",secondsCountDown];
    [self.yanzhengmabtn setTitle:[NSString stringWithFormat:@"重新发送(%d)",secondsCountDown] forState:UIControlStateDisabled];
    if (secondsCountDown == 0) {
        self.yanzhengmabtn.enabled = YES;
        [self.yanzhengmabtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [countDownTimer invalidate];
    }
}

@end
