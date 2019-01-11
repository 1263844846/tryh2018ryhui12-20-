//
//  RHRegisterSecondViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 16/5/16.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import "RHRegisterSecondViewController.h"

#import "RHGesturePasswordViewController.h"

#import "RHRegisterWebViewController.h"
#import "RHShowGiftTableViewCell.h"
#import "RHOpenCountViewController.h"
@interface RHRegisterSecondViewController ()<UITextFieldDelegate,UIAlertViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    int secondsCountDown;
    NSTimer *countDownTimer;
}

@property (weak, nonatomic) IBOutlet UITextField *usernametf;
@property (weak, nonatomic) IBOutlet UITextField *passwordtf;

//红包设置
@property (strong, nonatomic) IBOutlet UIView *giftView;
@property (weak, nonatomic) IBOutlet UIImageView *typeImageView;
@property (weak, nonatomic) IBOutlet UILabel *giftMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *giftNoticeLabel;
@property (strong, nonatomic) IBOutlet UIView *kaihuAndPhoneView;

@property(nonatomic,assign)BOOL res;

@property (weak, nonatomic) IBOutlet UIImageView *mingwenimage;
@property (weak, nonatomic) IBOutlet UIImageView *zhuceimage;
@property (weak, nonatomic) IBOutlet UIButton *kaihumybtn;
@property (weak, nonatomic) IBOutlet UITableView *GiftTableView;

@property(nonatomic,strong)NSMutableArray * giftArray;
@property (weak, nonatomic) IBOutlet UILabel *registmoneylab;
@property (weak, nonatomic) IBOutlet UIView *testview;
@property (weak, nonatomic) IBOutlet UIView *sussesview;
@property (weak, nonatomic) IBOutlet UIImageView *sussessiamge;





@property (weak, nonatomic) IBOutlet UILabel *hiddenlab;
@property (weak, nonatomic) IBOutlet UILabel *hiddentestlab;
@property (weak, nonatomic) IBOutlet UIImageView *hidenimage;
@property (weak, nonatomic) IBOutlet UILabel *miaolab;

@end

@implementation RHRegisterSecondViewController
//-(NSMutableArray *)giftArray{
//    if (_giftArray) {
//        _giftArray = [NSMutableArray array];
//    }
//    return _giftArray;
//    
//}

-(void)getloginpassword{
    
    NSDictionary *parameters = @{@"password":self.passwordtf.text};
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
    self.kaihuAndPhoneView.hidden = YES;
    [self setNavigationBackButton];
    self.passwordtf.secureTextEntry = YES;
    [self configTitleWithString:@"注册"];
    self.giftView.hidden = YES;
    self.usernametf.delegate = self;
    
    //self.passwordtf.delegate = self;
    
    self.zhuceimage.userInteractionEnabled = NO;
    
//    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(fiftCloseButtonClicked:)];
    
    if ([UIScreen mainScreen].bounds.size.width<321) {
        self.sussesview.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 210);
        NSLog(@"%f",self.sussesview.frame.size.width);
        self.sussessiamge.frame = CGRectMake(125, 10, 145, 145);
        
        self.registmoneylab.font = [UIFont systemFontOfSize:30];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)getsuccesspassword{
    NSString *deviceUUID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSMutableDictionary* parameters=[[NSMutableDictionary alloc]initWithCapacity:0];
    [parameters setObject:self.usernametf.text forKey:@"username"];
    [parameters setObject:self.passwordtf.text forKey:@"password"];
    [parameters setObject:self.passwordtf.text forKey:@"passwordRepeat"];
    [parameters setObject:@"appstore" forKey:@"channelRegister"];
    [parameters setObject:deviceUUID forKey:@"equipmentRegister"];
    [parameters setObject:@"IOS" forKey:@"equipmentTypeRegister"];
    [[RHNetworkService instance] POST:@"app/common/user/appRegister/nextStep2" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        DLog(@"%@",responseObject)341941;
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            
            NSString* result=[responseObject objectForKey:@"md5"];
            [RHUserManager sharedInterface].username = self.usernametf.text ;
            //            [RHUserManager sharedInterface].md5 = result;
            if (result&&[result length]>0) {
                NSString* md5=[responseObject objectForKey:@"md5"];
                [RHNetworkService instance].niubiMd5=md5;
                
                //                [RHUserManager sharedInterface].username=self.accountTF.text;
                
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
                NSString* _userid=[[responseObject objectForKey:@"userId"] stringValue];
                if (_userid&&[_userid length]>0) {
                    [RHUserManager sharedInterface].userId=_userid;
                    [[NSUserDefaults standardUserDefaults] setObject:[RHUserManager sharedInterface].userId forKey:@"RHUSERID"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                }
                
                //                [RHUtility showTextWithText:@"注册成功"];
                
                //                [self selectOtherAciton:nil];
                //                self.kaihuAndPhoneView.hidden = NO;
                
                //                self.kaihuAndPhoneView.frame = CGRectMake(0, CGRectGetHeight([UIScreen mainScreen].bounds) - CGRectGetHeight(self.kaihuAndPhoneView.frame) - 64, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight(self.kaihuAndPhoneView.frame));
                //
                //                [self.view addSubview:self.kaihuAndPhoneView];
                //                [self.view bringSubviewToFront:self.kaihuAndPhoneView];
                self.kaihuAndPhoneView.hidden = NO;
                [self reSendMessage];
                //                [self cheTheGift];
                [self cheTheGifts];
                
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //        DLog(@"%@",operation.responseObject);
        if ([operation.responseObject isKindOfClass:[NSDictionary class]]) {
            NSString* msg=[operation.responseObject objectForKey:@"msg"];
            if ([msg isEqualToString:@"验证码错误"]||[msg isEqualToString:@"手机验证码错误"]) {
                // [self changeCaptcha];
            }
            [RHUtility showTextWithText:msg];
        }
    }];
    
    
}
- (IBAction)queren:(id)sender {
    [self.usernametf resignFirstResponder];
    [self.passwordtf resignFirstResponder];
    
   
    if ([self.usernametf.text length]<=0) {
        [RHUtility showTextWithText:@"请输用户名"];
        return;
    }
   
    if ([self.passwordtf.text length]<=0) {
        [RHUtility showTextWithText:@"请输入密码"];
        return;
    }
     [self getloginpassword];
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.usernametf resignFirstResponder];
    [self.passwordtf resignFirstResponder];
   
}

- (void)setNavigationBackButton {
    UIButton* button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(backToGusture:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"icon_back.png"] forState:UIControlStateNormal];
    button.frame=CGRectMake(0, 0, 11, 17);
    self.navigationItem.leftBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)backToGusture:(UIButton *)btn {
    
    
    if (self.kaihuAndPhoneView.hidden == NO) {
        RHGesturePasswordViewController* controller=[[RHGesturePasswordViewController alloc]init];
        //    BOOL forget = YES;
        //    controller.forget = forget ;
        [self.navigationController pushViewController:controller animated:YES];
        
    }else{
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"是否放弃注册？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
//    alert.tag=5565;
    [alert show];
    }
//    [self.navigationController popViewControllerAnimated:YES];
}
-(void)loginryh{
    UIAlertView* alertView=[[UIAlertView alloc]initWithTitle:@""
                                                     message:@"登录后才可查看投标记录，请先登录"
                                                    delegate:self
                                           cancelButtonTitle:@"确定"
                                           otherButtonTitles:@"取消", nil];
//    alertView.tag=5565;
    // if (!self.ressss) {
    [alertView show];
    
    //}
    
    
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
//    self.ressss=YES;
    if (buttonIndex==0) {
        [self.navigationController popViewControllerAnimated:YES];
        
    }else{
        
       
        
    }
}
-(void)cheTheGifts {
    AFHTTPRequestOperationManager* manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[[AFCompoundResponseSerializer alloc]init];
    manager.securityPolicy = [[RHNetworkService instance] customSecurityPolicy];
    [manager.operationQueue cancelAllOperations];
    NSString* session=[[NSUserDefaults standardUserDefaults] objectForKey:@"RHSESSION"];
    NSLog(@"------------------%@",session);
    NSString* session1=[[NSUserDefaults standardUserDefaults] objectForKey:@"RHNEWMYSESSION"];
    
    if (session1.length>12) {
        session = [NSString stringWithFormat:@"%@,%@",session,session1];
    }
    if (session&&[session length]>0) {
        [manager.requestSerializer setValue:session forHTTPHeaderField:@"cookie"];
    }
    [manager POST:[NSString stringWithFormat:@"%@app/front/payment/appAccount/newsAppQueryRegFinishedBonuses",[RHNetworkService instance].newdoMain] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"------------------%@",responseObject);
        
        if ([responseObject isKindOfClass:[NSData class]]) {
            NSDictionary* dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"------------------%@",dic);
            NSString* isShow=[dic objectForKey:@"isShow"];
            self.giftMoneyLabel.text = [dic objectForKey:@"giftMoney"];
            if (![[dic objectForKey:@"giftMoney"] isKindOfClass:[NSNull class]]) {
                
                CGFloat a = [[dic objectForKey:@"giftMoney"] doubleValue];
                if (a>5) {
                    self.registmoneylab.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"giftMoney"]];
                }else{
                    self.registmoneylab.text = [NSString stringWithFormat:@"%@%%",[dic objectForKey:@"giftMoney"]];
                    self.hiddenlab.hidden = YES;
                    self.registmoneylab.font = [UIFont systemFontOfSize:35];
                }
                
            }
            if (![[dic objectForKey:@"giftContent"] isKindOfClass:[NSNull class]]) {
                self.hiddentestlab.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"giftContent"]];

            }
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"%@",[[NSString alloc] initWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
        self.hiddenlab.hidden = YES;
        self.hidenimage.hidden = YES;
        self.hiddentestlab.hidden = YES;
        self.registmoneylab.hidden = YES;
        
    }];
}
-(void)cheTheGift {
    AFHTTPRequestOperationManager* manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[[AFCompoundResponseSerializer alloc]init];
    manager.securityPolicy = [[RHNetworkService instance] customSecurityPolicy];
    [manager.operationQueue cancelAllOperations];
    NSString* session=[[NSUserDefaults standardUserDefaults] objectForKey:@"RHSESSION"];
    NSLog(@"------------------%@",session);
    NSString* session1=[[NSUserDefaults standardUserDefaults] objectForKey:@"RHNEWMYSESSION"];
    
    if (session1.length>12) {
        session = [NSString stringWithFormat:@"%@,%@",session,session1];
    }
    if (session&&[session length]>0) {
        [manager.requestSerializer setValue:session forHTTPHeaderField:@"cookie"];
    }
    [manager POST:[NSString stringWithFormat:@"%@app/common/user/appRegister/checkPopGift",[RHNetworkService instance].newdoMain] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"------------------%@",responseObject);
        
        if ([responseObject isKindOfClass:[NSData class]]) {
            NSDictionary* dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"------------------%@",dic);
            NSString* amount=[dic objectForKey:@"money"];
            if (amount&&[amount length]>0) {
//                self.giftView.frame = CGRectMake(0, -20, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) + 64);
                self.giftView.hidden = NO;
                self.giftMoneyLabel.text = [NSString stringWithFormat:@"%d元红包券已放入账户",[amount intValue]];
                [self setTheAttributeString:self.giftMoneyLabel.text];
                [self.navigationController.navigationBar addSubview:self.giftView];
                [self performSelector:@selector(fiftCloseButtonClicked:) withObject:nil afterDelay:15.0];
                self.kaihumybtn.userInteractionEnabled = NO;
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"%@",[[NSString alloc] initWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
    }];
}
-(void)setTheAttributeString:(NSString *)string {
    NSDictionary *attribute = @{NSForegroundColorAttributeName : [UIColor colorWithRed:249.0/255 green:212.0/255 blue:37.0/255 alpha:1.0], NSFontAttributeName: [UIFont systemFontOfSize:22.0]};
    NSDictionary *attribute1 = @{NSForegroundColorAttributeName : [UIColor colorWithRed:249.0/255 green:212.0/255 blue:37.0/255 alpha:1.0]};
    
    NSString *subString = [string componentsSeparatedByString:@"元"][0];
    
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:string];
    
    [attributeString setAttributes:attribute range:NSMakeRange(0, subString.length)];
    [attributeString setAttributes:attribute1 range:NSMakeRange(subString.length, 1)];
    self.giftMoneyLabel.attributedText = attributeString;
}

- (IBAction)fiftCloseButtonClicked:(UIButton *)sender {
    self.kaihumybtn.userInteractionEnabled = YES;
    self.giftView.hidden = YES;
    //[textFiled resignFirstResponder];
    
    self.kaihuAndPhoneView.hidden = NO;
//    RHGesturePasswordViewController* controller=[[RHGesturePasswordViewController alloc]init];
//    //    BOOL forget = YES;
//    //    controller.forget = forget ;
//    [self.navigationController pushViewController:controller animated:NO];
}




- (IBAction)closegift:(id)sender {
    
    self.kaihumybtn.userInteractionEnabled = YES;
    self.giftView.hidden = YES;
    //[textFiled resignFirstResponder];
    
    self.kaihuAndPhoneView.hidden = NO;
    
}


- (IBAction)anwen:(id)sender {
    
    if (!self.res) {
        self.mingwenimage.image = [UIImage imageNamed:@"PNG_注册-可见1"];
        self.passwordtf.secureTextEntry = NO;
        self.res = YES;
       // return;
    }else{
    self.mingwenimage.image = [UIImage imageNamed:@"PNG_注册-不可见"];
    self.passwordtf.secureTextEntry = YES;
    self.res = NO;
    
    }
}
- (IBAction)kaihu:(id)sender {
    NSLog(@"kaihu");
    RHOpenCountViewController* vc = [[RHOpenCountViewController alloc]initWithNibName:@"RHOpenCountViewController" bundle:nil];
     [countDownTimer invalidate];
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)reSendMessage {
    secondsCountDown = 5;
    //[self.yanzhengmatf becomeFirstResponder];
    // self.huoqubtn.enabled = NO;
    
    countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
}

- (void)timeFireMethod {
    secondsCountDown --;
    
    self.miaolab.text = [NSString stringWithFormat:@"%dS后自动跳转",secondsCountDown] ;
    if (secondsCountDown == 0) {
        [self kaihu:nil];
        [countDownTimer invalidate];
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [countDownTimer invalidate];
}
@end
