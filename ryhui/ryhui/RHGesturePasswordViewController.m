//
//  RHGesturePasswordViewController.m
//  ryhui
//
//  Created by stefan on 15/2/28.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHGesturePasswordViewController.h"
#import <CoreFoundation/CoreFoundation.h>
#import "RHALoginViewController.h"
#import "RHMyMessageViewController.h"
#import "RHProjectListViewController.h"
#import "RHMyGiftViewController.h"
#import "DQViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "RHhelper.h"
#import "RHMainViewController.h"

@interface RHGesturePasswordViewController ()<UIAlertViewDelegate>
{
    AppDelegate *app;
    BOOL isDrawPan;
    int checkNum;
}
@property (nonatomic,strong) RHGesturePasswordView * gesturePasswordView;
@property(nonatomic,assign)BOOL myresk;

@end

@implementation RHGesturePasswordViewController{
    NSString * previousString;
    NSString * password;
    UIViewController *oringinVC;
}

@synthesize gesturePasswordView;
@synthesize isForgotV;
@synthesize isReset;
@synthesize isRegister;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)stzfpush{
    
//    [[RHNetworkService instance] POST:@"front/payment/account/trusteePayAlter" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        if ([responseObject isKindOfClass:[NSDictionary class]]) {
//            NSString * str = [NSString stringWithFormat:@"%@",responseObject[@"flag"]];
//            
//           
//            
//            
//        }
//        
//        NSLog(@"%@",responseObject);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        ;
//    }];
    
}
-(void)getbankcard{
   
    //    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSDictionary* parameters=@{@"username":[RHUserManager sharedInterface].username};
    
    //  self.view.userInteractionEnabled = NO;
    [[RHNetworkService instance] POST:@"app/front/payment/appAccount/instantHuifu" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //   self.view.userInteractionEnabled = YES;
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            if (responseObject[@"msg"]&&![responseObject[@"msg"] isKindOfClass:[NSNull class]]) {
                [RHhelper ShraeHelp].numstr = [NSString stringWithFormat:@"%@",responseObject[@"msg"]];
                
            }
            if (responseObject[@"money"]&&![responseObject[@"money"] isKindOfClass:[NSNull class]]) {
                [RHhelper ShraeHelp].moneystr = [NSString stringWithFormat:@"%@",responseObject[@"money"]];
                
            }else{
                
                [RHhelper ShraeHelp].moneystr = @"0";
            }
            if (responseObject[@"flag"]&&![responseObject[@"flag"] isKindOfClass:[NSNull class]]) {
                [RHhelper ShraeHelp].flag = [NSString stringWithFormat:@"%@",responseObject[@"flag"]];
                
            }
        }
        //        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSLog(@"%@---",responseObject);
        
     //   [self huifumoth];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
        // self.view.userInteractionEnabled = YES;
        
        
    }];
    
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
     
    [self getbankcard];
    
    // Do any additional setup after loading the view.
    previousString = [NSString string];
    app = [UIApplication sharedApplication].delegate;
    password = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@Gesture",[RHUserManager sharedInterface].username]];
    [DQViewController Sharedbxtabar].tarbar.hidden = YES;
    self.navigationController.navigationBar.hidden = YES;
//    UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(30, 100, 300, 40)];
//    
//    lab.text = @"5343";
//    lab.backgroundColor = [UIColor redColor];
//    
//
//    [self.view addSubview:lab];
//    [self.view bringSubviewToFront:lab];
    //    DLog(@"%@",password);
    if (!password) {
        
        [self reset];
    }
    else {
        if (isReset) {
            [self reset];
        }else{
            [self verify];
        }
        //        [self verify];
        //        if (isReset) {
        //            [gesturePasswordView.forgetButton setHidden:YES];
        //            [gesturePasswordView.changeButton setHidden:YES];
        //            [gesturePasswordView.state setTextColor:[UIColor colorWithRed:2/255.f green:174/255.f blue:240/255.f alpha:1]];
        //            [gesturePasswordView.state setText:@"请输入密码"];
        //        }
    }
    
    checkNum=0;
    
    [app.alert removeFromSuperview];
    gesturePasswordView.clearButton.hidden = YES;
    if (self.myresk) {
        gesturePasswordView.clearButton.hidden = NO;
    }
    
   NSString * zhiwen = [[NSUserDefaults standardUserDefaults] objectForKey:@"zhiwen"];
    if ([zhiwen isEqualToString:@"zhiwen"]) {
        LAContext * con = [[LAContext alloc]init];
                con.localizedFallbackTitle = @"手势解锁";
                NSError * error;
//                BOOL can = [con canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
//                NSLog(@"%d",can);
        
        
        [con evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                localizedReason:@"指纹解锁" reply:^(BOOL success, NSError * _Nullable error) {
                    if (success) {
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            [self verification:password];
                        }];
                    
                    }
                }];
        
        NSLog(@"down");
        
        
    }
    
    [self openappmydever];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self stzfpush];
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden=NO;
    for (UIView *subView in [UIApplication sharedApplication].keyWindow.subviews) {
        if (subView.tag == 1000) {
            [subView removeFromSuperview];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 验证手势密码
- (void)verify{
    gesturePasswordView = [[RHGesturePasswordView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [gesturePasswordView.tentacleView setRerificationDelegate:self];
    [gesturePasswordView.tentacleView setStyle:1];
    [gesturePasswordView setGesturePasswordDelegate:self];
    [self.view addSubview:gesturePasswordView];
}

#pragma mark - 重置手势密码
- (void)reset{
    gesturePasswordView = [[RHGesturePasswordView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [gesturePasswordView setGesturePasswordDelegate:self];
    [gesturePasswordView.tentacleView setResetDelegate:self];
    [gesturePasswordView.tentacleView setStyle:2];
    //    [gesturePasswordView.imgView setHidden:YES];
    [gesturePasswordView.forgetButton setHidden:YES];
    [gesturePasswordView.changeButton setHidden:YES];
    [gesturePasswordView.clearButton setHidden:NO];
    [gesturePasswordView.enterButton setHidden:NO];
    
   // [gesturePasswordView.state setTextColor:[RHUtility colorForHex:@"#4abac0"]];
    if (self.isReset) {
        gesturePasswordView.textlab.text = @"请绘制原手势密码";
        gesturePasswordView.enterButton.hidden = YES;
        gesturePasswordView.clearButton.hidden = NO;
        gesturePasswordView.namelab.hidden = YES;
        gesturePasswordView.imgView.hidden = YES;
        gesturePasswordView.psimageview.hidden = NO;
         [gesturePasswordView.clearButton setTitle:@"取消修改" forState:UIControlStateNormal];
        
        self.myresk = YES;
    } else {
        gesturePasswordView.enterButton.hidden = NO;
        gesturePasswordView.clearButton.hidden = NO;
    }
    isDrawPan=YES;
    [self.view addSubview:gesturePasswordView];
}

#pragma mark - 判断是否已存在手势密码
- (BOOL)exist{
    password = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@Gesture",[RHUserManager sharedInterface].username]];
    if (!password)return NO;
    return YES;
}

#pragma mark - 清空记录
- (void)clear{
    password=nil;
    previousString=@"";
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:[NSString stringWithFormat:@"%@Gesture",[RHUserManager sharedInterface].username]];
}

#pragma mark - 改变手势密码
//用其他账户登录
- (void)change{
     [[RHUserManager sharedInterface] logout];
    [RHhelper ShraeHelp].moneystr= @"0";
    [RHhelper ShraeHelp].numstr = @"1";
    [self loginoutmyarccout];
    RHALoginViewController* controller=[[RHALoginViewController alloc]initWithNibName:@"RHALoginViewController" bundle:nil];
    controller.isPan=YES;
    [self.navigationController pushViewController:controller animated:YES];
}
-(void)loginoutmyarccout{
    [[RHNetworkService instance] POST:@"app/common/user/appLogout/appUser" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        
    }];
    
}
#pragma mark - 忘记手势密码
- (void)forget{
    [[RHUserManager sharedInterface] logout];
    RHALoginViewController* controller=[[RHALoginViewController alloc]initWithNibName:@"RHALoginViewController" bundle:nil];
    controller.isForgotV=YES;
    [self.navigationController pushViewController:controller animated:YES];
    [self clear];
}

-(void)cleanPan{
    if ([gesturePasswordView.clearButton.titleLabel.text isEqualToString:@"取消修改"]) {
        NSLog(@"cbxbcbxbcbxbcbxbcbxb");
        if (gesturePasswordView.myresttwo) {
            [[RHTabbarManager sharedInterface] initTabbar];
            [[[RHTabbarManager  sharedInterface] selectTabbarMain] popToRootViewControllerAnimated:NO];
        }
        
    }
    if (self.myresk) {
        [gesturePasswordView.clearButton setTitle:@"取消修改" forState:UIControlStateNormal];
    }
    previousString = @"";
     gesturePasswordView.textlab.text = @"请设置新手势密码";
    //[gesturePasswordView.state setText:@"请设置手势密码"];
//    [gesturePasswordView.state setTextColor:[RHUtility colorForHex:@"#4abac0"]];
    [gesturePasswordView.tentacleView enterArgin];
    [gesturePasswordView.clearButton setHidden:NO];
    [gesturePasswordView.enterButton setHidden:NO];
}


-(void)enterPan{
    
    [gesturePasswordView tishiimage:previousString];
    
    if ([previousString isEqualToString:@""]) {
        [RHUtility showTextWithText:@"请先设置正确的手势密码"];
    }else{
        gesturePasswordView.imgView.hidden = YES;
        gesturePasswordView.psimageview.hidden = NO;
        [gesturePasswordView.tentacleView enterArgin];
        [gesturePasswordView.state setTextColor:[UIColor redColor]];
     //   [gesturePasswordView.state setText:@"请确认手势密码"];
//        [gesturePasswordView.clearButton setHidden:YES];
        gesturePasswordView.textlab.text = @"请再次确认手势密码";
        [gesturePasswordView.clearButton setTitle:@"重新绘制" forState:UIControlStateNormal];
        gesturePasswordView.clearButton.hidden = NO;
        [gesturePasswordView.enterButton setHidden:YES];
        isDrawPan=NO;
//        gesturePasswordView.state
    }
}

- (BOOL)verification:(NSString *)result{
    
    
    if ([result isEqualToString:password]) {
        [gesturePasswordView.state setTextColor:[UIColor colorWithRed:2/255.f green:174/255.f blue:240/255.f alpha:1]];
      //  [gesturePasswordView.state setText:@"输入正确"];
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"GestureSave"];
        
        [[RHTabbarManager sharedInterface] initTabbar];
        
        if (self.isNotification) {
            [self sessionFailAndLoginAgain];
            NSString *getString = [self.userInfo objectForKey:@"type"];
            if (getString && getString.length > 0 && [getString integerValue] == 1) {
                //project
                RHProjectListViewController *myMessage = [[RHProjectListViewController alloc] initWithNibName:@"RHProjectListViewController" bundle:nil];
                NSString *investtype = [self.userInfo objectForKey:@"investType"];
                if (investtype && investtype.length > 0) {
                    if ([investtype integerValue] > 1 || [investtype integerValue] < 0) {
                        myMessage.type = @"0";
                    } else {
                         myMessage.type = investtype;
                    }
                } else {
                    myMessage.type = @"0";
                }
                [[RHTabbarManager sharedInterface] initTabbar];
                [[[RHTabbarManager  sharedInterface] selectTabbarMain] pushViewController:myMessage animated:NO];
            } else if (getString && getString.length > 0 && [getString integerValue] == 2) {
                //hongbao
                RHMyGiftViewController *myMessage = [[RHMyGiftViewController alloc] initWithNibName:@"RHMyGiftViewController" bundle:nil];
                [[RHTabbarManager sharedInterface] initTabbar];
                [[[RHTabbarManager  sharedInterface] selectTabbarUser] pushViewController:myMessage animated:NO];
            } else if (getString && getString.length > 0 && [getString integerValue] == 3) {
                //消息
                RHMyMessageViewController *myMessage = [[RHMyMessageViewController alloc] initWithNibName:@"RHMyMessageViewController" bundle:nil];
                [[RHTabbarManager sharedInterface] initTabbar];
                [[[RHTabbarManager  sharedInterface] selectTabbarUser] pushViewController:myMessage animated:NO];
            } else {
                //首页
                [[RHTabbarManager sharedInterface] initTabbar];
                [[[RHTabbarManager  sharedInterface] selectTabbarMain] popToRootViewControllerAnimated:NO];
            }
            app.isAPPActive = YES;
        } else {
            if (isReset) {
                [self reset];
                [self clear];
                
            }else{
                //                if (self.isEnter) {
                ////                    UINavigationController *navi = (UINavigationController *)delegate.window.rootViewController;
                ////
                ////                    NSLog(@"--------------%d",navi.viewControllers.count);
                ////                    if (navi.viewControllers.count > 2) {
                ////                        UIViewController *vc = navi.viewControllers[navi.viewControllers.count - 2];
                ////                        [self.navigationController popToViewController:vc animated:NO];
                ////                    } else {
                //////                        [self.navigationController popViewControllerAnimated:NO];
                ////                        UIViewController *vc = navi.viewControllers[navi.viewControllers.count - 1];
                ////                    }
                //                    [self.navigationController popViewControllerAnimated:NO];
                //                } else {
                [self sessionFailAndLoginAgain];
                
             
                //                }
            }
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"RHGestureSuccessed" object:nil];
        return YES;
    }
    [gesturePasswordView.state setTextColor:[UIColor redColor]];
    [gesturePasswordView.state setText:[NSString stringWithFormat:@"手势密码错误,您还可输入%d次",4 - checkNum]];
    checkNum++;
    if (checkNum >= 5) {
        checkNum=0;
        UIAlertView* alertView =[[UIAlertView alloc]initWithTitle:@"手势密码错误超过5次"
                                                         message:@"手势密码错误超过5次，您将退出登录，请重新登录设置新的手势密码"
                                                        delegate:self
                                               cancelButtonTitle:@"我知道了"
                                                                     otherButtonTitles:nil, nil];
        
        alertView.tag = 10001;
        [alertView show];
    }
    return NO;
}

-(void)openappmydever{
     NSString *deviceUUID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
      NSDictionary* parameters=@{@"popularizeCompany":@"appstore",@"equipment":deviceUUID,@"type":@"IOS",@"appVersion":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]};
    
    [[RHNetworkService instance] POST:@"app/common/appMain/userOperation" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
    }];
}

-(void)sessionFailAndLoginAgain
{
    
    NSLog(@"%f",RHScreeWidth);
    
    NSString * str = @"app/common/user/appLogin/appLogin";
//    NSString * str1 = @"common/user/login/appLogin";
    
    NSDictionary* parameters=@{@"account":[RHUserManager sharedInterface].username,@"password":[RHUserManager sharedInterface].md5};

    [[RHNetworkService instance] POST:str parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        DLog(@"%@",responseObject);
        NSArray* array=[[operation.response.allHeaderFields objectForKey:@"Set-Cookie"] componentsSeparatedByString:@";"];
//        array = @[];
        for (NSString * str in array) {
            if(str.length>12){
                
            
                if ([str rangeOfString:@"JSESSIONID="].location != NSNotFound) {
                    
                    NSArray *array1 = [str componentsSeparatedByString:@"="];
                    
                    NSString * string = [NSString stringWithFormat:@"JSESSIONID=%@",array1[1]];
                    [[NSUserDefaults standardUserDefaults] setObject:string forKey:@"RHSESSION"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                }
                if ([str rangeOfString:@"MYSESSIONID="].location != NSNotFound) {
                    
                    NSArray *array1 = [str componentsSeparatedByString:@"="];
                    
                    NSString * string = [NSString stringWithFormat:@"MYSESSIONID=%@",array1[1]];
                    [[NSUserDefaults standardUserDefaults] setObject:string forKey:@"RHNEWMYSESSION"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                }
            }
        }
        
//        NSString* session=[[NSUserDefaults standardUserDefaults] objectForKey:@"RHSESSION"];
//        [[NSUserDefaults standardUserDefaults] setObject:[array objectAtIndex:0] forKey:@"RHSESSION"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//                DLog(@"%@",operation.response.allHeaderFields);
        NSString *strin = [[NSUserDefaults standardUserDefaults] objectForKey:@"RHSESSION"];
        NSLog(@"=========-session=========%@",strin);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSString* result=[responseObject objectForKey:@"md5"];
            if (result&&[result length]>0) {
                NSString* md5=[responseObject objectForKey:@"md5"];
                [RHNetworkService instance].niubiMd5=md5;
                
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
                NSString* _userpwd=[responseObject objectForKey:@"isSetPwd"] ;
                if (_userpwd&&[_userid length]>0) {
                   
                    [[NSUserDefaults standardUserDefaults] setObject: _userpwd forKey:@"RHUSERpwd"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                }
                NSString* session1=[[NSUserDefaults standardUserDefaults] objectForKey:@"RHUSERpwd"];
                NSLog(@"%@",session1);
                
            }
        }
        if (self.isNotification == NO) {
            NSString *string = [[NSUserDefaults  standardUserDefaults] objectForKey:@"RHSESSION"];
            if (string && string.length > 0) {
                [[[RHTabbarManager sharedInterface] selectTabbarMain] popToRootViewControllerAnimated:NO];
            } else {
//                [RHUtility showTextWithText:@"登录失败，请重新尝试！"];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSDictionary* errorDic=[NSJSONSerialization JSONObjectWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@"%@",errorDic);
        [RHUtility showTextWithText:@"登录失败，请重新尝试！"];
        
//                DLog(@"%@",error);
    }];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag!=10001) {
        
        if (buttonIndex==1) {
                NSString* _zhiwen=@"zhiwen";
                            [RHUserManager sharedInterface].zhiwen=_zhiwen;
                [[NSUserDefaults standardUserDefaults] setObject:[RHUserManager sharedInterface].zhiwen forKey:@"zhiwen"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            
        }
         [self turnToUserCenterOrMainViewcontroller];
//        LAContext * con = [[LAContext alloc]init];
//        con.localizedFallbackTitle = @"手势解锁";
//        NSError * error;
//        BOOL can = [con canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
//        NSLog(@"%d",can);
//        
//        
//        [con evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"验证指纹" reply:^(BOOL success, NSError * _Nullable error) {
//            if (success) {
//                NSLog(@"11111111");
//                [self turnToUserCenterOrMainViewcontroller];
//                
//            }
//            
//            NSLog(@"%d,%@",success,error);
//        }];
        
    }else{
    [[RHUserManager sharedInterface] logout];
    [[RHTabbarManager sharedInterface] selectALogin];
    }
}

//修改手势密码
- (BOOL)resetPassword:(NSString *)result{
    if (self.isReset) {
        NSString *pass =  [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@Gesture",[RHUserManager sharedInterface].username]];
        if ([pass isEqualToString:result]) {
            [self cleanPan];
            gesturePasswordView.myresttwo = NO;
             self.isReset = NO;
        } else {
            [RHUtility showTextWithText:@"原始密码不正确"];
        }
    } else {
        if ([previousString isEqualToString:@""]||isDrawPan) {
            //        DLog(@"%@",result);
            previousString=result;
            [self enterPan];
            return YES;
        } else {
            //        DLog(@"%@",result);
            if ([result isEqualToString:previousString]) {
                password=result;
                
                [[NSUserDefaults standardUserDefaults] setObject:result forKey:[NSString stringWithFormat:@"%@Gesture",[RHUserManager sharedInterface].username]];
                //[self presentViewController:(UIViewController) animated:YES completion:nil];
                [gesturePasswordView.state setTextColor:[UIColor colorWithRed:2/255.f green:174/255.f blue:240/255.f alpha:1]];
                [gesturePasswordView.state setText:@"已保存手势密码"];
                
                if (isReset) {
                    [RHUtility showTextWithText:@"手势密码修改成功"];
                    if (self.navigationController.childViewControllers.count > 1) {
                        [self.navigationController popViewControllerAnimated:YES];
                    }else{
                        [self turnToUserCenterOrMainViewcontroller];
                    }
                }else{
                    
                    if ([self.myres isEqualToString:@"ryh"]) {
                        [self turnToUserCenterOrMainViewcontroller];
                    }else{
                    LAContext * con = [[LAContext alloc]init];
                    NSError * error;
                    BOOL can = [con canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
                    NSLog(@"%d",can);
                    if (can) {
                        if ([[RHhelper ShraeHelp].moneystr doubleValue]<=0) {
                        
                        UIAlertView * alter = [[UIAlertView alloc]initWithTitle:@"指纹" message:@"融益汇将要调用您的指纹解锁" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"应用", nil];
                        
                        [alter show];
                        
                        return YES;
                        }
                    }
                    }
                    [self turnToUserCenterOrMainViewcontroller];
                }
                
                return YES;
            }
            else{
                [gesturePasswordView.clearButton setHidden:NO];
                [gesturePasswordView.tentacleView enterArgin];
                [gesturePasswordView.state setTextColor:[UIColor redColor]];
                [gesturePasswordView.state setText:@"两次密码不一致，请重新输入"];
                return NO;
            }
        }
    }
    return NO;
}


- (void)turnToUserCenterOrMainViewcontroller {
    
    if (isRegister) {
        
        if ([RHhelper ShraeHelp].registnum==9) {
            [RHhelper ShraeHelp].registnum=0;
             RHUserCountViewController *controller = [[RHUserCountViewController alloc]initWithNibName:@"RHUserCountViewController" bundle:nil];
            [[RHTabbarManager sharedInterface] initTabbar];
            [[[RHTabbarManager sharedInterface] selectTabbarMain] popToRootViewControllerAnimated:NO];
            [[DQViewController Sharedbxtabar]tabBar:(DQview *)controller.view didSelectedIndex:2];
            UIButton *btn = [[UIButton alloc]init];
            btn.tag = 2;
            [[DQview Shareview] btnClick:btn];
        }else{
        [[RHTabbarManager sharedInterface] initTabbar];
        [[[RHTabbarManager sharedInterface] selectTabbarUser] popToRootViewControllerAnimated:NO];
        }
    }else{
        
        
        
        
        [[RHTabbarManager sharedInterface] initTabbar];
        [[[RHTabbarManager sharedInterface] selectTabbarMain] popToRootViewControllerAnimated:NO];
    }
}

@end
