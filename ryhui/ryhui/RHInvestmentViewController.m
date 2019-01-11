//
//  RHInvestmentViewController.m
//  ryhui
//
//  Created by 江 云龙 on 15/3/18.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHInvestmentViewController.h"
#import "RHInvestmentWebViewController.h"
#import "RHRechargeViewController.h"
#import "RHContractViewContoller.h"
#import "DQViewController.h"
#import "RHCPFirstViewController.h"
#import "RHInverstWebViewController.h"
#import "RHXMJTBSQViewController.h"
#import "MBProgressHUD.h"
#import "RHErrorViewController.h"
#import "RHXYWebviewViewController.h"
#import "RHXYWebviewViewController.h"

@interface RHInvestmentViewController ()<UITextFieldDelegate,chooseGiftDelegate>
{
    float changeY;
    float keyboardHeight;
    float currentThreshold;
    int currentMoney;
    int secondsCountDown;
    NSTimer* countDownTimer;
}

@property (weak, nonatomic) IBOutlet UILabel *ketoumoney;
@property (weak, nonatomic) IBOutlet UILabel *keyongmoney;


@property (weak, nonatomic) IBOutlet UIImageView *RHaimageviewicon;
//1
@property (weak, nonatomic) IBOutlet UIImageView *textBG;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIImageView *gifticon;
//gift
@property (weak, nonatomic) IBOutlet UIView *giftSupperView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *keyonglable;
//
@property (weak, nonatomic) IBOutlet UILabel *investorRateLabel;
@property (weak, nonatomic) IBOutlet UILabel *limitTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *projectFundLabel;
//可投金额
@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;
//2

@property (weak, nonatomic) IBOutlet UITextField *touzitextfFiled;

@property (weak, nonatomic) IBOutlet UITextField *textFiled;
@property (weak, nonatomic) IBOutlet UIView *giftView;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label0;
@property (weak, nonatomic) IBOutlet UIButton *chooseButton;

@property(nonatomic,strong)NSString* projectId;
@property(nonatomic,strong)NSString* giftId;

@property (weak, nonatomic) IBOutlet UIButton *querenbtn;
@property (weak, nonatomic) IBOutlet UILabel *moneylab;
@property(nonatomic,copy)NSString * leibie;

@property(nonatomic,copy)NSString * dayormouth;

@property(nonatomic,strong)NSDictionary * bankdic ;
@property(nonatomic,copy)NSString * bankress ;

@property (weak, nonatomic) IBOutlet UIView *mengbanview;

@property (weak, nonatomic) IBOutlet UIView *cepingview;
@property (weak, nonatomic) IBOutlet UIImageView *cepingimage;

@property(nonatomic,copy)NSString * cepingstr;

@property (weak, nonatomic) IBOutlet UILabel *biglab;
@property (weak, nonatomic) IBOutlet UILabel *smalllab;


@property(nonatomic,copy)NSString * strxmjsq;



@property (weak, nonatomic) IBOutlet UIView *xmjview;
@property (weak, nonatomic) IBOutlet UITextField *xmjtf;
@property (weak, nonatomic) IBOutlet UILabel *xmjphonenumberlab;
@property (weak, nonatomic) IBOutlet UIButton *xmjyzmbtn;
@property (weak, nonatomic) IBOutlet UIButton *xmjxzbtn;


@property(nonatomic,strong)NSDictionary *jkdic;
@property(nonatomic,copy)NSString  *jkstring;


@property (weak, nonatomic) IBOutlet UILabel *xmjmoneylab;
@property (weak, nonatomic) IBOutlet UILabel *xmjhongbaolab;
@property (weak, nonatomic) IBOutlet UIView *cjxmjview;

@property (weak, nonatomic) IBOutlet UIButton *xieyiframe;


@property (weak, nonatomic) IBOutlet UILabel *cplabstr;


@property(nonatomic,copy)NSString  *xzbtnres;

@property(nonatomic,copy)NSString *xmjinsertcp;


@property (weak, nonatomic) IBOutlet UIButton *yuedubtn;

@property(nonatomic,copy)NSString * yuedustr;

@end

@implementation RHInvestmentViewController
@synthesize projectId;
@synthesize dataDic;
@synthesize projectFund;
@synthesize giftId=_giftId;

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [DQViewController Sharedbxtabar].tarbar.hidden = YES;
    [self checkout];
    [self getprojectdata];
     [self getceping];
    
    if ([self.xmjres isEqualToString:@"xmj"]||self.xmjid) {
        [self shouquanyanzhengxmj];
    }
}


- (void)viewDidLoad {
//    self.xzbtnres = @"1";
    [super viewDidLoad];
    [[UIApplication sharedApplication].keyWindow addSubview:self.mengbanview];
    [[UIApplication sharedApplication].keyWindow addSubview:self.cepingimage];
    [[UIApplication sharedApplication].keyWindow addSubview:self.cepingview];
    [[UIApplication sharedApplication].keyWindow addSubview:self.xmjview];
    [[UIApplication sharedApplication].keyWindow addSubview:self.cjxmjview];
    
   
    [self getxieyi];
    self.xmjview.frame = CGRectMake(CGRectGetMinX(self.xmjview.frame), CGRectGetMinY(self.xmjview.frame), RHScreeWidth-30, 220);
    
    self.cjxmjview.frame = CGRectMake(RHScreeWidth/2-140, 150, 280, 240);
    
    self.xmjview.hidden = YES;
    
    self.mengbanview.hidden = YES;
    self.cepingimage.hidden = YES;
    self.cepingview.hidden = YES;
     self.cjxmjview.hidden = YES;
//    [self getceping];
    
    
    CGFloat a = 260;
    if ([UIScreen mainScreen].bounds.size.width>320) {
        a=300;
    }
    
    self.cepingimage.frame =CGRectMake(([UIScreen mainScreen].bounds.size.width-a)/2.0, 160, a, 260);
    self.cepingview.frame =CGRectMake(([UIScreen mainScreen].bounds.size.width-a)/2.0, 160, a, 260);
    if (self.newpeople == YES) {
        self.giftSupperView.hidden = YES;
    }
    [self getmyjxbankcard];
    
    UIView * dbxView = [[UIView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-70, [UIScreen mainScreen].bounds.size.width, 70)];
    
    if ([UIScreen mainScreen].bounds.size.height>740) {
         dbxView.frame=CGRectMake(0, [UIScreen mainScreen].bounds.size.height-70, [UIScreen mainScreen].bounds.size.width, 70);
    }
    self.view.backgroundColor = [RHUtility colorForHex:@"#E4E6E6"];
    dbxView.backgroundColor = [RHUtility colorForHex:@"#E4E6E6"];
//    dbxView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:dbxView];
    
    UIImageView * dbxaimage = [[UIImageView alloc]init];
    
    
    
    if ([UIScreen mainScreen].bounds.size.width<330) {
        dbxaimage.frame = CGRectMake(self.giftSupperView.bounds.size.width-40, 16, 17, 14) ;
        
        self.ketoumoney.font = [UIFont boldSystemFontOfSize:14];
        self.keyongmoney.font = [UIFont boldSystemFontOfSize:14];
        self.keyonglable.font = [UIFont boldSystemFontOfSize:16];
        self.projectFundLabel.font = [UIFont boldSystemFontOfSize:16];
        
    }else if ([UIScreen mainScreen].bounds.size.width>330 && [UIScreen mainScreen].bounds.size.width<380){
        dbxaimage.frame = CGRectMake(self.giftSupperView.bounds.size.width-40+50, 16, 12, 14);
    }else{
        dbxaimage.frame = CGRectMake(self.giftSupperView.bounds.size.width-40+80, 16, 12, 14);
    }
    
    
    NSLog(@"%f",[UIScreen mainScreen].bounds.size.width);
    dbxaimage.image = [UIImage imageNamed:@"fanback"];
    [self.giftSupperView addSubview:dbxaimage];
    
    self.RHaimageviewicon.image = [UIImage imageNamed:@"rhcbx1"];
    
    [self.touzitextfFiled addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    
    UIButton*rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,30,30)];
    //[rightButton setImage:[UIImage imageNamed:@"shezhipng.png"]forState:UIControlStateNormal];
    [rightButton setTitle:@"协议" forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [rightButton setTitleColor:[RHUtility colorForHex:@"#44bbc1"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(chongzhi)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
//    UIBarButtonItem * btn = [[UIBarButtonItem alloc]initWithTitle:@"协议" style:UIBarButtonItemStylePlain target:self action:@selector(chongzhi)];
//    
//    [btn setTitle:@"协议"];
//    [btn setTintColor:[RHUtility colorForHex:@"#44bbc1"]];
    
    
//    self.navigationItem.rightBarButtonItem = rightItem;
  
    [self configBackButton];
    
    [self configTitleWithString:@"我要出借"];
    
    [self setupWithDic:self.dataDic];
    
    self.querenbtn.layer.masksToBounds=YES;
    self.querenbtn.layer.cornerRadius=5;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textchange:) name:UITextFieldTextDidChangeNotification object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    
//    CGRect rect=self.contentView.frame;
//    rect.origin.x=([UIScreen mainScreen].bounds.size.width-320)/2.0;
//    
//    self.contentView.frame=rect;
    
    currentThreshold=0.0;
    currentMoney=0;
    self.giftView.hidden=YES;
    //self.gifticon.image=[UIImage imageNamed:@"gift.png"];
    self.giftId=@"";
    
//    self.touzitextfFiled.delegate = self;
    
    
    if ([UIScreen mainScreen].bounds.size.height<481) {
        [[UIApplication sharedApplication].keyWindow addSubview:self.querenbtn];
        
        self.querenbtn.frame = CGRectMake( self.querenbtn.frame.origin.x, self.querenbtn.frame.origin.y+200, self.querenbtn.frame.size.width, self.querenbtn.frame.size.height);
    }
    
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(firstresboster)];
    
    
    [self.xmjview addGestureRecognizer:tap];
    
}

-(void)firstresboster{
    
    [self.xmjtf resignFirstResponder];
}

-(void)setupWithDic:(NSDictionary*)dic
{
     if ([self.xmjres isEqualToString:@"xmj"]) {
         
         self.dayormouth = @"month";
         self.projectId=[dic objectForKey:@"id"];
         self.nameLabel.text=[dic objectForKey:@"name"];
          [self getimagemy];
          self.projectFundLabel.text=[NSString stringWithFormat:@"%.2d",projectFund];
         if ([[dic objectForKey:@"everyoneEndAmount"] isKindOfClass:[NSNull class]]) {
             self.everyoneEndAmountstr = @"10000";
         }else{
             
             //        if ([[dic objectForKey:@"everyoneEndAmount"] isEqualToString:@"null"]) {
             //            self.everyoneEndAmountstr = @"10000";
             //        }else{
             
             self.everyoneEndAmountstr =[dic objectForKey:@"everyoneEndAmount"];
             //        }
         }
         return;
     }
    
    self.projectId=[dic objectForKey:@"id"];
    self.nameLabel.text=[dic objectForKey:@"name"];
    self.investorRateLabel.text=[[dic objectForKey:@"investorRate"] stringValue];
    //self.investorRateLabel.text = _lilv;
    
    if (self.panduan == 10) {
        NSString * str =[dic objectForKey:@"limitTime"];
        _limitTimeLabel.text= str;
        
    }else{
        NSString * str =[dic objectForKey:@"limitTime"] ;
        _limitTimeLabel.text= str;
    }
    //self.limitTimeLabel.text=[[dic objectForKey:@"limitTime"] stringValue];
    self.projectFundLabel.text=[NSString stringWithFormat:@"%.2d",projectFund];
    
    if ([[dic objectForKey:@"everyoneEndAmount"] isKindOfClass:[NSNull class]]) {
        self.everyoneEndAmountstr = @"10000";
    }else{
        
//        if ([[dic objectForKey:@"everyoneEndAmount"] isEqualToString:@"null"]) {
//            self.everyoneEndAmountstr = @"10000";
//        }else{
        
            self.everyoneEndAmountstr =[dic objectForKey:@"everyoneEndAmount"];
//        }
    }
    
    if (![dic[@"monthOrDay"] isEqualToString:@"个月"]) {
        self.dayormouth = @"day";
    }else{
        
        self.dayormouth = @"month";
    }
    
    
}

- (void)checkout
{
    
    [[RHNetworkService instance] POST:@"app/front/payment/appBankCardJx/appQueryBalance" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        DLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSString* AvlBal=[responseObject objectForKey:@"AvlBal"];
            if (AvlBal&&[AvlBal length]>0) {
                self.keyonglable.text = AvlBal;
                //self.balanceLabel.text=AvlBal;
                [RHUserManager sharedInterface].balance=AvlBal;
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
     //   DLog(@"%@",error);
        
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//协议
- (IBAction)pushAreegment:(id)sender {
    RHContractViewContoller* controller=[[RHContractViewContoller alloc]initWithNibName:@"RHContractViewContoller" bundle:nil];
    controller.isAgreen=YES;
    controller.projectId = self.projectId;
    [self.navigationController pushViewController:controller animated:YES];
}
- (IBAction)Investment:(id)sender {
    
    
    if (![self.yuedustr isEqualToString:@"1"]) {
        [RHUtility showTextWithText:@"请先同意协议，再出借。"];
        return;
    }
   
    
    if ([self.cepingstr isEqualToString:@"ceping"]) {
        self.mengbanview.hidden = NO;
        self.cepingimage.hidden = NO;
        self.cepingview.hidden = NO;
        return;
    }
    
   // int amount=[self.textFiled.text intValue];
    int amount=[self.touzitextfFiled.text intValue];
    int everyoneEndAmount = [self.everyoneEndAmountstr intValue];
    if (everyoneEndAmount<10) {
        everyoneEndAmount=10000;
    }
    if (self.newpeople == YES) {
    if (everyoneEndAmount < amount) {
        [RHUtility showTextWithText:[NSString stringWithFormat:@"单人限制出借金额：%d元",everyoneEndAmount]];
        return;
    }
    }
    //22222
    if (amount%100!=0||amount==0) {
        [RHUtility showTextWithText:@"出借金额需为100的整数倍"];
        return;
    }
//    if ([self.textFiled.text length]<=0) {
//        [RHUtility showTextWithText:@"请输入投资金额"];
//        return;
//    }
//    if ([self.textFiled.text floatValue]>projectFund) {
//        [RHUtility showTextWithText:@"请输入可投范围内的金额"];
//        return;
//    }
    if ([self.touzitextfFiled.text length]<=0) {
        [RHUtility showTextWithText:@"请输入出借金额"];
        return;
    }
    if ([self.touzitextfFiled.text floatValue]>projectFund) {
        [RHUtility showTextWithText:@"请输入可投范围内的金额"];
        return;
    }
    NSMutableString* balance=[[NSMutableString alloc]initWithCapacity:0];
    ;
//    for (NSString* subStr in [self.balanceLabel.text componentsSeparatedByString:@","]) {
//        [balance appendString:subStr];
//    }
    for (NSString* subStr in [self.keyonglable.text componentsSeparatedByString:@","]) {
        [balance appendString:subStr];
    }
//    if ([self.textFiled.text intValue]-currentMoney>[balance intValue]) {
//        [RHUtility showTextWithText:@"您账户余额不足"];
//        return;
//    }
    if ([self.touzitextfFiled.text intValue]>[balance intValue]) {
        [RHUtility showTextWithText:@"您账户余额不足"];
        return;
    }
    [self.touzitextfFiled resignFirstResponder];
    //[self.textFiled resignFirstResponder];
//    RHInvestmentWebViewController* controller=[[RHInvestmentWebViewController alloc]initWithNibName:@"RHInvestmentWebViewController" bundle:nil];
////    controller.price=self.textFiled.text;
//    controller.price=self.touzitextfFiled.text;
//    controller.projectId=self.projectId;
//    controller.giftId=self.giftId;
//    [self.navigationController pushViewController:controller animated:YES];
    
    if ([self.xmjres isEqualToString:@"xmj"]){
        [self getmyxmjcepingtz];
        
    }else{
        [self getmycepingtz];
    }
    
    return;
    
    if ([self.xmjres isEqualToString:@"xmj"]||self.xmjid) {
        
        if ([self.strxmjsq isEqualToString:@"no"]) {
            self.xmjview.hidden = NO;
            self.mengbanview.hidden = NO;
        }else{
            self.xmjmoneylab.text = [NSString stringWithFormat:@"%@元",self.touzitextfFiled.text];
            self.xmjhongbaolab.text = self.label0.text;
            
            if ([self.xmjhongbaolab.text isEqualToString:@"请选择可用红包"]) {
                self.xmjhongbaolab.text = @"未使用";
            }
            self.mengbanview.hidden = NO;
            self.cjxmjview.hidden = NO;
//            [self didtouzixmj];
        }
        return;
    }
    
    
    RHInverstWebViewController* controller=[[RHInverstWebViewController alloc]initWithNibName:@"RHInverstWebViewController" bundle:nil];
    //    controller.price=self.textFiled.text;
    controller.price=self.touzitextfFiled.text;
    controller.projectId=self.projectId;
    controller.giftId=self.giftId;
    [self.navigationController pushViewController:controller animated:YES];
    
}
- (IBAction)quedingchujiexmj:(id)sender {
    self.mengbanview.hidden = YES;
    self.cjxmjview.hidden = YES;
    [self didtouzixmj];
    
}
- (IBAction)quxiaoxmj:(id)sender {
    self.mengbanview.hidden = YES;
    self.cjxmjview.hidden = YES;
    
//    [self zidongtpubioaxiei:nil];
}

-(void)getmyxmjcepingtz{
    NSDictionary* parameters=@{@"projectListId":self.projectId,@"money":self.touzitextfFiled.text};
    
    [[RHNetworkService instance] POST:@"front/payment/reskTest/checkInvestProjectList" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
      
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            if ([responseObject[@"isInvest"] isEqualToString:@"yes"]) {
               
                    
                    if ([self.strxmjsq isEqualToString:@"no"]) {
                        self.xmjview.hidden = NO;
                        self.mengbanview.hidden = NO;
                    }else{
                        self.xmjmoneylab.text = [NSString stringWithFormat:@"%@元",self.touzitextfFiled.text];
                        self.xmjhongbaolab.text = self.label0.text;
                        
                        if ([self.xmjhongbaolab.text isEqualToString:@"请选择可用红包"]) {
                            self.xmjhongbaolab.text = @"未使用";
                        }
                        self.mengbanview.hidden = NO;
                        self.cjxmjview.hidden = NO;
                        //            [self didtouzixmj];
                    }
               
            }else{
                
                self.xmjinsertcp = @"no";
                self.mengbanview.hidden = NO;
                self.cepingimage.hidden = NO;
                self.cepingview.hidden = NO;
                self.biglab.hidden = YES;
                self.smalllab.hidden = YES;
                self.cplabstr.text = responseObject[@"reasonMsg"];
//                [RHUtility showTextWithText:[NSString stringWithFormat:@"%@",responseObject[@"reasonMsg"]]];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];
    
}
-(void)getmycepingtz{
    
   NSDictionary* parameters=@{@"projectId":self.projectId,@"money":self.touzitextfFiled.text};
    
    [[RHNetworkService instance] POST:@"front/payment/reskTest/checkInvestProject" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
     
        
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            if ([responseObject[@"isInvest"] isEqualToString:@"yes"]) {
                     if ([self.xmjres isEqualToString:@"xmj"]||self.xmjid) {
            
                           if ([self.strxmjsq isEqualToString:@"no"]) {
                                  self.xmjview.hidden = NO;
                                  self.mengbanview.hidden = NO;
                            }else{
                                self.xmjmoneylab.text = [NSString stringWithFormat:@"%@元",self.touzitextfFiled.text];
                                self.xmjhongbaolab.text = self.label0.text;
                
                             if ([self.xmjhongbaolab.text isEqualToString:@"请选择可用红包"]) {
                                  self.xmjhongbaolab.text = @"未使用";
                                }
                               self.mengbanview.hidden = NO;
                               self.cjxmjview.hidden = NO;
                //            [self didtouzixmj];
                         }
                         return;
                  }
        
        
                 RHInverstWebViewController* controller=[[RHInverstWebViewController alloc]initWithNibName:@"RHInverstWebViewController" bundle:nil];
        //    controller.price=self.textFiled.text;
                 controller.price=self.touzitextfFiled.text;
                 controller.projectId=self.projectId;
                 controller.giftId=self.giftId;
                 [self.navigationController pushViewController:controller animated:YES];
            }else{
                self.xmjinsertcp = @"no";
                self.mengbanview.hidden = NO;
                self.cepingimage.hidden = NO;
                self.cepingview.hidden = NO;
                self.biglab.hidden = YES;
                self.smalllab.hidden = YES;
                self.cplabstr.text = responseObject[@"reasonMsg"];
//                [RHUtility showTextWithText:[NSString stringWithFormat:@"%@",responseObject[@"reasonMsg"]]];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];
}
-(void)didtouzixmj{
    NSDictionary* parameters;
    if ([self.xmjres isEqualToString:@"xmj"]) {
        
        parameters = @{@"projectListId":self.projectId,@"giftId":self.giftId,@"money":self.touzitextfFiled.text,@"investType":@"App"};
        
    }else{
        
        parameters = @{@"projectListId":self.xmjid,@"giftId":self.giftId,@"money":self.touzitextfFiled.text,@"investType":@"App",@"projectId":self.projectId};
    }
     [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[RHNetworkService instance] POST:@"app/front/payment/appProjectListArchives/investProjectList" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        DLog(@"%@",responseObject);
        // [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        if ([responseObject[@"msg"] isEqualToString:@"success"]) {
            [self jktouzisuccess];
        }else{
            
            [RHUtility showTextWithText:[responseObject objectForKey:@"msg"]];
//            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        }
            
          
        
            
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //        [RHUtility showTextWithText:@"请求失败"];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([error.userInfo.allKeys containsObject:@"com.alamofire.serialization.response.error.data"]) {
            NSDictionary* errorDic=[NSJSONSerialization JSONObjectWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] options:NSJSONReadingMutableContainers error:nil];
            if ([errorDic objectForKey:@"msg"]) {
                
                [RHUtility showTextWithText:[errorDic objectForKey:@"msg"]];
            }
        }
    }];
    
    
    
}

-(void)jktouzisuccess{
    

   [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[RHNetworkService instance] POST:@"common/paymentJxResponse/investListHandle" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        DLog(@"%@",responseObject);
        // [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            if ([responseObject[@"returnMsg"] isEqualToString:@"success"]) {
                
                NSLog(@"chenggong");
                RHErrorViewController* controller=[[RHErrorViewController alloc]initWithNibName:@"RHErrorViewController" bundle:nil];
                controller.titleStr=[NSString stringWithFormat:@"出借金额%@元",self.touzitextfFiled.text];
                controller.tipsStr=@"赚钱别忘告诉其他小伙伴哦~";
                controller.type=RHInvestmentSucceed;
                 [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                [self.navigationController pushViewController:controller animated:YES];
            }else if ([responseObject[@"returnMsg"] isEqualToString:@"fail"]){
                  RHErrorViewController* controller=[[RHErrorViewController alloc]initWithNibName:@"RHErrorViewController" bundle:nil];
                controller.type=RHInvestmentFail;
                 [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                if (responseObject[@"failMsg"] && ![responseObject[@"failMsg"] isKindOfClass:[NSNull class]]) {
                     controller.tipsStr=[NSString stringWithFormat:@"%@",responseObject[@"failMsg"]];
                }
                if (responseObject[@"failCode"] && ![responseObject[@"failCode"] isKindOfClass:[NSNull class]]) {
                    controller.bankbackstr =[NSString stringWithFormat:@"%@",responseObject[@"failCode"]];
                }
                [self.navigationController pushViewController:controller animated:YES];
                 NSLog(@"shibai");
            }else{
                
                 NSLog(@"chulizhong");
                if ([self.jkstring isEqualToString:@"jk"]) {
                    RHErrorViewController* controller=[[RHErrorViewController alloc]initWithNibName:@"RHErrorViewController" bundle:nil];
                    //  controller.titleStr=[NSString stringWithFormat:@"投资金额%@元",price];
                    controller.tipsStr=@"       请稍后在[我的出借]查看出借结果\n     如有问题请拨打客服电话\n     400-010-4001    ";
                    controller.type=RHInvestmentchixu;
                     [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                    [self.navigationController pushViewController:controller animated:YES];
                    
                }else{
//                 [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                    self.jkstring = @"jk";
                [self performSelector:@selector(jktouzisuccess) withObject:self afterDelay:10];
                }
                return ;
                    
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //        [RHUtility showTextWithText:@"请求失败"];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        if ([error.userInfo.allKeys containsObject:@"com.alamofire.serialization.response.error.data"]) {
            NSDictionary* errorDic=[NSJSONSerialization JSONObjectWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] options:NSJSONReadingMutableContainers error:nil];
            if ([errorDic objectForKey:@"msg"]) {
                if ([[errorDic objectForKey:@"msg"] isEqualToString:@"验证码错误"]) {
                    
                }
                [RHUtility showTextWithText:[errorDic objectForKey:@"msg"]];
            }
        }
    }];
    
    
}
-(void)shouquanyanzhengxmj{
    
    [[RHNetworkService instance] POST:@"front/payment/accountJx/userAutoAuth" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        DLog(@"%@",responseObject);
        // [MBProgressHUD showHUDAddedTo:self.view animated:YES];
      
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            
            self.strxmjsq = [NSString stringWithFormat:@"%@",responseObject[@"isAutoInvest"]];
            
            NSString *str = [RHUserManager sharedInterface].telephone;
            
            NSString * laststr = [str substringFromIndex:str.length - 4];
            NSString * firststr = [str substringToIndex:3];
            self.xmjphonenumberlab.text = [NSString stringWithFormat:@"%@****%@",firststr,laststr];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [RHUtility showTextWithText:@"请求失败"];
        
    }];
    
    
}

//  全投 －－－－－

- (IBAction)allin:(id)sender {
    // [self.textFiled resignFirstResponder];
    [self.touzitextfFiled resignFirstResponder];
    NSArray* stringArray=[[RHUserManager sharedInterface].balance componentsSeparatedByString:@","];
    
    NSMutableString* resultString=[NSMutableString string];
    for (NSString* subStr in stringArray) {
        [resultString appendString:subStr];
    }
    if ([resultString length]<=0) {
        [resultString appendString:@"0"];
    }
    
    int balance=[resultString intValue];
    int allinAmount=(balance/100)*100;
    int project=(projectFund/100)*100;
    //    DLog(@"project=%d",project);
    //    DLog(@"allinAmount=%d  balance=%d",allinAmount,balance);
    if (allinAmount>project) {
        //self.textFiled.text=[NSString stringWithFormat:@"%d",project];
        self.touzitextfFiled.text=[NSString stringWithFormat:@"%d",project];
    }else{
        //self.textFiled.text=[NSString stringWithFormat:@"%d",allinAmount];
        self.touzitextfFiled.text=[NSString stringWithFormat:@"%d",allinAmount];
    }
    
    if (!self.giftView.hidden) {
        // self.label1.text=[NSString stringWithFormat:@"实际扣减账户金额%d元",[self.textFiled.text intValue]-currentMoney];
        //self.label1.text=[NSString stringWithFormat:@"实际扣减账户金额%d元",[self.touzitextfFiled.text intValue]-currentMoney];
    }
     self.moneylab.text=[NSString stringWithFormat:@"实付金额（元）%d",[self.touzitextfFiled.text intValue]];
    self.label0.text=[NSString stringWithFormat:@"请选择可用红包"];
//    self.moneylab.text=[NSString stringWithFormat:@"实付金额（元）%@",self.touzitextfFiled.text] ;
}

- (IBAction)newchongzhi:(id)sender {
    
    
    RHRechargeViewController* controller=[[RHRechargeViewController alloc]initWithNibName:@"RHRechargeViewController" bundle:nil];
    //controller.balance=self.balanceLabel.text;
    controller.balance=self.keyonglable.text;
    [DQViewController Sharedbxtabar].tabBar.hidden = YES;
    controller.bankdic = self.bankdic;
    controller.bankress = self.bankress;
    [self.navigationController pushViewController:controller animated:YES];
}
-(void)getmyjxbankcard{
    
    [[RHNetworkService instance] POST:@"app/front/payment/appBankCardJx/isBindBankCard" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"----===============-1111---%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            if (![responseObject[@"msg"] isKindOfClass:[NSNull class]]&&responseObject[@"msg"]) {
                
                self.bankress =[NSString stringWithFormat:@"%@",responseObject[@"msg"]];
            }
            
            if (![responseObject[@"bank"] isKindOfClass:[NSNull class]]&&responseObject[@"bank"]) {
                
                
                self.bankdic = responseObject[@"bank"];
                if (responseObject[@"bank"][@"bankNo"]&&![responseObject[@"bank"][@"bankNo"] isKindOfClass:[NSNull class]]) {
                   // self.strbnakcard = [NSString stringWithFormat:@"%@",responseObject[@"bank"][@"bankNo"]];
                }
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //        DLog(@"%@",error);
        DLog(@"%@",[[NSString alloc] initWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
    }];
}

-(NSDictionary*)bankdic{
    
    if (!_bankdic) {
        _bankdic = [NSDictionary dictionary];
    }
    return _bankdic;
}
// 全投 
- (IBAction)allIn:(id)sender {
   // [self.textFiled resignFirstResponder];
    [self.touzitextfFiled resignFirstResponder];
    NSArray* stringArray=[[RHUserManager sharedInterface].balance componentsSeparatedByString:@","];
    NSMutableString* resultString=[NSMutableString string];
    for (NSString* subStr in stringArray) {
        [resultString appendString:subStr];
    }
    if ([resultString length]<=0) {
        [resultString appendString:@"0"];
    }
    
    int balance=[resultString intValue];
    int allinAmount=(balance/100)*100;
    int project=(projectFund/100)*100;
//    DLog(@"project=%d",project);
//    DLog(@"allinAmount=%d  balance=%d",allinAmount,balance);
    if (allinAmount>project) {
        //self.textFiled.text=[NSString stringWithFormat:@"%d",project];
        self.touzitextfFiled.text=[NSString stringWithFormat:@"%d",project];
    }else{
        //self.textFiled.text=[NSString stringWithFormat:@"%d",allinAmount];
        self.touzitextfFiled.text=[NSString stringWithFormat:@"%d",allinAmount];
    }
    
    if (!self.giftView.hidden) {
       // self.label1.text=[NSString stringWithFormat:@"实际扣减账户金额%d元",[self.textFiled.text intValue]-currentMoney];
        self.label1.text=[NSString stringWithFormat:@"实际扣减账户金额%d元",[self.touzitextfFiled.text intValue]-currentMoney];
    }
}

- (IBAction)recharge:(id)sender {
    ////////////////充值
    //[self.textFiled resignFirstResponder];
    [self.touzitextfFiled resignFirstResponder];
     [self.xmjtf resignFirstResponder];
    RHRechargeViewController* controller=[[RHRechargeViewController alloc]initWithNibName:@"RHRechargeViewController" bundle:nil];
    //controller.balance=self.balanceLabel.text;
    controller.balance = self.keyonglable.text;
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)chooseGift:(id)sender {
    //[self.textFiled resignFirstResponder];
    [self.touzitextfFiled resignFirstResponder];
     [self.xmjtf resignFirstResponder];
    RHChooseGiftViewController* controller=[[RHChooseGiftViewController alloc] initWithNibName:@"RHChooseGiftViewController" bundle:nil];
    CGFloat mouthNum = 0 ;
    int investNum=0;
    if (!self.dayormouth) {
       self.dayormouth = @"month";;
    }
    
    controller.dayormonth = self.dayormouth;
    controller.myblock = ^{
        
            self.leibie = @"jx";
       
      
        
    };
    
    if ([self.touzitextfFiled.text length]>0) {
        investNum=[self.touzitextfFiled.text intValue];
    }
    if (self.dataDic[@"limitTime"]) {
        mouthNum=[self.dataDic[@"limitTime"] floatValue];
    }else{
        
        mouthNum=[self.dataDic[@"period"] floatValue];
    }
    controller.mouthNum = mouthNum;
    controller.investNum=investNum;
    controller.delegate=self;
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)chooseGiftWithnNum:(NSString *)num threshold:(NSString *)threshold giftId:(NSString *)giftId giftTP:(NSString *)TP
{
    
    
    self.giftId=giftId;
    currentMoney=[num intValue];
    
    currentThreshold=[threshold floatValue];
    
    //self.label1.text=[NSString stringWithFormat:@"实际扣减账户金额%d元",[self.textFiled.text intValue]-[num intValue]];
    self.label1.text=[NSString stringWithFormat:@"实际扣减账户金额%d元",[self.touzitextfFiled.text intValue]-[num intValue]];
    
    if ([TP isEqualToString:@"加息券"]) {
        self.label0.text=[NSString stringWithFormat:@"%@%%年化加息",num];
//        self.moneylab.text = [NSString stringWithFormat:@"实付金额（元）%d",[self.touzitextfFiled.text intValue]];
        [self getjiaxidata:giftId];
    }else{
        self.label0.text=[NSString stringWithFormat:@"%@元红包券",num];
//        self.moneylab.text = [NSString stringWithFormat:@"实付金额（元）%d",[self.touzitextfFiled.text intValue]];
    }
    self.chooseButton.hidden=YES;
    self.giftView.hidden=NO;
   // self.gifticon.image=[UIImage imageNamed:@"gift1.png"];

}

-(void)getjiaxidata:(NSString *)giftid{
    
    NSDictionary* parameters=@{@"calMoney":self.touzitextfFiled.text,@"projectId":self.projectId,@"giftId":giftid};
    
    [[RHNetworkService instance] POST:@"app/front/payment/appAccount/appCalAddInterest" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        DLog(@"%@",responseObject);
//        self.moneylab.text = [NSString stringWithFormat:@"预计加息（元）%@",responseObject[@"addInterest"]];
//        
//        self.leibie = @"test";
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //[RHUtility showTextWithText:@"请求失败"];
    }];
}

-(void)keyboardHide:(NSNotification*)not
{
    [UIView animateWithDuration:.2 animations:^{
        self.view.frame = CGRectMake(0, 64, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    }];
}

-(void)keyboardShow:(NSNotification*)not
{
//    DLog(@"%@",not.userInfo);
    NSValue* value=[not.userInfo objectForKey:@"UIKeyboardBoundsUserInfoKey"];
    
    CGRect rect=[value CGRectValue];
    keyboardHeight=rect.size.height;
    
   // changeY = self.textFiled.frame.origin.y + self.textFiled.frame.size.height;
    changeY = self.touzitextfFiled.frame.origin.y + self.touzitextfFiled.frame.size.height;
    
    if (changeY + self.contentView.frame.origin.y  >= (CGRectGetHeight([UIScreen mainScreen].bounds) - keyboardHeight - 64)) {
        CGRect viewRect=self.view.frame;
       // viewRect.origin.y = - ((self.view.frame.size.height - keyboardHeight) - self.textFiled.frame.origin.y - 74 - self.textFiled.frame.size.height );
        viewRect.origin.y = - ((self.view.frame.size.height - keyboardHeight) - self.touzitextfFiled.frame.origin.y - 74 - self.touzitextfFiled.frame.size.height );
        [UIView animateWithDuration:.4 animations:^{
            self.view.frame=viewRect;
        }];
    }
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    CGRect rect=self.view.frame;
    rect.origin.y=64;
    self.view.frame=rect;
    
    [textField resignFirstResponder];
    
    return YES;
}

-(void)textchange:(NSNotification*)not
{
//    if (self.textFiled.text.length > 0) {
//        self.textFiled.font = [UIFont systemFontOfSize:18.0];
//    }else{
//        self.textFiled.font = [UIFont systemFontOfSize:12.0];
//    }
//    if ([self.textFiled.text floatValue]<currentThreshold) {
//        self.chooseButton.hidden=NO;
//        self.giftView.hidden=YES;
//        //self.gifticon.image=[UIImage imageNamed:@"gift.png"];
//        self.giftId=@"";
//        currentMoney=0;
//        
//    }else{
//        self.label1.text=[NSString stringWithFormat:@"实际扣减账户金额%d元",[self.textFiled.text intValue]-currentMoney];
//    }

    
    if (self.touzitextfFiled.text.length > 0) {
        self.touzitextfFiled.font = [UIFont systemFontOfSize:18.0];
    }else{
        self.touzitextfFiled.font = [UIFont systemFontOfSize:12.0];
    }
    if ([self.touzitextfFiled.text floatValue]<currentThreshold) {
        self.chooseButton.hidden=NO;
        self.giftView.hidden=YES;
        //self.gifticon.image=[UIImage imageNamed:@"gift.png"];
        self.giftId=@"";
        currentMoney=0;
        
    }else{
        self.label1.text=[NSString stringWithFormat:@"实际扣减账户金额%d元",[self.touzitextfFiled.text intValue]-currentMoney];
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSCharacterSet *cs;
    NSString* str=@"0123456789";
    cs = [[NSCharacterSet characterSetWithCharactersInString:str] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basicTest = [string isEqualToString:filtered];
    
    if(!basicTest)
    {
        return NO;
    }
    
    return YES;
}
-(void)textFieldDidChange :(UITextField *)theTextField{
    
//    self.moneylab.text=[NSString stringWithFormat:@"实付金额（元）%@",self.touzitextfFiled.text] ;
    self.label0.text=[NSString stringWithFormat:@"请选择可用红包"];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //[self.textFiled resignFirstResponder];
    [self.touzitextfFiled resignFirstResponder];
    [self.xmjtf resignFirstResponder];
}

-(void)viewWillDisappear:(BOOL)animated
{
    for (UIView *subView in [UIApplication sharedApplication].keyWindow.subviews) {
        if (subView.tag == 1000) {
            [subView removeFromSuperview];
        }
    }
    if ([UIScreen mainScreen].bounds.size.height<481) {
        
        self.querenbtn.hidden = YES;
    }
    
    [super viewWillDisappear:animated];
}


- (void)chongzhi{
    
//    RHContractViewContoller* controller=[[RHContractViewContoller alloc]initWithNibName:@"RHContractViewContoller" bundle:nil];
//    controller.isAgreen=YES;
    RHXYWebviewViewController * controller = [[RHXYWebviewViewController alloc]initWithNibName:@"RHXYWebviewViewController" bundle:nil];
    if([self.xmjres isEqualToString:@"xmj"]){
        controller.projectid = self.xmjfirst;
    }else{
    controller.projectid = self.projectId;
    }
    controller.namestr = @"借款协议范本";
    [self.navigationController pushViewController:controller animated:YES];
    
   // [self.textFiled resignFirstResponder];
    
    
    
   
    
//    NSString * str = btn.titleLabel.text;
//
//    NSString *stringWithoutQuotation = [str
//                                        stringByReplacingOccurrencesOfString:@"《" withString:@""];
//    str =  [stringWithoutQuotation stringByReplacingOccurrencesOfString:@"》" withString:@""];
    
//    controller.projectid = self.firstid;
    
//    [self.navigationController pushViewController:controller animated:YES];
    
    [self.touzitextfFiled resignFirstResponder];
   [self.xmjtf resignFirstResponder];
    
}


-(void)getimagemy{
    NSDictionary* parameters=@{@"projectListId":self.projectId};
    
    [[RHNetworkService instance] POST:@"app/common/appProjectList/getProjectListInfoForApp" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        DLog(@"%@",responseObject);
        
       
        if (responseObject[@"firstProjectId"]&&![[responseObject objectForKey:@"firstProjectId"] isKindOfClass:[NSNull class]]) {
            
            self.xmjfirst = [NSString stringWithFormat:@"%@",responseObject[@"firstProjectId"]];
        }
        NSLog(@"%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //[RHUtility showTextWithText:@"请求失败"];
    }];
    
    
    
}

-(void)getprojectdata{
     if (![self.xmjres isEqualToString:@"xmj"]) {
    
    NSDictionary* parameters=@{@"id":self.projectId};
    
    [[RHNetworkService instance] POST:@"app/common/appDetails/appProjectDetailData" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        DLog(@"%@",responseObject);
        
        self.projectFundLabel.text = responseObject[@"project"][@"available2"];
        
        
        if (![responseObject[@"project"][@"monthOrDay"]isKindOfClass:[NSNull class]]) {
            
            
            if ([responseObject[@"project"][@"monthOrDay"] isEqualToString:@"day"]||[responseObject[@"project"][@"monthOrDay"] isEqualToString:@"天"]) {
                 self.dayormouth = @"day";
            }else{
                
                self.dayormouth = @"month";
            }
           
            
        }else{
            
            
                
                self.dayormouth = @"month";
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //[RHUtility showTextWithText:@"请求失败"];
        NSString* msg=[operation.responseObject objectForKey:@"msg"];
        
                NSLog(@"%@",msg);
        
    }];
     }else{
         
         NSDictionary* parameters=@{@"projectListId":self.projectId};
         
         [[RHNetworkService instance] POST:@"app/common/appProjectList/getProjectListInfoForApp" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
             //        DLog(@"%@",responseObject);
             
             
             
             if (responseObject[@"remainMoney"]&&![[responseObject objectForKey:@"remainMoney"] isKindOfClass:[NSNull class]]) {
                 
                 self.projectFundLabel.text = [NSString stringWithFormat:@"%@",responseObject[@"remainMoney"]];
             }
             
             NSLog(@"%@",responseObject);
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             //[RHUtility showTextWithText:@"请求失败"];
         }];
         
     }
}
- (IBAction)xieyiyuedu:(id)sender {
    
    [self chongzhi];
}

- (IBAction)cepingbtn:(id)sender {
    
//    if ([self.xmjinsertcp isEqualToString:@"no"]) {
//        self.mengbanview.hidden = YES;
//        self.cepingimage.hidden = YES;
//        self.cepingview.hidden = YES;
//        self.xmjinsertcp = @"xmj";
//
//        RHCPFirstViewController * vc = [[RHCPFirstViewController alloc]initWithNibName:@"RHCPFirstViewController" bundle:nil];
//        [self.navigationController pushViewController:vc animated:YES];
//        return;
//    }
    
    self.mengbanview.hidden = YES;
    self.cepingimage.hidden = YES;
    self.cepingview.hidden = YES;
    
    RHCPFirstViewController * vc = [[RHCPFirstViewController alloc]initWithNibName:@"RHCPFirstViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)getceping{
    
    
    [[RHNetworkService instance] POST:@"app/front/payment/appReskTest/isReskTest" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        DLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary * dic = responseObject[@"reskData"];
            if ([dic[@"isTest"] isEqualToString:@"no"]) {
                self.cepingstr = @"ceping";
            }else{
                self.cepingstr = @"";
            }
            if (dic[@"reskResp"]&&![dic[@"reskResp"] isKindOfClass:[NSNull class]]) {
                self.biglab.text = dic[@"reskResp"];
            }
            if (dic[@"viewWord"]&&![dic[@"viewWord"] isKindOfClass:[NSNull class]]) {
                self.smalllab.text = dic[@"viewWord"];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //  NSLog(@"%@",error);
        DLog(@"%@",[[NSString alloc] initWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
        
    }];
}
- (IBAction)guanbiceping:(id)sender {
      [self.touzitextfFiled resignFirstResponder];
    self.mengbanview.hidden = YES;
    self.cepingimage.hidden = YES;
    self.cepingview.hidden = YES;
}

- (IBAction)xmjhuoquyanzhnegma:(id)sender {
    
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
    self.xmjyzmbtn.enabled = NO;
    countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
}

- (void)timeFireMethod {
    secondsCountDown --;
    self.xmjyzmbtn.titleLabel.text = [NSString stringWithFormat:@"重新发送(%d)",secondsCountDown];
    [self.xmjyzmbtn setTitle:[NSString stringWithFormat:@"重新发送(%d)",secondsCountDown] forState:UIControlStateDisabled];
    if (secondsCountDown == 0) {
        self.xmjyzmbtn.enabled = YES;
        [self.xmjyzmbtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [countDownTimer invalidate];
    }
}

- (IBAction)opentoubiaosq:(id)sender {
    if (![self.xzbtnres isEqualToString:@"1"]) {
        [RHUtility showTextWithText:@"请先同意融益汇自动投标服务协议"];
        return;
    }
//    if (self.xmjtf.text.length<1) {
//         [RHUtility showTextWithText:@"请先输入验证码"];
//        return;
//    }
    RHXMJTBSQViewController * vc = [[RHXMJTBSQViewController alloc]initWithNibName:@"RHXMJTBSQViewController" bundle:nil];
    
    vc.smcstr = self.xmjtf.text;
    self.xmjview.hidden = YES;
    
    self.mengbanview.hidden = YES;
     [self.xmjtf resignFirstResponder];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (IBAction)zidongtpubioaxiei:(id)sender {
    
    self.xmjview.hidden = YES;
    self.mengbanview.hidden = YES;
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

- (IBAction)didxuanzhongbtn:(id)sender {
    
    if ([self.xzbtnres isEqualToString:@"1"]) {
        self.xzbtnres = @"2";
        
        [self.xmjxzbtn setImage:[UIImage imageNamed:@"未选中状态icon"] forState:UIControlStateNormal];
        
    }else{
         [self.xmjxzbtn setImage:[UIImage imageNamed:@"选中状态icon"] forState:UIControlStateNormal];
        self.xzbtnres = @"1";
    }
    
}
- (IBAction)guanbixmjview:(id)sender {
     [self.xmjtf resignFirstResponder];
    self.xmjview.hidden = YES;
    
    self.mengbanview.hidden = YES;
    
}


-(void)getxieyi{
    
    [[RHNetworkService instance] POST:@"common/main/getProticelName" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        DLog(@"%@",responseObject);
        // [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        if ([responseObject isKindOfClass:[NSArray class]]) {
            
            NSArray * array = responseObject;
            int testxieyi = 0;
            for (int i = 0; i<array.count; i++) {
                UIButton * btn = [[UIButton alloc]init];
                [btn setTitle:[NSString stringWithFormat:@"《%@》",array[i]] forState:UIControlStateNormal];
                //                    btn.backgroundColor=[UIColor redColor];
                btn.titleLabel.font = [UIFont systemFontOfSize:13];
                
                btn.titleLabel.lineBreakMode = 0 ;
                
                //                        btn.frame = CGRectMake(26,i+30, 200, 20);
                
                
                if (RHScreeWidth<321) {
                    if (i%2==0) {
                        btn.frame = CGRectMake(20,CGRectGetMinY(self.xieyiframe.frame)+5+testxieyi, (RHScreeWidth-40)/2, 20);
                        
                    }else{
                        
                        btn.frame = CGRectMake(RHScreeWidth/2.0 +20,CGRectGetMinY(self.xieyiframe.frame)+5+testxieyi, (RHScreeWidth-40)/2, 20);
                        testxieyi = testxieyi+20;
                    }
                }else{
                    if (i%2==0) {
                         btn.frame = CGRectMake(20,CGRectGetMinY(self.xieyiframe.frame)+5+testxieyi, (RHScreeWidth-40)/2, 20);
                        
                    }else{
                        
                        btn.frame = CGRectMake(RHScreeWidth/2.0 +20,CGRectGetMinY(self.xieyiframe.frame)+5+testxieyi, (RHScreeWidth-40)/2, 20);
                        testxieyi = testxieyi+20;
                    }
                }
                //                        if (str.length>10) {
                //                            btn.frame = CGRectMake(8,i+30, 360, 20);
                //                        }else{
                //                            btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                //                        }
                //                [btn addTarget:self action:@selector(didxieyi:) forControlEvents:UIControlEventTouchUpInside];
                [btn setTitleColor:[RHUtility colorForHex:@"44bbc1"] forState:UIControlStateNormal];
                btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                [btn addTarget:self action:@selector(didxieyi:) forControlEvents:UIControlEventTouchUpInside];
                [self.view addSubview:btn];
            }
            
            self.querenbtn.frame = CGRectMake(self.querenbtn.frame.origin.x, CGRectGetMinY(self.xieyiframe.frame)+5+testxieyi+20, self.querenbtn.frame.size.width, self.querenbtn.frame.size.height);
            self.xieyiframe.hidden = YES;
            // [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [RHUtility showTextWithText:@"请求失败"];
    }];
    
//    [[RHNetworkService instance] POST:@"common/projectList/getProjectMsgUrl" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        //        DLog(@"%@",responseObject);
//        // [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        if ([responseObject isKindOfClass:[NSDictionary class]]) {
//
//
//            self.cpurl= responseObject[@"url"];
//
//            // [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [RHUtility showTextWithText:@"请求失败"];
//    }];
    
}

-(void)didxieyi:(UIButton *)btn{
    
    
    RHXYWebviewViewController * controller = [[RHXYWebviewViewController alloc]initWithNibName:@"RHXYWebviewViewController" bundle:nil];
    
    NSString * str = btn.titleLabel.text;
    
    NSString *stringWithoutQuotation = [str
                                        stringByReplacingOccurrencesOfString:@"《" withString:@""];
    str =  [stringWithoutQuotation stringByReplacingOccurrencesOfString:@"》" withString:@""];
    if([self.xmjres isEqualToString:@"xmj"]){
        controller.projectid = self.xmjfirst;
    }else{
        controller.projectid = self.projectId;
    }controller.namestr = str;
    
//    controller.projectid = self.firstid;
    
    [self.navigationController pushViewController:controller animated:YES];
    NSLog(@"%@",btn.titleLabel.text);
}

- (IBAction)yuedujxxieyi:(id)sender {
    
    
    if ([self.yuedustr isEqualToString:@"1"]) {
        self.yuedustr = @"2";
        
        [self.yuedubtn setImage:[UIImage imageNamed:@"未选中状态icon"] forState:UIControlStateNormal];
        
    }else{
        [self.yuedubtn setImage:[UIImage imageNamed:@"选中状态icon"] forState:UIControlStateNormal];
        self.yuedustr = @"1";
    }
    
}


@end
