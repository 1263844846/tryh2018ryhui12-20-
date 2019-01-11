//
//  RHzhuanzhangViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 17/8/3.
//  Copyright © 2017年 stefan. All rights reserved.
//

#import "RHzhuanzhangViewController.h"
#import "MBProgressHUD.h"
#import "RHBFbankcardListViewController.h"
@interface RHzhuanzhangViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *mengban;
@property (weak, nonatomic) IBOutlet UIView *alterview;
@property (weak, nonatomic) IBOutlet UILabel *lab;
@property (weak, nonatomic) IBOutlet UIImageView *banklogoimage;

@property (weak, nonatomic) IBOutlet UILabel *banknamelab;
@property (weak, nonatomic) IBOutlet UILabel *bankcardnumberlab;
@property (weak, nonatomic) IBOutlet UILabel *bankxianelab;
@property (weak, nonatomic) IBOutlet UILabel *moneylab;

@property (weak, nonatomic) IBOutlet UITextField *moneytf;
@property (weak, nonatomic) IBOutlet UILabel *lastmoneylab;

@property(nonatomic,copy)NSString * wortimestr;

@property (weak, nonatomic) IBOutlet UIButton *chongzhibtn;
@property(nonatomic,assign)BOOL isHaveDian;

@property (weak, nonatomic) IBOutlet UIView *yzmview;

@property (weak, nonatomic) IBOutlet UILabel *yamlab;
@property (weak, nonatomic) IBOutlet UITextField *yamtf;
@property (weak, nonatomic) IBOutlet UIButton *yambtn;

@property(nonatomic,copy)NSString * bankcard;
@property(nonatomic,copy)NSString * businessNo;

@property (weak, nonatomic) IBOutlet UILabel *NotBoundCard;

@property(nonatomic,strong)NSArray * myarray;

@end

@implementation RHzhuanzhangViewController

-(void)getworktime{
    
//    NSDictionary* parameters=@{@"cardNo":self.bankcard,@"money":self.moneytf.text};
    
    
    [[RHNetworkService instance] POST:@"front/payment/baofoo/getAllBankCards" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        DLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
           
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //  NSLog(@"%@",error);
        DLog(@"%@",[[NSString alloc] initWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
        
    }];
  
    
}
-(void)viewWillAppear:(BOOL)animated{
    
   
    [super viewWillAppear:animated];
    [self getworktime];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication].keyWindow addSubview:self.mengban];
    [[UIApplication sharedApplication].keyWindow addSubview:self.alterview];
      [[UIApplication sharedApplication].keyWindow addSubview:self.yzmview];
    self.alterview.frame = CGRectMake(self.alterview.frame.origin.x, self.alterview.frame.origin.y, [UIScreen mainScreen].bounds.size.width-40, self.alterview.frame.size.height);
    if ([UIScreen mainScreen].bounds.size.width<321) {
        self.lab.font = [UIFont systemFontOfSize:12];
    }
    self.moneylab.text = self.bancle;
    self.lastmoneylab.text = self.bancle;
    [self getworktime];
   // self.scrollview.contentSize=CGSizeMake([UIScreen mainScreen].bounds.size.width,CGRectGetMaxY(self.framlab.frame)+2805+20);
    CGSize size = [self.lab sizeThatFits:CGSizeMake(self.lab.frame.size.width, MAXFLOAT)];
    self.lab.frame = CGRectMake(self.lab.frame.origin.x, self.lab.frame.origin.y, self.lab.frame.size.width,      size.height);
    
    self.mengban.hidden = YES;
    
    self.alterview.hidden = YES;
    
    
    self.yzmview.frame = CGRectMake(self.yzmview.frame.origin.x, self.yzmview.frame.origin.y, [UIScreen mainScreen].bounds.size.width-40, self.yzmview.frame.size.height);
    self.yzmview.hidden = YES;
    
    [self setbankdata:self.bankdic];
    
    CGSize sizetishi = [self.lab sizeThatFits:CGSizeMake(self.lab.frame.size.width, MAXFLOAT)];
    self.lab.frame = CGRectMake(self.lab.frame.origin.x, self.lab.frame.origin.y, self.lab.frame.size.width,      sizetishi.height);
    
    self.baofumykjblock = ^(NSArray * arr){
        
        NSLog(@"%@",arr);
        self.myarray = [NSArray arrayWithArray:arr];
        if (arr.count >0) {
            self.banknamelab.text = arr[0][1];
            
             [self.banklogoimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@common/main/attachment/%@",[RHNetworkService instance].newdoMain,arr[0][0]]]];
            self.bankxianelab.text = [NSString stringWithFormat:@"限额：单笔%@万，单日累计%@万，单月累计不限",arr[0][3],arr[0][4]];
            
            NSString *str = [NSString stringWithFormat:@"%@",arr[0][2]];
            //NSString *str = [RHUserManager sharedInterface].telephone;
            self.bankcard = str;
            NSString * laststr = [str substringFromIndex:str.length - 4];
            NSString * firststr = [str substringToIndex:4];
            self.bankcardnumberlab.text = [NSString stringWithFormat:@"%@ **** **** %@",firststr,laststr];
            self.NotBoundCard.text = @"";
        }else{
            
            self.NotBoundCard.text = @"您尚未绑定银行卡，请先绑卡";
        }
        
    };
    
    self.moneytf.delegate = self;
      [self.moneytf addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
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
-(void)textFieldDidChange :(UITextField *)theTextField{
    if (theTextField.text.length >0) {
        
    }
    
    double a = [[self.moneylab.text stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
    double b = [self.moneytf.text doubleValue];
    
    NSString * str  = [NSString stringWithFormat:@"%.2f",b+a];
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:@"###,##0.00;"];
    NSString *formattedNumberString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble: [str doubleValue] ]];
    
    
    self.lastmoneylab.text = formattedNumberString;
    
    if (self.moneytf.text.length>0) {
        self.chongzhibtn.backgroundColor = [RHUtility colorForHex:@"#09aeb0"];
    }
    if (self.moneytf.text.length==0) {
        //self.my.text = [NSString stringWithFormat:@"0.00"];
        self.chongzhibtn.backgroundColor = [RHUtility colorForHex:@"#9BD0D1"];
    }
    
}
-(void)setbankdata:(NSDictionary *)dic{
    
    
    
    
}
- (IBAction)chongzhi:(id)sender {
    
    if (![self.yambtn.titleLabel.text isEqualToString:@"点击获取"]&&![self.yambtn.titleLabel.text isEqualToString:@"60S后重新获取"]) {
        self.mengban.hidden = NO;
        self.yzmview.hidden = NO;
        return;
    }
    
    NSDictionary* parameters=@{@"cardNo":self.bankcard,@"money":self.moneytf.text};
   
    
    [[RHNetworkService instance] POST:@"front/payment/baofoo/prepPay" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        DLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            self.mengban.hidden = NO;
            self.yzmview.hidden = NO;
            self.businessNo = responseObject[@"businessNo"];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
      //  NSLog(@"%@",error);
        DLog(@"%@",[[NSString alloc] initWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
        
    }];
    
   
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)guanbi:(id)sender {
    
    self.mengban.hidden = YES;
    self.alterview.hidden = YES;
}
- (IBAction)tishi:(id)sender {
    self.mengban.hidden = NO;
    self.alterview.hidden = NO;
}

-(NSDictionary*)bankdic{
    
    if (!_bankdic) {
        _bankdic = [NSDictionary dictionary];
    }
    return _bankdic;
}
- (IBAction)hiddenmyimage:(id)sender {
    
    
   
}

- (IBAction)hiddenyzm:(id)sender {
    
    self.yzmview.hidden = YES;
    self.mengban.hidden = YES;
    
}

- (IBAction)querenchongzhi:(id)sender {
    
    NSDictionary* parameters=@{@"businessNo":self.businessNo,@"smsCode":self.yamtf.text,@"cardNo":self.bankcard};
    
    
    [[RHNetworkService instance] POST:@"front/payment/baofoo/pay" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        DLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
          
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //  NSLog(@"%@",error);
        DLog(@"%@",[[NSString alloc] initWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
        
    }];
    
}

- (IBAction)getbaofubankcards:(id)sender {
    
    RHBFbankcardListViewController* vc= [[RHBFbankcardListViewController alloc]initWithNibName:@"RHBFbankcardListViewController" bundle:nil];
    
    vc.array = self.myarray;
    [self.nav pushViewController:vc animated:YES];
    
}

@end
