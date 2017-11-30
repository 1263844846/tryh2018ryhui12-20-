//
//  RHRechargeViewController.m
//  ryhui
//
//  Created by stefan on 15/3/15.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHRechargeViewController.h"
#import "RHRechargeWebViewController.h"
#import "MBProgressHUD.h"
#import "RHBindCardViewController.h"
#import "DQViewController.h"
#import "RHRechangejiluViewController.h"
#import "RHBankwebviewViewController.h"
#import "RHBankNameTableViewCell.h"
#import <objc/runtime.h>
#import "RHMoreWebViewViewController.h"
#import "RHkuaijViewController.h"
#import "RHzhuanzhangViewController.h"
#import "RHALpayViewController.h"
#import "RHBngkCardDetailViewController.h"
#import <SobotKit/SobotKit.h>
@interface RHRechargeViewController ()<UIActionSheetDelegate,UITableViewDelegate,UITableViewDataSource,RHSegmentContentViewDelegate>
{
    BOOL isQpCard;
}

@property (weak, nonatomic) IBOutlet UIButton *xzbankcard;

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *rechargeButton;
@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *houmoneylab;
@property (weak, nonatomic) IBOutlet UIImageView *dbxaimage;
//@property (weak, nonatomic) IBOutlet UILabel *tishilab;
@property (weak, nonatomic) IBOutlet UIView *hidenview;
@property (weak, nonatomic) IBOutlet UIButton *agreebtn;
@property (weak, nonatomic) IBOutlet UILabel *bankcardlab;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong)NSArray * keyArray;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)NSString * banklogo;

@property(nonatomic,assign)BOOL res;
@property (weak, nonatomic) IBOutlet UILabel *kuaijie;
@property (weak, nonatomic) IBOutlet UILabel *xianelab;
@property (weak, nonatomic) IBOutlet UIImageView *czts;

@property (weak, nonatomic) IBOutlet UILabel *mytishilab;
@property (weak, nonatomic) IBOutlet UIView *resuarsview;



//new
@property(nonatomic,strong)RHSegmentContentView* segmentContentView;
@property(nonatomic,strong)NSMutableArray* viewControllers;
@property (weak, nonatomic) IBOutlet UIView *segmentView1;
@property (weak, nonatomic) IBOutlet UIView *segmentView2;
@property (weak, nonatomic) IBOutlet UIView *segmentView3;
@property (strong, nonatomic) IBOutlet UIView *secondview;

@property(nonatomic,strong)RHkuaijViewController* controller1;
@property(nonatomic,strong)RHzhuanzhangViewController*controller2;
@property(nonatomic,strong)RHALpayViewController*controller3;


@property (weak, nonatomic) IBOutlet UILabel *hidenlab1;
@property (weak, nonatomic) IBOutlet UILabel *hidenlab2;

@property (weak, nonatomic) IBOutlet UIImageView *hidenimage1;

@property (weak, nonatomic) IBOutlet UIImageView *hideniaamge2;
@property (weak, nonatomic) IBOutlet UIButton *hidenbtn1;
@property (weak, nonatomic) IBOutlet UIButton *hidenbtn2;
@property (weak, nonatomic) IBOutlet UIView *hidenmengban;
@property (weak, nonatomic) IBOutlet UIView *hidenguize;
@property (weak, nonatomic) IBOutlet UILabel *guizelab1;
@property (weak, nonatomic) IBOutlet UILabel *guizelab2;
@property (weak, nonatomic) IBOutlet UILabel *guizelab3;
@property (weak, nonatomic) IBOutlet UIImageView *fanxian1;

@property (weak, nonatomic) IBOutlet UIImageView *fanxian2;
@property (weak, nonatomic) IBOutlet UIScrollView *tishiscorlview;

@property(nonatomic,copy)NSString * stri;
@end

@implementation RHRechargeViewController
@synthesize balance;


-(NSDictionary*)bankdic{
    
    if (!_bankdic) {
        _bankdic = [NSDictionary dictionary];
    }
    return _bankdic;
}

- (UIToolbar *)addToolbar
{
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame),35)];
   
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 40, 7,40, 30)];
    [button setTitle:@"完成"forState:UIControlStateNormal];
    //   button.titleLabel
    [button addTarget:self action:@selector(textFieldDone) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[RHUtility colorForHex:@"#44BBC1"] forState:UIControlStateNormal];
  
    [toolbar addSubview:button];
    return toolbar;
}
-(void)textFieldDone{
    
    [self.textField resignFirstResponder];
    
   
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configBackButton];
    self.textField.inputAccessoryView = [self addToolbar];
    self.resuarsview.layer.masksToBounds=YES;
    self.resuarsview.layer.cornerRadius=9;
    self.kuaijie.hidden = YES;
    self.xzbankcard.hidden = YES;
    self.rechargeButton.layer.masksToBounds=YES;
    self.rechargeButton.layer.cornerRadius=9;
    self.czts.layer.masksToBounds=YES;
    self.czts.layer.cornerRadius=9;
    self.kuaijie.layer.masksToBounds = YES;
    self.kuaijie.layer.cornerRadius = 3;
    self.tableView.hidden  = YES;
    [self configTitleWithString:@"充值"];
    _viewControllers = [NSMutableArray array];
//    [self.textField becomeFirstResponder];
    if (balance&&[balance length]>0) {
        self.balanceLabel.text=balance;
    }else{
        self.balanceLabel.text=@"0.00";
    }
    [self.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.houmoneylab.text = self.balanceLabel.text;
    
    
    self.hidenview.hidden = YES;
    
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.hidenmengban];
    [[UIApplication sharedApplication].keyWindow addSubview:self.hidenguize];
    self.hidenguize.frame = CGRectMake(10, 100, [UIScreen mainScreen].bounds.size.width-20, self.hidenguize.frame.size.height);
    
    self.hidenguize.hidden = YES;
    self.hidenmengban.hidden = YES;
    
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
     [self getBindCard];
    UITapGestureRecognizer * tapp = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchdid)];
    [self.xianelab addGestureRecognizer:tapp];
    self.xianelab.userInteractionEnabled = YES;
    
  //  [self getbankid];
//    UIView * wadbxView = [[UIView alloc]init];
//    
//    wadbxView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-115, [UIScreen mainScreen].bounds.size.width,53);
//    self.view.backgroundColor = [RHUtility colorForHex:@"#e4e6e6"];
//    wadbxView.backgroundColor = [RHUtility colorForHex:@"#e4e6e6"];
//    [self.view addSubview:wadbxView];
    
//    UIImageView * aimageview = [[UIImageView alloc]init];
//    aimageview.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-44-69-20, 300, 40);
//    [self.view addSubview:aimageview];
//    aimageview.backgroundColor = [UIColor redColor];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(getbankid)];
    
    self.dbxaimage.userInteractionEnabled = YES;
//    self.xzbankcard.userInteractionEnabled = NO;
    [self.dbxaimage addGestureRecognizer:tap];
//    aimageview.userInteractionEnabled = YES;
//    [aimageview addGestureRecognizer:tap];
    
    
    
    [self getbankcard];
    [self getregchagenews];
    
    NSDictionary *attributes = @{NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *netString = [[NSMutableAttributedString alloc] initWithString:_xianelab.text];
    [netString addAttributes:attributes range:NSMakeRange(37, 6)];
     [netString addAttribute:NSForegroundColorAttributeName value:[RHUtility colorForHex:@"#4abac0"] range:NSMakeRange(37,6)];
    _xianelab.attributedText = netString;

    
    if ([UIScreen mainScreen].bounds.size.width ==375) {
        self.mytishilab.font = [UIFont systemFontOfSize:13];
    }else if ([UIScreen mainScreen].bounds.size.width >376){
        
        self.mytishilab.font = [UIFont systemFontOfSize:14];
    }else{
        
        self.mytishilab.font = [UIFont systemFontOfSize:11];
    }
    
    
    
    
    
    
    
    
    
    
    self.segmentContentView = [[RHSegmentContentView alloc] initWithFrame:CGRectMake(0, 90, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].applicationFrame.size.height-50-self.navigationController.navigationBar.frame.size.height)];
    
    [_segmentContentView setDelegate:self];
    [self.secondview addSubview:_segmentContentView];
    
    self.secondview.frame = CGRectMake(0, 0, self.view.frame.size.width, [UIScreen mainScreen].bounds.size.height+50);
    
    [self.view addSubview:self.secondview];
    
    [self getsegmentviewcontrol];
    
   // [self didSelectSegmentAtIndex:2];
    self.controller3.alipaybtn.hidden = YES;
    self.controller3.albtn2.hidden = YES;
    
}
-(void)getsegmentviewcontrol{
    self.controller1=[[RHkuaijViewController alloc]initWithNibName:@"RHkuaijViewController" bundle:nil];
    self.controller1.nav = self.navigationController;
    self.controller1.bankdic = self.bankdic;
    self.controller1.bancle = self.balance;
    
    self.controller1.mykjblock = ^(){
        [self wanyinbtn:nil];
    };
   // [self.controller1 setbankcarddata:self.bankdic];
    [_viewControllers addObject:_controller1];
    
    self.controller2=[[RHzhuanzhangViewController alloc]initWithNibName:@"RHzhuanzhangViewController" bundle:nil];
    self.controller2.bankdic = self.bankdic;
    [_viewControllers addObject:_controller2];
   
    
    self.controller3=[[RHALpayViewController alloc]initWithNibName:@"RHALpayViewController" bundle:nil];
    self.controller3.alipaybtn.hidden = YES;
    self.controller3.albtn2.hidden = YES;
    self.controller3.bankdic = self.bankdic;
    [_viewControllers addObject:_controller3];
       [_segmentContentView setViews:_viewControllers];
    
    //[self segmentContentView:_segmentContentView selectPage:0];
    //[self getdata];
    
}
//dssddsds
- (IBAction)getbanknamebtn:(id)sender {
    
    
    if (self.dbxaimage.hidden ==YES) {
        return;
    }
    [self getbankid];
    
    
    
}

-(void)toubiao{
    
    NSLog(@"57575");
}

- (void)chongzhi{
    [self.textField resignFirstResponder];
     self.controller3.alipaybtn.hidden = YES;
    self.controller3.albtn2.hidden = YES;
    float  versonfl = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (versonfl < 8.3) {
        
    
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"充值记录", @"充值帮助",@"客服",nil];
    

    
    
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];
    }else{
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([UIAlertAction class], &count);
    for (int i = 0; i<count; i++) {
        // 取出成员变量
        //        Ivar ivar = *(ivars + i);
        Ivar ivar = ivars[i];
        // 打印成员变量名字
//        NSLog(@"%s------%s", ivar_getName(ivar),ivar_getTypeEncoding(ivar));
    }
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle: nil message: nil preferredStyle:UIAlertControllerStyleActionSheet];
    [self addActionTarget:alert title:@"充值记录" color: [RHUtility colorForHex:@"555555"] action:^(UIAlertAction *action) {
        NSLog(@"nicaicai");
        RHRechangejiluViewController *  vc = [[RHRechangejiluViewController alloc]initWithNibName:@"RHRechangejiluViewController" bundle:nil];
        
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [self addActionTarget:alert title:@"充值帮助" color: [RHUtility colorForHex:@"555555"] action:^(UIAlertAction *action) {
        NSLog(@"nicaicai");
        RHMoreWebViewViewController * vc = [[RHMoreWebViewViewController alloc]initWithNibName:@"RHMoreWebViewViewController" bundle:nil];
        vc.namestr = @"充值帮助";
        vc.urlstr = @"http://www.ryhui.com/common/helpCenterView/newHelpQuery?type=recharge";
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
        [self addActionTarget:alert title:@"客服" color: [RHUtility colorForHex:@"555555"] action:^(UIAlertAction *action) {
            //
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
                         [[DQViewController Sharedbxtabar].tabBar setHidden:YES];
                        [self.navigationController setNavigationBarHidden:NO];
                        //[DQViewController Sharedbxtabar].tarbar.hidden = NO;
                        // [DQViewController Sharedbxtabar].tarbar.hidden = YES;
                        
                      //  self.secondview.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height+50);
                    });
                    
                }
                
                // 页面UI初始化完成，可以获取UIView，自定义UI
                if(type==ZCPageBlockLoadFinish){
                    
                    
                    [object.backButton setTitle:@"关闭" forState:UIControlStateNormal];
                    
                    
                    
                }
            } messageLinkClick:nil];
            NSLog(@"nicaicai");
        }];
        
    [self addCancelActionTarget:alert title:@"取消"];
        
    [self presentViewController:alert animated:YES completion:nil];
    }
}
-(void)addCancelActionTarget:(UIAlertController*)alertController title:(NSString *)title
{
    UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
//         self.controller3.alipaybtn.hidden = NO;
//        self.controller3.albtn2.hidden = NO;
        if ([self.stri isEqualToString:@"qq"]) {
            self.controller3.albtn2.hidden = NO;
        }
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

- (void)willPresentActionSheet:(UIActionSheet *)actionSheet {
    for (UIView *subViwe in actionSheet.subviews) {
        if ([subViwe isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)subViwe;
            label.font = [UIFont systemFontOfSize:16];
            label.frame = CGRectMake(CGRectGetMinX(label.frame), CGRectGetMinY(label.frame), CGRectGetWidth(label.frame), CGRectGetHeight(label.frame)+20);
            label.textColor = [UIColor redColor];
        }
//        if ([subViwe isKindOfClass:[UIButton class]]) {
//            UIButton *button = (UIButton*)subViwe;
//            if ([button.titleLabel.text isEqualToString:@"确定"]) {
//                [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//            } else {
//                [button setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
//            }
//            button.titleLabel.font = [UIFont systemFontOfSize:18];
//        }
    }
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        NSLog(@"11111");
        RHRechangejiluViewController *  vc = [[RHRechangejiluViewController alloc]initWithNibName:@"RHRechangejiluViewController" bundle:nil];
        
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }else if (buttonIndex == 1) {
        NSLog(@"22222");
      
    }else if(buttonIndex == 2) {
        NSLog(@"X");
    }
    
}


-(void)textFieldDidChange :(UITextField *)theTextField{
   // NSLog( @"text changed: %@", theTextField.text);
    if ([self.textField.text isEqualToString:@"0"]) {
        
        self.textField.text= @"";
        return;
    }
    
    NSString * str = [self.balanceLabel.text stringByReplacingOccurrencesOfString:@"," withString:@""];
    
    //actionsheet
    
    
    double  dbx = [str doubleValue];
    
    //dbx = [[NSString stringWithFormat:@"%.2f元",dbx] doubleValue ];
//    dbx = 
    if (dbx >0) {
        dbx = dbx + [self.textField.text doubleValue];
        
        self.houmoneylab.text = [NSString stringWithFormat:@"%.2lf",dbx];
        
    }else{
    dbx = dbx + [self.textField.text doubleValue];
   
    self.houmoneylab.text = [NSString stringWithFormat:@"%.2f",dbx];
    }
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:@"###,##0.00;"];
    NSString *formattedNumberString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble: [self.houmoneylab.text doubleValue] ]];
    
    //        self.moneylab.backgroundColor = [UIColor redColor];
    //        self.moneylab.frame = CGRectMake(CGRectGetMinX(self.moneylab.frame)-20, CGRectGetMinY(self.moneylab.frame), self.moneylab.frame.size.width+60, self.moneylab.frame.size.height);
    self.houmoneylab.text = formattedNumberString;
    //NSLog(@"%@",str);

}
-(void)viewWillAppear:(BOOL)animated
{
//    NSString * str = @"front/payment/account/myAccountData";
//    NSString * newstr = @"front/payment/appAccount/appMyAccountData";
    
    [DQViewController Sharedbxtabar].tarbar.hidden = YES;
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=NO;
    self.rechargeButton.userInteractionEnabled = YES;
//    [[RHNetworkService instance] POST:@"app/front/payment/account/countUnReadMessage" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        //        DLog(@"%@",responseObject);
//        if ([responseObject isKindOfClass:[NSDictionary class]]) {
//            NSString* numStr=nil;
//            if (![[responseObject objectForKey:@"msgCount"] isKindOfClass:[NSNull class]]) {
//                if ([[responseObject objectForKey:@"msgCount"] isKindOfClass:[NSNumber class]]) {
//                    numStr=[[responseObject objectForKey:@"msgCount"] stringValue];
//                }else{
//                    numStr=[responseObject objectForKey:@"msgCount"];
//                }
//            }
//            if (numStr) {
//                [[NSUserDefaults standardUserDefaults] setObject:numStr forKey:@"RHMessageNumSave"];
//                [[NSUserDefaults standardUserDefaults] synchronize];
//                [[NSNotificationCenter defaultCenter] postNotificationName:@"RHMessageNum" object:numStr];
//            }
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSURL *dic = [error.userInfo objectForKey:@"NSErrorFailingURLKey"];
//        
//        NSString *str = [dic absoluteString];
//        
//        if ([str rangeOfString:@"/common/user/login/index"].location != NSNotFound) {
////            self.rechargeButton.userInteractionEnabled = NO;
//        }
//    }];

    if ([self.stri isEqualToString:@"qq"]) {
        self.controller3.albtn2.hidden = NO;
    }
    if ([self.bankress isEqualToString:@"notBank"]) {
        [self didSelectSegmentAtIndex:1];
    }
    self.hidenlab2.frame = CGRectMake(51, 12, 279, 21);
    [self msgChange];
}

-(void)getBindCard
{
//    ／／front/payment/appAccount/appMyCards
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    
//    [[RHNetworkService instance] POST:@"front/payment/account/myCashDataForApp" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
////        DLog(@"%@",responseObject);
//        if ([responseObject isKindOfClass:[NSDictionary class]]) {
//            NSArray* array=nil;
//            if ([responseObject objectForKey:@"qpCard"]) {
//                array=[responseObject objectForKey:@"qpCard"];
//                if ([array isKindOfClass:[NSArray class]]&&[array count]>0) {
//                    isQpCard=YES;
//                    self.rechargeButton.userInteractionEnabled = YES;
//                }
//            }
//        }
//        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
//        
//    }];
}

- (IBAction)recharge:(id)sender {
    //111
    [self.textField resignFirstResponder];
    if ([self.bankcardlab.text isEqualToString:@"    首次快捷充值将接受银行验证绑定快捷卡"]) {
//        [RHUtility showTextWithText:@"请选择银行"];
//        return;
    }
    
    if ([self.textField.text length]<=0) {
        [RHUtility showTextWithText:@"请输入充值金额"];
        return;
    }else{
        if ([self.textField.text floatValue] <= 0) {
            [RHUtility showTextWithText:@"请输入正确金额"];
            return;
        }else if ([_textField.text floatValue] < 1.0 ){
            [RHUtility showTextWithText:@"充值金额应大于等于 1 元"];
            return;
        }
    }
    if (!isQpCard) {
        
        self.hidenview.hidden = NO;
        self.agreebtn.hidden = NO;
         [self.agreebtn setTitle:@"同意" forState:UIControlStateNormal];
//        RHBindCardViewController* contoller=[[RHBindCardViewController alloc] initWithNibName:@"RHBindCardViewController" bundle:nil];
//        contoller.amountStr=self.textField.text;
//        [self.navigationController pushViewController:contoller animated:YES];
    }else{
        
        
        RHRechargeWebViewController* controllers=[[RHRechargeWebViewController alloc]initWithNibName:@"RHRegisterWebViewController" bundle:nil];
        controllers.price=self.textField.text;
//        controllers.bankname = self.banklogo;
        [self.navigationController pushViewController:controllers animated:YES];
    }
    self.rechargeButton.userInteractionEnabled = NO;
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSCharacterSet *cs;
    NSString* str=@"0123456789.";
    cs = [[NSCharacterSet characterSetWithCharactersInString:str] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basicTest = [string isEqualToString:filtered];
    if(!basicTest)
    {
        return NO;
    }
    
    NSString* result=[NSString stringWithFormat:@"%@%@",textField.text,string];
    NSArray* array=[result componentsSeparatedByString:@"."];
    if (array&&[array count]>2) {
        return NO;
    }
    NSRange ranges=[result rangeOfString:@"."];
    if (ranges.location!=NSNotFound) {
        NSString* temp=[result substringFromIndex:ranges.location+1];
//        DLog(@"%@",temp);
        if ([temp length]>2) {
            return NO;
        }
    }
    return YES;
}
-(void)touchdid{
    RHMoreWebViewViewController * vc = [[RHMoreWebViewViewController alloc]initWithNibName:@"RHMoreWebViewViewController" bundle:nil];
    vc.namestr = @"支持银行";
    vc.urlstr = [NSString stringWithFormat:@"%@bindKJCard",[RHNetworkService instance].newdoMain];
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.textField resignFirstResponder];
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.view];
    if (CGRectContainsPoint(_xianelab.frame, touchPoint)) {
        
        
        
        //http://www.ryhui.com/bindKJCard
        
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
   
   // [self.view removeFromSuperview];
    for (UIView *subView in [UIApplication sharedApplication].keyWindow.subviews) {
        if (subView.tag == 1000) {
            [subView removeFromSuperview];
        }
    }
     self.controller3.alipaybtn.hidden = YES;
    self.controller3.albtn2.hidden = YES;
    self.hidenlab2.hidden = YES;
    [super viewWillDisappear:animated];
}

- (IBAction)tishi:(id)sender {
    
    self.hidenview.hidden = NO;
//    self.agreebtn.hidden = YES;
    [self.agreebtn setTitle:@"关闭" forState:UIControlStateNormal];
}

- (IBAction)disapper:(id)sender {
    self.hidenview.hidden = YES;
    self.rechargeButton.userInteractionEnabled = YES;
    
}

- (IBAction)tongyitishi:(id)sender {
    
    UIButton * btn = sender;
    
    if ([btn.titleLabel.text isEqualToString:@"关闭"]) {
        
        
    }else{
    
    //self.hidenview.hidden = YES;
    
    RHRechargeWebViewController* controllers=[[RHRechargeWebViewController alloc]initWithNibName:@"RHRegisterWebViewController" bundle:nil];
    controllers.price=self.textField.text;
    controllers.bankname = self.banklogo;
    [self.navigationController pushViewController:controllers animated:YES];
        self.rechargeButton.userInteractionEnabled = YES;
    }
    self.hidenview.hidden = YES;
   // RHBindCardViewController* contoller=[[RHBindCardViewController alloc] initWithNibName:@"RHBindCardViewController" bundle:nil];
//    contoller.amountStr=self.textField.text;
////
//    [self.navigationController pushViewController:contoller animated:YES];
    
}

-(void)getbankcard{
    
    [[RHNetworkService instance] POST:@"app/front/payment/appAccount/appMyCards" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        DLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSArray * array1 = responseObject[@"cards"];
//            NSString * str = responseObject[@"cards"][0][1];
//            NSString * str1 = responseObject[@"cards"][0][0];
            
            for (NSArray * arra in array1) {
                if (![arra[2]isKindOfClass:[NSNull class]]|| !arra[2]) {
                    if ([arra[2] isEqualToString:@"QP"]) {
                        NSString * str ;
                        if (![arra[1] isKindOfClass:[NSNull class]]) {
                            str = arra[1];
                        }else{
                            str= @"";
                        }
                        
//                        NSString * str1 = arra[0];
                        NSLog(@"------");
                        self.dbxaimage.hidden = YES;
//                        self.xzbankcard.userInteractionEnabled = NO;
                        isQpCard=YES;
                        NSArray * array = @[@"ABC",@"CCB",@"BOC",@"CEB",@"CIB",@"CITIC",@"PINGAN",@"BOS",@"CBHB",@"PSBC",@"SPDB",@"ICBC",@"BCM",@"CMBC",@"GDB"];
                      if (arra.count>3) {
                        if (![arra[3] isKindOfClass:[NSNull class]]&&arra[3]) {
                            self.banklogo = arra[3];
                        }else{
                            self.banklogo = @"";
                        }
                      }else{
                          self.banklogo = @"";
                      }
//                        NSInteger index = [array indexOfObject:str1];
//                        switch (index) {
//                            case 0:
//                                str1 = @"农业银行";
//                                break;
//                            case 1:
//                                str1 = @"建设银行";
//                                break;
//                            case 2:
//                                str1 = @"中国银行";
//                                break;
//                            case 3:
//                                str1 = @"光大银行";
//                                break;
//                            case 4:
//                                str1 = @"兴业银行";
//                                break;
//                            case 5:
//                                str1 = @"中信银行";
//                                break;
//                            case 6:
//                                str1 = @"平安银行";
//                                break;
//                            case 7:
//                                str1 = @"上海银行";
//                                break;
//                            case 8:
//                                str1 = @"渤海银行";
//                                break;
//                            case 9:
//                                str1 = @"邮储银行";
//                                break;
//                            case 10:
//                                str1 = @"浦发银行";
//                                break;
//                            case 11:
//                                str1 = @"工商银行";
//                                break;
//                            case 12:
//                                str1 = @"交通银行";
//                                break;
//                            case 13:
//                                str1 = @"民生银行";
//                                break;
//                            case 14:
//                                str1 = @"广发银行";
//                                break;
//                                
//                            default:
//                                break;
//                        }
                        
                        
                        NSString * laststr = [str substringFromIndex:str.length - 4];
                        NSString * firststr = [str substringToIndex:4];
                        
                        
                        
                        self.bankcardlab.text = [NSString stringWithFormat:@"   %@ %@****%@",self.banklogo,firststr,laststr];
                        // self.dbxaimage.hidden = YES;
                        
                        self.kuaijie.hidden = NO;
                        self.rechargeButton.userInteractionEnabled = YES;
                        NSLog(@"%@",str);
                    }else{
                        
                        NSLog(@"=======");
                    }
                }else{
                    
                    NSLog(@"=======");
                }
                
            }
            
        }
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //[MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    }];
    
    
}


- (void)getbankid{
    
    
    if (self.res) {
        self.tableView.hidden = YES;
        self.dbxaimage.image = [UIImage imageNamed:@"down"];
        self.res = NO;
        return;
    }
    self.dbxaimage.image = [UIImage imageNamed:@"sjt"];
    self.tableView.hidden = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.res = YES;
    
    
     [[RHNetworkService instance] POST:@"app/back/archives/appBank/appGetBankJSON" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
         
         if ([responseObject isKindOfClass:[NSDictionary class]]) {
             self.keyArray = [responseObject[@"1"] allKeys];
             
             for (NSString * key in self.keyArray) {
                 [self.dataArray addObject:responseObject[@"1"][key]];
             }
             
             self.tableView.hidden = NO;
             [self.tableView reloadData];
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         ;
     }];
    
}





-(NSArray *)keyArray{
    
    
    if (!_keyArray) {
        _keyArray = [NSArray array];
    }
    return _keyArray;
}

-(NSArray *)dataArray{
    
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
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
    
    [self.controller1 respfirsttf];
    if (page ==1) {
        [self wanyinbtn:nil];
       // [self segentsecondbtn:nil];
    }else if (page ==2){
        [self alipaybtn:nil];
     //   [self segntthreebtn:nil];
    }else{
   //     [self segntonebtn:nil];
        [self kaujiebtn:nil];
    }
    //    [self didSelectSegmentAtIndex:page];
}

- (IBAction)kaujiebtn:(id)sender {
    
    if ([self.bankress isEqualToString:@"notBank"]) {
        [self.controller1 respfirsttf];
       // RHBngkCardDetailViewController * controller = [[RHBngkCardDetailViewController alloc]initWithNibName:@"RHBngkCardDetailViewController" bundle:nil];
        
       // controller.ress = self.bankress;
       // [self.navigationController pushViewController:controller animated:YES];
        
        [self.controller1 hidenbankcard];
        self.controller1.bankress = self.bankress;
        return;
    }
    
    self.segmentView2.hidden = YES;
    self.segmentView3.hidden = YES;
    self.segmentView1.hidden = NO;
    // NSLog(@"cbxcbx");
    [self didSelectSegmentAtIndex:0];
    self.controller3.alipaybtn.hidden = YES;
    self.controller3.albtn2.hidden = YES;
    self.stri  =@"ww";
    [self.controller1 respfirsttf];
}

- (IBAction)wanyinbtn:(id)sender {
    self.segmentView2.hidden = NO;
    self.segmentView3.hidden = YES;
    self.segmentView1.hidden = YES;
    // NSLog(@"cbxcbx");
    [self didSelectSegmentAtIndex:1];
    self.controller3.alipaybtn.hidden = YES;
    self.controller3.albtn2.hidden = YES;
    self.stri  =@"ww";
    [self.controller1 respfirsttf];
}
- (IBAction)alipaybtn:(id)sender {
    self.segmentView2.hidden = YES;
    self.segmentView3.hidden = NO;
    self.segmentView1.hidden = YES;
    // NSLog(@"cbxcbx");
    [self didSelectSegmentAtIndex:2];
    self.controller3.alipaybtn.hidden = NO;
    self.controller3.albtn2.hidden = NO;
    
    self.stri  =@"qq";
    [self.controller1 respfirsttf];
}
- (IBAction)guanbilunbo:(id)sender {
   // self.segmentContentView = [[RHSegmentContentView alloc] initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].applicationFrame.size.height-50-self.navigationController.navigationBar.frame.size.height)];
    
    self.segmentView1.frame = CGRectMake(0, 2, [UIScreen mainScreen].bounds.size.width,50);
    self.segmentView2.frame = CGRectMake(0, 2, [UIScreen mainScreen].bounds.size.width,50);
    self.segmentView3.frame = CGRectMake(0, 2, [UIScreen mainScreen].bounds.size.width,50);
    self.segmentContentView.frame = CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].applicationFrame.size.height-50-self.navigationController.navigationBar.frame.size.height);
    
    
    self.hidenbtn1.hidden = YES;
    self.hidenbtn2.hidden = YES;
    self.hidenlab1.hidden = YES;
    self.hidenlab2.hidden = YES;
    self.hidenimage1.hidden = YES;
    self.hideniaamge2.hidden = YES;
    
    self.controller3.myblock();
//    self.controller3.alipaybtn.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-40, [UIScreen mainScreen].bounds.size.width, 40);
}

-(void)getregchagenews{
    NSDictionary* parameters=@{@"type":@"recharge"};
    
    [[RHNetworkService instance] POST:@"app/common/appMain/appPagePrompt" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        DLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
           
            NSLog(@"%@",responseObject);
            
            if (![responseObject[@"message"] isKindOfClass:[NSNull class]]&&responseObject) {
             
          
            if (responseObject[@"message"][@"summary"]) {
                NSLog(@"%@",responseObject[@"message"][@"summary"]);
                
                self.hidenlab2.text  = [NSString stringWithFormat:@"%@",responseObject[@"message"][@"summary"]];
                
//                CGRect frame = self.hidenlab2.frame;
//                frame.origin.x = -180;
//                self.hidenlab2.frame = frame;
//                [UIView beginAnimations:@"testAnimation"context:NULL];
//                [UIView setAnimationDuration:8.8f];
//                [UIView setAnimationCurve:UIViewAnimationCurveLinear];
//                [UIView setAnimationDelegate:self];
//                [UIView setAnimationRepeatAutoreverses:NO];
//                [UIView setAnimationRepeatCount:999999];
//                frame = self.hidenlab2.frame;
//                frame.origin.x =350;
//                self.hidenlab2.frame = frame;
//                [UIView commitAnimations];
                
                
                [self msgChange];
                
               //从第一条开始显示
            
                
                self.guizelab1.text  = [NSString stringWithFormat:@"%@",responseObject[@"message"][@"title"]];
                self.guizelab2.text  = @"";
                self.guizelab3.text  = [NSString stringWithFormat:@"%@",responseObject[@"message"][@"content"]];
                
                CGSize size = [self.guizelab1 sizeThatFits:CGSizeMake(self.guizelab1.frame.size.width, MAXFLOAT)];
                self.guizelab1.frame = CGRectMake(self.guizelab1.frame.origin.x, self.guizelab1.frame.origin.y, self.guizelab1.frame.size.width,      size.height);
                CGSize size1 = [self.guizelab2 sizeThatFits:CGSizeMake(self.guizelab1.frame.size.width, MAXFLOAT)];
                self.guizelab2.frame = CGRectMake(self.guizelab2.frame.origin.x, CGRectGetMaxY(self.guizelab1.frame)+10, self.guizelab2.frame.size.width,      size1.height);
                CGSize size2 = [self.guizelab3 sizeThatFits:CGSizeMake(self.guizelab3.frame.size.width, MAXFLOAT)];
               // self.guizelab3.frame = CGRectMake(self.guizelab3.frame.origin.x, CGRectGetMaxY(self.guizelab1.frame)+10, self.guizelab3.frame.size.width,      size2.height);
                
                
                CGSize titleSize = [self.guizelab3.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
                self.guizelab3.frame = CGRectMake(self.guizelab3.frame.origin.x, self.guizelab3.frame.origin.y, self.guizelab3.frame.size.width, size2.height);
                
                
                self.tishiscorlview.contentSize=CGSizeMake(self.tishiscorlview.frame.size.width,CGRectGetMaxY(self.guizelab3.frame)+60);
            }
            }else{
                
                [self guanbilunbo:nil];
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //[MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    }];
    
    
}
- (IBAction)didlunbo:(id)sender {
    self.hidenmengban.hidden = NO;
    self.hidenguize.hidden = NO;
}


- (void)msgChange {
    CGSize titleSize = [self.hidenlab2.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    self.hidenlab2.frame = CGRectMake(self.hidenlab2.frame.origin.x, self.hidenlab2.frame.origin.y, titleSize.width+100, self.hidenlab2.frame.size.height);
    
    CGRect frame = self.hidenlab2.frame;
    frame.origin.x = [UIScreen mainScreen].bounds.size.width;
    self.hidenlab2.frame = frame;
    
    [UIView beginAnimations:@"scrollLabelTest" context:NULL];
    [UIView setAnimationDuration:15.0f];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView setAnimationRepeatCount:999999];
    
    frame = self.hidenlab2.frame;
    frame.origin.x = -frame.size.width;
    self.hidenlab2.frame = frame;
    [UIView commitAnimations];
    
   
//    self.controller3.alipaybtn.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-40-200, [UIScreen mainScreen].bounds.size.width, 40);
    
    
}

- (IBAction)guanbi:(id)sender {
    
    self.hidenguize.hidden = YES;
    self.hidenmengban.hidden = YES;
    
}

@end
