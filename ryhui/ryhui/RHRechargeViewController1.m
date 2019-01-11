//
//  RHRechargeViewController.m
//  ryhui
//
//  Created by stefan on 15/3/15.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHRechargeViewController1.h"
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
#import "RHzhuanzhangViewController1.h"
#import "RHALpayViewController.h"
#import "RHBngkCardDetailViewController.h"

@interface RHRechargeViewController1 ()<UIActionSheetDelegate,UITableViewDelegate,UITableViewDataSource,RHSegmentContentViewDelegate>
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
@property(nonatomic,strong)RHzhuanzhangViewController1*controller2;
@property(nonatomic,strong)RHALpayViewController*controller3;
@end

@implementation RHRechargeViewController1
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
    
    
    UIButton*rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,30,30)];
    [rightButton setImage:[UIImage imageNamed:@"更多.png"]forState:UIControlStateNormal];
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
    
    
    
    
    
    
    
    
    
    
    self.segmentContentView = [[RHSegmentContentView alloc] initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].applicationFrame.size.height-50-self.navigationController.navigationBar.frame.size.height)];
    
    [_segmentContentView setDelegate:self];
    [self.secondview addSubview:_segmentContentView];
    
    self.secondview.frame = CGRectMake(0, 0, self.view.frame.size.width, [UIScreen mainScreen].bounds.size.height+50);
    
    [self.view addSubview:self.secondview];
    
    [self getsegmentviewcontrol];
    
   // [self didSelectSegmentAtIndex:2];
    self.controller3.alipaybtn.hidden = YES;
    
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
    
    self.controller2=[[RHzhuanzhangViewController1 alloc]initWithNibName:@"RHzhuanzhangViewController1" bundle:nil];
    self.controller2.bankdic = self.bankdic;
    [_viewControllers addObject:_controller2];
   
    
    self.controller3=[[RHALpayViewController alloc]initWithNibName:@"RHALpayViewController" bundle:nil];
    self.controller3.alipaybtn.hidden = YES;
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
    
    float  versonfl = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (versonfl < 8.3) {
        
    
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"充值记录", @"充值帮助",nil];
    

    
    
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

    
    if ([self.bankress isEqualToString:@"notBank"]) {
        [self didSelectSegmentAtIndex:1];
    }
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
   
    for (UIView *subView in [UIApplication sharedApplication].keyWindow.subviews) {
        if (subView.tag == 1000) {
            [subView removeFromSuperview];
        }
    }
     self.controller3.alipaybtn.hidden = YES;
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
    
    [self.controller1 respfirsttf];
}

- (IBAction)wanyinbtn:(id)sender {
    self.segmentView2.hidden = NO;
    self.segmentView3.hidden = YES;
    self.segmentView1.hidden = YES;
    // NSLog(@"cbxcbx");
    [self didSelectSegmentAtIndex:1];
    self.controller3.alipaybtn.hidden = YES;
    [self.controller1 respfirsttf];
}
- (IBAction)alipaybtn:(id)sender {
    self.segmentView2.hidden = YES;
    self.segmentView3.hidden = NO;
    self.segmentView1.hidden = YES;
    // NSLog(@"cbxcbx");
    [self didSelectSegmentAtIndex:2];
    self.controller3.alipaybtn.hidden = NO;
    [self.controller1 respfirsttf];
}


@end
