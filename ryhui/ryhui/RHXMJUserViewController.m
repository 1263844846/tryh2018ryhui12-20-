//
//  RHXMJUserViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 2018/8/24.
//  Copyright © 2018年 stefan. All rights reserved.
//

#import "RHXMJUserViewController.h"
#import "RHXYWebviewViewController.h"
#import "RHXMJTBSQViewController.h"

@interface RHXMJUserViewController ()
{
    int secondsCountDown;
    NSTimer* countDownTimer;
}
@property (weak, nonatomic) IBOutlet UILabel *phonenumberlab;
@property (weak, nonatomic) IBOutlet UIButton *yanzhenmabtn;
@property (weak, nonatomic) IBOutlet UITextField *yzmtf;

@property (weak, nonatomic) IBOutlet UIButton *gouxuanbtn;

@property(nonatomic,copy)NSString *xzbtnres;
@end

@implementation RHXMJUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configBackButton];
    [self configTitleWithString:@"项目集授权"];
    self.phonenumberlab.text = self.phonenumber;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)yanzhengma:(id)sender {
    NSDictionary *parameters = @{@"srvAuthType":@"autoBidAuthPlus",@"mobile": [RHUserManager sharedInterface].telephone};
    
    [[RHNetworkService instance]POST:@"app/front/payment/appJxAccount/sendJxTelCaptcha" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            if (responseObject[@"msg"]&&[responseObject[@"msg"]isEqualToString:@"success"]) {
                [RHUtility showTextWithText:@"验证码已发送至您的手机"];
                
                [self reSendMessage];
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

- (void)reSendMessage {
    secondsCountDown = 60;
    self.yanzhenmabtn.enabled = NO;
    countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
}

- (void)timeFireMethod {
    secondsCountDown --;
    self.yanzhenmabtn.titleLabel.text = [NSString stringWithFormat:@"重新发送(%d)",secondsCountDown];
    [self.yanzhenmabtn setTitle:[NSString stringWithFormat:@"重新发送(%d)",secondsCountDown] forState:UIControlStateDisabled];
    if (secondsCountDown == 0) {
        self.yanzhenmabtn.enabled = YES;
        [self.yanzhenmabtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [countDownTimer invalidate];
    }
}


- (IBAction)xieyi:(id)sender {
    RHXYWebviewViewController * controller = [[RHXYWebviewViewController alloc]initWithNibName:@"RHXYWebviewViewController" bundle:nil];
    
    //    NSString * str = btn.titleLabel.text;
    //
    //    NSString *stringWithoutQuotation = [str
    //                                        stringByReplacingOccurrencesOfString:@"《" withString:@""];
    //    str =  [stringWithoutQuotation stringByReplacingOccurrencesOfString:@"》" withString:@""];
    controller.namestr = @"融益汇自动投标服务协议";
    //    controller.projectid = self.projectId;
    
    [self.navigationController pushViewController:controller animated:YES];
    
}

- (IBAction)didgouxuanbtn:(id)sender {
    
    if ([self.xzbtnres isEqualToString:@"1"]) {
        self.xzbtnres = @"2";
        
        [self.gouxuanbtn setImage:[UIImage imageNamed:@"未选中状态icon"] forState:UIControlStateNormal];
        
    }else{
        [self.gouxuanbtn setImage:[UIImage imageNamed:@"选中状态icon"] forState:UIControlStateNormal];
        self.xzbtnres = @"1";
    }
    
}
- (IBAction)kaiqiyanzheng:(id)sender {
    
    if (![self.xzbtnres isEqualToString:@"1"]) {
        [RHUtility showTextWithText:@"请先同意融益汇自动投标服务协议"];
        return;
    }
    
    RHXMJTBSQViewController * vc = [[RHXMJTBSQViewController alloc]initWithNibName:@"RHXMJTBSQViewController" bundle:nil];
    
    vc.smcstr = self.yzmtf.text;
//    self.xmjview.hidden = YES;
//
//    self.mengbanview.hidden = YES;
    [self.yzmtf resignFirstResponder];
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
