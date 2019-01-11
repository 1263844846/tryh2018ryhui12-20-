//
//  RHPhoneKHxiugaiViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 2018/12/3.
//  Copyright © 2018年 stefan. All rights reserved.
//

#import "RHPhoneKHxiugaiViewController.h"
#import "RHHFPhonexiugaiViewController.h"

@interface RHPhoneKHxiugaiViewController ()
{
    int secondsCountDown;
    NSTimer *countDownTimer;
}
@property (weak, nonatomic) IBOutlet UIButton *imagebtn;
@property (weak, nonatomic) IBOutlet UIButton *yzmbtn;
@property (weak, nonatomic) IBOutlet UILabel *phonenumlab;
@property (weak, nonatomic) IBOutlet UITextField *yaztf;
@property (weak, nonatomic) IBOutlet UITextField *phoneyamtf;
@property (weak, nonatomic) IBOutlet UIImageView *myimage;

@end

@implementation RHPhoneKHxiugaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self getimage:nil];
    
    
    
    [self configBackButton];
    [self configTitleWithString:@"修改手机号"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self getupdata];
}
- (void)getupdata{
    
    NSString *str = [RHUserManager sharedInterface].telephone;
    
    NSString * laststr = [str substringFromIndex:str.length - 4];
    NSString * firststr = [str substringToIndex:3];
    self.phonenumlab.text = [NSString stringWithFormat:@"%@******%@",firststr,laststr];
    //    self.phonelab.text = [RHUserManager sharedInterface].telephone;
}
- (IBAction)nextview:(id)sender {
    
    NSDictionary *parameters = @{@"telephone":[RHUserManager sharedInterface].telephone,@"captcha":self.yaztf.text,@"telCaptcha":self.phoneyamtf.text};
    [[RHNetworkService instance] POST:@"app/common/user/appUpdateUser/changeNextStep1" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        DLog(@"%@",responseObject);
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            if ([responseObject[@"msg"] isEqualToString:@"success"]) {
                
                RHHFPhonexiugaiViewController *vc1 = [[RHHFPhonexiugaiViewController alloc]initWithNibName:@"RHHFPhonexiugaiViewController" bundle:nil];
                
                [self.navigationController pushViewController: vc1 animated:YES];
                
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
- (IBAction)getimage:(id)sender {
    
    AFHTTPRequestOperationManager* manager=[AFHTTPRequestOperationManager manager];
    
    [manager setSecurityPolicy:[[RHNetworkService instance] customSecurityPolicy]];
    manager.responseSerializer=[[AFImageResponseSerializer alloc]init];
    [manager POST:[NSString stringWithFormat:@"%@app/common/user/appGeneral/captcha?type=CAPTCHA_CHANGE_PHONE",[RHNetworkService instance].newdoMain] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingMutableContainers)  error:nil];
        
        if ([responseObject isKindOfClass:[UIImage class]]) {
            
//            [self.imagebtn setImage:responseObject forState:UIControlStateNormal];
            self.myimage.image=responseObject;
        }
       
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}
- (IBAction)getphoneyzm:(id)sender {
    
    NSDictionary *parameters = @{@"telephone":[RHUserManager sharedInterface].telephone,@"type":@"SMS_CAPTCHA_CHANGE_PHONE",@"captcha":self.yaztf.text};
    AFHTTPRequestOperationManager* manager=[AFHTTPRequestOperationManager manager];
    manager.securityPolicy = [[RHNetworkService instance] customSecurityPolicy];
    manager.responseSerializer=[[AFCompoundResponseSerializer alloc]init];
    [manager POST:[NSString stringWithFormat:@"%@app/common/user/appGeneral/changePhoneTel",[RHNetworkService instance].newdoMain] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"result==%@ <<<",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        if ([responseObject isKindOfClass:[NSData class]]) {
            NSString* restult=[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            if ([restult isEqualToString:@"{\"msg\":\"手机验证码发送成功\"}"]||[restult isEqualToString:@"{\"msg\":\"success\"}"]) {
                //短信发送成功
                [RHUtility showTextWithText:@"验证码已发送至您的手机"];
                [self reSendMessage];
            }else{
                NSDictionary* errorDic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                if ([errorDic objectForKey:@"msg"]) {
                    //DLog(@"%@",[errorDic objectForKey:@"msg"]);
                    if ([[errorDic objectForKey:@"msg"] isEqualToString:@"图片验证码错误"]) {
                    }
                    [RHUtility showTextWithText:[errorDic objectForKey:@"msg"]];
                }
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if ([error.userInfo.allKeys containsObject:@"com.alamofire.serialization.response.error.data"]) {
            NSDictionary* errorDic=[NSJSONSerialization JSONObjectWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] options:NSJSONReadingMutableContainers error:nil];
            if ([errorDic objectForKey:@"msg"]) {
                //DLog(@"%@",[errorDic objectForKey:@"msg"]);
                if ([[errorDic objectForKey:@"msg"] isEqualToString:@"图片验证码错误"]) {
                    [self getimage:nil];
                }
                [RHUtility showTextWithText:[errorDic objectForKey:@"msg"]];
            }
        }
    }];
    
}
- (void)reSendMessage {
    secondsCountDown = 60;
    self.yzmbtn.enabled = NO;
    countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
}

- (void)timeFireMethod {
    secondsCountDown --;
    [self.yzmbtn setTitle:[NSString stringWithFormat:@"重新发送(%d)",secondsCountDown] forState:UIControlStateDisabled];
    if (secondsCountDown == 0) {
        self.yzmbtn.enabled = YES;
        [self.yzmbtn setTitle:@"点击获取" forState:UIControlStateNormal];
        [countDownTimer invalidate];
    }
}

@end
