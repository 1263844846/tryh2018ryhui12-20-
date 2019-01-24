//
//  RHWithdrawViewController.m
//  ryhui
//
//  Created by 江 云龙 on 15/3/29.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHWithdrawViewController.h"
#import "RHWithdrawWebViewController.h"
#import "RHBindCardWebViewController.h"
#import "RYHViewController.h"
#import "RHTXTableViewCell.h"
#import "MBProgressHUD.h"
#import "RHWitdrawJLViewController.h"
#import "RHUserCountViewController.h"
#import "RHMoreWebViewViewController.h"
#import "RHDaETXViewController.h"
#import "RHShiShiTXViewController.h"
#import <SobotKit/SobotKit.h>
#import "RHhelper.h"
#import "RHWSQViewController.h"
#import "RHXYWebviewViewController.h"

@interface RHWithdrawViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UITextFieldDelegate,UIScrollViewDelegate>
{
    int secondsCountDown;
    NSTimer *countDownTimer;
    double free;
}
@property (weak, nonatomic) IBOutlet UIButton *wenhaobtn;

@property (weak, nonatomic) IBOutlet UIView *overView;
@property (weak, nonatomic) IBOutlet UIView *cardsView;
@property (weak, nonatomic) IBOutlet UIButton *changeCardsButton;
@property (weak, nonatomic) IBOutlet UIView *qbCardTipsView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
//验证码
@property (weak, nonatomic) IBOutlet UIButton *captchaButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *cardLabel;
//可提金额
@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;
//提现金额
@property (weak, nonatomic) IBOutlet UITextField *withdrawTF;
//手续费
@property (weak, nonatomic) IBOutlet UILabel *freeLabel;
//到账金额
@property (weak, nonatomic) IBOutlet UILabel *getAmountLabel;
//验证码
@property (weak, nonatomic) IBOutlet UITextField *captchaTF;


@property (weak, nonatomic) IBOutlet UITableView *yhktableview;

@property (weak, nonatomic) IBOutlet UIImageView *tximage;
@property (weak, nonatomic) IBOutlet UIImageView *yhimage;

@property(nonatomic,strong)NSMutableArray * dataArray;
@property (weak, nonatomic) IBOutlet UILabel *putongtixianlab;
@property (weak, nonatomic) IBOutlet UILabel *kuaisutixianlab;
@property (weak, nonatomic) IBOutlet UIImageView *fengeimage;
@property (weak, nonatomic) IBOutlet UILabel *sjlab;
@property (weak, nonatomic) IBOutlet UILabel *tixianfangshilab;
@property (weak, nonatomic) IBOutlet UILabel *tixianmiaoshulab;
@property (weak, nonatomic) IBOutlet UILabel *xuanhaodeyinhangkalab;
@property (weak, nonatomic) IBOutlet UILabel *tishilab;
@property (weak, nonatomic) IBOutlet UIView *tiview;

@property (weak, nonatomic) IBOutlet UIButton *xuanzeyinhangkabtn;

@property(strong,nonatomic)NSMutableArray * bankCardArry;


@property(nonatomic,strong)NSString * category;
@property (weak, nonatomic) IBOutlet UILabel *freelab;

@property (weak, nonatomic) IBOutlet UILabel *balancelab;

//@property(nonatomic,strong)NSString * categraystr;

@property(nonatomic,assign)int ksday;

@property(nonatomic,assign)BOOL res;
@property (weak, nonatomic) IBOutlet UIScrollView *tishiscoll;

@property (weak, nonatomic) IBOutlet UIButton *qrtibtn;

@property(nonatomic,strong)NSString * bankcard;

@property (weak, nonatomic) IBOutlet UILabel *cardqj;

@property (weak, nonatomic) IBOutlet UIButton *agreebtn;
@property (weak, nonatomic) IBOutlet UIView *mengbanview;

@property (weak, nonatomic) IBOutlet UILabel *tishilabel;
@property (weak, nonatomic) IBOutlet UIButton *hidenbtn;
@property (weak, nonatomic) IBOutlet UIImageView *tishiaimage;
@property (weak, nonatomic) IBOutlet UILabel *newtishilab;

//@property(nonatomic,strong)NSString *
@property(nonatomic,assign)CGFloat myrect;
@property(nonatomic,assign)BOOL rectres;
@property(nonatomic,copy)NSString * moneystr;

// new
@property(nonatomic,strong)RHSegmentContentView* segmentContentView;
@property(nonatomic,strong)NSMutableArray* viewControllers;
@property(nonatomic,strong)RHShiShiTXViewController* controller1;
@property(nonatomic,strong)RHDaETXViewController*controller2;
@property (weak, nonatomic) IBOutlet UIView *segmentView1;
@property (weak, nonatomic) IBOutlet UIView *segmentView2;
@property (strong, nonatomic) IBOutlet UIView *secondview;
@property(nonatomic,assign)CGFloat today;

@property (weak, nonatomic) IBOutlet UIView *daetishiview;
@property (weak, nonatomic) IBOutlet UIView *mengban1;

@property(nonatomic,copy)NSString * wortimestr;

@property(nonatomic,copy)NSString * sqstring;
@property (weak, nonatomic) IBOutlet UIView *sqview;
@end

@implementation RHWithdrawViewController
-(NSDictionary*)bankdic{
    
    if (!_bankdic) {
        _bankdic = [NSDictionary dictionary];
    }
    return _bankdic;
}

- (void)configBackButton
{
    UIButton* button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    //    UIImage * image = [UIImage imageNamed:@"back.png"];
    
    [button setImage:[UIImage imageNamed:@"icon_back.png"] forState:UIControlStateNormal];
     button.frame=CGRectMake(0, 0, 25, 40);
    
    // button.backgroundColor = [UIColor colorWithHexString:@"44bbc1"];
    self.navigationItem.leftBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:button];
}
- (IBAction)xuanzetixianfangshibtn:(id)sender {
    
    [self tixianfangshi:nil];
}

- (void)configRightButtonWithTitle:(NSString*)title action:(SEL)action
{
    UIButton* button=[UIButton buttonWithType:UIButtonTypeCustom];
    // button.titleLabel.backgroundColor =  [RHUtility colorForHex:@"#44BBC1"];
    [button setTitleColor:[RHUtility colorForHex:@"#44BBC1"] forState:UIControlStateNormal];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:title forState:UIControlStateNormal];
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    button.frame=CGRectMake(0, 0, 50, 20);
    self.navigationItem.rightBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:button];
}



-(void)back
{
//    RHUserCountViewController * vc =[[RHUserCountViewController alloc]initWithNibName:@"RHUserCountViewController" bundle:nil];
    
    [self.navigationController popToViewController:[RHTabbarManager sharedInterface].usercon animated:YES];
//        [self.navigationController popViewControllerAnimated:YES];
}

-(NSMutableArray *)bankCardArry{
    if (!_bankCardArry) {
        _bankCardArry = [NSMutableArray array];
    }
    return _bankCardArry;
    
}
-(NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
    
}

-(void)getmycard{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[RHNetworkService instance] POST:@"app/front/payment/appAccount/appMyCashData" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
           // self.freelab.text = [NSString stringWithFormat:@"%@",responseObject[@"free"]];
            
            //free = [self.freelab.text doubleValue];
            if (responseObject[@"limitMoney"]&& ![responseObject[@"limitMoney"] isKindOfClass:[NSNull class]]) {
                self.moneystr = responseObject[@"limitMoney"];
                [RHhelper ShraeHelp].withdrawsmall = responseObject[@"limitMoney"];
                self.newtishilab.text = [NSString stringWithFormat:@"1、提现条件：用户完成身份认证、开通汇付天下托管账户、绑定银行卡后，才能申请提现；每用户每日可提现1次；根据资金托管方规定，个人网银/快捷充值的资金当日不能提现。\n2、预计到账时间:\n1)普通提现：单笔最低提现金额%@元，每日21:00前申请普通提现，将于T+1个工作日到账，每日21:00后申请普通提现，视同第二日申请。如遇周六日/法定节假日，到账时间将顺延至下一个工作日。除法定节假日外，周一至周四21:00提现到账时间为第二日，周四21:00至周日申请提现，将会在下周一到账。 实际到账时间依据资金托管方及提现银行而有所差异，请耐心等待。\n2)即时取现：单笔最低提现金额200元，工作日（除法定节假日外，为周一至周五)8:00-17:30可发起即时取现，提现资金将在当日到账。\n3、提现手续费\n1)普通提现：若您充入的资金用于出借、融益汇将替您支付到期本息的资金托管方交易手续费，您可免费提现；若您充入资金未经出借就提现，则每笔提现将收取资金托管方交易手续费：提现金额*0.5%%（最低1元）。\n 2)即时取现：即时取现手续费计算规则同普通提现，另需额外支付资金托管方手续费：提现金额*0.1%%，若你在节假日（包括周六日/法定节假日）前一个工作日即时取现，资金托管方手续费为：提现金额*0.1%%*(节假日天数+1)。\n4、普通提现、即时取现服务由资金托管方汇付天下提供。\n5、如有疑问请联系在线客服或拨打400-010-4001",self.moneystr];
                
            }
//            if (free<0) {
//                self.freelab.text = @"0";
//                free = 0;
//            }
//            self.balancelab.text = [NSString stringWithFormat:@"%@",responseObject[@"balance"]];
//            double mon = [self.balancelab.text doubleValue];
//
//            if (free > mon) {
//                self.freelab.text = self.balancelab.text;
//            }
            
        }
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSLog(@"%@---",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    }];
    
}
-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];

        
    [RYHViewController Sharedbxtabar].tarbar.hidden = YES;
    [self getworktime];
    
    [self.dataArray removeAllObjects];
}
-(void)tap2{
     [self.withdrawTF resignFirstResponder];
    [self.captchaTF resignFirstResponder];
    if ([UIScreen mainScreen].bounds.size.width <321){
        self.scrollView.frame = CGRectMake(0, 2, [UIScreen mainScreen].bounds.size.width , self.scrollView.frame.size.height);
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, 590+60);
    }else{
        self.scrollView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width , self.scrollView.frame.size.height);

    }
    

    
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.captchaTF.delegate = self;
//    self.captchaTF.inputAccessoryView = [self addToolbar];
//    self.withdrawTF.inputAccessoryView = [self addToolbar1];
//    self.cardqj.hidden = YES;
//    self.mengbanview.hidden = YES;
//    self.tishiscoll.hidden = YES;
//    self.tishiaimage.hidden = YES;
//    if ([UIScreen mainScreen].bounds.size.height > 580 &&[UIScreen mainScreen].bounds.size.height <670) {
//        NSLog(@"%f",[UIScreen mainScreen].bounds.size.height);
//        self.tishilab.font = [UIFont systemFontOfSize: 13.0];
//    }else if ([UIScreen mainScreen].bounds.size.height> 670){
//        self.tishilab.font = [UIFont systemFontOfSize: 15.0];
//    }
//    
//    UIButton * mybtn = [[UIButton alloc]init];
//    mybtn.frame = CGRectMake(self.wenhaobtn.frame.origin.x, self.wenhaobtn.frame.origin.y, self.wenhaobtn.frame.size.width, self.wenhaobtn.frame.size.height);
////    mybtn.backgroundColor = [UIColor redColor];
//    [mybtn addTarget:self action:@selector(wenhaotishi:) forControlEvents:UIControlEventTouchUpInside];
//    [self.scrollView addSubview:mybtn];
//    
//    self.tishilabel.layer.masksToBounds=YES;
//    self.tishilabel.layer.cornerRadius=11;
//    self.tiview.hidden = YES;
//    
//    self.captchaButton.layer.masksToBounds=YES;
//    self.captchaButton.layer.cornerRadius=5;
//    
//    self.qrtibtn.layer.masksToBounds= YES;
//    
//    self.qrtibtn.layer.cornerRadius = 9;
//    
//    self.tishiscoll.layer.masksToBounds = YES;
//    self.tishiscoll.layer.cornerRadius = 9;
//    self.putongtixianlab.hidden = YES;
//    self.kuaisutixianlab.hidden = YES;
//    self.sjlab.hidden = YES;
//    self.fengeimage.hidden = YES;
//    self.putongtixianlab.userInteractionEnabled = YES;
//    self.kuaisutixianlab.userInteractionEnabled = YES;
//    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
//    UITapGestureRecognizer * tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap1:)];
//    [self.putongtixianlab addGestureRecognizer:tap];
//    [self.kuaisutixianlab addGestureRecognizer:tap1];
//    
//   UITapGestureRecognizer * tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap2)];
//    
//    self.yhktableview.hidden = YES;
//    self.yhktableview.dataSource = self;
//
//    self.yhktableview.delegate = self;
//    
    [RYHViewController Sharedbxtabar].tarbar.hidden = YES;
    [self configBackButton];
    [self configTitleWithString:@"提现"];
//    self.overView.hidden = YES;
//    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, 590);
//    [self.scrollView addGestureRecognizer:tap2];
//    self.scrollView.bounces = NO;
//   // self.scrollView.delegate = self;
//    CGSize size = CGSizeMake(300,2000);
//    CGSize size1 = [self.newtishilab.text sizeWithFont:self.newtishilab.font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
////    self.newtishilab.frame = CGRectMake(15,40 , self.tishilab.frame.size.width, size1.height);
//    if ([UIScreen mainScreen].bounds.size.width > 376) {
//        size1.height = size1.height-70;
//        self.newtishilab.frame = CGRectMake(15,0 ,self.newtishilab.frame.size.width-5, size1.height-100);
////        self.tishilab.backgroundColor = [UIColor redColor];
//        self.agreebtn.frame  = CGRectMake(self.agreebtn.frame.origin.x, size1.height-86-15, self.agreebtn.frame.size.width, 40);
//        self.tishiscoll.contentSize = CGSizeMake(self.tishiscoll.frame.size.width, size1.height-20);
//        self.tishiscoll.bounces = NO;
//    }else if ([UIScreen mainScreen].bounds.size.width <321){
////        size1.height = size1.height+90;
//        self.newtishilab.frame = CGRectMake(15,30 , self.newtishilab.frame.size.width-5, size1.height+90);
////        self.tishilab.backgroundColor = [UIColor redColor];
//        self.agreebtn.frame  = CGRectMake(self.agreebtn.frame.origin.x, size1.height+105, self.agreebtn.frame.size.width, 40);
//        self.tishiscoll.contentSize = CGSizeMake(self.tishiscoll.frame.size.width, size1.height+165);
//        
//        self.tishiscoll.bounces = NO;
//    }else{
////        size1.height = size1.height;
//        self.newtishilab.frame = CGRectMake(15,20 ,260, size1.height-100);
////    self.newtishilab.backgroundColor = [UIColor redColor];
//    self.agreebtn.frame  = CGRectMake(self.agreebtn.frame.origin.x, CGRectGetMaxY(self.newtishilab.frame)-7+20, self.agreebtn.frame.size.width, 40);
//    self.tishiscoll.contentSize = CGSizeMake(self.tishiscoll.frame.size.width, size1.height+95);
//        self.myrect = size1.height+95;
//    self.tishiscoll.bounces = NO;
//    }
//    self.changeCardsButton.layer.cornerRadius = 9;
//    self.changeCardsButton.layer.masksToBounds = YES;
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
////    self.withdrawTF.enabled = NO;
//    self.cardsView.hidden = YES;
//    self.category = @"1";
    
    
    UIButton*rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,30,30)];
    [rightButton setImage:[UIImage imageNamed:@"More"]forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(chongzhi)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    
    
    //    [btn setTitle:@""];
    //
    //
    //    [btn setTintColor:[RHUtility colorForHex:@"#44bbc1"]];
    //btn.image = [UIImage imageNamed:@"gengduo"];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self getmycard];
    
    
    
    
    self.segmentContentView = [[RHSegmentContentView alloc] initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].applicationFrame.size.height-50-self.navigationController.navigationBar.frame.size.height)];
    
    [_segmentContentView setDelegate:self];
    [self.secondview addSubview:_segmentContentView];
    
    self.secondview.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height+50);
    
    
    [self.view addSubview: self.secondview];
  //  [self.view addSubview:self.secondview];
    _viewControllers = [NSMutableArray array];
    [self getsegmentviewcontrol];

    [self getmysert];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.mengban1];
    [[UIApplication sharedApplication].keyWindow addSubview:self.daetishiview];
    [[UIApplication sharedApplication].keyWindow addSubview:self.sqview];
    self.mengban1.hidden = YES;
    self.daetishiview.hidden = YES;
    self.sqview.hidden = YES;
}

-(void)getsegmentviewcontrol{
    self.controller1=[[RHShiShiTXViewController alloc]initWithNibName:@"RHShiShiTXViewController" bundle:nil];
    self.controller1.nav = self.navigationController;
    
    self.controller1.smallmoney = self.moneystr;
    self.controller1.mydeblock = ^(){
        
        [self didSelectSegmentAtIndex:1];
    };
    self.controller1.sqswitch = self.myswitch;
    self.controller1.sqblock = ^(){
        if ([self.myswitch isEqualToString:@"ON"]) {
            [self jxsq];
        }
        
        
    };
    self.controller1.today = self.today;
    self.controller1.bankdic = self.bankdic;
    [_viewControllers addObject:_controller1];
    
    self.controller2=[[RHDaETXViewController alloc]initWithNibName:@"RHDaETXViewController" bundle:nil];
    self.controller2.nav = self.navigationController;
     self.controller2.bankdic = self.bankdic;
     self.controller2.today = self.today;
     self.controller2.sqswitch = self.myswitch;
    self.controller2.sqblock = ^(){
        if ([self.myswitch isEqualToString:@"ON"]) {
            [self jxsq];
        }
    };
    [_viewControllers addObject:_controller2];
    
    
    
    [_segmentContentView setViews:_viewControllers];
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField;{
    if (textField==self.withdrawTF) {
        return;
    }
    
    if ([UIScreen mainScreen].bounds.size.width < 380) {
        self.scrollView.frame = CGRectMake(0, -200, [UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.height);
    }else{
        
        self.scrollView.frame = CGRectMake(0, -30, [UIScreen mainScreen].bounds.size.width ,self.scrollView.frame.size.height);
    }
    
    NSLog(@"cbx");
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
{
    //    NSLog(@" scrollViewDidScroll");
    NSLog(@"ContentOffset  x is  %f,yis %f",scrollView.contentOffset.x,scrollView.contentOffset.y);
}

- (void)customUserInformationWith:(ZCLibInitInfo*)initInfo{
    // 用户手机号码
    //    initInfo.phone        = @"Your phone";
    
    // 用户昵称
    initInfo.nickName     = [RHUserManager sharedInterface].username;
}
- (void)setZCLibInitInfoParam:(ZCLibInitInfo *)initInfo{
    // 获取AppKey
    initInfo.appKey = @"75bdfe3a9f9c4b8a846e9edc282c92b4";
    //    initInfo.appKey = @"23a063ddadb1485a9a59f391b46bcb8b";
    //    initInfo.skillSetId = _groupIdTF.text;
    //    initInfo.skillSetName = _groupNameTF.text;
    //    initInfo.receptionistId = _aidTF.text;
    //    initInfo.robotId = _robotIdTF.text;
    //    initInfo.tranReceptionistFlag = _aidTurn;
    //    initInfo.scopeTime = [_historyScopeTF.text intValue];
    //    initInfo.titleType = titleType;
    //    initInfo.customTitle = _titleCustomTF.text;
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    
}

- (void)chongzhi{
//    [self.textField resignFirstResponder];
    
   
    
    float  versonfl = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (versonfl < 8.3) {
        
        
        
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:nil
                                      delegate:self
                                      cancelButtonTitle:@"取消"
                                      destructiveButtonTitle:nil
                                      otherButtonTitles:@"提现记录", @"提现帮助",nil];
        
        
        
        
        actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
        [actionSheet showInView:self.view];
    }else{
        unsigned int count = 0;
//        Ivar *ivars = class_copyIvarList([UIAlertAction class], &count);
//        for (int i = 0; i<count; i++) {
//            // 取出成员变量
//            //        Ivar ivar = *(ivars + i);
//            Ivar ivar = ivars[i];
//            // 打印成员变量名字
//            //        NSLog(@"%s------%s", ivar_getName(ivar),ivar_getTypeEncoding(ivar));
//        }
        
        UIAlertController * alert = [UIAlertController alertControllerWithTitle: nil message: nil preferredStyle:UIAlertControllerStyleActionSheet];
        [self addActionTarget:alert title:@"提现记录" color: [RHUtility colorForHex:@"555555"] action:^(UIAlertAction *action) {
            NSLog(@"nicaicai");
            self.secondview.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height+50);
            RHWitdrawJLViewController *  vc = [[RHWitdrawJLViewController alloc]initWithNibName:@"RHWitdrawJLViewController" bundle:nil];
            
            [self.navigationController pushViewController:vc animated:YES];
        }];
        [self addActionTarget:alert title:@"提现帮助" color: [RHUtility colorForHex:@"555555"] action:^(UIAlertAction *action) {
            self.secondview.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height+50);
            RHMoreWebViewViewController * vc = [[RHMoreWebViewViewController alloc]initWithNibName:@"RHMoreWebViewViewController" bundle:nil];
            vc.namestr = @"提现帮助";
            vc.urlstr = @"http://www.ryhui.com/common/helpCenterView/newHelpQuery?type=cash";
            [self.navigationController pushViewController:vc animated:YES];
            NSLog(@"nicaicai");
        }];
        [self addActionTarget:alert title:@"客服" color: [RHUtility colorForHex:@"555555"] action:^(UIAlertAction *action) {
            
            ZCLibInitInfo *initInfo = [ZCLibInitInfo new];
            // Appkey    *必填*
            //initInfo.appKey  = @"75bdfe3a9f9c4b8a846e9edc282c92b4";//appKey;
            initInfo.nickName     = [RHUserManager sharedInterface].username;
            //自定义用户参数
            [self customUserInformationWith:initInfo];
            [self setZCLibInitInfoParam:initInfo];
            ZCKitInfo *uiInfo=[ZCKitInfo new];
            // uiInfo.info=initInfo;
            uiInfo.isOpenEvaluation = YES;
            [[ZCLibClient getZCLibClient] setLibInitInfo:initInfo];
            
            
            // 启动
            [ZCSobot startZCChatView:uiInfo with:self target:nil pageBlock:^(ZCUIChatController *object, ZCPageBlockType type) {
                // 点击返回
                if(type==ZCPageBlockGoBack){
                    NSLog(@"点击了关闭按钮");
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self.navigationController setNavigationBarHidden:NO];
                        //[RYHViewController Sharedbxtabar].tarbar.hidden = NO;
                        // [RYHViewController Sharedbxtabar].tarbar.hidden = YES;
                        
                     //   self.secondview.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height+50);
                    });
                }
                
                // 页面UI初始化完成，可以获取UIView，自定义UI
                if(type==ZCPageBlockLoadFinish){
                    [RYHViewController Sharedbxtabar].tarbar.hidden = YES;
                    //            object.navigationController.interactivePopGestureRecognizer.delegate = object;
                    // banner 返回按钮
                    [object.backButton setTitle:@"关闭" forState:UIControlStateNormal];
                    
                    
                }
            } messageLinkClick:nil];
            
            
/*
            ZCLibInitInfo *initInfo = [ZCLibInitInfo new];
            // Appkey    *必填*
            initInfo.appKey  = @"75bdfe3a9f9c4b8a846e9edc282c92b4";//appKey;
            initInfo.nickName     = [RHUserManager sharedInterface].username;
            //自定义用户参数
            //        [self customUserInformationWith:initInfo];
            
            ZCKitInfo *uiInfo=[ZCKitInfo new];
            uiInfo.info=initInfo;
            uiInfo.isOpenEvaluation = YES;
            
            [ZCSobot startZCChatView:uiInfo with:self pageBlock:^(ZCUIChatController *object, ZCPageBlockType type) {
                // 点击返回
                if(type==ZCPageBlockGoBack){
                    NSLog(@"点击了关闭按钮");
                    
                    //             [self.navigationController setNavigationBarHidden:NO];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                    [self.navigationController setNavigationBarHidden:NO];
                        //[RYHViewController Sharedbxtabar].tarbar.hidden = NO;
                       // [RYHViewController Sharedbxtabar].tarbar.hidden = YES;
                        
                    self.secondview.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height+50);
                    });
                    
                }
                
                // 页面UI初始化完成，可以获取UIView，自定义UI
                if(type==ZCPageBlockLoadFinish){
                    
                 
                    [object.backButton setTitle:@"关闭" forState:UIControlStateNormal];
                    
                    
                    
                }
            } messageLinkClick:nil];
 */
            NSLog(@"nicaicai");
        }];
        
 
        [self addCancelActionTarget:alert title:@"取消"];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}
-(void)addCancelActionTarget:(UIAlertController*)alertController title:(NSString *)title
{
    UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    [action setValue:[RHUtility colorForHex:@"555555"] forKey:@"_titleTextColor"];
    [alertController addAction:action];
}

- (void)addActionTarget:(UIAlertController *)alertController title:(NSString *)title color:(UIColor *)color action:(void(^)(UIAlertAction *action))actionTarget
{
    UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        actionTarget(action);
        
        
    }];
    
    [action setValue:color forKey:@"_titleTextColor"];
    [alertController addAction:action];
}
-(void)tap:(UILabel *)sender{
    
        
        NSLog(@"putong");
    
    self.category = @"1";
    
       // NSLog(@"ks");
    self.tixianfangshilab.text = @" 普通提现";
    self.tixianmiaoshulab.text = @" T+1个工作日到账";
    self.putongtixianlab.hidden = YES;
    self.kuaisutixianlab.hidden = YES;
    self.sjlab.hidden = YES;
    self.fengeimage.hidden = YES;
  self.tximage.image = [UIImage imageNamed:@"down"];
    [self textFieldTextDidChange:nil];
    
}
-(void)tap1:(UILabel *)sender{
   
    
    NSDate *now = [NSDate date];
      NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
     NSInteger hour = [dateComponent hour];
     NSInteger minute = [dateComponent minute];
    
    if (!(hour> 8 && hour <18)) {
        if (hour==17) {
            
            if (minute>30) {
                [RHUtility showTextWithText:@"非工作时间不能用即时提现请您选择普通提现"];
            }
        }else{
         [RHUtility showTextWithText:@"非工作时间不能用即时提现，请您选择普通提现。"];
        }
    }
    
    self.category = @"2";
//    NSLog(@"putong");
     self.tixianmiaoshulab.text = @"当日到账";
    self.tixianfangshilab.text = @" 即时提现";
    self.putongtixianlab.hidden = YES;
    self.kuaisutixianlab.hidden = YES;
    self.sjlab.hidden = YES;
    self.fengeimage.hidden = YES;
    
     NSLog(@"ks");
    self.tximage.image = [UIImage imageNamed:@"down"];
    [self getmysert];
    
    
}
-(void)getmysert{
    
   
    [[RHNetworkService instance] POST:@"app/front/payment/appJxAccount/withdrawIsToday" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            if (responseObject[@"isToday"] && ![responseObject[@"isToday"]isKindOfClass:[NSNull class]] ) {
                self.today = [[NSString stringWithFormat:@"%@",responseObject[@"isToday"]] floatValue];
                self.controller1.today = self.today;
                self.controller2.today = self.today;
              //  self.controller2.lhcstr = [NSString stringWithFormat:@"%@",responseObject[@"isToday"]];

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

- (void)getWithdrawData {
    [[RHNetworkService instance] POST:@"app/front/payment/account/myCashDataForApp" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        DLog(@"%@",responseObject);
        NSString *balance = [NSString stringWithFormat:@"%0.2f",[[responseObject objectForKey:@"balance"] doubleValue]];
        
        if (!balance ||![balance isKindOfClass:[NSNull class]]) {
             self.balanceLabel.text = balance;
        }else{
            
            self.balanceLabel.text = @"0.00";

        }
       
        
        NSArray *qpCard=[responseObject objectForKey:@"qpCard"];
        NSArray *cards=[responseObject objectForKey:@"cards"];
        
        if ((cards && [cards count] > 0)||(qpCard && [qpCard count] > 0)) {
            self.overView.hidden = YES;
//            self.withdrawTF.enabled = YES;
        } else {
            self.overView.hidden = NO;
//            self.withdrawTF.enabled = NO;
        }
        NSString* bankType = nil;
        NSString* cardId = nil;
        NSString* cardType = nil;
        if (![qpCard isKindOfClass:[NSNull class]] && qpCard && [qpCard count] > 0) {
            for (NSString *idStr in qpCard) {
                int index = [[NSNumber numberWithUnsignedInteger:[qpCard indexOfObject:idStr]] intValue];
                if (index == 0) {
                    bankType = idStr;
                }
                if (index == 1) {
                    cardId = idStr;
                }
                if (index == 2) {
                    cardType = idStr;
                }
            }
            self.qbCardTipsView.hidden = NO;
            self.cardsView.hidden = YES;
        }else{
            if (![cards isKindOfClass:[NSNull class]] && cards&&[cards count] > 0) {
//                DLog(@"%@",cards);
                for (NSString *idStr in [cards objectAtIndex:0]) {
//                    DLog(@"%@",idStr);
                    int index = [[NSNumber numberWithUnsignedInteger:[[cards objectAtIndex:0] indexOfObject:idStr]] intValue];
//                    DLog(@"%d",index);
                    if (index == 0) {
                        bankType = idStr;
                    }
                    if (index == 1) {
                        cardId = idStr;
                    }
                    if (index == 2) {
                        cardType = idStr;
                    }
                }
                self.qbCardTipsView.hidden = YES;
                self.cardsView.hidden = NO;
            }
        }
//        DLog(@"%@",[NSString stringWithFormat:@"%@.jgp",bankType]);
//        
//        DLog(@"%@",cardId);
        if(cardId != nil) {
            
            
            //self.cardLabel.text = [NSString stringWithFormat:@"%@ **** **** %@",[cardId substringToIndex:4],[cardId substringFromIndex:[cardId length] - 4]];
            
        }
        self.iconImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",bankType]];
        free = [[responseObject objectForKey:@"free"] doubleValue];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        DLog(@"%@",error);
        self.balanceLabel.text = @"0.00";
        self.freelab.text = @"0.00";
    }];
}

//提现
- (IBAction)withdrawAction:(id)sender {
    if ([self.withdrawTF.text length] <= 0) {
        [RHUtility showTextWithText:@"请填写提现金额"];
        return;
    }
    if ([self.captchaTF.text length] <= 0) {
        [RHUtility showTextWithText:@"请填写提验证码"];
        return;
    }
    if ([self.withdrawTF.text floatValue] < [self.moneystr doubleValue]&&[self.category isEqualToString:@"1"]) {
        [RHUtility showTextWithText:[NSString stringWithFormat:@"普通提现至少%d元",[self.moneystr intValue] ]];
        return;
    }
    if ([self.category isEqualToString:@"2"]&&[self.withdrawTF.text doubleValue] <200) {
        [RHUtility showTextWithText:@"即时提现，单笔最低提现200元"];
        return;
    }
    
    RHWithdrawWebViewController *controller = [[RHWithdrawWebViewController alloc]initWithNibName:@"RHWithdrawWebViewController" bundle:nil];
    controller.amount = self.withdrawTF.text;
    controller.captcha = self.captchaTF.text;
    controller.category = self.category;
    controller.bankcard = self.bankcard;
    if (controller.bankcard.length<1) {
        controller.bankcard = @"000";
    }
    
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)bindCardAction:(id)sender {
    RHBindCardWebViewController *controller = [[RHBindCardWebViewController alloc]initWithNibName:@"RHBindCardWebViewController" bundle:nil];
    controller.delegate = self;
    
    
    [self.navigationController pushViewController:controller animated:YES];
}
//设置银行卡
- (IBAction)changeCards:(id)sender {
    [self bindCardAction:nil];
}

- (void)textFieldTextDidChange:(NSNotification *)nots {
    
    if ([self.category isEqualToString:@"1"]) {
        
    
    double price = [self.withdrawTF.text doubleValue];
    if (price > [self.balanceLabel.text doubleValue]) {
        price = [self.balanceLabel.text doubleValue];
        self.withdrawTF.text = [NSString stringWithFormat:@"%0.2f",[self.balanceLabel.text doubleValue]];
    }
    double tempPrice = free - price;
    if (tempPrice > 0) {
        self.freeLabel.text = @"0.00";
        self.getAmountLabel.text = [NSString stringWithFormat:@"%0.2f",[self.withdrawTF.text doubleValue]];
    } else {
        tempPrice = price - free;
        double getAmount;
        if (tempPrice > 0) {
             getAmount = tempPrice * 0.005 > 1.00 ? tempPrice * 0.005 : 1.00;
            
            
            self.freeLabel.text = [NSString stringWithFormat:@"%0.2f",getAmount];
            
            
        }else{
         getAmount = tempPrice ;
        
        
        self.freeLabel.text = [NSString stringWithFormat:@"%0.2f",getAmount];
        }
        if (price+getAmount <= [self.balanceLabel.text doubleValue]) {
            self.getAmountLabel.text = [NSString stringWithFormat:@"%.2f",price];
        } else {
            if ([self.balanceLabel.text doubleValue] - getAmount > 0) {
                self.getAmountLabel.text = [NSString stringWithFormat:@"%0.2f",[self.balanceLabel.text doubleValue] - getAmount];
            } else {
                self.getAmountLabel.text = @"0.00";
            }
        }
    }
    }else{
        
        double price = [self.withdrawTF.text doubleValue];
        if (price > [self.balanceLabel.text doubleValue]) {
            price = [self.balanceLabel.text doubleValue];
                    self.withdrawTF.text = [NSString stringWithFormat:@"%0.2f",[self.balanceLabel.text doubleValue]];
        }
         double tempPrice = free - price;
        if (tempPrice >= 0) {
            
            double a = self.ksday;
            self.freeLabel.text = [NSString stringWithFormat:@"%.2f",a * price*0.001];
        }else{
            
            double a = self.ksday ;
            double b = (price - free) * 0.005;
            if (b<1) {
                b= 1;
            }
            
            self.freeLabel.text = [NSString stringWithFormat:@"%.2f",a * price*0.001 + b];
        }
        
    }
 
    double zongmy = [self.balanceLabel.text doubleValue];
    double timy = [self.withdrawTF.text doubleValue];
    double shouxumy = [self.freeLabel.text doubleValue];
    double res = zongmy - timy - shouxumy;
    if (res >= 0) {
         self.getAmountLabel.text = [NSString stringWithFormat:@"%.2f",[self.withdrawTF.text doubleValue]];
    }else{
        
        self.getAmountLabel.text = [NSString stringWithFormat:@"%.2f",[self.withdrawTF.text doubleValue] - [self.freeLabel.text doubleValue]];
    }
    //self.getAmountLabel.text = [NSString stringWithFormat:@"%.2f",[self.withdrawTF.text doubleValue] - [self.freeLabel.text doubleValue]];
    
}

//获取验证码
- (IBAction)getCaptchaAction:(id)sender {
    if ([self.withdrawTF.text isEqualToString:@"0"]) {
        [RHUtility showTextWithText:@"提现金额不能为0"];
        return;
    }
    
    NSDictionary *parameters = @{@"telephone":[RHUserManager sharedInterface].telephone,@"type":@"SMS_CAPTCHA_CASH"};
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
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        DLog(@"%@",error);
    }];
}

- (void)reSendMessage {
    secondsCountDown = 60;
    self.captchaButton.enabled = NO;
    countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
}

- (void)timeFireMethod {
    secondsCountDown --;
    [self.captchaButton setTitle:[NSString stringWithFormat:@"重新发送(%d)",secondsCountDown] forState:UIControlStateDisabled];
    if (secondsCountDown == 0) {
        self.captchaButton.enabled = YES;
        [self.captchaButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [countDownTimer invalidate];
    }
}

- (IBAction)pushMain:(id)sender {
    [[[RHTabbarManager sharedInterface] selectTabbarMain] popToRootViewControllerAnimated:NO];
}

- (IBAction)pushUser:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)pushMore:(id)sender {
    [[[RHTabbarManager sharedInterface] selectTabbarMore] popToRootViewControllerAnimated:NO];
}

//////添加银行卡
- (IBAction)hiddenKeyBorad:(id)sender {
    [self.withdrawTF resignFirstResponder];
    [self.captchaTF resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSCharacterSet *cs;
    NSString *str=@"0123456789.";
    cs = [[NSCharacterSet characterSetWithCharactersInString:str] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basicTest = [string isEqualToString:filtered];
    if (!basicTest) {
        return NO;
    }
    
    NSString *result=[NSString stringWithFormat:@"%@%@",textField.text,string];
    NSArray *array=[result componentsSeparatedByString:@"."];
    if (array && [array count] > 2) {
        return NO;
    }
    NSRange ranges = [result rangeOfString:@"."];
    if (ranges.location != NSNotFound) {
        NSString *temp=[result substringFromIndex:ranges.location+1];
//        DLog(@"%@",temp);
        if ([temp length] > 2) {
            return NO;
        }
    }
    return YES;
}

- (IBAction)gestureTape:(UITapGestureRecognizer *)sender {
    
    if ([self.category isEqualToString:@"2"]&&[self.withdrawTF.text doubleValue] <200) {
         [RHUtility showTextWithText:@"即时提现，单笔最低提现200元"];
    }
    
    [self.withdrawTF resignFirstResponder];
    [self.captchaTF resignFirstResponder];
}

-(void)viewWillDisappear:(BOOL)animated {
    for (UIView *subView in [UIApplication sharedApplication].keyWindow.subviews) {
        if (subView.tag == 1000) {
            [subView removeFromSuperview];
        }
    }
     self.secondview.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height+50);
    [super viewWillDisappear:animated];
}

- (IBAction)tixianfangshi:(id)sender {
    
    
    if (self.res) {
        self.putongtixianlab.hidden = YES;
        self.kuaisutixianlab.hidden = YES;
        self.sjlab.hidden = YES;
        self.fengeimage.hidden = YES;
        self.res = NO;
        self.tximage.image = [UIImage imageNamed:@"down"];
        return;
        
    }
   
    
        self.putongtixianlab.hidden = NO;
        self.kuaisutixianlab.hidden = NO;
        self.sjlab.hidden = NO;
        self.fengeimage.hidden = NO;
    self.tximage.image = [UIImage imageNamed:@"sjt"];
    self.res = YES;
    
}

- (IBAction)xuanzeyinhangka:(id)sender {
    
    
    if (self.res ) {
        self.yhktableview.hidden = YES;
        self.yhimage.image = [UIImage imageNamed:@"down"];
        self.res = NO;
        return;
    }
    self.yhktableview.hidden = NO;
    self.yhimage.image = [UIImage imageNamed:@"sjt"];
    self.res = YES;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.dataArray.count==1) {
        self.yhktableview.frame = CGRectMake(CGRectGetMinX(self.yhktableview.frame), CGRectGetMinY(self.yhktableview.frame), self.yhktableview.frame.size.width, 40);
    }
    
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * string = @"RHxuanzebankcard";
    
    RHTXTableViewCell * cell =(RHTXTableViewCell*) [tableView dequeueReusableCellWithIdentifier:string];
    
    if (!cell) {
     cell = [[[NSBundle mainBundle] loadNibNamed:@"RHTXTableViewCell" owner:nil options:nil] objectAtIndex:0];
    }
    
    [cell updateCell:self.dataArray[indexPath.row]];
    cell.myblock = ^{
        [self tableView:tableView didSelectRowAtIndexPath:indexPath];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
   
    //self.xuanhaodeyinhangkalab.text = [NSString stringWithFormat:@"%@ %@",self.dataArray[indexPath.row][@"yh"],self.dataArray[indexPath.row][@"kh"] ];
    NSString *str = [NSString stringWithFormat:@"%@",self.dataArray[indexPath.row][@"kh"]];
    
    self.bankcard = str;
    NSString * laststr = [str substringFromIndex:str.length - 4];
    NSString * firststr = [str substringToIndex:4];
    
    self.xuanhaodeyinhangkalab.text = [NSString stringWithFormat:@"%@  %@  ****  %@  ",self.dataArray[indexPath.row][@"yh"],firststr,laststr];
    
    NSLog(@"%ld",(long)indexPath.row);
    self.yhktableview.hidden = YES;
    [self xuanzeyinhangka:nil];
}
- (IBAction)tixiantishi:(id)sender {
    self.tishiaimage.hidden = NO;
    self.tishiscoll.hidden = NO;
    self.mengbanview.hidden = NO;
//    self.tishiscoll.hidden = YES;
}
- (IBAction)agreetishi:(id)sender {
    
    self.mengbanview.hidden =YES;
    self.tishiscoll.hidden = YES;
    self.tishiaimage.hidden=YES;
}

-(void)getmybankcardData{
    
    
    [[RHNetworkService instance] POST:@"app/front/payment/appAccount/appMyCards" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSArray class]]) {
             self.yhimage.hidden = YES;
            return ;
        }
        NSLog(@"%@",responseObject);
        if ([responseObject[@"msg"] isEqualToString:@"success"] ) {
            
            NSArray * array = responseObject[@"cards"];
            
            for (NSArray * arr in array) {
                
                if (![arr[2] isKindOfClass:[NSNull class]]&&[arr[2] isEqualToString:@"default"]) {
                    NSString * bankname = @"";
//                    NSLog(@"%@",arr[2]);
                    if (arr.count>3) {
                      if (![arr[3] isKindOfClass:[NSNull class]]) {
                        bankname = arr[3];
                      }
                    }
                    
                    
                    NSString * str ;
                
                    if (![arr[1] isKindOfClass:[NSNull class]]) {
                        str = arr[1];
                    }else{
                        str= @"";
                    }
                    NSString * laststr = [str substringFromIndex:str.length - 4];
                    NSString * firststr = [str substringToIndex:4];
                    
                    self.xuanhaodeyinhangkalab.text = [NSString stringWithFormat:@" %@ %@  ****  %@  ",bankname,firststr,laststr];
//                    self.qrtibtn.hidden = YES;
                   // self.xuanhaodeyinhangkalab.text = arr[1];
                   // self.cardqj.hidden = NO;
                    self.xuanzeyinhangkabtn.hidden = NO;
                    
//                    NSString * str11;
//                    if (![arr[3] isKindOfClass:[NSNull class]]) {
//                        str11 = arr[3];
//                    }else{
//                        str11= @"";
//                    }
                    NSDictionary * dic = @{@"yh":bankname,
                                           @"kh":str};
                    [self.dataArray addObject:dic];
                }else if(![arr[2] isKindOfClass:[NSNull class]]&&[arr[2] isEqualToString:@"QP"]){
                    NSString * bankname = @"";
                    //
                    
//                    NSLog(@"%@",arr[2]);
                    if (arr.count>3) {
                        
                    
                    if (![arr[3] isKindOfClass:[NSNull class]]) {
                        bankname = arr[3];
                    }
                    }
                    
                    NSString * str ;
                    
                    if (![arr[1] isKindOfClass:[NSNull class]]) {
                        str = arr[1];
                    }else{
                        str= @"";
                    }
                    NSString * laststr = [str substringFromIndex:str.length - 4];
                    NSString * firststr = [str substringToIndex:4];
                    
                    self.xuanhaodeyinhangkalab.text = [NSString stringWithFormat:@" %@ %@  ****  %@  ",bankname,firststr,laststr];
                    //                    self.qrtibtn.hidden = YES;
                    // self.xuanhaodeyinhangkalab.text = arr[1];
                    self.cardqj.hidden = NO;
                   self.yhimage.hidden = YES;
                    self.xuanzeyinhangkabtn.hidden = YES;
                    
                }else{
                    NSString * str11 = @"";
                    if (arr.count>3) {
                       if (![arr[3] isKindOfClass:[NSNull class]]) {
                        str11 = arr[3];
                       }
                        
                    }
                    NSString * str ;
                    
                    if (![arr[1] isKindOfClass:[NSNull class]]) {
                        str = arr[1];
                    }else{
                        str= @"";
                    }
                    
                    NSDictionary * dic = @{@"yh":str11,
                                           @"kh":str};
                    [self.dataArray addObject:dic];
                    
                }
                    
                    
                
            }
            
        }
        
        [self.yhktableview reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
    }];
    
}

- (UIToolbar *)addToolbar
{
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame),35)];
    //    toolbar.tintColor = [UIColor blueColor];
    //    toolbar.backgroundColor = [UIColor clearColor];
    UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(nextTextField)];
    UIBarButtonItem *prevButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(prevTextField)];
    //    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 40, 7,40, 30)];
    [button setTitle:@"完成"forState:UIControlStateNormal];
    //   button.titleLabel
    [button addTarget:self action:@selector(textFieldDone) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[RHUtility colorForHex:@"#44BBC1"] forState:UIControlStateNormal];
    //    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(textFieldDone)];
    //    toolbar.items = @[bar];
    [toolbar addSubview:button];
    return toolbar;
}
-(void)textFieldDone{
    
    
    
    [self tap2];
}


- (UIToolbar *)addToolbar1
{
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame),35)];
    //    toolbar.tintColor = [UIColor blueColor];
    //    toolbar.backgroundColor = [UIColor clearColor];
    UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(nextTextField)];
    UIBarButtonItem *prevButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(prevTextField)];
//    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
     UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 40, 7,40, 30)];
     [button setTitle:@"完成"forState:UIControlStateNormal];
//   button.titleLabel
    [button addTarget:self action:@selector(textFieldDone1) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[RHUtility colorForHex:@"#44BBC1"] forState:UIControlStateNormal];
//    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(textFieldDone)];
//    toolbar.items = @[bar];
       [toolbar addSubview:button];
    return toolbar;
}
-(void)textFieldDone1{
    
    
    
    [self.withdrawTF resignFirstResponder];
    [self.captchaTF resignFirstResponder];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(NSString *)backcardmycard : (NSString * )str{
    
    NSString * str1;
    NSArray * array = @[@"ABC",@"CCB",@"BOC",@"CEB",@"CIB",@"CITIC",@"PINGAN",@"BOS",@"CBHB",@"PSBC",@"SPDB",@"ICBC",@"BCM",@"CMBC",@"GDB",@"CMB"];
    NSInteger index = [array indexOfObject:str];
    switch (index) {
        case 0:
            str1 = @"农业银行";
            break;
        case 1:
            str1 = @"建设银行";
            break;
        case 2:
            str1 = @"中国银行";
            break;
        case 3:
            str1 = @"光大银行";
            break;
        case 4:
            str1 = @"兴业银行";
            break;
        case 5:
            str1 = @"中信银行";
            break;
        case 6:
            str1 = @"平安银行";
            break;
        case 7:
            str1 = @"上海银行";
            break;
        case 8:
            str1 = @"渤海银行";
            break;
        case 9:
            str1 = @"邮储银行";
            break;
        case 10:
            str1 = @"浦发银行";
            break;
        case 11:
            str1 = @"工商银行";
            break;
        case 12:
            str1 = @"交通银行";
            break;
        case 13:
            str1 = @"民生银行";
            break;
        case 14:
            str1 = @"广发银行";
            break;
        case 15:
            str1 = @"招商银行";
            break;
            
        default:
            break;
    }
    
    return str1;
}


- (IBAction)hiden:(id)sender {
    
    self.mengbanview.hidden = YES;
    self.tishiscoll.hidden = YES;
}
- (IBAction)wenhaotishi:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"可提现金额＝可用余额－当日个人网银／快捷充值金额－提现处理中金额" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles: nil];
    [alert show];
//    [RHUtility showTextWithText:@"可提现金额＝可用余额－当日个人网银／快捷充值金额－提现处理中金额"];
}
- (IBAction)xuanzeyehangkabtn:(id)sender {
    if (self.xuanzeyinhangkabtn.hidden ==YES) {
        return;
    }
    
     [self xuanzeyinhangka:nil];
}


- (IBAction)shishitixian:(id)sender {
    
   
    self.segmentView2.hidden = YES;
   // self.segmentView3.hidden = YES;
    self.segmentView1.hidden = NO;
    // NSLog(@"cbxcbx");
    [self didSelectSegmentAtIndex:0];
}


- (IBAction)daetixian:(id)sender {
//    if ([self.wortimestr isEqualToString:@"false"]) {
//
//        self.mengban1.hidden = NO;
//        self.daetishiview.hidden = NO;
//        [self shishitixian:nil];
//        return;
//    }
    
    if ([self.wortimestr isEqualToString:@"false"]) {
        
        self.mengban1.hidden = NO;
        self.daetishiview.hidden = NO;
//        self.segmentView2.hidden = YES;
//        // self.segmentView3.hidden = YES;
//        self.segmentView1.hidden = NO;
//        // NSLog(@"cbxcbx");
//        [self didSelectSegmentAtIndex:0];
        
    }
    self.segmentView2.hidden = NO;
   // self.segmentView3.hidden = YES;
    self.segmentView1.hidden = YES;
    // NSLog(@"cbxcbx");
    [self didSelectSegmentAtIndex:1];
    
}
- (void)didSelectSegmentAtIndex:(int)index
{
    
    //    [self getSegmentnum1];
    //    [self getSegmentnum2];
    //    RHDetaisecondViewController* controller=[_viewControllers objectAtIndex:index];
    // [controller.tableView setContentOffset:CGPointMake(0,0) animated:YES];
    //    if (index ==2) {
    //        NSString *pass =  [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@Gesture",[RHUserManager sharedInterface].username]];;
    //
    //        if (pass.length <1) {
    //            [self segentsecondbtn:nil];
    //            //        self.controller3.tableView.hidden = YES;
    //            [self loginryh];
    //
    //            return;
    //        }
    //    }
    
    [_segmentContentView setSelectPage:index];
    
}
- (void)segmentContentView:(RHSegmentContentView *)segmentContentView selectPage:(NSUInteger)page{
    
   // [self.controller1 respfirsttf];
    if (page ==1) {
        
        [self daetixian:nil];
        
        [self.controller1 rebsfirst];
        //[self.controller2 moneyrebsfirst];
        // [self segentsecondbtn:nil];
    }else{
        //     [self segntonebtn:nil];
        [self shishitixian:nil];
        [self.controller2 rebsfirst];
      //  [self.controller1 moneyrebsfirst];
    }
    //    [self didSelectSegmentAtIndex:page];
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
- (IBAction)quxiaoqudae:(id)sender {
    self.segmentView2.hidden = YES;
    // self.segmentView3.hidden = YES;
    self.segmentView1.hidden = NO;
    // NSLog(@"cbxcbx");
    [self didSelectSegmentAtIndex:0];
    self.mengban1.hidden = YES;
    self.daetishiview.hidden = YES;
    
}
- (IBAction)qudaetixian:(id)sender {
    
    
    self.segmentView2.hidden = YES;
    // self.segmentView3.hidden = YES;
    self.segmentView1.hidden = NO;
    // NSLog(@"cbxcbx");
    [self didSelectSegmentAtIndex:0];
    self.mengban1.hidden = YES;
    self.daetishiview.hidden = YES;
    
}

-(void)jxsq{
    
    self.mengban1.hidden = NO;
    self.sqview.hidden = NO;
    
//    RHWSQViewController * vc = [[RHWSQViewController alloc]initWithNibName:@"RHWSQViewController" bundle:nil];
//    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)sqxieyi:(id)sender {
    self.mengban1.hidden = YES;
    self.sqview.hidden = YES;
    RHXYWebviewViewController * vc= [[RHXYWebviewViewController alloc]initWithNibName:@"RHXYWebviewViewController" bundle:nil];
    vc.namestr = @"缴费授权协议";
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)hidennsqview:(id)sender {
    self.mengban1.hidden = YES;
    self.sqview.hidden = YES;
}
- (IBAction)gosq:(id)sender {
    self.mengban1.hidden = YES;
    self.sqview.hidden = YES;
    RHWSQViewController * vc = [[RHWSQViewController alloc]initWithNibName:@"RHWSQViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
}

@end
