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

@interface RHInvestmentViewController ()<UITextFieldDelegate,chooseGiftDelegate>
{
    float changeY;
    float keyboardHeight;
    float currentThreshold;
    int currentMoney;
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
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.newpeople == YES) {
        self.giftSupperView.hidden = YES;
    }
    [self getmyjxbankcard];
    
    UIView * dbxView = [[UIView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-70-65, [UIScreen mainScreen].bounds.size.width, 70)];
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
    
    [self configTitleWithString:@"我要投资"];
    
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
    
    
    
}



-(void)setupWithDic:(NSDictionary*)dic
{
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
   // int amount=[self.textFiled.text intValue];
    int amount=[self.touzitextfFiled.text intValue];
    int everyoneEndAmount = [self.everyoneEndAmountstr intValue];
    if (everyoneEndAmount<10) {
        everyoneEndAmount=10000;
    }
    if (self.newpeople == YES) {
    if (everyoneEndAmount < amount) {
        [RHUtility showTextWithText:[NSString stringWithFormat:@"单人限制投资金额：%d元",everyoneEndAmount]];
        return;
    }
    }
    //22222
    if (amount%100!=0||amount==0) {
        [RHUtility showTextWithText:@"投资金额需为100的整数倍"];
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
        [RHUtility showTextWithText:@"请输入投资金额"];
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
    if ([self.touzitextfFiled.text intValue]-currentMoney>[balance intValue]) {
        [RHUtility showTextWithText:@"您账户余额不足"];
        return;
    }
    [self.touzitextfFiled resignFirstResponder];
    //[self.textFiled resignFirstResponder];
    RHInvestmentWebViewController* controller=[[RHInvestmentWebViewController alloc]initWithNibName:@"RHInvestmentWebViewController" bundle:nil];
//    controller.price=self.textFiled.text;
    controller.price=self.touzitextfFiled.text;
    controller.projectId=self.projectId;
    controller.giftId=self.giftId;
    [self.navigationController pushViewController:controller animated:YES];
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
    RHRechargeViewController* controller=[[RHRechargeViewController alloc]initWithNibName:@"RHRechargeViewController" bundle:nil];
    //controller.balance=self.balanceLabel.text;
    controller.balance = self.keyonglable.text;
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)chooseGift:(id)sender {
    //[self.textFiled resignFirstResponder];
    [self.touzitextfFiled resignFirstResponder];
    RHChooseGiftViewController* controller=[[RHChooseGiftViewController alloc] initWithNibName:@"RHChooseGiftViewController" bundle:nil];
    CGFloat mouthNum = 0 ;
    int investNum=0;
    controller.dayormonth = self.dayormouth;
    controller.myblock = ^{
        
            self.leibie = @"jx";
       
      
        
    };
    
    if ([self.touzitextfFiled.text length]>0) {
        investNum=[self.touzitextfFiled.text intValue];
    }
    if (self.dataDic[@"limitTime"]) {
        mouthNum=[self.dataDic[@"limitTime"] floatValue];
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
        self.moneylab.text = [NSString stringWithFormat:@"实付金额（元）%d",[self.touzitextfFiled.text intValue]];
        [self getjiaxidata:giftId];
    }else{
        self.label0.text=[NSString stringWithFormat:@"%@元投资现金",num];
        self.moneylab.text = [NSString stringWithFormat:@"实付金额（元）%d",[self.touzitextfFiled.text intValue]-[num intValue]];
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
    
    self.moneylab.text=[NSString stringWithFormat:@"实付金额（元）%@",self.touzitextfFiled.text] ;
    self.label0.text=[NSString stringWithFormat:@"请选择可用红包"];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //[self.textFiled resignFirstResponder];
    [self.touzitextfFiled resignFirstResponder];
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
    
    RHContractViewContoller* controller=[[RHContractViewContoller alloc]initWithNibName:@"RHContractViewContoller" bundle:nil];
    controller.isAgreen=YES;
    controller.projectId = self.projectId;
    [self.navigationController pushViewController:controller animated:YES];
    
   // [self.textFiled resignFirstResponder];
    [self.touzitextfFiled resignFirstResponder];
   
    
}

-(void)getprojectdata{
    
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
    }];
}
- (IBAction)xieyiyuedu:(id)sender {
    
    [self chongzhi];
}


@end
