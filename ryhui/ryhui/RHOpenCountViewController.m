//
//  RHOpenCountViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 2018/5/4.
//  Copyright © 2018年 stefan. All rights reserved.
//

//
//  RHOpenCountViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 17/8/1.
//  Copyright © 2017年 stefan. All rights reserved.
//

#import "RHOpenCountViewController.h"
#import "RHOpenAccountScuessViewController.h"
#import "RHGesturePasswordViewController.h"
#import "RHOpenAccoutWebViewViewController.h"
#import "RHMoreWebViewViewController.h"
#import "RHOpenCountWebViewController.h"
#import "RHHFphonenumberViewController.h"
#import "RHPhoneKHxiugaiViewController.h"

@interface RHOpenCountViewController ()<UITextFieldDelegate>
{
    int secondsCountDown;
    NSTimer *countDownTimer;
}
@property (weak, nonatomic) IBOutlet UITextField *nametf;
@property (weak, nonatomic) IBOutlet UITextField *nymbertf;


@property (weak, nonatomic) IBOutlet UITextField *yanzhengmatf;
@property (weak, nonatomic) IBOutlet UILabel *yuanyinlab;
@property (weak, nonatomic) IBOutlet UIView *mengbanview;
@property (weak, nonatomic) IBOutlet UIView *tishiview;
@property (weak, nonatomic) IBOutlet UILabel *bankbacklab;
@property (weak, nonatomic) IBOutlet UILabel *phonelab;
@property (weak, nonatomic) IBOutlet UIButton *chujiebtn;
@property (weak, nonatomic) IBOutlet UIButton *jiekuanbtn;

@property (weak, nonatomic) IBOutlet UIButton *manbtn;

@property (weak, nonatomic) IBOutlet UIButton *womanbtn;

@property(nonatomic,copy)NSString * peoplenumber;
@property(nonatomic,copy)NSString * manorwoman;

@end

@implementation RHOpenCountViewController

-(void)viewWillAppear:(BOOL)animated{
    [self getupdata];
    [super viewWillAppear:animated];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    [self.nametf resignFirstResponder];
    [self.nymbertf resignFirstResponder];
   
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    self.phonelab.text = [RHUserManager sharedInterface].telephone;
    
//    self.mengbanview.hidden = YES;
    
    self.tishiview.hidden  = YES;
    
    [self configTitleWithString:@"开户"];
    //    [self configBackButton];
    self.peoplenumber= @"1";
    self.manorwoman= @"M";
    
    [self setNavigationBackButton];
    
    
   self.jiekuanbtn.layer.cornerRadius = 10.5;
    self.jiekuanbtn.layer.masksToBounds = YES;
    self.chujiebtn.layer.cornerRadius = 10.5;
    self.chujiebtn.layer.masksToBounds = YES;
    
    self.manbtn.layer.cornerRadius = 10.5;
    self.manbtn.layer.masksToBounds = YES;
    self.womanbtn.layer.cornerRadius = 10.5;
    self.womanbtn.layer.masksToBounds = YES;
}
- (void)backToGusture:(UIButton *)btn {
    
    NSString * password;
    password = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@Gesture",[RHUserManager sharedInterface].username]];
    if (password.length>3) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    RHGesturePasswordViewController * controller=[[RHGesturePasswordViewController alloc]init];
    //    BOOL forget = YES;
    //    controller.forget = forget ;
    [self.navigationController pushViewController:controller animated:YES];
    
}
- (void)setNavigationBackButton {
    UIButton* button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(backToGusture:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"icon_back.png"] forState:UIControlStateNormal];
    button.frame=CGRectMake(0, 0, 11, 17);
    self.navigationItem.leftBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:button];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    //开始编辑时触发，文本字段将成为first responder
    
   
    
}






- (IBAction)morebank:(id)sender {
    
    RHMoreWebViewViewController * vc = [[RHMoreWebViewViewController alloc]initWithNibName:@"RHMoreWebViewViewController" bundle:nil];
    vc.namestr = @"支持银行";
    vc.urlstr = [NSString stringWithFormat:@"%@bindKJCard",[RHNetworkService instance].newdoMain];
    [self.navigationController pushViewController:vc animated:YES];
}


- (IBAction)getphonenumberVerificationCode:(id)sender {
    NSDictionary *parameters = @{@"mobile":[RHUserManager sharedInterface].telephone,@"srvAuthType":@"accountOpenPlus"};
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
   
}

- (void)timeFireMethod {
   
}

- (IBAction)AgreenOpenAccount:(id)sender {
    if (self.nametf.text.length<1) {
        [RHUtility showTextWithText:@"请输入姓名"];
        return;
    }
//    if (self.nymbertf.text.length!=18) {
//        [RHUtility showTextWithText:@"请输入正确的身份证号"];
//        return;
//    }
    RHOpenCountWebViewController * vc = [[RHOpenCountWebViewController alloc]initWithNibName:@"RHOpenCountWebViewController" bundle:nil];
    
    vc.idcardstr = self.manorwoman;
    vc.namestr = self.nametf.text;
    
    vc.accusestr = @"00000";
    vc.identitystr = self.peoplenumber;
    vc.mobilestr = [RHUserManager sharedInterface].telephone;
    
    [self.navigationController pushViewController:vc animated:YES];
   
}

- (IBAction)jiangxiBank:(id)sender {
   
    RHPhoneKHxiugaiViewController *vc1 = [[RHPhoneKHxiugaiViewController alloc]initWithNibName:@"RHPhoneKHxiugaiViewController" bundle:nil];
    
    [self.navigationController pushViewController: vc1 animated:YES];
    
//    RHHFphonenumberViewController * vc = [[RHHFphonenumberViewController alloc]initWithNibName:@"RHHFphonenumberViewController" bundle:nil];
//    NSLog(@"111");
//    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)AccountAgreement:(id)sender {
    
    RHOpenAccoutWebViewViewController* controller1=[[RHOpenAccoutWebViewViewController alloc]initWithNibName:@"RHOpenAccoutWebViewViewController" bundle:nil];
    controller1.urlstr = @"userAgreement";
    controller1.titlestr = @"用户授权协议";
    [self.navigationController pushViewController:controller1 animated:YES];
    
}
- (IBAction)hidenfail:(id)sender {
    
    self.mengbanview.hidden = YES;
    
    self.tishiview.hidden  = YES;
}

- (void)getupdata{
    
    NSString *str = [RHUserManager sharedInterface].telephone;
    
    NSString * laststr = [str substringFromIndex:str.length - 4];
    NSString * firststr = [str substringToIndex:3];
    self.phonelab.text = [NSString stringWithFormat:@"%@******%@",firststr,laststr];
    //    self.phonelab.text = [RHUserManager sharedInterface].telephone;
}
- (IBAction)xiane:(id)sender {
    
}
- (IBAction)chujie:(id)sender {
    
    self.chujiebtn.backgroundColor = [RHUtility colorForHex:@"44BBC1"];
    self.jiekuanbtn.backgroundColor = [RHUtility colorForHex:@"DEE0E0"];
    self.peoplenumber= @"1";
    
}
- (IBAction)jiekuan:(id)sender {
    self.chujiebtn.backgroundColor = [RHUtility colorForHex:@"DEE0E0"];
    self.jiekuanbtn.backgroundColor = [RHUtility colorForHex:@"44BBC1"];
    self.peoplenumber= @"2";
}


- (IBAction)didManbtn:(id)sender {
    
    self.manbtn.backgroundColor = [RHUtility colorForHex:@"44BBC1"];
    self.womanbtn.backgroundColor = [RHUtility colorForHex:@"DEE0E0"];
    self.manorwoman= @"M";
}
- (IBAction)didWomanbtn:(id)sender {
    self.manbtn.backgroundColor = [RHUtility colorForHex:@"DEE0E0"];
    self.womanbtn.backgroundColor = [RHUtility colorForHex:@"44BBC1"];
    self.manorwoman= @"F";
}


@end

