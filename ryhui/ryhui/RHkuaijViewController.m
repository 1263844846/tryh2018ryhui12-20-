//
//  RHkuaijViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 17/8/3.
//  Copyright © 2017年 stefan. All rights reserved.
//

#import "RHkuaijViewController.h"
#import "RHErrorViewController.h"
#import "RHHFphonenumberViewController.h"
#import "RHBngkCardDetailViewController.h"
#import "RHMoreWebViewViewController.h"
#import "MBProgressHUD.h"
#import "RHJXRechargeWebViewController.h"
@interface RHkuaijViewController ()<UITextFieldDelegate>
{
    int secondsCountDown;
    NSTimer *countDownTimer;
}
@property (weak, nonatomic) IBOutlet UIView *mengban;
@property (weak, nonatomic) IBOutlet UIView *chongzhialtert;
@property (weak, nonatomic) IBOutlet UILabel *lab1;
@property (weak, nonatomic) IBOutlet UILabel *lab2;
@property (weak, nonatomic) IBOutlet UIView *tishiview;
@property (weak, nonatomic) IBOutlet UILabel *tishilab;
@property (weak, nonatomic) IBOutlet UITextField *moneytf;
@property (weak, nonatomic) IBOutlet UITextField *yanzhengmatf;
@property (weak, nonatomic) IBOutlet UILabel *yanzhnegmalab;
@property (weak, nonatomic) IBOutlet UIButton *messagebtn;
@property (weak, nonatomic) IBOutlet UILabel *phonenumberlab;
@property (weak, nonatomic) IBOutlet UIView *shibaiview;
@property (weak, nonatomic) IBOutlet UILabel *shibailab;
@property (weak, nonatomic) IBOutlet UILabel *banknamelab;
@property (weak, nonatomic) IBOutlet UILabel *bankcardnumberlab;
@property (weak, nonatomic) IBOutlet UILabel *bankxianelab;
@property (weak, nonatomic) IBOutlet UIImageView *banklogo;
@property (weak, nonatomic) IBOutlet UILabel *yuelab;
@property (weak, nonatomic) IBOutlet UILabel *mastyuelab;
@property (weak, nonatomic) IBOutlet UIImageView *jidunimgage;
@property (weak, nonatomic) IBOutlet UILabel *jxcglab;
@property (weak, nonatomic) IBOutlet UIButton *mychongzhibtn;
@property(nonatomic,assign)BOOL isHaveDian;
@property (weak, nonatomic) IBOutlet UIView *bangkaview;
@property (weak, nonatomic) IBOutlet UILabel *bankbacklab;

@property(nonatomic,assign)BOOL chongress;
@end

@implementation RHkuaijViewController
-(NSDictionary*)bankdic{
    
    if (!_bankdic) {
        _bankdic = [NSDictionary dictionary];
    }
    return _bankdic;
}
-(void)respfirsttf{
    [self.moneytf resignFirstResponder];
    [self.yanzhengmatf resignFirstResponder];
    
}
- (void)getupdata{
    
    NSString *str = [RHUserManager sharedInterface].telephone;
    
    NSString * laststr = [str substringFromIndex:str.length - 4];
    NSString * firststr = [str substringToIndex:3];
   // self.phonenumberlab.text = [NSString stringWithFormat:@"%@******%@",firststr,laststr];
    //    self.phonelab.text = [RHUserManager sharedInterface].telephone;
        self.phonenumberlab.text = [NSString stringWithFormat:@"短信验证码已发送到%@****%@",firststr,laststr];
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

- (void)viewDidLoad {
    self.moneytf.inputAccessoryView = [self addToolbar];
    self.yanzhengmatf.inputAccessoryView = [self addToolbar];
    [super viewDidLoad];
    self.jidunimgage.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-self.jxcglab.frame.size.width)/2+20, self.jidunimgage.frame.origin.y, self.jidunimgage.frame.size.width, self.jidunimgage.frame.size.height);
    self.jxcglab.frame = CGRectMake(CGRectGetMaxX(self.jidunimgage.frame)+75, self.jxcglab.frame.origin.y, self.jxcglab.frame.size.width, self.jxcglab.frame.size.height);
    
    if ([UIScreen mainScreen].bounds.size.width<321) {
        self.jxcglab.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-self.jxcglab.frame.size.width)/2+110, self.jxcglab.frame.origin.y, self.jxcglab.frame.size.width, self.jxcglab.frame.size.height);
        
        self.jidunimgage.hidden = YES;
        self.jxcglab.hidden = YES;
    }
    
    // Do any additional setup after loading the view from its nib.
    [[UIApplication sharedApplication].keyWindow addSubview:self.mengban];
    [[UIApplication sharedApplication].keyWindow addSubview:self.chongzhialtert];
    [[UIApplication sharedApplication].keyWindow addSubview:self.tishiview];
     [[UIApplication sharedApplication].keyWindow addSubview:self.shibaiview];
    [[UIApplication sharedApplication].keyWindow addSubview:self.bangkaview];
    self.shibaiview.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-275)/2, 150, 275, 285);
    self.bangkaview.hidden = YES;
    self.tishiview.hidden = YES;
    self.mengban.hidden = YES;
    self.chongzhialtert.frame = CGRectMake(self.chongzhialtert.frame.origin.x, self.chongzhialtert.frame.origin.y, [UIScreen mainScreen].bounds.size.width-40, self.chongzhialtert.frame.size.height);
    self.chongzhialtert.hidden = YES;
    
    self.tishiview.frame = CGRectMake(self.tishiview.frame.origin.x, self.tishiview.frame.origin.y, [UIScreen mainScreen].bounds.size.width-40, self.tishiview.frame.size.height);
     self.bangkaview.frame = CGRectMake(self.bangkaview.frame.origin.x, self.bangkaview.frame.origin.y, [UIScreen mainScreen].bounds.size.width-80, self.bangkaview.frame.size.height);
    NSLog(@"%f",self.view.frame.size.width);
    NSLog(@"%f",[UIScreen mainScreen].bounds.size.width);
    CGSize size = [self.lab1 sizeThatFits:CGSizeMake([UIScreen mainScreen].bounds.size.width-40, MAXFLOAT)];
    self.lab1.frame = CGRectMake(self.lab1.frame.origin.x, self.lab1.frame.origin.y, self.lab1.frame.size.width,      size.height);
    CGSize size1 = [self.lab2 sizeThatFits:CGSizeMake([UIScreen mainScreen].bounds.size.width-40, MAXFLOAT)];
    self.lab2.frame = CGRectMake(self.lab2.frame.origin.x, CGRectGetMaxY(self.lab1.frame)+5, self.lab2.frame.size.width,      size1.height);
    
    if ([UIScreen mainScreen].bounds.size.width<321) {
       
        self.lab1.frame = CGRectMake(self.lab1.frame.origin.x, self.lab1.frame.origin.y-5, self.lab1.frame.size.width,      size.height);
        self.lab2.frame = CGRectMake(self.lab2.frame.origin.x, CGRectGetMaxY(self.lab1.frame)-3, self.lab2.frame.size.width,      size1.height);
    }
    
    
    
    NSDictionary *attributes = @{NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *netString = [[NSMutableAttributedString alloc] initWithString:self.lab1.text];
    
    [netString addAttributes:attributes range:NSMakeRange(self.lab1.text.length-5,5)];
    [netString addAttribute:NSForegroundColorAttributeName value:[RHUtility colorForHex:@"#09AEB0"] range:NSMakeRange(self.lab1.text.length-5,5)];
   
    self.lab1.attributedText = netString;
    NSDictionary *attributes1 = @{NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *netString1 = [[NSMutableAttributedString alloc] initWithString:self.lab2.text];
    
    [netString1 addAttributes:attributes1 range:NSMakeRange(self.lab2.text.length-4,4)];
    [netString1 addAttribute:NSForegroundColorAttributeName value:[RHUtility colorForHex:@"#09AEB0"] range:NSMakeRange(self.lab2.text.length-4,4)];
    
    self.lab2.attributedText = netString1;
    
    self.moneytf.delegate = self;
    
    [self.moneytf addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    self.messagebtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    
   // self.phonenumberlab.text = [NSString stringWithFormat:@"短信验证码已发送到%@",[RHUserManager sharedInterface].telephone];
    
     self.shibaiview.hidden = YES;
    
    [self setbankcarddata:self.bankdic];
    [self getupdata];
    
   
    [self getfailbank];
    
    
    [self gettishistr];
    
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


-(void)setbankcarddata:(NSDictionary*)dic{
    
    if (dic[@"bankName"] && ![dic[@"bankName"] isKindOfClass:[NSNull class]]) {
        self.banknamelab.text = [NSString stringWithFormat:@"%@",dic[@"bankName"]];
    }
    if (dic[@"bankNo"] && ![dic[@"bankNo"] isKindOfClass:[NSNull class]]) {
       // self.bankcardnumberlab.text = [NSString stringWithFormat:@"%@",dic[@"bankNo"]];
        NSString *str = [NSString stringWithFormat:@"%@",dic[@"bankNo"]];
        //NSString *str = [RHUserManager sharedInterface].telephone;
        
        NSString * laststr = [str substringFromIndex:str.length - 4];
        NSString * firststr = [str substringToIndex:4];
        self.bankcardnumberlab.text = [NSString stringWithFormat:@"%@ **** **** %@",firststr,laststr];
    }
    if (dic[@"bankLogo"] && ![dic[@"bankLogo"] isKindOfClass:[NSNull class]]) {
        //self.banknamelab.text = [NSString stringWithFormat:@"%@",dic[@"bankName"]];
        [self.banklogo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@common/main/attachment/%@",[RHNetworkService instance].newdoMain,dic[@"bankLogo"]]]];
    }
    
    if (dic[@"bankOneLimit"] && ![dic[@"bankOneLimit"] isKindOfClass:[NSNull class]] ) {
        self.bankxianelab.text = [NSString stringWithFormat:@"限额：单笔%@，",dic[@"bankOneLimit"]];
        if ([UIScreen mainScreen].bounds.size.width <321) {
            self.bankxianelab.font = [UIFont systemFontOfSize:11];
        }
        
    }
    if (dic[@"bankDayLimit"] && ![dic[@"bankDayLimit"] isKindOfClass:[NSNull class]] ) {
        self.bankxianelab.text = [NSString stringWithFormat:@"%@单日累计%@",self.bankxianelab.text,dic[@"bankDayLimit"]];
        if ([UIScreen mainScreen].bounds.size.width <321) {
            self.bankxianelab.font = [UIFont systemFontOfSize:11];
        }
        
    }
    if (dic[@"bankMonthLimit"] && ![dic[@"bankMonthLimit"] isKindOfClass:[NSNull class]] ) {
        self.bankxianelab.text = [NSString stringWithFormat:@"%@，单月累计%@。",self.bankxianelab.text,dic[@"bankMonthLimit"]];
        if ([UIScreen mainScreen].bounds.size.width <321) {
            self.bankxianelab.font = [UIFont systemFontOfSize:11];
        }
        
    }
    self.yuelab.text = self.bancle;
    double a = [[self.yuelab.text stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
    //double b = [self.moneytf.text doubleValue];
    
    NSString * str  = [NSString stringWithFormat:@"%.2f",a];
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:@"###,##0.00;"];
    NSString *formattedNumberString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble: [str doubleValue] ]];
    
    
    self.mastyuelab.text = formattedNumberString;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.view];
    [self.moneytf resignFirstResponder];
    [self.yanzhengmatf resignFirstResponder];
    //    self.bankcardtf
    if (CGRectContainsPoint(self.lab1.frame, touchPoint)) {
         RHHFphonenumberViewController * vc = [[RHHFphonenumberViewController alloc]initWithNibName:@"RHHFphonenumberViewController" bundle:nil];
        NSLog(@"111");
        [self.nav pushViewController:vc animated:YES];
    }
     if (CGRectContainsPoint(self.lab2.frame, touchPoint)) {
         
         NSLog(@"222");
         RHMoreWebViewViewController * vc = [[RHMoreWebViewViewController alloc]initWithNibName:@"RHMoreWebViewViewController" bundle:nil];
         vc.namestr = @"支持银行";
         vc.urlstr = [NSString stringWithFormat:@"%@bindKJCard",[RHNetworkService instance].newdoMain];
         [self.nav pushViewController:vc animated:YES];
     }
    
}

-(void)getfailbank{
    
    [[RHNetworkService instance] POST:@"app/front/payment/appBankCardJx/bankMsgByCardNo" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"----===============-1111---%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            if (![responseObject[@"msg"]isEqualToString:@"success"]) {
                self.bankxianelab.text = [NSString stringWithFormat:@"此银行卡暂不支持快捷充值！"];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
        DLog(@"%@",[[NSString alloc] initWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
        //
        //        self.mengban.hidden = NO;
        //        self.shibaiview.hidden = NO;
        
//        if ([error.userInfo.allKeys containsObject:@"com.alamofire.serialization.response.error.data"]) {
//            NSDictionary* errorDic=[NSJSONSerialization JSONObjectWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] options:NSJSONReadingMutableContainers error:nil];
//            if ([errorDic objectForKey:@"msg"]) {
//                self.mengban.hidden = NO;
//                self.shibaiview.hidden = NO;
//                self.chongzhialtert.hidden = YES;
//                self.shibailab.text = errorDic[@"msg"];
//            }
//        }
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)huoquyanzhengma:(id)sender {
    self.yanzhengmatf.text = @"";
    if ([self.bankxianelab.text isEqualToString:@"此银行卡暂不支持快捷充值！"]) {
       // self.bankxianelab.text = [NSString stringWithFormat:@"此银行卡暂不支持快捷充值！"];
        [RHUtility showTextWithText:@"此银行卡暂不支持快捷充值！"];
        return;
    }
    
    if (self.moneytf.text.length<1) {
         [RHUtility showTextWithText:@"请输入充值金额"];
        return;
    }
    if ([self.moneytf.text floatValue]<1) {
        [RHUtility showTextWithText:@"最少充值1元"];
        return;
    }
    
    RHJXRechargeWebViewController * vc = [[RHJXRechargeWebViewController alloc]initWithNibName:@"RHJXRechargeWebViewController" bundle:nil];
    
    vc.money = self.moneytf.text;
    [self.nav pushViewController:vc animated:YES];
    
    return;
    if (![self.messagebtn.titleLabel.text isEqualToString:@"点击获取"]&&![self.messagebtn.titleLabel.text isEqualToString:@"60S后重新获取"]) {
        self.mengban.hidden = NO;
        self.chongzhialtert.hidden = NO;
        return;
    }
   
    NSDictionary *parameters = @{@"mobile":[RHUserManager sharedInterface].telephone,@"srvAuthType":@"directRechargeOnline"};
    NSLog(@"%@",[RHUserManager sharedInterface].telephone);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = [[RHNetworkService instance] customSecurityPolicy];
    manager.responseSerializer = [[AFCompoundResponseSerializer alloc]init];
    [manager POST:[NSString stringWithFormat:@"%@app/front/payment/appJxAccount/sendJxTelCaptcha",[RHNetworkService instance].newdoMain] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSData class]]) {
            NSString *restult = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            if ([restult isEqualToString:@"{\"msg\":\"success\"}"]||[restult isEqualToString:@"success"]) {
                //短信发送成功
                self.mengban.hidden = NO;
                self.chongzhialtert.hidden = NO;
                [RHUtility showTextWithText:@"验证码已发送至您的手机"];
                 [self reSendMessage];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //        DLog(@"%@",error);
        [RHUtility showTextWithText:@"过几秒后重新获取"];
    }];
    
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

- (IBAction)quxiao:(id)sender {
    [self.moneytf resignFirstResponder];
    [self.yanzhengmatf resignFirstResponder];
   // self.moneytf.text = @"";
    self.mengban.hidden = YES;
    self.chongzhialtert.hidden = YES;
 //   self.messagebtn.enabled = YES;
  //  [self.messagebtn setTitle:@"点击获取" forState:UIControlStateNormal];
  //  [countDownTimer invalidate];
}

- (IBAction)querenchongzhi:(id)sender {
    [self.moneytf resignFirstResponder];
    [self.yanzhengmatf resignFirstResponder];
    NSDictionary* parameters=@{@"money":self.moneytf.text,@"smsCode":self.yanzhengmatf.text};
     [MBProgressHUD showHUDAddedTo:self.chongzhialtert animated:YES];
    [[RHNetworkService instance] POST:@"app/front/payment/appJxAccount/directRechargeOnlineData" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"----===============-1111---%@",responseObject);
        RHErrorViewController* controller=[[RHErrorViewController alloc]initWithNibName:@"RHErrorViewController" bundle:nil];
         controller.titleStr=[NSString stringWithFormat:@"充值金额%@元",self.moneytf.text];
        controller.tipsStr=@"好项目不等人，快去抢吧~";
        controller.type=RHPaySucceed;
        
        [self guanbitishi:nil];
        [self.nav pushViewController:controller animated:YES];
        [MBProgressHUD hideAllHUDsForView:self.chongzhialtert animated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
        DLog(@"%@",[[NSString alloc] initWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
//        
//        self.mengban.hidden = NO;
//        self.shibaiview.hidden = NO;
         [MBProgressHUD hideAllHUDsForView:self.chongzhialtert animated:YES];
        if ([error.userInfo.allKeys containsObject:@"com.alamofire.serialization.response.error.data"]) {
            NSDictionary* errorDic=[NSJSONSerialization JSONObjectWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] options:NSJSONReadingMutableContainers error:nil];
            if ([errorDic objectForKey:@"msg"]) {
                self.mengban.hidden = NO;
                self.shibaiview.hidden = NO;
                self.chongzhialtert.hidden = YES;
                self.shibailab.text = errorDic[@"msg"];
                
                if (errorDic[@"retCodeJx"]&&![errorDic[@"retCodeJx"] isKindOfClass:[NSNull class]]) {
                    self.bankbacklab.text = [NSString stringWithFormat:@"银行返回值：%@", errorDic[@"retCodeJx"]];
                }
                
               
            }
        }
    }];
    
}
- (IBAction)guanbitishi:(id)sender {
    
    self.mengban.hidden = YES;
    self.tishiview.hidden = YES;
    self.shibaiview.hidden = YES;
    self.chongzhialtert.hidden = YES;
}
- (IBAction)chongzhitishi:(id)sender {
    self.mengban.hidden = NO;
    self.tishiview.hidden = NO;
}
-(void)textFieldDidChange :(UITextField *)theTextField{
    if (theTextField.text.length >0) {
        
    }
    
    double a = [[self.yuelab.text stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
    double b = [self.moneytf.text doubleValue];
   
    NSString * str  = [NSString stringWithFormat:@"%.2f",b+a];

    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:@"###,##0.00;"];
    NSString *formattedNumberString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble: [str doubleValue] ]];
    
 
    self.mastyuelab.text = formattedNumberString;
    
    if (self.moneytf.text.length>0) {
        self.mychongzhibtn.backgroundColor = [RHUtility colorForHex:@"#09aeb0"];
    }
    if (self.moneytf.text.length==0) {
        //self.my.text = [NSString stringWithFormat:@"0.00"];
        self.mychongzhibtn.backgroundColor = [RHUtility colorForHex:@"#9BD0D1"];
    }
    
}
- (IBAction)asaggrenyanzhengma:(id)sender {
    
    [self huoquyanzhengma:nil];
}
- (IBAction)chongshi:(id)sender {
    
    [self guanbitishi:nil];
}

- (IBAction)bangka:(id)sender {
    RHBngkCardDetailViewController * controller = [[RHBngkCardDetailViewController alloc]initWithNibName:@"RHBngkCardDetailViewController" bundle:nil];
    
    controller.ress = self.bankress;
    self.bangkaview.hidden = YES;
    self.mengban.hidden = YES;
    [self.nav pushViewController:controller animated:YES];
}
- (IBAction)quxiaobangka:(id)sender {
    
    self.bangkaview.hidden = YES;
    self.mengban.hidden = YES;
    self.mykjblock();
}
-(void)hidenbankcard{
    
    self.bangkaview.hidden = NO;
    self.mengban.hidden = NO;
}

-(void)gettishistr{
    
    NSDictionary* parameters=@{@"type":@"fastCharge"};
  
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
