//
//  RHHFLoginPasswordViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 16/3/2.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import "RHHFLoginPasswordViewController.h"
#import "AppDelegate.h"
#import "RHHFWebviewViewController.h"
#import "RHJXPassWordViewController.h"
#import "RHInvestmentViewController.h"
#import "RHWithdrawViewController.h"

#import "RHJXPassWordNewViewController.h"

@interface RHHFLoginPasswordViewController ()
{
    int secondsCountDown;
    NSTimer *countDownTimer;
}
@property (weak, nonatomic) IBOutlet UILabel *phonenumberlab;
@property (weak, nonatomic) IBOutlet UIButton *messagebtn;
@property (weak, nonatomic) IBOutlet UITextField *yanzhengmatf;

@end

@implementation RHHFLoginPasswordViewController

- (void)getupdata{
    
    NSString *str = [RHUserManager sharedInterface].telephone;
    
    NSString * laststr = [str substringFromIndex:str.length - 4];
    NSString * firststr = [str substringToIndex:3];
    self.phonenumberlab.text = [NSString stringWithFormat:@"%@****%@",firststr,laststr];
    //    self.phonelab.text = [RHUserManager sharedInterface].telephone;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
   [self configTitleWithString:@"修改交易密码"];
   self.messagebtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    
//    self.phonenumberlab.text = [RHUserManager sharedInterface].telephone;
    
    [self conmyBackButton];
    
    [self getupdata];
}
- (void)conmyBackButton
{
    UIButton* button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    //    UIImage * image = [UIImage imageNamed:@"back.png"];
    
    [button setImage:[UIImage imageNamed:@"icon_back.png"] forState:UIControlStateNormal];
    button.frame=CGRectMake(0, 0, 11, 17);
    
    // button.backgroundColor = [UIColor colorWithHexString:@"44bbc1"];
    self.navigationItem.leftBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:button];
}

-(void)back{
    
    NSArray * array = self.navigationController.viewControllers;
    for (UIViewController * contr in array) {
        if ([contr isKindOfClass:[RHInvestmentViewController class] ]) {
            
           
            
            [self.navigationController popToViewController:contr animated:YES];
            return;
        }
        if ([contr isKindOfClass:[RHWithdrawViewController class] ]) {
            
            
            
            [self.navigationController popToViewController:contr animated:YES];
            return;
        }
    }
    


    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)huoquyanzhengma:(id)sender {
    NSDictionary *parameters = @{@"mobile":[RHUserManager sharedInterface].telephone,@"srvAuthType":@"passwordResetPlus"};
    NSLog(@"%@",[RHUserManager sharedInterface].telephone);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = [[RHNetworkService instance] customSecurityPolicy];
    manager.responseSerializer = [[AFCompoundResponseSerializer alloc]init];
    [manager POST:[NSString stringWithFormat:@"%@app/front/payment/appJxAccount/sendJxTelCaptcha",[RHNetworkService instance].newdoMain] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        DLog(@"result==%@ <<<",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        if ([responseObject isKindOfClass:[NSData class]]) {
            NSString *restult = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            if ([restult isEqualToString:@"{\"msg\":\"success\"}"]||[restult isEqualToString:@"success"]) {
                //短信发送成功
                [RHUtility showTextWithText:@"验证码已发送至您的手机"];
                [self reSendMessage];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //        DLog(@"%@",error);
    }];
    
    
}
- (void)reSendMessage {
    secondsCountDown = 60;
    self.messagebtn.enabled = NO;
    countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
}

- (void)timeFireMethod {
    secondsCountDown --;
    [self.messagebtn setTitle:[NSString stringWithFormat:@"重新发送(%d)",secondsCountDown] forState:UIControlStateDisabled];
    if (secondsCountDown == 0) {
        self.messagebtn.enabled = YES;
        [self.messagebtn setTitle:@"点击获取" forState:UIControlStateNormal];
        [countDownTimer invalidate];
    }
}
- (IBAction)chongzhi:(id)sender {
    
    
    RHJXPassWordViewController * controller =[[RHJXPassWordViewController alloc]initWithNibName:@"RHJXPassWordViewController" bundle:nil];
    
    controller.urlstr = @"app/front/payment/appReformAccountJx/passwordResetPageData";
//    controller.messagestr = self.yanzhengmatf.text;
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)xiugai:(id)sender {
    
   // NSDictionary* parameters=@{@"idType":@"01",@"smsCode":self.yanzhengmatf.text};
    
    if ([self.boolres isEqualToString:@"res"]) {
    [RHUtility showTextWithText:@"请先设置交易密码"];
        return;
    }
//    RHJXPassWordNewViewController * controller =[[RHJXPassWordNewViewController alloc]initWithNibName:@"RHJXPassWordNewViewController" bundle:nil];
////    controller.xiugai = @"1";
//    controller.urlstr = @"app/front/payment/appReformAccountJx/passwordUpdate";
//    //    controller.messagestr = self.yanzhengmatf.text;
//    [self.navigationController pushViewController:controller animated:YES];
    
    
    
    RHJXPassWordViewController * controller =[[RHJXPassWordViewController alloc]initWithNibName:@"RHJXPassWordViewController" bundle:nil];
    controller.xiugai = @"1";
    controller.urlstr = @"app/front/payment/appReformAccountJx/passwordUpdate";
//    controller.messagestr = self.yanzhengmatf.text;
    [self.navigationController pushViewController:controller animated:YES];
}

@end
