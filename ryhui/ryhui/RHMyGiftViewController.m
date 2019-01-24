 //
//  RHMyGiftViewController.m
//  ryhui
//
//  Created by jufenghudong on 15/4/14.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHMyGiftViewController.h"
#import "RHMyGiftContentViewController.h"
#import "RHCashCardViewController.h"
#import "RHmainModel.h"
#import <objc/runtime.h>
#import "RHRegisterWebViewController.h"
#import "RHMoreWebViewViewController.h"
#import "RHhelper.h"
#import "RHOpenCountViewController.h"
#import "MBProgressHUD.h"
@interface RHMyGiftViewController ()<UIActionSheetDelegate>

@property(nonatomic,strong)RHSegmentContentView* segmentContentView;
@property(nonatomic,strong)NSMutableArray* viewControllers;
@property (weak, nonatomic) IBOutlet UIView *segmentView1;
@property (weak, nonatomic) IBOutlet UIView *segmentView2;
@property (weak, nonatomic) IBOutlet UIView *segmentView3;

@property (weak, nonatomic) IBOutlet UILabel *cashcardlab;
@property (weak, nonatomic) IBOutlet UIImageView *cashcardimage;
@property (weak, nonatomic) IBOutlet UIButton *CashCardbutton;
@property (weak, nonatomic) IBOutlet UIView *alterview;
@property(nonatomic,strong)UIButton * buttonbtn;
@property (weak, nonatomic) IBOutlet UIButton *yuanbtn;
@property (weak, nonatomic) IBOutlet UIView *mengbanview;
@property (weak, nonatomic) IBOutlet UIView *kaihuview;
@property (weak, nonatomic) IBOutlet UIView *SegmentView4;

@property (weak, nonatomic) IBOutlet UILabel *duihuancountlab;

@property (weak, nonatomic) IBOutlet UIView *duihuanview;



@property(nonatomic,copy)NSString * mygiftcount;
@end

@implementation RHMyGiftViewController
@synthesize segmentContentView=_segmentContentView;
@synthesize viewControllers=_viewControllers;

- (void)viewDidLoad {
    [self getduixiancount];
    
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    [super viewDidLoad];
    self.viewControllers=[[NSMutableArray alloc]initWithCapacity:0];
    self.kaihuview.hidden = YES;
    self.mengbanview.hidden = YES;
    self.duihuanview.hidden = YES;
    [RYHViewController Sharedbxtabar].tarbar.hidden = YES;
    [self configBackButton];
    [self configTitleWithString:@"我的红包"];
    [self.yuanbtn.layer  setMasksToBounds:YES];
    [self.yuanbtn.layer setCornerRadius:12.0];
    //CGFloat w = [UIScreen mainScreen].bounds.size.width;
    
    self.buttonbtn = [[UIButton alloc]init];
//    self.buttonbtn.frame = CGRectMake(0,[UIScreen mainScreen].bounds.size.height - 69 , [UIScreen mainScreen].bounds.size.width, 50);
    
    [self.view addSubview:self.buttonbtn];
   // self.buttonbtn.backgroundColor = [UIColor redColor];
    [[UIApplication sharedApplication].keyWindow addSubview:self.buttonbtn];
    [self.buttonbtn addTarget:self action:@selector(hiddened:) forControlEvents:UIControlEventTouchUpInside];
    
    self.buttonbtn.hidden = YES;
    self.alterview.hidden = YES;
    UIButton*rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,30,30)];
    
//    UIButton*rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,30,30)];
    [rightButton setImage:[UIImage imageNamed:@"More"]forState:UIControlStateNormal];
//    [rightButton addTarget:self action:@selector(chongzhi)forControlEvents:UIControlEventTouchUpInside];
    
//    [rightButton setImage:[UIImage imageNamed:@"gengduo.png"]forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(help)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    
    //    [btn setTitle:@""];
    //
    //
    //    [btn setTintColor:[RHUtility colorForHex:@"#44bbc1"]];
    //btn.image = [UIImage imageNamed:@"gengduo"];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
//    self.cashcardimage.frame = CGRectMake(w/ 2 -60, 41, 21, 18);
//    self.CashCardbutton.frame = CGRectMake(0, 41, w, 18);
    self.segmentContentView = [[RHSegmentContentView alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].applicationFrame.size.height-50-30-self.navigationController.navigationBar.frame.size.height+40)];
//    DLog(@"%f----%f",[UIScreen mainScreen].applicationFrame.size.height-50-40-self.navigationController.navigationBar.frame.size.height,self.navigationController.navigationBar.frame.size.height);
    [_segmentContentView setDelegate:self];
    [self.view addSubview:_segmentContentView];

    
    RHMyGiftContentViewController* controller1=[[RHMyGiftContentViewController alloc]init];
    controller1.nav=self.navigationController;
    controller1.type=@"app/front/payment/appGift/appMyInitGiftListData";
    controller1.myblock = ^{
        
        [self kaihu];
    };
    [_viewControllers addObject:controller1];
    
    RHMyGiftContentViewController* controller4=[[RHMyGiftContentViewController alloc]init];
    controller4.nav=self.navigationController;
    controller4.type=@"app/front/payment/appGift/myCanCashGiftListDataWebForApp";
    [_viewControllers addObject:controller4];
    
    RHMyGiftContentViewController* controller2=[[RHMyGiftContentViewController alloc]init];
    controller2.nav=self.navigationController;
    controller2.type=@"app/front/payment/appGift/appMyUsedGiftListData";
    [_viewControllers addObject:controller2];
    
    RHMyGiftContentViewController* controller3=[[RHMyGiftContentViewController alloc]init];
    controller3.nav=self.navigationController;
    controller3.type=@"app/front/payment/appGift/appMyPastGiftListData";
    [_viewControllers addObject:controller3];
    
    
  
    
    [_segmentContentView setViews:_viewControllers];
    
    [self segmentContentView:_segmentContentView selectPage:0];
    
  
//    NSDictionary *attributes = @{NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]};
//    NSMutableAttributedString *netString = [[NSMutableAttributedString alloc] initWithString:_cashcardlab.text];
//    [netString addAttributes:attributes range:NSMakeRange(0, netString.length)];
//    _cashcardlab.attributedText = netString;

//    self.cashcardimage.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2 - 65, 41, 21, 18);
//    self.cashcardlab.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2 - 29, 41, 97, 18);
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
-(void)back
{
    if ([RHhelper ShraeHelp].giftres ==2) {
         self.myblock();
        [RHhelper ShraeHelp].giftres =3;
    }
   
    [self.navigationController popToRootViewControllerAnimated:NO];
}

-(void)help{
    
    
    
     float  versonfl = [[[UIDevice currentDevice] systemVersion] floatValue];
     if (versonfl < 8.3) {
         
         
         
         UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                       initWithTitle:nil
                                       delegate:self
                                       cancelButtonTitle:@"取消"
                                       destructiveButtonTitle:nil
                                       otherButtonTitles:@"如何获取红包", @"红包使用帮助",nil];
         
         
         
         
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
//         [self addActionTarget:alert title:@"如何获取红包" color: [RHUtility colorForHex:@"555555"] action:^(UIAlertAction *action) {
//             NSLog(@"nicaicai");
//
//         }];
         [self addActionTarget:alert title:@"红包使用帮助" color: [RHUtility colorForHex:@"555555"] action:^(UIAlertAction *action) {
             RHMoreWebViewViewController * vc = [[RHMoreWebViewViewController alloc]initWithNibName:@"RHMoreWebViewViewController" bundle:nil];
             vc.namestr = @"红包使用帮助";
             vc.urlstr = @"http://www.ryhui.com/common/helpCenterView/newHelpQuery?type=gift";
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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.view];
    
    if (CGRectContainsPoint(_cashcardlab.frame, touchPoint)) {
        _cashcardlab.textColor = [UIColor whiteColor];
    }
    _cashcardlab.textColor = [UIColor colorWithRed:57/255.0 green:109/255.0 blue:185/255.0 alpha:1];
    
}
-(void)dealloc{
    
   // [super dealloc];
    
    self.buttonbtn.hidden = YES;
    
}
- (IBAction)cardmoney:(id)sender {
    
    RHCashCardViewController * CashCardVC = [[RHCashCardViewController alloc]initWithNibName:@"RHCashCardViewController" bundle:nil];
    CashCardVC.res = YES;
    
    [self.navigationController pushViewController:CashCardVC animated:YES];
}
//-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
//    
//
//    RHCashCardViewController * CashCardVC = [[RHCashCardViewController alloc]initWithNibName:@"RHCashCardViewController" bundle:nil];
//    CashCardVC.res = YES;
//    
//    [self.navigationController pushViewController:CashCardVC animated:YES];
//    
//}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //[self.view removeFromSuperview];
    // [[UIApplication sharedApplication].keyWindow addSubview:self.alterview];
  
    if ([[RHmainModel ShareRHmainModel].maintest isEqualToString:@"hehe"]) {
        
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
    
    self.navigationController.navigationBar.hidden=NO;
     [self initData];
    [self segmentAction1:nil];
    //[self viewDidLoad];
    
   // [self viewDidAppear:YES];
    [self segmentContentView:_segmentContentView selectPage:0];
    [RYHViewController Sharedbxtabar].tarbar.hidden = YES;
}

-(void)initData
{
    self.segmentView1.hidden=NO;
    self.segmentView2.hidden=YES;
    self.segmentView3.hidden=YES;
}
- (IBAction)segmentAction4:(id)sender {
    
    self.segmentContentView.frame = CGRectMake(0, 80, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].applicationFrame.size.height-50 - 60 -self.navigationController.navigationBar.frame.size.height);
    self.segmentView1.hidden=YES;
    self.segmentView2.hidden=YES;
    self.segmentView3.hidden=YES;
    self.SegmentView4.hidden=NO;
    [self didSelectSegmentAtIndex:1];
}


- (IBAction)segmentAction1:(id)sender {

    self.segmentContentView.frame = CGRectMake(0, 60, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].applicationFrame.size.height-50 - 30 -self.navigationController.navigationBar.frame.size.height);
    self.segmentView1.hidden=NO;
    self.segmentView2.hidden=YES;
    self.segmentView3.hidden=YES;
    self.SegmentView4.hidden=YES;
    [self didSelectSegmentAtIndex:0];
}

- (IBAction)segmentAction2:(id)sender {
    self.segmentContentView.frame = CGRectMake(0, 30, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].applicationFrame.size.height-50-self.navigationController.navigationBar.frame.size.height);
    self.segmentView1.hidden=YES;
    self.segmentView2.hidden=NO;
    self.segmentView3.hidden=YES;
    self.SegmentView4.hidden=YES;
    [self didSelectSegmentAtIndex:2];
}

- (IBAction)segmentAction3:(id)sender {
    self.segmentContentView.frame = CGRectMake(0, 30, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].applicationFrame.size.height-50-self.navigationController.navigationBar.frame.size.height);
    self.segmentView1.hidden=YES;
    self.segmentView2.hidden=YES;
    self.segmentView3.hidden=NO;
    self.SegmentView4.hidden=YES;
    [self didSelectSegmentAtIndex:3];
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

- (void)didSelectSegmentAtIndex:(int)index
{
    [_segmentContentView setSelectPage:index];
    
}

- (void)segmentContentView:(RHSegmentContentView *)segmentContentView selectPage:(NSUInteger)page{
    switch (page) {
        case 0:
            [self segmentAction1:nil];
            break;
        case 1:
            [self segmentAction4:nil];
            break;
        case 2:
            [self segmentAction2:nil];
            break;
        case 3:
            [self segmentAction3:nil];
            break;
        default:
            break;
    }
    
    RHMyGiftContentViewController* controller=[_viewControllers objectAtIndex:page];
    [controller.dataArray removeAllObjects];
    if ([[NSNumber numberWithInteger:[controller.dataArray count]] intValue]<=0) {
        [controller startPost];
    }
}


- (IBAction)Cashcarddid:(id)sender {
    
    RHCashCardViewController * CashCardVC = [[RHCashCardViewController alloc]initWithNibName:@"RHCashCardViewController" bundle:nil];
    CashCardVC.res = YES;
    
    [self.navigationController pushViewController:CashCardVC animated:YES];
    
}
- (IBAction)hiddened:(id)sender {
    
    self.alterview.hidden = YES;
    self.buttonbtn.hidden = YES;
}

- (IBAction)helped:(id)sender {
    self.alterview.hidden = YES;
    self.buttonbtn.hidden = YES;
}
- (IBAction)getgift:(id)sender {
    self.alterview.hidden = YES;
    self.buttonbtn.hidden = YES;
}

- (void)kaihu{
    
    self.kaihuview.hidden = NO;
    self.mengbanview.hidden = NO;
    [[UIApplication sharedApplication].keyWindow addSubview:self.mengbanview];
    [[UIApplication sharedApplication].keyWindow addSubview:self.kaihuview];
    
//    NSLog(@"11111");
    
}
- (IBAction)hidenkaihu:(id)sender {
    self.mengbanview.hidden = YES;
    self.kaihuview.hidden = YES;
}
- (IBAction)kaihu:(id)sender {
    
    self.mengbanview.hidden = YES;
    self.kaihuview.hidden = YES;
//    [RYHViewController Sharedbxtabar].tarbar.hidden = YES;
    RHOpenCountViewController* controller1=[[RHOpenCountViewController alloc]initWithNibName:@"RHOpenCountViewController" bundle:nil];
    [self.navigationController pushViewController:controller1 animated:YES];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.buttonbtn.hidden = YES;
    NSLog(@"1222222222222222");
}
- (IBAction)quanbuduihuan:(id)sender {
   
    if ([self.mygiftcount isEqualToString:@"0"]) {
        [RHUtility showTextWithText:@"没有可兑现奖励"];
    }else{
        [[UIApplication sharedApplication].keyWindow addSubview:self.mengbanview];
        [[UIApplication sharedApplication].keyWindow addSubview:self.duihuanview];
        self.mengbanview.hidden = NO;
        self.duihuanview.hidden = NO;
    }
    
}

-(void)getduixiancount{
    
    [[RHNetworkService instance] POST:@"app/front/payment/appProjectListArchives/getGiftInfo" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        DLog(@"%@",responseObject);
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            if (responseObject[@"count"]&& ![responseObject[@"count"] isKindOfClass:[NSNull class]]) {
                self.mygiftcount = [NSString stringWithFormat:@"%@",responseObject[@"count"]];
            }
            if (responseObject[@"total"]&& ![responseObject[@"total"] isKindOfClass:[NSNull class]]) {
                self.duihuancountlab.text = [NSString stringWithFormat:@"您共有%@个奖励可兑现，总额%@元",self.mygiftcount,responseObject[@"total"]];
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


- (IBAction)guanbiduihuan:(id)sender {
    self.mengbanview.hidden = YES;
    self.duihuanview.hidden = YES;
}

- (IBAction)querenduihuanbtn:(id)sender {
    
    self.mengbanview.hidden = YES;
    self.duihuanview.hidden = YES;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[RHNetworkService instance] POST:@"app/front/payment/appProjectListArchives/useAllGiftForApp" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        DLog(@"%@",responseObject);
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            [self getduixiancount];
            if ([responseObject[@"msg"] isEqualToString:@"成功"]) {
                
                NSString * str = [NSString stringWithFormat:@"%@",responseObject[@"total"]];
                if ([str isEqualToString:@"0"]) {
                    [RHUtility showTextWithText:@"兑换失败,请重试"];
                    NSNotification * notice = [NSNotification notificationWithName:@"relodata" object:nil userInfo:@{@"1":@"123"}];
                    //发送消息
                    [[NSNotificationCenter defaultCenter]postNotification:notice];
                    
                }else{
                    
                    [RHUtility showTextWithText:[NSString stringWithFormat:@"%@个红包兑现成功,兑换金额为%@元",responseObject[@"count"],responseObject[@"total"]]];
                    NSNotification * notice = [NSNotification notificationWithName:@"relodata" object:nil userInfo:@{@"1":@"123"}];
                    //发送消息
                    [[NSNotificationCenter defaultCenter]postNotification:notice];
                }
                
            }else{
                
                [RHUtility showTextWithText:@"兑换失败,请重试"];
            }
        }
         [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
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

@end
