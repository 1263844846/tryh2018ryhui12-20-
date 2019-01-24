//
//  RHFriendViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 16/4/15.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import "RHFriendViewController.h"
//#import <ShareSDK/ShareSDK.h>
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKUI/SSUIShareActionSheetStyle.h>
#import "WXApi.h"
#import "WeiboSDK.h"
#import "RHMyFriendViewController.h"
#import "RHGZdetailViewController.h"
#import <objc/runtime.h>
#import "RHOfficeNetAndWeiBoViewController.h"
@interface RHFriendViewController ()<UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UIView *mengbanView;
@property (weak, nonatomic) IBOutlet UIView *tishiView;
@property (weak, nonatomic) IBOutlet UIView *hidenView;
@property (weak, nonatomic) IBOutlet UILabel *myInvitationcodelab;
@property (weak, nonatomic) IBOutlet UILabel *mygiftmoney;
@property (weak, nonatomic) IBOutlet UILabel *mygiftlab;
@property (weak, nonatomic) IBOutlet UIButton *smallbtn;
@property (weak, nonatomic) IBOutlet UIImageView *hidenimage;
@property (weak, nonatomic) IBOutlet UILabel *hindenlab;

@property (weak, nonatomic) IBOutlet UIView *shareview;

@property (weak, nonatomic) IBOutlet UIImageView *shareimage1;
@property (weak, nonatomic) IBOutlet UIImageView *sahreiamge2;
@property (weak, nonatomic) IBOutlet UIImageView *shareiamge3;
@property (weak, nonatomic) IBOutlet UIImageView *shareimage4;
@property(nonatomic,assign)CGPoint center;
@property(nonatomic,assign)CGPoint center1;
@property(nonatomic,assign)CGPoint center2;
@property(nonatomic,assign)CGPoint center3;
@property (weak, nonatomic) IBOutlet UILabel *lab1;
@property (weak, nonatomic) IBOutlet UILabel *lab2;

@property (weak, nonatomic) IBOutlet UILabel *lab3;
@property (weak, nonatomic) IBOutlet UILabel *lab4;

@property(nonatomic,strong)NSTimer* timer;

@property (weak, nonatomic) IBOutlet UILabel *peoplelab;

@property (weak, nonatomic) IBOutlet UILabel *ljmoneylab;


@end

@implementation RHFriendViewController

- (void)viewDidLoad {
    
    self.mengbanView.hidden = YES;
    self.tishiView.hidden = YES;
    [super viewDidLoad];
    [self configTitleWithString:@"邀请好友"];
    [self configBackButton];
    [self getright:@"邀请记录" action:@selector(jilu)];
    [[UIApplication sharedApplication].keyWindow addSubview:self.shareview];
    self.shareview.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-220, [UIScreen mainScreen].bounds.size.width, 220);
    self.shareview.hidden = YES;
    
    if ([UIScreen mainScreen].bounds.size.height >570) {
        self.hidenView.hidden = YES;
    }
    if ([UIScreen mainScreen].bounds.size.height < 481){
        
        self.hindenlab.hidden = YES;
        self.hidenimage.hidden = YES;
        self.smallbtn.frame = CGRectMake(40, 440, 240, 40);
        
        [[UIApplication sharedApplication].keyWindow addSubview:self.smallbtn];
    }
    [self getloaddata];
    
    
    CGPoint center = self.shareimage1.center ;
    
    
    center.y += [UIScreen mainScreen].bounds.size.height-400;
    
    
    self.shareimage1.center = center;
    self.lab1.center = center;
    CGPoint center1 = self.sahreiamge2.center ;
    
    
    center1.y += [UIScreen mainScreen].bounds.size.height-400;
    
    
    self.sahreiamge2.center = center1;
    self.lab2.center = center1;
    CGPoint center2 = self.shareiamge3.center ;
    
    
    center2.y += [UIScreen mainScreen].bounds.size.height-400;
    
    
    self.shareiamge3.center = center2;
    self.lab3.center = center2;
    
    CGPoint center3 = self.shareimage4.center ;
    
    
    center3.y += [UIScreen mainScreen].bounds.size.height-400;
    
    
    self.shareimage4.center = center3;
    self.lab4.center = center3;
    self.center = CGPointMake(center.x, center.y);
    self.center1 = CGPointMake(center1.x, center1.y);
    self.center2 = CGPointMake(center2.x, center2.y);
    self.center3 = CGPointMake(center3.x, center3.y);
    
    UITapGestureRecognizer * tap1 = [[UITapGestureRecognizer alloc]init];
    [tap1 addTarget:self action:@selector(setstatshare)];
    UITapGestureRecognizer * tap2 = [[UITapGestureRecognizer alloc]init];
    [tap2 addTarget:self action:@selector(setstatshare2)];
    UITapGestureRecognizer * tap3 = [[UITapGestureRecognizer alloc]init];
    [tap3 addTarget:self action:@selector(setstatshare3)];
    UITapGestureRecognizer * tap4 = [[UITapGestureRecognizer alloc]init];
    [tap4 addTarget:self action:@selector(setstatshare4)];
    [self.shareimage1 addGestureRecognizer:tap1];
    [self.sahreiamge2 addGestureRecognizer:tap2];
    [self.shareiamge3 addGestureRecognizer:tap3];
    [self.shareimage4 addGestureRecognizer:tap4];
    self.shareimage1.userInteractionEnabled = YES;
    self.sahreiamge2.userInteractionEnabled = YES;
    self.shareiamge3.userInteractionEnabled = YES;
    self.shareimage4.userInteractionEnabled = YES;
    
    
    
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self inputinshare:nil];
}
-(void)jilu{
    if ([UIScreen mainScreen].bounds.size.height < 481){
        self.smallbtn.hidden = YES;
    }
    RHMyFriendViewController * vc = [[RHMyFriendViewController alloc]initWithNibName:@"RHMyFriendViewController" bundle:nil];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    if ([UIScreen mainScreen].bounds.size.height < 481){
        self.smallbtn.hidden = YES;
    }
    self.shareview.hidden = YES;
    self.mengbanView.hidden = YES;
    [self.timer invalidate];
}
-(void)viewWillAppear:(BOOL)animated{
    
      
        
        [RYHViewController Sharedbxtabar].tarbar.hidden = YES;
   
    [super viewWillAppear:animated];
    if ([UIScreen mainScreen].bounds.size.height < 481){
        self.smallbtn.hidden = NO;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getloaddata{
    
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[RHNetworkService instance] POST:@"app/front/payment/appInviteFriends/getMyInviteCode" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSLog(@"%@",responseObject);
            if (responseObject[@"code"]||![responseObject[@"code"] isKindOfClass:[NSNull class]]) {
                self.myInvitationcodelab.text = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
            }
            if (responseObject[@"myAward"]||![responseObject[@"myAward"] isKindOfClass:[NSNull class]]) {
                self.mygiftlab.text = [NSString stringWithFormat:@"%@",responseObject[@"myAward"]];
            }
            if (responseObject[@"invites"]||![responseObject[@"invites"] isKindOfClass:[NSNull class]]) {
                self.mygiftmoney.text = [NSString stringWithFormat:@"%@",responseObject[@"invites"]];
            }
            
            if (responseObject[@"inviteCodeName"]||![responseObject[@"inviteCodeName"] isKindOfClass:[NSNull class]]) {
                self.peoplelab.text = [NSString stringWithFormat:@"%@",responseObject[@"inviteCodeName"]];
            }
            if (responseObject[@"myAwardName"]||![responseObject[@"myAwardName"] isKindOfClass:[NSNull class]]) {
                self.ljmoneylab.text = [NSString stringWithFormat:@"%@",responseObject[@"myAwardName"]];
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
    }];
    
}


- (IBAction)hongdongguize:(id)sender {
    RHGZdetailViewController*vc = [[RHGZdetailViewController alloc]initWithNibName:@"RHGZdetailViewController" bundle:nil];
   // [self.navigationController pushViewController:vc animated:YES];
    
//    self.mengbanView.hidden = NO;
//    self.tishiView.hidden = NO;
    RHOfficeNetAndWeiBoViewController *office = [[RHOfficeNetAndWeiBoViewController alloc] initWithNibName:@"RHOfficeNetAndWeiBoViewController" bundle:nil];
    //            office.NavigationTitle = naviTitle;
    //office.Type = 3;
    //office.shareid = @"0";
    
    office.urlString = @"https://www.ryhui.com/common/main/inviteFriendApp";
    [self.navigationController pushViewController:office animated:YES];
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
- (IBAction)sharefriend:(id)sender {
    self.mengbanView.hidden = NO;
    self.shareview.hidden = NO;
    
    CGPoint center1 = CGPointMake(self.center.x, self.center.y);
    center1.y -=[UIScreen mainScreen].bounds.size.height+5-400;
    
    
    CGPoint center2 = CGPointMake(self.center1.x, self.center1.y);
    center2.y -=[UIScreen mainScreen].bounds.size.height+5-400;
    CGPoint center3 = CGPointMake(self.center2.x, self.center2.y);
    center3.y -=[UIScreen mainScreen].bounds.size.height+5-400;
    CGPoint center4 = CGPointMake(self.center3.x, self.center3.y);
    center4.y -=[UIScreen mainScreen].bounds.size.height+5-400;
    [UIView animateWithDuration:0.2 delay:0 options:0.1 animations:^{
        
        self.shareimage1.center = center1;
        self.lab1.center = CGPointMake(center1.x, center1.y+50);
    } completion:nil];
    [UIView animateWithDuration:0.2 delay:0.05 options:0.1 animations:^{
        
        //        self.lab2.transform = CGAffineTransformMakeScale(1, 1);
        self.sahreiamge2.center = center2;
        self.lab2.center = CGPointMake(center2.x, center2.y+50);
    } completion:nil];
    [UIView animateWithDuration:0.2 delay:0.1 options:0.2 animations:^{
        
        self.shareiamge3.center = center3;
        self.lab3.center =CGPointMake(center3.x, center3.y+50);
    } completion:nil];
    [UIView animateWithDuration:0.2 delay:0.15 options:0.2 animations:^{
        
        self.shareimage4.center = center4;
        self.lab4.center = CGPointMake(center4.x, center4.y+50);
    } completion:nil];
    center1.y +=5;
    center2.y +=5;
    center3.y+=5;
    center4.y+=5;
    [UIView animateWithDuration:0.1 delay:0.2 options:0.1 animations:^{
        
        //        self.lab2.transform = CGAffineTransformMakeScale(1, 1);
        self.shareimage1.center = center1;
         self.lab1.center = CGPointMake(center1.x, center1.y+50);
    } completion:nil];
    [UIView animateWithDuration:0.1 delay:0.25 options:0.1 animations:^{
        
        //        self.lab2.transform = CGAffineTransformMakeScale(1, 1);
        self.sahreiamge2.center = center2;
         self.lab2.center = CGPointMake(center2.x, center2.y+50);
    } completion:nil];
    [UIView animateWithDuration:0.1 delay:0.3 options:0.1 animations:^{
        
        //        self.lab2.transform = CGAffineTransformMakeScale(1, 1);
        self.shareiamge3.center = center3;
         self.lab3.center = CGPointMake(center3.x, center3.y+50);
    } completion:nil];
    [UIView animateWithDuration:0.1 delay:0.35 options:0.1 animations:^{
        
        //        self.lab2.transform = CGAffineTransformMakeScale(1, 1);
        self.shareimage4.center = center4;
         self.lab4.center = CGPointMake(center4.x, center4.y+50);
    } completion:nil];
   /*
    CGPoint center1 = self.shareimage1.center ;
    center1.y -= 10;
    self.shareimage1.center = center1;
    center1.y +=10;
    
    CGPoint center2 = self.sahreiamge2.center ;
    center2.y -= 10;
    self.sahreiamge2.center = center2;
    center2.y +=10;
    
    CGPoint center3 = self.shareiamge3.center ;
    center3.y -= 10;
    self.shareiamge3.center = center3;
    center3.y +=10;
    
    CGPoint center4 = self.shareimage4.center ;
    center4.y -= 10;
    self.shareimage4.center = center4;
    center4.y +=10;
    
    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.1 initialSpringVelocity:0 options:nil animations:^{
        self.shareimage1.center = center1;
    } completion:nil];
    [UIView animateWithDuration:1 delay:0.2 usingSpringWithDamping:0.1 initialSpringVelocity:0 options:nil animations:^{
        self.sahreiamge2.center = center2;
    } completion:nil];
    [UIView animateWithDuration:1 delay:0.4 usingSpringWithDamping:0.1 initialSpringVelocity:0 options:nil animations:^{
        self.shareiamge3.center = center3;
    } completion:nil];
    [UIView animateWithDuration:1 delay:0.6 usingSpringWithDamping:0.1 initialSpringVelocity:0 options:nil animations:^{
        self.shareimage4.center = center4;
    } completion:nil];
   */
    
    return;
    
    float  versonfl = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (versonfl < 8.3) {
        
        
        
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:nil
                                      delegate:self
                                      cancelButtonTitle:@"取消"
                                      destructiveButtonTitle:nil
                                      otherButtonTitles:nil];
        
        
        
        
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
       
        
        
        [self addCancelActionTarget:alert title:@"取消"];
        
        [self presentViewController:alert animated:YES completion:nil];

    }
    
    return;
    
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"fenxiang1" ofType:@"png"];
    [SSUIShareActionSheetStyle setShareActionSheetStyle:ShareActionSheetStyleSimple];
    NSArray* imageArray = @[[UIImage imageNamed:@"fenxiang1.png"]];
//    images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    
    
    
    
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:@"银行资金存管，优质机构担保，100元起出借，目标年化利率7~12%，注册送豪华大礼包。"
                                     images:imageArray
                                        url:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.ryhui.com/common/mobile/mobileMain/inviteReg/%@",self.myInvitationcodelab.text]]
                                      title:@"我在融益汇赚取好收益，邀您一起来体验！"
                                       type:SSDKContentTypeAuto];
     [self startSharePlatform:SSDKPlatformTypeWechat parameters:shareParams];
    
    return;
    
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"银行资金存管，优质机构担保，100元起出借，目标年化利率7~12%，注册送豪华大礼包。"
                                         images:imageArray
                                            url:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.ryhui.com/common/mobile/mobileMain/inviteReg/%@",self.myInvitationcodelab.text]]
                                          title:@"我在融益汇赚取好收益，邀您一起来体验！"
                                           type:SSDKContentTypeAuto];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                   message:nil
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                               [alertView show];
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           default:
                               break;
                       }
                   }
         ];}
    
    
    
}

- (IBAction)hidenguize:(id)sender {
    
    
    self.mengbanView.hidden = YES;
    self.tishiView.hidden = YES;
}

/////////
//开始分享
-(void)setstatshare{
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"fenxiang1" ofType:@"png"];
//    [SSUIShareActionSheetStyle setShareActionSheetStyle:ShareActionSheetStyleSimple];
    NSArray* imageArray = @[[UIImage imageNamed:@"fenxiang1.png"]];
    //    images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    
    
    
    
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:@"银行资金存管，优质机构担保，100元起出借，目标年化利率7~12%，注册送豪华大礼包"
                                     images:imageArray
                                        url:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.ryhui.com/common/mobile/mobileMain/inviteReg/%@",self.myInvitationcodelab.text]]
                                      title:@"我在融益汇赚取好收益，邀您一起来体验！"
                                       type:SSDKContentTypeAuto];
    [self startSharePlatform:SSDKPlatformSubTypeWechatSession parameters:shareParams];
}
-(void)setstatshare2{
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"fenxiang1" ofType:@"png"];
//    [SSUIShareActionSheetStyle setShareActionSheetStyle:ShareActionSheetStyleSimple];
    NSArray* imageArray = @[[UIImage imageNamed:@"fenxiang1.png"]];
    //    images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    
    
    
    
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:@"银行资金存管，优质机构担保，100元起出借，目标年化利率7~12%，注册送豪华大礼包"
                                     images:imageArray
                                        url:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.ryhui.com/common/mobile/mobileMain/inviteReg/%@",self.myInvitationcodelab.text]]
                                      title:@"我在融益汇赚取好收益，邀您一起来体验！"
                                       type:SSDKContentTypeAuto];
    [self startSharePlatform:SSDKPlatformSubTypeWechatTimeline parameters:shareParams];
    
}
-(void)setstatshare3{
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"fenxiang1" ofType:@"png"];
//    [SSUIShareActionSheetStyle setShareActionSheetStyle:ShareActionSheetStyleSimple];
    NSArray* imageArray = @[[UIImage imageNamed:@"fenxiang1.png"]];
    //    images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    
    
    
    
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:@"银行资金存管，优质机构担保，100元起出借，目标年化利率7~12%，注册送豪华大礼包"
                                     images:imageArray
                                        url:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.ryhui.com/common/mobile/mobileMain/inviteReg/%@",self.myInvitationcodelab.text]]
                                      title:@"我在融益汇赚取好收益，邀您一起来体验！"
                                       type:SSDKContentTypeAuto];
    [self startSharePlatform:SSDKPlatformSubTypeWechatFav parameters:shareParams];
}
-(void)setstatshare4{
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"fenxiang1" ofType:@"png"];
//    [SSUIShareActionSheetStyle setShareActionSheetStyle:ShareActionSheetStyleSimple];
    NSArray* imageArray = @[[UIImage imageNamed:@"fenxiang1.png"]];
    //    images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    
    
    
    
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:@"银行资金存管，优质机构担保，100元起出借，目标年化利率7~12%，注册送豪华大礼包"
                                     images:imageArray
                                        url:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.ryhui.com/common/mobile/mobileMain/inviteReg/%@",self.myInvitationcodelab.text]]
                                      title:@"我在融益汇赚取好收益，邀您一起来体验！"
                                       type:SSDKContentTypeAuto];
    [self startSharePlatform:SSDKPlatformTypeSinaWeibo parameters:shareParams];
}

-(void)startSharePlatform:(SSDKPlatformType)platform parameters:(NSMutableDictionary *)parameters{
  /*
 [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                             items:nil
                       shareParams:parameters
               onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                   
                   switch (state) {
                       case SSDKResponseStateSuccess:
                       {
                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                               message:nil
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"确定"
                                                                     otherButtonTitles:nil];
                           [alertView show];
                           break;
                       }
                       case SSDKResponseStateFail:
                       {
                           UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                           message:[NSString stringWithFormat:@"%@",error]
                                                                          delegate:nil
                                                                 cancelButtonTitle:@"OK"
                                                                 otherButtonTitles:nil, nil];
                           [alert show];
                           break;
                       }
                       default:
                           break;
                   }
               }
     ];
    
  */
 
    [ShareSDK share:platform parameters:parameters onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
        
        switch (state) {
            case SSDKResponseStateSuccess:
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功" message:nil  delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alertView show];
                break;
            }
            case SSDKResponseStateFail:
            {
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败" message:[NSString stringWithFormat:@"%@",error] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                [alert show];
                break;
            }
            default:
                break;
        }
    }];

}
//点击取消
-(void)cancelBtnClicked:(UIButton *)sender{
    
//    [self.inviteStuView removeFromSuperview];
//    [self.inviteStuView.backgroundView removeFromSuperview];
}




- (IBAction)inputinshare:(id)sender {
    
    
    
    [UIView animateWithDuration:0.5 delay:0.15 options:0.1 animations:^{
        
        self.shareimage1.center = self.center;
        self.lab1.center = self.center;
    } completion:nil];
    [UIView animateWithDuration:0.2 delay:0.1 options:0.1 animations:^{
        
        //        self.lab2.transform = CGAffineTransformMakeScale(1, 1);
        self.sahreiamge2.center = self.center1;
        self.lab2.center = self.center1;
    } completion:nil];
    [UIView animateWithDuration:0.2 delay:0.05 options:0.1 animations:^{
        
        self.shareiamge3.center = self.center2;
        self.lab3.center =self.center2;
    } completion:nil];
    [UIView animateWithDuration:0.2 delay:0 options:0.1 animations:^{
        
        self.shareimage4.center = self.center3;
        self.lab4.center = self.center3;
    } completion:nil];
  self.timer =  [NSTimer scheduledTimerWithTimeInterval:0.35f target:self selector:@selector(hidenmyview) userInfo:nil repeats:NO];
//    [self.timer fire];
}

-(void)hidenmyview{
    
    self.shareview.hidden = YES;
    self.mengbanView.hidden = YES;
//     self.sharebtn.hidden = NO;
}
@end
