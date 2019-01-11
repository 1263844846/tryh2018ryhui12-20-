//
//  RHDaETXViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 17/8/14.
//  Copyright © 2017年 stefan. All rights reserved.
//

#import "RHDaETXViewController.h"
#import "RHKHBankCardViewController.h"
#import "RHWithdrawWebViewController.h"
#import "RHhelper.h"
#import "RHWSQViewController.h"
@interface RHDaETXViewController ()<UITextFieldDelegate>

{
    int secondsCountDown;
    NSTimer *countDownTimer;
    double free;
}


@property (weak, nonatomic) IBOutlet UIView *mengban;

@property (weak, nonatomic) IBOutlet UIView *alterview;
@property (weak, nonatomic) IBOutlet UIView *tishiview;
@property (weak, nonatomic) IBOutlet UILabel *tishilab;
@property (weak, nonatomic) IBOutlet UITextField *yanzhengmatf;
@property (weak, nonatomic) IBOutlet UIButton *messagebtn;
@property (weak, nonatomic) IBOutlet UILabel *phonenumberlab;
@property (weak, nonatomic) IBOutlet UIButton *bankbtn;

@property (weak, nonatomic) IBOutlet UITextField *LHcardnumbertf;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UIButton *banklistpushbtn;
@property (weak, nonatomic) IBOutlet UILabel *xuanzekaihuhanglab;
@property (weak, nonatomic) IBOutlet UITextField *moneytf;
@property (weak, nonatomic) IBOutlet UIButton *tixianbtn;


@property (weak, nonatomic) IBOutlet UILabel *bankname;

@property (weak, nonatomic) IBOutlet UIImageView *banklogo;
@property (weak, nonatomic) IBOutlet UILabel *bankcardnumber;
@property (weak, nonatomic) IBOutlet UILabel *edulab;
@property (weak, nonatomic) IBOutlet UILabel *yuelable;
@property(nonatomic,copy)NSString *bankstr;
@property (weak, nonatomic) IBOutlet UILabel *shouxufei;

@property (weak, nonatomic) IBOutlet UIView *lianhangkatishi;

@property (weak, nonatomic) IBOutlet UIView *mianfeiedutishi;
@property(nonatomic,assign)BOOL isHaveDian;

@property(nonatomic,copy)NSString * bankpoststr;


@property(nonatomic,copy)NSString * wortimestr;


@property(nonatomic,copy)NSString * sqstring;
@end

@implementation RHDaETXViewController

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        
        RHWSQViewController * vc = [[RHWSQViewController alloc]initWithNibName:@"RHWSQViewController" bundle:nil];
        [self.nav pushViewController:vc animated:YES];
    }
      NSString *deviceUUID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    
}
- (void)getupdata{
    
    NSString *str = [RHUserManager sharedInterface].telephone;
    
    NSString * laststr = [str substringFromIndex:str.length - 4];
    NSString * firststr = [str substringToIndex:3];
    self.phonenumberlab.text = [NSString stringWithFormat:@"短信验证码已发送到%@****%@",firststr,laststr];
    //    self.phonelab.text = [RHUserManager sharedInterface].telephone;
}
- (UIToolbar *)addToolbar
{
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame),35)];
    //    toolbar.tintColor = [UIColor blueColor];
    //    toolbar.backgroundColor = [UIColor clearColor];
    UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(nextTextField)];
    UIBarButtonItem *prevButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(prevTextField)];
    //    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 50, 3,40, 30)];
    [button setTitle:@"完成"forState:UIControlStateNormal];
    //   button.titleLabel
    [button addTarget:self action:@selector(textFieldDone) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[RHUtility colorForHex:@"#44BBC1"] forState:UIControlStateNormal];
    // UIBarButtonItem *rectItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    UIBarButtonItem *flexibleitem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemFlexibleSpace) target:self action:nil];
    NSArray *items = @[flexibleitem,flexibleitem,item];
    [toolbar setItems:items animated:YES];
    //    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(textFieldDone)];
    //    toolbar.items = @[bar];
    //[toolbar :rectItem];
    return toolbar;
}
-(void)textFieldDone{
    
    [self.moneytf resignFirstResponder];
    [self.yanzhengmatf resignFirstResponder];
}
-(NSDictionary*)bankdic{
    
    if (!_bankdic) {
        _bankdic = [NSDictionary dictionary];
    }
    return _bankdic;
}
-(void)gethuoqusq{
    [[RHNetworkService instance] POST:@"app/front/payment/appReformAccountJx/appUserPaymentAuthState" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        DLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            self.sqstring = responseObject[@"paymentState"];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //  NSLog(@"%@",error);
        DLog(@"%@",[[NSString alloc] initWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
        
    }];
    
}
- (void)viewDidLoad {
    self.moneytf.inputAccessoryView = [self addToolbar];
    self.yanzhengmatf.inputAccessoryView = [self addToolbar];
    [super viewDidLoad];
    [self gethuoqusq];
    [[UIApplication sharedApplication].keyWindow addSubview:self.mengban];
    [[UIApplication sharedApplication].keyWindow addSubview:self.alterview];
    [[UIApplication sharedApplication].keyWindow addSubview:self.tishiview];
    [[UIApplication sharedApplication].keyWindow addSubview:self.mianfeiedutishi];
    [[UIApplication sharedApplication].keyWindow addSubview:self.lianhangkatishi];
    self.lianhangkatishi.frame = CGRectMake(self.lianhangkatishi.frame.origin.x, self.lianhangkatishi.frame.origin.y, [UIScreen mainScreen].bounds.size.width-40, self.lianhangkatishi.frame.size.height);
    self.mianfeiedutishi.frame = CGRectMake(self.mianfeiedutishi.frame.origin.x, self.mianfeiedutishi.frame.origin.y, [UIScreen mainScreen].bounds.size.width-40, self.mianfeiedutishi.frame.size.height);
  
    self.mianfeiedutishi.hidden = YES;
    self.lianhangkatishi.hidden = YES;
    self.alterview.frame = CGRectMake(self.alterview.frame.origin.x, self.alterview.frame.origin.y, [UIScreen mainScreen].bounds.size.width-40, self.alterview.frame.size.height);
    self.alterview.hidden = YES;
    self.tishiview.hidden = YES;
    self.mengban.hidden = YES;
    if ([UIScreen mainScreen].bounds.size.width<321) {
        self.tishilab.font = [UIFont systemFontOfSize:12];
    }
    
    
    self.tishiview.frame = CGRectMake(self.tishiview.frame.origin.x, self.tishiview.frame.origin.y, [UIScreen mainScreen].bounds.size.width-40, self.tishiview.frame.size.height+30);
    CGSize size = [self.tishilab sizeThatFits:CGSizeMake(self.tishilab.frame.size.width, MAXFLOAT)];
//    self.tishilab.frame = CGRectMake(self.tishilab.frame.origin.x, self.tishilab.frame.origin.y, self.tishilab.frame.size.width,      size.height);
    
    //self.xuanzekaihuhanglab.hidden = YES;
  //  self.banklistpushbtn.hidden = YES;
  //  self.image.hidden = YES;
    self.LHcardnumbertf.hidden = YES;
    [self getupdata];
    [self setbankcarddata:self.bankdic];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
    self.moneytf.delegate =self;
    [self getworktime];
    [self getmysert];
    
    [self gettishistr];
    
}
-(void)getmysert{
    
    
    [[RHNetworkService instance] POST:@"app/front/payment/appJxAccount/withdrawIsToday" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            if (responseObject[@"isToday"] && ![responseObject[@"isToday"]isKindOfClass:[NSNull class]] ) {
               //stringWithFormat:@"%@",responseObject[@"isToday"]];
                NSString * num = [NSString stringWithFormat:@"%@",responseObject[@"bankLineCode"]];
                
                if (num.length>5) {
                    self.xuanzekaihuhanglab.text = [NSString stringWithFormat:@"%@",num];
                }
                
            }
        }
        NSLog(@"%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        DLog(@"%@",[[NSString alloc] initWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
    }];
    
    //    [[RHNetworkService instance] POST:@"app/front/payment/appAccount/appGetCashDays" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    //
    //        if (!responseObject[@"dats"]|| [responseObject[@"days"]isKindOfClass:[NSNull class]]) {
    //            self.ksday = [responseObject[@"days"] intValue];
    //             [self textFieldTextDidChange:nil];
    //        }
    //
    //        NSLog(@"%@",responseObject);
    //    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    //
    //        NSLog(@"%@",error);
    //    }];
    
    
}

-(void)getworktime{
    
    [[RHNetworkService instance] POST:@"app/front/payment/appAccount/judgeThisDay" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            if (responseObject[@"isWorkDay"]&&![responseObject[@"isWorkDay"]isKindOfClass:[NSNull class]]) {
                
                self.wortimestr = [NSString stringWithFormat:@"%@",responseObject[@"isWorkDay"]];
            }
        }
        NSLog(@"%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        DLog(@"%@",[[NSString alloc] initWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.yanzhengmatf resignFirstResponder];
    [self.LHcardnumbertf resignFirstResponder];
    [self.moneytf resignFirstResponder];
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    /*
     * 不能输入.0-9以外的字符。
     * 设置输入框输入的内容格式
     * 只能有一个小数点
     * 小数点后最多能输入两位
     * 如果第一位是.则前面加上0.
     * 如果第一位是0则后面必须输入点，否则不能输入。
     */
    
    // 判断是否有小数点
    if ([textField.text containsString:@"."]) {
        self.isHaveDian = YES;
    }else{
        self.isHaveDian = NO;
    }
    
    if (string.length > 0) {
        
        //当前输入的字符
        unichar single = [string characterAtIndex:0];
        //        BXLog(@"single = %c",single);
        
        // 不能输入.0-9以外的字符
        if (!((single >= '0' && single <= '9') || single == '.'))
        {
            //            [MBProgressHUD bwm_showTitle:@"您的输入格式不正确" toView:self hideAfter:1.0];
            return NO;
        }
        
        // 只能有一个小数点
        if (self.isHaveDian && single == '.') {
            //            [MBProgressHUD bwm_showTitle:@"最多只能输入一个小数点" toView:self hideAfter:1.0];
            return NO;
        }
        
        // 如果第一位是.则前面加上0.
        if ((textField.text.length == 0) && (single == '.')) {
            textField.text = @"0";
        }
        
        // 如果第一位是0则后面必须输入点，否则不能输入。
        if ([textField.text hasPrefix:@"0"]) {
            if (textField.text.length > 1) {
                NSString *secondStr = [textField.text substringWithRange:NSMakeRange(1, 1)];
                if (![secondStr isEqualToString:@"."]) {
                    //                    [MBProgressHUD bwm_showTitle:@"第二个字符需要是小数点" toView:self hideAfter:1.0];
                    return NO;
                }
            }else{
                if (![string isEqualToString:@"."]) {
                    //                    [MBProgressHUD bwm_showTitle:@"第二个字符需要是小数点" toView:self hideAfter:1.0];
                    return NO;
                }
            }
        }
        
        // 小数点后最多能输入两位
        if (self.isHaveDian) {
            NSRange ran = [textField.text rangeOfString:@"."];
            // 由于range.location是NSUInteger类型的，所以这里不能通过(range.location - ran.location)>2来判断
            if (range.location > ran.location) {
                if ([textField.text pathExtension].length > 1) {
                    //                    [MBProgressHUD bwm_showTitle:@"小数点后最多有两位小数" toView:self hideAfter:1.0];
                    return NO;
                }
            }
        }
        
    }
    
    return YES;
}

- (void)textFieldTextDidChange:(NSNotification *)nots {
    
 /*
    double price = [self.moneytf.text doubleValue];
    
    
    free = [self.edulab.text doubleValue];
    
    if (price > [self.yuelable.text doubleValue]) {
        self.moneytf.text = self.yuelable.text;
        price = [self.yuelable.text doubleValue];
    }
    if (price<=free) {
        double getAmount=0;
        if (self.today>0) {
            
            getAmount= getAmount+2;
        }
        self.shouxufei.text = [NSString stringWithFormat:@"%0.2f",getAmount];
    }else{
        double tempPrice = price - free;
        double getAmount;
        getAmount = tempPrice * 0.005 > 1.00 ? tempPrice * 0.005 : 1.00;
        if (self.today>0) {
            getAmount= getAmount+2;
        }
        self.shouxufei.text = [NSString stringWithFormat:@"%0.2f",getAmount];
        
    }
    if (self.moneytf.text.length>0) {
        self.tixianbtn.backgroundColor = [RHUtility colorForHex:@"#09aeb0"];
    }
    
    if (self.moneytf.text.length==0) {
        self.shouxufei.text = [NSString stringWithFormat:@"0.00"];
        self.tixianbtn.backgroundColor = [RHUtility colorForHex:@"#9BD0D1"];
    }
    
   */
    
    
    
    double price = [self.moneytf.text doubleValue];
    
    
    free = [self.edulab.text doubleValue];
    
    if (price > [self.yuelable.text doubleValue]) {
        self.moneytf.text = self.yuelable.text;
        price = [self.yuelable.text doubleValue];
    }
    if (price<=free) {
        double getAmount=0;
        if (self.today>0) {
            
            getAmount= getAmount+2;
        }
        self.shouxufei.text = [NSString stringWithFormat:@"%0.2f",round(getAmount *100)/100];
    }else{
        double tempPrice = price - free;
        double getAmount;
        getAmount = tempPrice * 0.005 > 1.00 ? tempPrice * 0.005 : 1.00;
        if (self.today>0) {
            getAmount= getAmount+2;
        }
        self.shouxufei.text = [NSString stringWithFormat:@"%0.2f",round(getAmount *100)/100];
        
    }
    
    if (self.moneytf.text.length>0) {
        self.tixianbtn.backgroundColor = [RHUtility colorForHex:@"#09aeb0"];
    }
    if (self.moneytf.text.length==0) {
        self.shouxufei.text = [NSString stringWithFormat:@"0.00"];
        self.tixianbtn.backgroundColor = [RHUtility colorForHex:@"#9BD0D1"];
    }
    
    
}
- (IBAction)kaihubang:(id)sender {
    if ([self.bankbtn.titleLabel.text isEqualToString:@"选择开户行"]) {
        [self.bankbtn setTitle:@"输入联行号" forState:UIControlStateNormal];
        self.xuanzekaihuhanglab.hidden = NO;
        self.banklistpushbtn.hidden = NO;
        self.image.hidden = NO;
        self.LHcardnumbertf.hidden = YES;
        self.xuanzekaihuhanglab.text = @"请选择开户行";
        self.LHcardnumbertf.text = @"";
        self.bankpoststr = @"";
    }else{
         [self.bankbtn setTitle:@"选择开户行" forState:UIControlStateNormal];
        self.xuanzekaihuhanglab.hidden = YES;
        self.banklistpushbtn.hidden = YES;
        self.image.hidden = YES;
        self.LHcardnumbertf.hidden = NO;
        self.xuanzekaihuhanglab.text = @"请选择开户行";
        self.LHcardnumbertf.text = @"";
         self.bankpoststr = @"";
        
    }
    
}
- (IBAction)pushbanklist:(id)sender {
    RHKHBankCardViewController * con = [[RHKHBankCardViewController alloc]initWithNibName:@"RHKHBankCardViewController" bundle:nil];
    con.bankblock = ^(NSString * bankstr,NSString*bankstr1){
        self.xuanzekaihuhanglab.text = bankstr;
        self.bankpoststr = bankstr1;
    };
    [self.nav pushViewController:con animated:YES];
    
}
- (IBAction)tixianhuoquyanzhnegma:(id)sender {
//    NSDate *now = [NSDate date];
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
//    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
//    NSInteger hour = [dateComponent hour];
//    NSInteger minute = [dateComponent minute];
//    hour = 16;
    CGFloat cc = [[RHhelper ShraeHelp].withdrawsmall doubleValue];
    if (cc>[self.moneytf.text doubleValue]) {
        [RHUtility showTextWithText:[NSString stringWithFormat:@"最少提现%@",[RHhelper ShraeHelp].withdrawsmall]];
        return;
    }
    NSDictionary *parametersss = @{@"money":self.moneytf.text};
    [[RHNetworkService instance] POST:@"front/payment/accountJx/checkUserWithdraw" parameters:parametersss success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        DLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSString * res = [NSString stringWithFormat:@"%@",responseObject[@"withdrawFlag"]];
            
            if ([res isEqualToString:@"yes"]) {
                
                
                if ([self.shouxufei.text floatValue]>0&&[self.sqstring isEqualToString:@"no"]&& [self.sqswitch isEqualToString:@"ON"]) {
                    
                    
                    self.sqblock();
                    
                    return;
                    
                }
                
                if ([self.wortimestr isEqualToString:@"false"]) {
                    [RHUtility showTextWithText:@"非工作时间不能大额提现，请您选择普通提现"];
                    return;
                }
                
                if (self.moneytf.text.length<1) {
                    [RHUtility showTextWithText:@"请输入提现金额"];
                    return;
                }
                
                CGFloat aa = [[RHhelper ShraeHelp].withdrawsmall doubleValue];
                //    if (aa<1) {
                //        aa=50;
                //    }
                if ([self.moneytf.text doubleValue]<aa) {
                    [RHUtility showTextWithText:[NSString stringWithFormat:@"最少提现%@",[RHhelper ShraeHelp].withdrawsmall]];
                    return;
                }
                if (self.LHcardnumbertf.text.length<4  ) {
                    
                    if (self.xuanzekaihuhanglab.text.length <5||[self.xuanzekaihuhanglab.text isEqualToString:@"请选择开户行"]) {
                        
                        if (self.bankpoststr.length<5) {
                            [RHUtility showTextWithText:@"请输入正确联行卡号"];
                            return;
                        }
                        
                    }
                    
                }
                
                
                
                if (![self.messagebtn.titleLabel.text isEqualToString:@"点击获取"]&&![self.messagebtn.titleLabel.text isEqualToString:@"60S后重新获取"]) {
                    self.mengban.hidden = NO;
                    self.alterview.hidden = NO;
                    return;
                }
                
                NSDictionary *parameters = @{@"telephone":[RHUserManager sharedInterface].telephone,@"type":@"SMS_CAPTCHA_CASH"};
                NSLog(@"%@",[RHUserManager sharedInterface].telephone);
                AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
                manager.securityPolicy = [[RHNetworkService instance] customSecurityPolicy];
                manager.responseSerializer = [[AFCompoundResponseSerializer alloc]init];
                [manager POST:[NSString stringWithFormat:@"%@app/common/user/appGeneral/appSendTelCaptcha",[RHNetworkService instance].newdoMain] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    //        DLog(@"result==%@ <<<",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
                    if ([responseObject isKindOfClass:[NSData class]]) {
                        NSString *restult = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                        if ([restult isEqualToString:@"{\"msg\":\"success\"}"]||[restult isEqualToString:@"success"]) {
                            //短信发送成功
                            
                            [RHUtility showTextWithText:@"验证码已发送至您的手机"];
                            [self reSendMessage];
                            self.mengban.hidden = NO;
                            self.alterview.hidden = NO;
                        }
                    }
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    //        DLog(@"%@",error);
                }];

                
            }else{
                
                [RHUtility showTextWithText:@"您的交易存在风险，请联系客服确认是否为本人操作"];
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //  NSLog(@"%@",error);
        DLog(@"%@",[[NSString alloc] initWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
        
    }];

    
    return;
    
    
    
    if ([self.shouxufei.text floatValue]>0&&[self.sqstring isEqualToString:@"no"]&& [self.sqswitch isEqualToString:@"ON"]) {
       
            
            self.sqblock();
            
            return;
        
    }
    
    if ([self.wortimestr isEqualToString:@"false"]) {
        [RHUtility showTextWithText:@"非工作时间不能大额提现，请您选择普通提现"];
        return;
    }
    
    if (self.moneytf.text.length<1) {
        [RHUtility showTextWithText:@"请输入提现金额"];
        return;
    }
  
    CGFloat aa = [[RHhelper ShraeHelp].withdrawsmall doubleValue];
//    if (aa<1) {
//        aa=50;
//    }
    if ([self.moneytf.text doubleValue]<aa) {
       [RHUtility showTextWithText:[NSString stringWithFormat:@"最少提现%@",[RHhelper ShraeHelp].withdrawsmall]];
        return;
    }
    if (self.LHcardnumbertf.text.length<4  ) {
        
        if (self.xuanzekaihuhanglab.text.length <5||[self.xuanzekaihuhanglab.text isEqualToString:@"请选择开户行"]) {
            
            if (self.bankpoststr.length<5) {
                [RHUtility showTextWithText:@"请输入正确联行卡号"];
                return;
            }
            
        }
        
    }
    
    
    
    if (![self.messagebtn.titleLabel.text isEqualToString:@"点击获取"]&&![self.messagebtn.titleLabel.text isEqualToString:@"60S后重新获取"]) {
        self.mengban.hidden = NO;
        self.alterview.hidden = NO;
        return;
    }
    
    NSDictionary *parameters = @{@"telephone":[RHUserManager sharedInterface].telephone,@"type":@"SMS_CAPTCHA_CASH"};
    NSLog(@"%@",[RHUserManager sharedInterface].telephone);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = [[RHNetworkService instance] customSecurityPolicy];
    manager.responseSerializer = [[AFCompoundResponseSerializer alloc]init];
    [manager POST:[NSString stringWithFormat:@"%@app/common/user/appGeneral/appSendTelCaptcha",[RHNetworkService instance].newdoMain] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        DLog(@"result==%@ <<<",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        if ([responseObject isKindOfClass:[NSData class]]) {
            NSString *restult = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            if ([restult isEqualToString:@"{\"msg\":\"success\"}"]||[restult isEqualToString:@"success"]) {
                //短信发送成功
                
                [RHUtility showTextWithText:@"验证码已发送至您的手机"];
                [self reSendMessage];
                self.mengban.hidden = NO;
                self.alterview.hidden = NO;
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //        DLog(@"%@",error);
    }];

}



-(void)setbankcarddata:(NSDictionary*)dic{
    
    if (dic[@"bankName"] && ![dic[@"bankName"] isKindOfClass:[NSNull class]]) {
        self.bankname.text = [NSString stringWithFormat:@"%@",dic[@"bankName"]];
    }
    if (dic[@"bankNo"] && ![dic[@"bankNo"] isKindOfClass:[NSNull class]]) {
        //  self.bankcardnumberlab.text = [NSString stringWithFormat:@"%@",dic[@"bankNo"]];
        NSString *str = [NSString stringWithFormat:@"%@",dic[@"bankNo"]];
        //NSString *str = [RHUserManager sharedInterface].telephone;
        
        NSString * laststr = [str substringFromIndex:str.length - 4];
        NSString * firststr = [str substringToIndex:4];
        self.bankcardnumber.text = [NSString stringWithFormat:@"%@ **** **** %@",firststr,laststr];
        self.bankstr = [NSString stringWithFormat:@"%@",dic[@"bankNo"]];
    }
    if (dic[@"bankLogo"] && ![dic[@"bankLogo"] isKindOfClass:[NSNull class]]) {
        //self.banknamelab.text = [NSString stringWithFormat:@"%@",dic[@"bankName"]];
        [self.banklogo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@common/main/attachment/%@",[RHNetworkService instance].newdoMain,dic[@"bankLogo"]]]];
    }
    if (dic[@"avlBalance"] && ![dic[@"avlBalance"] isKindOfClass:[NSNull class]]) {
        self.yuelable.text = [NSString stringWithFormat:@"%@",dic[@"avlBalance"]];
    }
    if (dic[@"free"] && ![dic[@"free"] isKindOfClass:[NSNull class]]) {
        double free1 = [dic[@"free"] doubleValue];
        
        self.edulab.text = [NSString stringWithFormat:@"%0.2f",free1];
        
       // self.edulab.text = [NSString stringWithFormat:@"%@",dic[@"free"]];
    }
//    if (dic[@"avlBalance"] && ![dic[@"avlBalance"] isKindOfClass:[NSNull class]]) {
//        self.myyueelab.text = [NSString stringWithFormat:@"%@",dic[@"avlBalance"]];
//    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    //返回一个BOOL值，指定是否循序文本字段开始编辑
    
    self.view.frame = CGRectMake(self.view.frame.origin.x, -200, self.view.frame.size.width, self.view.frame.size.height);
    
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    //返回BOOL值，指定是否允许文本字段结束编辑，当编辑结束，文本字段会让出first responder
    //要想在用户结束编辑时阻止文本字段消失，可以返回NO
    //这对一些文本字段必须始终保持活跃状态的程序很有用，比如即时消息
    
    self.view.frame = CGRectMake(self.view.frame.origin.x, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    return YES;
}






- (void)reSendMessage {
    secondsCountDown = 60;
    [self.yanzhengmatf becomeFirstResponder];
    self.messagebtn.enabled = NO;
    countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
}

- (void)timeFireMethod {
    secondsCountDown --;
    [self.messagebtn setTitle:[NSString stringWithFormat:@"%dS后重新发送",secondsCountDown] forState:UIControlStateDisabled];
    if (secondsCountDown == 0) {
        self.messagebtn.enabled = YES;
        [self.messagebtn setTitle:@"点击获取" forState:UIControlStateNormal];
        [countDownTimer invalidate];
    }
}


- (IBAction)tixiantishi:(id)sender {
    self.mengban.hidden = NO;
    self.tishiview.hidden = NO;
    [self.moneytf resignFirstResponder];
    [self.yanzhengmatf resignFirstResponder];
}
- (IBAction)quxiaotixian:(id)sender {
    self.alterview.hidden = YES;
    self.tishiview.hidden = YES;
    self.mengban.hidden = YES;
    [self.moneytf resignFirstResponder];
    [self.yanzhengmatf resignFirstResponder];
}

- (IBAction)querentixian:(id)sender {
    
    [self.moneytf resignFirstResponder];
    [self.yanzhengmatf resignFirstResponder];
    //NSDictionary* parameters=@{@"cardNumber":self.bankcardstr,@"money":self.moneytf.text,@"txFee":self.shouxufeilab.text,@"category":@"1",@"smsCode":self.yanzhengmatf.text};
    NSDictionary* parameters=@{@"telephone":[RHUserManager sharedInterface].telephone,@"type":@"SMS_CAPTCHA_CASH",@"smsCode":self.yanzhengmatf.text};
    [[RHNetworkService instance] POST:@"app/front/payment/appJxAccount/verifyTelCaptcha" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"----===============-1111---%@",responseObject);
        RHWithdrawWebViewController *controller = [[RHWithdrawWebViewController alloc]initWithNibName:@"RHWithdrawWebViewController" bundle:nil];
        //  controller.delegate = self;
        controller.bankcard = self.bankstr;
        controller.category = @"2";
        controller.amount = self.moneytf.text;
        controller.captcha = self.shouxufei.text;
        
        if (self.LHcardnumbertf.text.length>5) {
            controller.cardBankCnaps = self.LHcardnumbertf.text;
        }else{
        
        
        if (self.LHcardnumbertf.hidden) {
            if (self.bankpoststr.length <5) {
                controller.cardBankCnaps = self.xuanzekaihuhanglab.text;
            }else{
            controller.cardBankCnaps = self.bankpoststr;
            }
        }
        
        }
        [self quxiaotixian:nil];
        // [self.navigationController pushViewController:controller animated:YES];
        
        //  [self guanbitishi:nil];
        [self.nav pushViewController:controller animated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
        DLog(@"%@",[[NSString alloc] initWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
        if ([error.userInfo.allKeys containsObject:@"com.alamofire.serialization.response.error.data"]) {
            NSDictionary* errorDic=[NSJSONSerialization JSONObjectWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] options:NSJSONReadingMutableContainers error:nil];
            if ([errorDic objectForKey:@"msg"]) {
                
                //self.shibailab.text = errorDic[@"msg"];
                [RHUtility showTextWithText:errorDic[@"msg"]];
             //   [MBProgressHUD hideAllHUDsForView:self.alterview animated:YES];
            }
        }
        self.mengban.hidden = NO;
        // self.shibaiview.hidden = NO;
    }];
    
    
}
- (IBAction)chongxinhuoquyanzhnegma:(id)sender {
    
   // [self didtixian:nil];
    
    
}


- (IBAction)hidenall:(id)sender {
    
    self.mengban.hidden = YES;
    self.mianfeiedutishi.hidden = YES;
    self.lianhangkatishi.hidden = YES;
    self.tishiview.hidden = YES;
}
- (IBAction)shouxufeidid:(id)sender {
    
    self.mengban.hidden = NO;
    self.mianfeiedutishi.hidden = NO;
}
- (IBAction)lainhangka:(id)sender {
    self.mengban.hidden = NO;
    self.lianhangkatishi.hidden = NO;
}
- (IBAction)guanbitishiview:(id)sender {
    
    [self hidenall:nil];
}
-(void)rebsfirst{
    [self textFieldDone];
    
}
-(void)moneyrebsfirst{
    
    [self.moneytf becomeFirstResponder];
}
-(void)gettishistr{
    
    NSDictionary* parameters=@{@"type":@"largeCash"};
    
    [[RHNetworkService instance] POST:@"app/front/payment/appJxAccount/getMsgByType" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        if (responseObject[@"msg"]&& ![responseObject[@"msg"] isKindOfClass:[NSNull class]]) {
            self.tishilab.text = responseObject[@"msg"];
            CGSize sizetishi = [self.tishilab sizeThatFits:CGSizeMake(self.tishilab.frame.size.width, MAXFLOAT)];
            self.tishilab.frame = CGRectMake(self.tishilab.frame.origin.x, self.tishilab.frame.origin.y, self.tishilab.frame.size.width,      sizetishi.height);
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
        DLog(@"%@",[[NSString alloc] initWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
        
        
        
    }];
}

@end
