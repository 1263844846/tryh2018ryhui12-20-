//
//  RHUserCountViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 16/2/24.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import "RHUserCountViewController.h"
#import "RHMyInvestmentViewController.h"
#import "RHRechargeViewController.h"
#import "RHWithdrawViewController.h"
//#import "RHMyAccountGetViewController.h"
#import "RHUserHFViewController.h"
#import "RHALoginViewController.h"
#import "RHMyGiftViewController.h"
#import "RHmainModel.h"
//#import "RHZZViewController.h"
#import "RHZQZRViewController.h"
#import "RHRLViewController.h"
#import "RHTradingViewController.h"
#import "MBProgressHUD.h"
#import "RHMyMessageViewController.h"
#import "RHFriendViewController.h"
#import "RHJPTableViewController.h"
#import "RHBankListViewController.h"
#import "RHBngkCardDetailViewController.h"
#import "RHMyMoneyyViewController.h"
#import "mytestsyViewController.h"
#import "RHSLBViewController.h"
#import "RHRegisterWebViewController.h"
#import "RHMynewgiftViewController.h"
#import "RHBankwebviewViewController.h"
#import "RHhelper.h"
#import "RHsmallMybankViewController.h"

#import "RHMyMoneyViewController.h"

#import "RHShowGiftTableViewCell.h"
#import "RHOpenCountViewController.h"
#import "RHJXPassWordViewController.h"
#import "UIImageView+WebCache.h"
#import "UIImage+GIF.h"
#import "RHOpenAccountScuessViewController.h"

#import "RHDBSJViewController.h"
#import "RHXMJWebViewController.h"
@interface RHUserCountViewController ()<UITableViewDataSource,UITableViewDelegate>
// 上部属性
@property(nonatomic,strong)UILabel * moneyLab ;

@property(nonatomic,strong)UILabel * symoneyLab ;

@property(nonatomic,strong)UILabel * kymoneyLab ;

@property(nonatomic,strong)UILabel * kymoneyLab1;

@property(nonatomic,strong)NSArray * array;
@property(nonatomic,strong)NSArray * imagearray;

@property (strong, nonatomic) IBOutlet UIView *giftVIEW;
@property (weak, nonatomic) IBOutlet UIImageView *giftTypeImageView;
@property (weak, nonatomic) IBOutlet UILabel *giftMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *giftNoticeLabel;
@property (weak, nonatomic) IBOutlet UIButton *doButton;

@property (weak, nonatomic) IBOutlet UITableView *gifttableview;

@property(nonatomic,strong)UIView * khview;
@property(nonatomic,strong)UIButton * khbutton;

@property (weak, nonatomic) IBOutlet UILabel *banklab;
@property (weak, nonatomic) IBOutlet UILabel *tishilable;

//mengban

@property (weak, nonatomic) IBOutlet UIView *mengbanview;
@property (weak, nonatomic) IBOutlet UIView *kaihuview;
@property (weak, nonatomic) IBOutlet UIButton *bankbtn;

@property (strong, nonatomic) IBOutlet UIView *hongbaoview;
@property (weak, nonatomic) IBOutlet UILabel *kaihumoneylab;
@property (weak, nonatomic) IBOutlet UILabel *huodonglab;


@property(nonatomic,strong)NSMutableArray * giftArray;
@property(nonatomic,strong)UIButton * leftbtn;

@property(nonatomic,copy)NSString * strbnakcard;
@property(nonatomic,copy)NSString * bankress;
@property(nonatomic,strong)NSDictionary * bankdic;
@property(nonatomic,copy)NSString * passwordbool;

@property(nonatomic,strong)UIImageView * testimage;

@property(nonatomic,strong)UIImageView * shauxiniamge;

@property(nonatomic,assign)BOOL mobress;


@property(nonatomic,strong)UIImageView * backgroundiamge;
@property(nonatomic,strong)UIImageView * backgroundiamge2;
@property(nonatomic,strong)UIImageView * backgroundiamge3;

@property(nonatomic,strong)UIImageView * backgroundiamgecopy;
@property(nonatomic,strong)UIImageView * backgroundiamgecopy2;
@property(nonatomic,strong)UIImageView * backgroundiamgecopy3;

@property(nonatomic,copy)NSString * sqswitch;


@property(nonatomic,copy)NSString * giftswitch;
@end

@implementation RHUserCountViewController
-(void)seachmygiftswitch{
    
  
        
        [[RHNetworkService instance] POST:@"app/common/appMain/giftSwitch" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                NSString * str = [NSString stringWithFormat:@"%@",responseObject[@"giftSwitch"]];
                
                
                self.giftswitch = str;
                
            }
            
            NSLog(@"%@",responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            ;
        }];
  
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.subviews.firstObject.alpha = 5.00;
//    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    [self.backgroundiamge.layer removeAllAnimations];
    [self.backgroundiamge2.layer removeAllAnimations];
    [self.backgroundiamge3.layer removeAllAnimations];
    
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    
}
-(NSDictionary*)bankdic{
    
    if (!_bankdic) {
        _bankdic = [NSDictionary dictionary];
    }
    return _bankdic;
}
-(void)getgift{
    return;
    
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    //    [manager.operationQueue cancelAllOperations];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.securityPolicy = [[RHNetworkService instance] customSecurityPolicy];
    [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    [[RHNetworkService instance] POST:[NSString stringWithFormat:@"%@app/front/payment/appAccount/queryAccountFinishedBonuses",[RHNetworkService instance].newdoMain ] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//         NSLog(@"%@1-1-1-1-11===",responseObject);
        if ([responseObject isKindOfClass:[NSData class]]) {
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            if (dic) {
//                 self.hongbaoview.hidden = NO;
                
                self.kaihumoneylab.text = [NSString stringWithFormat:@"%@元出借现金已放入账户",dic[@"money"]];
                self.hongbaoview.hidden = NO;
                if (dic &&![dic[@"lowestMoney"] isKindOfClass:[NSNull class]]) {
                    
                    if ([dic[@"lowestMoney"] intValue]<10) {
                        self.huodonglab.text = @"快去充值出借吧~";
                        self.khview.hidden = YES;
                    }else{
                    self.huodonglab.text = [NSString stringWithFormat:@"首次出借%@元以上立得返利现金哦！快去充值出借吧～",dic[@"lowestMoney"]];
                    self.khview.hidden = YES;
                    }
                }
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%@2-2-2-2-2-2-2-2==",error);
        
        if ([error.userInfo.allKeys containsObject:@"com.alamofire.serialization.response.error.data"]) {
            NSDictionary* errorDic=[NSJSONSerialization JSONObjectWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] options:NSJSONReadingMutableContainers error:nil];
            if ([errorDic objectForKey:@"msg"]) {
//                if ([[errorDic objectForKey:@"msg"] isEqualToString:@"验证码错误"]) {
                
//                    [self changeCaptcha];
//                }
//                [RHMobHua showTextWithText:[errorDic objectForKey:@"msg"]];
            }
        }
     
        
      //  [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    }];
//    
//    [[RHNetworkService instance] POST:@"app/front/payment/appAccount/queryAccountFinishedBonuses" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        NSLog(@"%@1-1-1-1-11===",responseObject);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        ;
//        
//        NSLog(@"%@2-2-2-2-2-2-2-2==",error);
//    }];
    
}

-(void)getkaihugift{
    
    return;
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    //    [manager.operationQueue cancelAllOperations];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.securityPolicy = [[RHNetworkService instance] customSecurityPolicy];
    [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    [manager POST:[NSString stringWithFormat:@"%@app/front/payment/appAccount/newsAppQueryAccountFinishedBonuses",[RHNetworkService instance].newdoMain ] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //         NSLog(@"%@1-1-1-1-11===",responseObject);
        if ([responseObject isKindOfClass:[NSData class]]) {
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            if (dic) {
                //                 self.hongbaoview.hidden = NO;
                
                NSString* isShow=[dic objectForKey:@"isShow"];
                self.giftMoneyLabel.text = [dic objectForKey:@"giftContent"];
                self.giftArray = [NSMutableArray arrayWithArray:[dic objectForKey:@"giftList"]];
                if ([isShow isEqualToString:@"true"]) {
//                    self.kaihumybtn.userInteractionEnabled = NO;
//                    self.giftView.hidden = NO;
                    [self.gifttableview reloadData];
                    self.khview.hidden = YES;
                    self.hongbaoview.hidden = NO;
                }
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //        NSLog(@"%@2-2-2-2-2-2-2-2==",error);
        
        if ([error.userInfo.allKeys containsObject:@"com.alamofire.serialization.response.error.data"]) {
            NSDictionary* errorDic=[NSJSONSerialization JSONObjectWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] options:NSJSONReadingMutableContainers error:nil];
            if ([errorDic objectForKey:@"msg"]) {
                //                if ([[errorDic objectForKey:@"msg"] isEqualToString:@"验证码错误"]) {
                
                //                    [self changeCaptcha];
                //                }
//                [RHMobHua showTextWithText:[errorDic objectForKey:@"msg"]];
            }
        }
        
     //   [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        
    }];
    
}

- (IBAction)hidenhongbao:(id)sender {
    self.hongbaoview.hidden = YES;
    self.khview.hidden = YES;
//    [self creatkaihu];
}

- (IBAction)kaihuchongzhi:(id)sender {
    self.hongbaoview.hidden = YES;
    RHRechargeViewController* controller=[[RHRechargeViewController alloc]initWithNibName:@"RHRechargeViewController" bundle:nil];
    controller.balance=self.kymoneyLab.text;
    [self.navigationController pushViewController:controller animated:NO];
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
                    self.strbnakcard = [NSString stringWithFormat:@"%@",responseObject[@"bank"][@"bankNo"]];
                }
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //        DLog(@"%@",error);
        DLog(@"%@",[[NSString alloc] initWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
    }];
}
-(void)notification1{
    NSLog(@"接收 不带参数的消息");
  
    [self getnavagation];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad {
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notification1) name:@"imagephoto" object:nil];
    [self seachmygiftswitch];
    
    NSLog(@"0000----%@",[RHUserManager sharedInterface].custId);
    
    [super viewDidLoad];
    
    [self sqmyswitch];
    self.gifttableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.gifttableview.delegate = self;
    self.gifttableview.dataSource = self;
    self.view.backgroundColor = [RHUtility colorForHex:@"#E4E6E6"];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
   // titleLabel.backgroundColor = [UIColor grayColor];
    
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    
    titleLabel.textColor = [UIColor whiteColor];
    
   // titleLabel.textAlignment = NSTextAlignmentCenter;
    
    
    titleLabel.text = [RHUserManager sharedInterface].username;
    
    
    self.navigationItem.titleView = titleLabel;
    
    
     //self.navigationController.navigationBar.subviews.firstObject.alpha = 0;
    
   // self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    self.array = [NSArray arrayWithObjects:@"我的出借",@"回款计划",@"资产总览",@"我的红包",@"我的奖品",@"邀请好友",@"银行卡",@"交易记录",@"自动投标", nil];
    self.imagearray = [NSArray arrayWithObjects:@"acount0",@"acount1",@"acount2",@"acount3",@"acount4",@"acount5",@"acount6",@"acount7",@"acount", nil];
    NSString* session=[[NSUserDefaults standardUserDefaults] objectForKey:@"RHSESSION"];
    NSLog(@"------------------%@",session);
    
    if ([RHUserManager sharedInterface].username) {
        //[manager.requestSerializer setValue:session forHTTPHeaderField:@"cookie"];
       
        
       
        [self creatAll];
        if ([RHUserManager sharedInterface].custId.length<1){
            
             [self creatkaihu];
            
            
        }
        
        
    }else{
        [DQViewController Sharedbxtabar].tarbar.hidden = YES;
        RHALoginViewController * vc = [[RHALoginViewController alloc]initWithNibName:@"RHALoginViewController" bundle:nil];
        vc.str = @"cbx";
        [self.navigationController pushViewController:vc animated:NO];
        
        //titleLabel.text = @"请先登录";
        
        self.view = self.giftVIEW;
        
    }
    
   // [self creatAll];
    
    self.moneyLab.text = @"0.00";
    self.symoneyLab.text = @"0.00";
    self.kymoneyLab.text = @"0.00";
    
    self.moneyLab.textColor = [UIColor whiteColor];
    self.symoneyLab.textColor = [UIColor whiteColor];
    self.kymoneyLab1.textColor = [UIColor whiteColor];
    self.kymoneyLab.textColor = [UIColor whiteColor];
    self.kaihuview.layer.masksToBounds=YES;
    self.kaihuview.layer.cornerRadius=8;
   
    self.kaihuview.hidden = YES;
    self.mengbanview.hidden = YES;
    self.hongbaoview.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,  [UIScreen mainScreen].bounds.size.height);
//    [self.view addSubview:self.hongbaoview];
    [[UIApplication sharedApplication].keyWindow addSubview:self.hongbaoview];
    self.hongbaoview.hidden = YES;
   // self.kaihuview.frame = CGRectMake(40, 150, [UIScreen mainScreen].bounds.size.width-80, 206*[UIScreen mainScreen].bounds.size.width/320);
    [[UIApplication sharedApplication].keyWindow addSubview:self.mengbanview];
    [[UIApplication sharedApplication].keyWindow addSubview:self.kaihuview];
    
    if ([UIScreen mainScreen].bounds.size.width>376) {
        self.kaihuview.frame = CGRectMake(40, CGRectGetMinY(self.kaihuview.frame), [UIScreen mainScreen].bounds.size.width-80, 310);
    }else{
        self.kaihuview.frame = CGRectMake(40, CGRectGetMinY(self.kaihuview.frame), [UIScreen mainScreen].bounds.size.width-80, 245);
    }
    self.testimage = [[UIImageView alloc]init];
    
    
   
}
- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize {
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
}

#pragma mark 保存图片到document
- (void)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName {
    NSData* imageData = UIImagePNGRepresentation(tempImage);
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    // Now we get the full path to the file
    NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:imageName];
    // and then we write it out
    [imageData writeToFile:fullPathToFile atomically:NO];
}

#pragma mark 从文档目录下获取Documents路径
- (NSString *)documentFolderPath {
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
}

- (void)getnavagation{
    
    NSString *version = [UIDevice currentDevice].systemVersion;
    
    
    
    UIButton*rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,25,25)];
    if ([version doubleValue]>=11) {
        rightButton.frame = CGRectMake(0,0,12,12);
        // rightButton.backgroundColor = [UIColor redColor];
    }
    
    [rightButton setImage:[UIImage imageNamed:@"账户test.png"]forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(getuser)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    
    NSString *pass =  [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@Gesture",[RHUserManager sharedInterface].username]];
    NSString * photoimage =[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"headUrl"]];
    
    if (photoimage&&photoimage.length>10) {
        [rightButton.layer setCornerRadius:12.5];
        
        rightButton.layer.masksToBounds=YES;
        //        UIImageView *aimng = [[UIImageView alloc]init];
        UIImageView * imageview1 = [[UIImageView alloc]init];
        [imageview1 sd_setImageWithURL:[NSURL URLWithString:photoimage]];
        if ([version doubleValue]>=11) {
            UIImage *theImage = [self imageWithImageSimple:imageview1.image scaledToSize:CGSizeMake(25, 25)];
            // [self imageWithImageSimple:imageview1.image scaledToSize:CGSizeMake(12, 12)];
            
            //NSData * imageData = UIImageJPEGRepresentation(imageview1.image, 0.1);
            self.testimage.image =  theImage;
            //[rightButton.layer setCornerRadius:12];
        }else{
            [self.testimage sd_setImageWithURL:[NSURL URLWithString:photoimage]];
        }
        
        //
        
        [rightButton setImage:self.testimage.image forState:UIControlStateNormal];
        
    }
    
    //    [btn setTitle:@""];
    //
    //
    //    [btn setTintColor:[RHUtility colorForHex:@"#44bbc1"]];
    //btn.image = [UIImage imageNamed:@"gengduo"];
    
    self.navigationItem.leftBarButtonItem = rightItem;
    //[self getBindCard];
    
    
    self.leftbtn = [[UIButton alloc]initWithFrame:CGRectMake(0,0,25,21)];
    [self.leftbtn setImage:[UIImage imageNamed:@"信息-正常.png"]forState:UIControlStateNormal];
    [self.leftbtn addTarget:self action:@selector(chongzhi)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*leftItem = [[UIBarButtonItem alloc]initWithCustomView:self.leftbtn];
    
    //    [btn setTitle:@""];
    //
    //
    //    [btn setTintColor:[RHUtility colorForHex:@"#44bbc1"]];
    //btn.image = [UIImage imageNamed:@"gengduo"];
    
    self.navigationItem.rightBarButtonItem = leftItem;
    
    
}

- (void)getuser{
    
    RHUserHFViewController * hfvc = [[RHUserHFViewController alloc]initWithNibName:@"RHUserHFViewController" bundle:nil];
    
//     self.tabBarController.tabBar.hidden = YES;
    hfvc.myswitch = self.sqswitch;
   // RHMyAccountGetViewController * vc = [[RHMyAccountGetViewController alloc]initWithNibName:@"RHMyAccountGetViewController" bundle:nil];
    [DQViewController Sharedbxtabar].tarbar.hidden = YES;
    [self.navigationController pushViewController:hfvc animated:NO];
    
}
- (void)chongzhi{
//    if ([RHUserManager sharedInterface].custId.length>0) {
     [DQViewController Sharedbxtabar].tarbar.hidden = YES;
    RHMyMessageViewController * vc = [[RHMyMessageViewController alloc]initWithNibName:@"RHMyMessageViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:NO];
//    }else{
//        
//        [RHUtility showTextWithText:@"请先开户"];
//    }
}
-(void)firsttouzi{
    [self.navigationController.navigationBar setBarTintColor:[RHUtility colorForHex:@"#44bbc1"]];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    //UIImageView * cbximage = [[UIImageView alloc]init];
    //cbximage.backgroundColor = [RHUtility colorForHex:@"#44bbc1"];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    self.navigationController.navigationBar.translucent = NO;
//    [self getnavagation];
    [DQViewController Sharedbxtabar].tarbar.hidden = NO;
}
- (void)getMyMessage {
   
    
    [[RHNetworkService instance] POST:@"app/front/payment/appAccount/getInitReadMsgs" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        DLog(@"%@",responseObject);
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            if ([responseObject[@"msgs"] intValue]>0) {
                NSLog(@"%@",responseObject);
                [self.leftbtn setImage:[UIImage imageNamed:@"信息666.png"]forState:UIControlStateNormal];
            }
        }
        
       
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //        DLog(@"%@",error);
       // [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    }];
}

-(void)stzfpush{
    
    [[RHNetworkService instance] POST:@"front/payment/account/trusteePayAlter" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSString * str = [NSString stringWithFormat:@"%@",responseObject[@"flag"]];
            [RHhelper ShraeHelp].dbsxstr = str;
            if ([str isEqualToString:@"1"]) {
                [DQViewController Sharedbxtabar].tarbar.hidden = YES;
                RHDBSJViewController * vc = [[RHDBSJViewController alloc]initWithNibName:@"RHDBSJViewController" bundle:nil];
                //        vc.str = @"cbx";
                [self.navigationController pushViewController:vc animated:NO];
                
            }
            
        }
        
        NSLog(@"%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
    }];
    
}

-(void)viewWillAppear:(BOOL)animated{
     [self startAnimation];
    
    [self stzfpush];
     [[DQViewController Sharedbxtabar].tabBar setHidden:YES];
    [super viewWillAppear:animated];
    
    if ([[RHhelper ShraeHelp].moneystr doubleValue] >0) {
        RHMainViewController *controller = [[RHMainViewController alloc]initWithNibName:@"RHMainViewController" bundle:nil];
       // controller.type = @"0";
        //    [nav pushViewController:controller animated:YES];
        [[DQViewController Sharedbxtabar]tabBar:(DQview *)controller.view didSelectedIndex:0];
        UIButton *btn = [[UIButton alloc]init];
        btn.tag = 0;
        [[DQview Shareview] btnClick:btn];
        // [self.navigationController popToRootViewControllerAnimated:NO];
       // return;
    }
    [self getMyMessage];

    if ([RHUserManager sharedInterface].custId.length>3) {
        [self getMyAccountData];
    }
    
    [self getnavagation];

    [RHmainModel ShareRHmainModel].maintest = @"";
    [DQViewController Sharedbxtabar].tarbar.hidden = NO;

    if ([RHhelper ShraeHelp].resss==1) {
        
      //  [DQViewController Sharedbxtabar].tarbar.hidden = YES;
    }
    
    if ([RHhelper ShraeHelp].giftres ==1) {
     
        [self gif];
    }
    
    [RHhelper ShraeHelp].resss=2;
   
    [self zhangtai];
    [self getmyjxbankcard];
    [self getmyjxpassword];
    dispatch_async(dispatch_get_main_queue(), ^{
       
       
//        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
//       [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"透明矩形.png"] forBarMetrics:UIBarMetricsDefault];
//        self.navigationController.navigationBar.backgroundColor = [UIColor clearColor]; self.navigationController.navigationBar.subviews.firstObject.alpha = 0;
    });
     NSLog(@"------%f",self.navigationController.navigationBar.subviews.firstObject.alpha);
    self.navigationController.navigationBar.barTintColor = [RHUtility colorForHex:@"#44bbc1"];
    self.navigationController.navigationBar.translucent = NO;
    
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init]
                                                  forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
    
 
    
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    if ([DQViewController Sharedbxtabar].tarbar.hidden == YES) {
       
    }
     if ([RHhelper ShraeHelp].invertres==1111) {
//         [RHhelper ShraeHelp].invertres==0
         RHMyInvestmentViewController* controller=[[RHMyInvestmentViewController alloc]initWithNibName:@"RHMyInvestmentViewController" bundle:nil];
         [DQViewController Sharedbxtabar].tarbar.hidden = YES;
         //  self.tabBarController.tabBar.hidden = YES;
         [self.navigationController pushViewController:controller animated:NO];
         controller.hidesBottomBarWhenPushed = YES;
         //        self.hidesBottomBarWhenPushed=YES;
         //        self.hidesBottomBarWhenPushed=YES;
         NSLog(@"我的出借");
     }
    
     NSLog(@"%d===---",[DQViewController Sharedbxtabar].tarbar.hidden );
//    [DQViewController Sharedbxtabar].tarbar.hidden = NO;
    
}
-(void)zhangtai{
   
    //return;
    if ([[RHUserManager sharedInterface].custId isEqualToString:@"first"]) {
        
        if (self.khview.hidden) {
            return;
        }
        
        self.khview.frame = CGRectMake(-200, -500, 200, 200);
    //    [self getgift];
       // [self getkaihugift];
//        self.hongbaoview.hidden = NO;
        [RHUserManager sharedInterface].custId = @"yekaihu";
        self.khview.hidden = YES;
        return;
    }
}
-(void)creatkaihu{
    
      if ([RHUserManager sharedInterface].custId.length>0){
          
          self.khview.hidden = YES;
          return;
          
          
      }
    
    CGFloat height  = [UIScreen mainScreen].bounds.size.height;
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat test;
    if (height < 569 ) {
        
        
        test = 200-69;
    }else if( height < 736&&height> 568){
        
        test = 275-69;
    }else{
    
        
        test = 275-69;
    }
    
    self.khview = [[UIView alloc]initWithFrame:CGRectMake(0, -64, width, test+64)];
    
    [self.view addSubview:self.khview];
    
    
    UIImageView * aimageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"背景个人中心"]];
    
    aimageview.frame = CGRectMake(0, 0, width, test+64);
    
      
    self.backgroundiamge = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Path1"]];
    self.backgroundiamge2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Path2"]];
    self.backgroundiamge3 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Path3"]];
    
    self.backgroundiamge.frame =CGRectMake(-150, CGRectGetMaxY(aimageview.frame)-80, [UIScreen mainScreen].bounds.size.width+300, 100);
    self.backgroundiamge2.frame =CGRectMake(-150, CGRectGetMaxY(aimageview.frame)-80, [UIScreen mainScreen].bounds.size.width+300, 100);
    self.backgroundiamge3.frame =CGRectMake(-150, CGRectGetMaxY(aimageview.frame)-80, [UIScreen mainScreen].bounds.size.width+300, 100);
    [aimageview addSubview:self.backgroundiamge];
    [aimageview addSubview:self.backgroundiamge2];
    [aimageview addSubview:self.backgroundiamge3];
   
    
    
    
    [self.khview addSubview:aimageview];
    self.khview.backgroundColor  = [RHUtility colorForHex:@"#44bbc1"];
    
    self.khbutton = [[UIButton alloc]init];
    self.khbutton.frame = CGRectMake(width/2-80, test,160, 40);
    
    //    [self.khbutton setTitle:@"请先开户" forState:UIControlStateNormal];
    [self.khbutton setImage:[UIImage imageNamed:@"PNG_请先开户"] forState:UIControlStateNormal];
    //    self.khbutton.backgroundColor =  [UIColor redColor];
    
    UILabel * lestlab = [[UILabel alloc]init];
    lestlab.frame = CGRectMake(width/2-130, CGRectGetMinY(self.khbutton.frame)-40, 260, 30);
    lestlab.font = [UIFont systemFontOfSize:14];
    
    lestlab.textColor = [UIColor whiteColor];
    lestlab.text = @"开通银行托管账户，资金流向安全透明";
    lestlab.textAlignment = NSTextAlignmentCenter;
    if ([UIScreen mainScreen].bounds.size.width > 374) {
        UILabel * zzlab = [[UILabel alloc]init];
        zzlab.frame = CGRectMake(width/2-130, CGRectGetMinY(lestlab.frame)-40, 260, 40);
        
        zzlab.text = @"总资产(元)";
        zzlab.font = [UIFont systemFontOfSize:15];
        
        zzlab.textColor = [UIColor whiteColor];
       
        zzlab.textAlignment = NSTextAlignmentCenter;
        
        UILabel * mylab = [[UILabel alloc]init];
        mylab.frame = CGRectMake(width/2-130, CGRectGetMinY(zzlab.frame)-40, 260, 40);
        
        mylab.text = @"0.00";
        mylab.font = [UIFont systemFontOfSize:28];
        
        mylab.textColor = [UIColor whiteColor];
        
        mylab.textAlignment = NSTextAlignmentCenter;
        
        [self.khview addSubview:zzlab];
        [self.khview addSubview:mylab];
    }
    [self.khview addSubview:lestlab];
    [self.khview addSubview:self.khbutton];
    
    [self.khbutton addTarget:self action:@selector(khbutton:) forControlEvents:UIControlEventTouchUpInside];
    if ([RHUserManager sharedInterface].custId.length>0){
        
        
       self.khview.frame = CGRectMake(-200, -500, 200, 200);
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)creatAll{
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]init];
    [tap addTarget:self action:@selector(getMyAccountData1)];
    CGFloat height  = [UIScreen mainScreen].bounds.size.height;
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat test;
   
    if ([UIScreen mainScreen].bounds.size.height < 481){
        test = 230-69;
        
        UIView * aview = [[UIView alloc]init];
        aview.frame = CGRectMake(0, -64, width, 200-69);
        aview.backgroundColor = [RHUtility colorForHex:@"#44bbc1"];
        [self.view addSubview:aview];
        UIImageView * aimageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"背景个人中心"]];
        
        aimageview.frame = CGRectMake(0, 0, width, 200-69+64);
        
        
        [aview addSubview:aimageview];
        
        self.backgroundiamge = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Path1"]];
        self.backgroundiamge2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Path2"]];
        self.backgroundiamge3 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Path3"]];
        
        self.backgroundiamge.frame =CGRectMake(-150, CGRectGetMaxY(aimageview.frame)-80, [UIScreen mainScreen].bounds.size.width+300, 100);
        self.backgroundiamge2.frame =CGRectMake(-150, CGRectGetMaxY(aimageview.frame)-80, [UIScreen mainScreen].bounds.size.width+300, 100);
        self.backgroundiamge3.frame =CGRectMake(-150, CGRectGetMaxY(aimageview.frame)-80, [UIScreen mainScreen].bounds.size.width+300, 100);
        [aimageview addSubview:self.backgroundiamge];
        [aimageview addSubview:self.backgroundiamge2];
        [aimageview addSubview:self.backgroundiamge3];
        
        
        
        self.moneyLab = [[UILabel alloc]init];
        //self.hkfLab.textAlignment = NSTextAlignmentRight;
        self.moneyLab.textAlignment = NSTextAlignmentCenter;
        self.moneyLab.frame =  CGRectMake(0, 90-79+64, width, 25);
        self.moneyLab.font = [UIFont systemFontOfSize: 20.0];
        [aview addSubview:self.moneyLab];
        
        UIButton * accoutbutton = [[UIButton alloc]init];
        accoutbutton.frame = CGRectMake(CGRectGetMinX(self.moneyLab.frame), CGRectGetMinY(self.moneyLab.frame), self.moneyLab.frame.size.width, self.moneyLab.frame.size.height+30+40+10);
        //        accoutbutton.backgroundColor = [UIColor redColor];
        
        [accoutbutton addTarget:self action:@selector(myaccount) forControlEvents:UIControlEventTouchUpInside];
        [aview addSubview:accoutbutton];
        
        UILabel * lab = [[UILabel alloc]init];
        lab.text = @"账户总额(元)";
        lab.font = [UIFont systemFontOfSize: 14.0];
        lab.frame = CGRectMake(width/2 -45, CGRectGetMaxY(self.moneyLab.frame)+10, 90, 20);
        lab.textColor = [UIColor whiteColor];
        [aview addSubview:lab];
        
        
        self.symoneyLab = [[UILabel alloc]init];
        self.symoneyLab.textAlignment = NSTextAlignmentCenter;
        self.symoneyLab.frame = CGRectMake(0, test-25-10-30-20+64, width/2, 25);
        self.symoneyLab.textAlignment = NSTextAlignmentCenter;;
        self.symoneyLab.font = [UIFont systemFontOfSize: 20.0];
        [aview addSubview:self.symoneyLab];
        
        
        UILabel * mytestlab = [[UILabel alloc]init];
        mytestlab.frame = CGRectMake(width/2-1, CGRectGetMinY(self.symoneyLab.frame)+5, 1, 40);
        
        [aview addSubview:mytestlab];
        
        mytestlab.backgroundColor = [UIColor whiteColor];
        
        UILabel * lab2 = [[UILabel alloc]init];
        lab2.textColor = [UIColor whiteColor];
        lab2.frame = CGRectMake(0, CGRectGetMaxY(self.symoneyLab.frame)+3 , width/2, 20);
        lab2.textAlignment = NSTextAlignmentCenter;
        lab2.text = @"累计收益(元)";
        lab2.font = [UIFont systemFontOfSize: 14.0];
        [aview addSubview:lab2];
        
        self.kymoneyLab = [[UILabel alloc]init];
        self.kymoneyLab.font = [UIFont systemFontOfSize: 20.0];
        self.kymoneyLab.frame = CGRectMake(width/2, CGRectGetMinY(self.symoneyLab.frame), width/2, 25);
        //self.kymoneyLab.backgroundColor = [UIColor redColor];
        [aview addSubview:self.kymoneyLab];
        self.kymoneyLab.textAlignment = NSTextAlignmentCenter;
        
        self.kymoneyLab1 = [[UILabel alloc]init];
        
        self.kymoneyLab1.frame = CGRectMake(width/2, CGRectGetMinY(lab2.frame) , width/2, 20);
        
        self.kymoneyLab1.text = @"可用余额(元)";
        self.kymoneyLab1.textAlignment = NSTextAlignmentCenter;
        self.kymoneyLab1.textColor = [UIColor whiteColor];
        self.kymoneyLab1.font = [UIFont systemFontOfSize: 14.0];
        [aview addSubview:self.kymoneyLab1];
        
        UIButton * czbtn = [[UIButton alloc]init];
        
        // czbtn.frame = CGRectMake(0, 400, 200, 100);
        czbtn.frame = CGRectMake(0, CGRectGetMaxY(aview.frame), width/2, 50);
        // czbtn.titleLabel.text = @"充值";
        [czbtn setTitle:@"充值" forState:UIControlStateNormal];
        [self.view addSubview:czbtn];
        [czbtn addTarget:self action:@selector(cbxcz) forControlEvents:UIControlEventTouchUpInside];
        //[czbtn setTintColor:[UIColor blackColor]];
        //czbtn.titleLabel.textColor = [UIColor blackColor];
        [czbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        czbtn.backgroundColor = [UIColor whiteColor];
        
        UIButton * tixbtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(czbtn.frame), CGRectGetMaxY(aview.frame), width/2, 50)];
        //txbtn.frame = CGRectMake(width/2, CGRectGetMaxY(aview.frame), width/2, 62);
        //txbtn.titleLabel.text = @"提现";
        tixbtn.backgroundColor = [UIColor whiteColor];
        [tixbtn setTitle:@"提现" forState:UIControlStateNormal];
        //[txbtn setTintColor:[UIColor blackColor]];
        // tixbtn.titleLabel.textColor = [UIColor blackColor];
        [tixbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [tixbtn addTarget:self action:@selector(cbxtixian) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:tixbtn];
        
        UIImageView * cbxView = [[UIImageView alloc]init];
        cbxView.frame = CGRectMake(width/2, CGRectGetMaxY(aview.frame)+5, 1, 40);
        
        cbxView.backgroundColor = [RHUtility colorForHex:@"#c6c6c6"];
        
        [self.view addSubview:cbxView];
        
        for (int j = 0; j < 3 ; j++) {
            
            for (int i = 0 ; i < 3; i ++) {
                
                UIButton * button = [[UIButton alloc]init];
                
                button.frame = CGRectMake(i * width/3, CGRectGetMaxY(tixbtn.frame)+10+j*60, width/3, 60);
                button.backgroundColor = [UIColor whiteColor];
                //[button setTitle:self.array[j*3+i ] forState:UIControlStateNormal];
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                // [button setImage:[UIImage imageNamed:@"jsqsx"] forState:UIControlStateNormal];
                [self.view addSubview:button];
                button.tag = 1111+j*3+i;
                UIImageView * ynaimage = [[UIImageView alloc]init];
                ynaimage.frame = CGRectMake(width/3/2-14, 10, 18,18);
                ynaimage.image = [UIImage imageNamed:self.imagearray[j*3+i]];
                
                [button addSubview:ynaimage];
                [button addTarget:self action:@selector(cbxaccont:) forControlEvents:UIControlEventTouchUpInside];
                
                UILabel * ynlab = [[UILabel alloc]init];
                ynlab.frame = CGRectMake(10, CGRectGetMaxY(ynaimage.frame)+5, 80, 20);
                ynlab.text = self.array[j*3+i ];
                ynlab.textAlignment = NSTextAlignmentCenter;
                ynlab.textColor = [RHUtility colorForHex:@"#232323"];
                ynlab.font = [UIFont systemFontOfSize: 13.0];
                [button addSubview:ynlab];
                
                
                UIImageView * cbxoneimage = [[UIImageView alloc]init];
                cbxoneimage.frame = CGRectMake(CGRectGetMinX(button.frame), CGRectGetMaxY(button.frame)-1, width/3, 1);
                if (j!=2) {
                    [self.view addSubview:cbxoneimage];
                }
                cbxoneimage.backgroundColor = [RHUtility colorForHex:@"#c0c0c0"];
                UIImageView * cbxtwoimage = [[UIImageView alloc]init];
                cbxtwoimage.frame = CGRectMake(CGRectGetMaxX(button.frame)-1, CGRectGetMinY(button.frame), 1, 60);
                [self.view addSubview:cbxtwoimage];
                cbxtwoimage.backgroundColor = [RHUtility colorForHex:@"#c0c0c0"];
                // cbxtwoimage.backgroundColor = [UIColor redColor];
                
                //ynlab.backgroundColor = [UIColor redColor];
            }
            
            
            
            
        }
        return;
       
    }
    
    if (height < 569 ) {
        
        
        test = 230-69;
        
        UIView * aview = [[UIView alloc]init];
        aview.frame = CGRectMake(0, -64, width, 200-69+64);
        aview.backgroundColor = [RHUtility colorForHex:@"#44bbc1"];
        [self.view addSubview:aview];
        UIImageView * aimageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"背景个人中心"]];
        
        aimageview.frame = CGRectMake(0, 0, width, 200-69+64);
        
        [aview addSubview:aimageview];
        
        self.backgroundiamge = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Path1"]];
        self.backgroundiamge2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Path2"]];
        self.backgroundiamge3 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Path3"]];
        
        self.backgroundiamge.frame =CGRectMake(-150, CGRectGetMaxY(aimageview.frame)-80, [UIScreen mainScreen].bounds.size.width+300, 100);
        self.backgroundiamge2.frame =CGRectMake(-150, CGRectGetMaxY(aimageview.frame)-80, [UIScreen mainScreen].bounds.size.width+300, 100);
        self.backgroundiamge3.frame =CGRectMake(-150, CGRectGetMaxY(aimageview.frame)-80, [UIScreen mainScreen].bounds.size.width+300, 100);
        [aimageview addSubview:self.backgroundiamge];
        [aimageview addSubview:self.backgroundiamge2];
        [aimageview addSubview:self.backgroundiamge3];
        
        
        
        self.moneyLab = [[UILabel alloc]init];
        //self.hkfLab.textAlignment = NSTextAlignmentRight;
        self.moneyLab.textAlignment = NSTextAlignmentCenter;
        self.moneyLab.frame =  CGRectMake(0, 90-79+64, width, 25);
        self.moneyLab.font = [UIFont systemFontOfSize: 20.0];
        [aview addSubview:self.moneyLab];
        
        UIButton * accoutbutton = [[UIButton alloc]init];
        accoutbutton.frame = CGRectMake(CGRectGetMinX(self.moneyLab.frame), CGRectGetMinY(self.moneyLab.frame), self.moneyLab.frame.size.width, self.moneyLab.frame.size.height+30+40+10);
//        accoutbutton.backgroundColor = [UIColor redColor];
        
        [accoutbutton addTarget:self action:@selector(myaccount) forControlEvents:UIControlEventTouchUpInside];
        [aview addSubview:accoutbutton];
        
        UILabel * lab = [[UILabel alloc]init];
        lab.text = @"账户总额(元)";
        lab.font = [UIFont systemFontOfSize: 14.0];
        lab.frame = CGRectMake(width/2 -45, CGRectGetMaxY(self.moneyLab.frame)+10, 90, 20);
        lab.textColor = [UIColor whiteColor];
        [aview addSubview:lab];
        
        
        self.symoneyLab = [[UILabel alloc]init];
        self.symoneyLab.textAlignment = NSTextAlignmentCenter;
        self.symoneyLab.frame = CGRectMake(0, test-25-10-30-20+64, width/2, 25);
        self.symoneyLab.textAlignment = NSTextAlignmentCenter;;
        self.symoneyLab.font = [UIFont systemFontOfSize: 20.0];
        [aview addSubview:self.symoneyLab];
        
        
        UILabel * mytestlab = [[UILabel alloc]init];
        mytestlab.frame = CGRectMake(width/2-1, CGRectGetMinY(self.symoneyLab.frame)+5, 1, 40);
        
        [aview addSubview:mytestlab];
        
        mytestlab.backgroundColor = [UIColor whiteColor];
        
        UILabel * lab2 = [[UILabel alloc]init];
        lab2.textColor = [UIColor whiteColor];
        lab2.frame = CGRectMake(0, CGRectGetMaxY(self.symoneyLab.frame)+3 , width/2, 20);
        lab2.textAlignment = NSTextAlignmentCenter;
        lab2.text = @"累计收益(元)";
        lab2.font = [UIFont systemFontOfSize: 14.0];
        [aview addSubview:lab2];
        
        self.kymoneyLab = [[UILabel alloc]init];
        self.kymoneyLab.font = [UIFont systemFontOfSize: 20.0];
        self.kymoneyLab.frame = CGRectMake(width/2, CGRectGetMinY(self.symoneyLab.frame), width/2, 25);
        //self.kymoneyLab.backgroundColor = [UIColor redColor];
        [aview addSubview:self.kymoneyLab];
        self.kymoneyLab.textAlignment = NSTextAlignmentCenter;
        
        self.kymoneyLab1 = [[UILabel alloc]init];
        
        self.kymoneyLab1.frame = CGRectMake(width/2, CGRectGetMinY(lab2.frame) , width/2, 20);
        
        self.kymoneyLab1.text = @"可用余额(元)";
        self.kymoneyLab1.textAlignment = NSTextAlignmentCenter;
        self.kymoneyLab1.textColor = [UIColor whiteColor];
        self.kymoneyLab1.font = [UIFont systemFontOfSize: 14.0];
        [aview addSubview:self.kymoneyLab1];
        
        
        self.shauxiniamge = [[UIImageView alloc]init];
        
        self.shauxiniamge.frame = CGRectMake(CGRectGetMaxX(self.kymoneyLab1.frame)+4, CGRectGetMinY(self.kymoneyLab1.frame), 25, 25);
        self.shauxiniamge.userInteractionEnabled = YES;
        
        [self.shauxiniamge addGestureRecognizer:tap];
        self.shauxiniamge.image = [UIImage imageNamed:@"shuaxina"];
        
       // [aview addSubview:self.shauxiniamge];
        
        UIButton * czbtn = [[UIButton alloc]init];
        
        // czbtn.frame = CGRectMake(0, 400, 200, 100);
        czbtn.frame = CGRectMake(0, CGRectGetMaxY(aview.frame), width/2, 50);
        // czbtn.titleLabel.text = @"充值";
        [czbtn setTitle:@"充值" forState:UIControlStateNormal];
        [self.view addSubview:czbtn];
        [czbtn addTarget:self action:@selector(cbxcz) forControlEvents:UIControlEventTouchUpInside];
        //[czbtn setTintColor:[UIColor blackColor]];
        //czbtn.titleLabel.textColor = [UIColor blackColor];
        [czbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        czbtn.backgroundColor = [UIColor whiteColor];
        
        UIButton * tixbtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(czbtn.frame), CGRectGetMaxY(aview.frame), width/2, 50)];
        //txbtn.frame = CGRectMake(width/2, CGRectGetMaxY(aview.frame), width/2, 62);
        //txbtn.titleLabel.text = @"提现";
        tixbtn.backgroundColor = [UIColor whiteColor];
        [tixbtn setTitle:@"提现" forState:UIControlStateNormal];
        //[txbtn setTintColor:[UIColor blackColor]];
        // tixbtn.titleLabel.textColor = [UIColor blackColor];
        [tixbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [tixbtn addTarget:self action:@selector(cbxtixian) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:tixbtn];
        
        UIImageView * cbxView = [[UIImageView alloc]init];
        cbxView.frame = CGRectMake(width/2, CGRectGetMaxY(aview.frame)+5, 1, 40);
        
        cbxView.backgroundColor = [RHUtility colorForHex:@"#c6c6c6"];
        
        [self.view addSubview:cbxView];
        
        for (int j = 0; j < 3 ; j++) {
            
            for (int i = 0 ; i < 3; i ++) {
                
                UIButton * button = [[UIButton alloc]init];
                
                button.frame = CGRectMake(i * width/3, CGRectGetMaxY(tixbtn.frame)+10+j*85, width/3, 85);
                button.backgroundColor = [UIColor whiteColor];
                //[button setTitle:self.array[j*3+i ] forState:UIControlStateNormal];
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                // [button setImage:[UIImage imageNamed:@"jsqsx"] forState:UIControlStateNormal];
                [self.view addSubview:button];
                button.tag = 1111+j*3+i;
                UIImageView * ynaimage = [[UIImageView alloc]init];
                ynaimage.frame = CGRectMake(width/3/2-14, 20, 28, 28);
                ynaimage.image = [UIImage imageNamed:self.imagearray[j*3+i]];
                
                [button addSubview:ynaimage];
                [button addTarget:self action:@selector(cbxaccont:) forControlEvents:UIControlEventTouchUpInside];
                
                UILabel * ynlab = [[UILabel alloc]init];
                ynlab.frame = CGRectMake(10-5, CGRectGetMaxY(ynaimage.frame)+5, 100, 30);
                ynlab.text = self.array[j*3+i ];
                ynlab.textAlignment = NSTextAlignmentCenter;
                ynlab.textColor = [RHUtility colorForHex:@"#232323"];
                ynlab.font = [UIFont systemFontOfSize: 14.0];
                [button addSubview:ynlab];
                
                
                UIImageView * cbxoneimage = [[UIImageView alloc]init];
                cbxoneimage.frame = CGRectMake(CGRectGetMinX(button.frame), CGRectGetMaxY(button.frame)-1, width/3, 1);
               
                
                if (j!=2) {
                    [self.view addSubview:cbxoneimage];
                }
                cbxoneimage.backgroundColor = [RHUtility colorForHex:@"#c6c6c6"];
                UIImageView * cbxtwoimage = [[UIImageView alloc]init];
                cbxtwoimage.frame = CGRectMake(CGRectGetMaxX(button.frame)-1, CGRectGetMinY(button.frame), 1, 85);
                [self.view addSubview:cbxtwoimage];
                cbxtwoimage.backgroundColor = [RHUtility colorForHex:@"#c6c6c6"];
                // cbxtwoimage.backgroundColor = [UIColor redColor];
                
                //ynlab.backgroundColor = [UIColor redColor];
                
                if (j==2&&i==2) {
                    ynlab.textColor = [RHUtility colorForHex:@"#999999"];
                }
            }
            
            
            
            
        }


        
        
    }else if( height < 736&&height> 568){
        
        test = 275-69;
        
        UIView * aview = [[UIView alloc]init];
        aview.frame = CGRectMake(0, -64, width, test+64);
        aview.backgroundColor = [RHUtility colorForHex:@"#44bbc1"];
        [self.view addSubview:aview];
        UIImageView * aimageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"背景个人中心"]];
        
        aimageview.frame = CGRectMake(0, 0, width, test+64);
        
        [aview addSubview:aimageview];
        
        self.backgroundiamge = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Path1"]];
        self.backgroundiamge2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Path2"]];
        self.backgroundiamge3 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Path3"]];
        
        self.backgroundiamge.frame =CGRectMake(-150, CGRectGetMaxY(aimageview.frame)-80, [UIScreen mainScreen].bounds.size.width+300, 100);
        self.backgroundiamge2.frame =CGRectMake(-150, CGRectGetMaxY(aimageview.frame)-80, [UIScreen mainScreen].bounds.size.width+300, 100);
        self.backgroundiamge3.frame =CGRectMake(-150, CGRectGetMaxY(aimageview.frame)-80, [UIScreen mainScreen].bounds.size.width+300, 100);
        [aimageview addSubview:self.backgroundiamge];
        [aimageview addSubview:self.backgroundiamge2];
        [aimageview addSubview:self.backgroundiamge3];
        
        
        
        
        UILabel * lab = [[UILabel alloc]init];
        lab.text = @"账户总额(元)";
        lab.font = [UIFont systemFontOfSize: 14.0];
        lab.frame = CGRectMake(width/2 -45, 150-69-10-5+64, 90, 40);
        lab.textColor = [UIColor whiteColor];
        [aview addSubview:lab];
        self.moneyLab = [[UILabel alloc]init];
       
        
        //self.hkfLab.textAlignment = NSTextAlignmentRight;
        self.moneyLab.textAlignment = NSTextAlignmentCenter;
        self.moneyLab.frame =  CGRectMake(width/2 - 100, 90 - 69+64, 200, 60);
        self.moneyLab.font = [UIFont systemFontOfSize: 28.0];
        [aview addSubview:self.moneyLab];
        
        UIButton * accoutbutton = [[UIButton alloc]init];
        accoutbutton.frame = CGRectMake(CGRectGetMinX(self.moneyLab.frame)-40-30, CGRectGetMinY(self.moneyLab.frame), self.moneyLab.frame.size.width+120+30, self.moneyLab.frame.size.height+80+40);
//        accoutbutton.backgroundColor = [UIColor redColor];
        
         [accoutbutton addTarget:self action:@selector(myaccount) forControlEvents:UIControlEventTouchUpInside];
        [aview addSubview:accoutbutton];
        
        self.symoneyLab = [[UILabel alloc]init];
        self.symoneyLab.textAlignment = NSTextAlignmentCenter;
        self.symoneyLab.frame = CGRectMake(10, test-25-30-20+64, width/2-10-10, 40);
        self.symoneyLab.font = [UIFont systemFontOfSize: 24.0];
        [aview addSubview:self.symoneyLab];
        
        UILabel * mytestlab = [[UILabel alloc]init];
        mytestlab.frame = CGRectMake(width/2-1, CGRectGetMinY(self.symoneyLab.frame)+15, 1, 40);
        
        [aview addSubview:mytestlab];
        
        mytestlab.backgroundColor = [UIColor whiteColor];
        
        
        UILabel * lab2 = [[UILabel alloc]init];
        lab2.textColor = [UIColor whiteColor];
        lab2.frame = CGRectMake(52, CGRectGetMaxY(self.symoneyLab.frame) , width/2-52-52, 30);
        lab2.text = @"累计收益(元)";
        lab2.font = [UIFont systemFontOfSize: 14.0];
        [aview addSubview:lab2];
        
        self.kymoneyLab = [[UILabel alloc]init];
        self.kymoneyLab.font = [UIFont systemFontOfSize: 24.0];
        self.kymoneyLab.frame = CGRectMake(width/2 + 10, test-25-30 -20+64, width/2-10-10, 40);
        //self.kymoneyLab.backgroundColor = [UIColor redColor];
        [aview addSubview:self.kymoneyLab];
        self.kymoneyLab.textAlignment = NSTextAlignmentCenter;
        
        self.kymoneyLab1 = [[UILabel alloc]init];
        
        self.kymoneyLab1.frame = CGRectMake(width/2+52, CGRectGetMaxY(self.symoneyLab.frame) , width/2-52-52, 30);
        
        self.kymoneyLab1.text = @"可用余额(元)";
        self.kymoneyLab1.textColor = [UIColor whiteColor];
        self.kymoneyLab1.font = [UIFont systemFontOfSize: 14.0];
        [aview addSubview:self.kymoneyLab1];
        
        
        self.shauxiniamge = [[UIImageView alloc]init];
        
        self.shauxiniamge.frame = CGRectMake(CGRectGetMaxX(self.kymoneyLab1.frame)+4, CGRectGetMinY(self.kymoneyLab1.frame), 25, 25);
        self.shauxiniamge.userInteractionEnabled = YES;
        
        [self.shauxiniamge addGestureRecognizer:tap];
        self.shauxiniamge.image = [UIImage imageNamed:@"shuaxina"];
        
     //   [aview addSubview:self.shauxiniamge];
        
        UIButton * czbtn = [[UIButton alloc]init];
        
       // czbtn.frame = CGRectMake(0, 400, 200, 100);
        czbtn.frame = CGRectMake(0, CGRectGetMaxY(aview.frame), width/2, 62);
       // czbtn.titleLabel.text = @"充值";
        [czbtn setTitle:@"充值" forState:UIControlStateNormal];
        [self.view addSubview:czbtn];
        [czbtn addTarget:self action:@selector(cbxcz) forControlEvents:UIControlEventTouchUpInside];
        //[czbtn setTintColor:[UIColor blackColor]];
        //czbtn.titleLabel.textColor = [UIColor blackColor];
        [czbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        czbtn.backgroundColor = [UIColor whiteColor];
        
        UIButton * tixbtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(czbtn.frame), CGRectGetMaxY(aview.frame), width/2, 62)];
        //txbtn.frame = CGRectMake(width/2, CGRectGetMaxY(aview.frame), width/2, 62);
        //txbtn.titleLabel.text = @"提现";
        tixbtn.backgroundColor = [UIColor whiteColor];
        [tixbtn setTitle:@"提现" forState:UIControlStateNormal];
        //[txbtn setTintColor:[UIColor blackColor]];
       // tixbtn.titleLabel.textColor = [UIColor blackColor];
         [tixbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [tixbtn addTarget:self action:@selector(cbxtixian) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:tixbtn];
        
        UIImageView * cbxView = [[UIImageView alloc]init];
        cbxView.frame = CGRectMake(width/2, CGRectGetMaxY(aview.frame)+10, 1, 42);
        
        cbxView.backgroundColor = [RHUtility colorForHex:@"#c6c6c6"];
        
        [self.view addSubview:cbxView];
        
        for (int j = 0; j < 3 ; j++) {
        
            for (int i = 0 ; i < 3; i ++) {
            
            UIButton * button = [[UIButton alloc]init];
            
            button.frame = CGRectMake(i * width/3, CGRectGetMaxY(tixbtn.frame)+9+j*90, width/3, 90);
                button.backgroundColor = [UIColor whiteColor];
                //[button setTitle:self.array[j*3+i ] forState:UIControlStateNormal];
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
               // [button setImage:[UIImage imageNamed:@"jsqsx"] forState:UIControlStateNormal];
                [self.view addSubview:button];
                button.tag = 1111+j*3+i;
                UIImageView * ynaimage = [[UIImageView alloc]init];
                ynaimage.frame = CGRectMake(width/3/2-14, 20, 28, 28);
                ynaimage.image = [UIImage imageNamed:self.imagearray[j*3+i]];
                
                [button addSubview:ynaimage];
                [button addTarget:self action:@selector(cbxaccont:) forControlEvents:UIControlEventTouchUpInside];
                
                UILabel * ynlab = [[UILabel alloc]init];
                ynlab.frame = CGRectMake(10, CGRectGetMaxY(ynaimage.frame)+5, 100, 30);
                ynlab.text = self.array[j*3+i ];
                ynlab.textAlignment = NSTextAlignmentCenter;
                ynlab.textColor = [RHUtility colorForHex:@"#232323"];
                [button addSubview:ynlab];
                
                
                    UIImageView * cbxoneimage = [[UIImageView alloc]init];
                    cbxoneimage.frame = CGRectMake(CGRectGetMinX(button.frame), CGRectGetMaxY(button.frame)-1, width/3, 1);
                if (j!=2) {
                    [self.view addSubview:cbxoneimage];
                }
                    cbxoneimage.backgroundColor = [RHUtility colorForHex:@"#c6c6c6"];
                    UIImageView * cbxtwoimage = [[UIImageView alloc]init];
                    cbxtwoimage.frame = CGRectMake(CGRectGetMaxX(button.frame)-1, CGRectGetMinY(button.frame), 1, 90);
                    [self.view addSubview:cbxtwoimage];
                    cbxtwoimage.backgroundColor = [RHUtility colorForHex:@"#c6c6c6"];
                   // cbxtwoimage.backgroundColor = [UIColor redColor];
                
                //ynlab.backgroundColor = [UIColor redColor];
                if (j==2&&i==2) {
                    ynlab.textColor = [RHUtility colorForHex:@"#999999"];
                }
            }
            
            
            
        
        }
        
        
    }else{
        
        //  shiyan
        
        
        test = 275-69;
        
        UIView * aview = [[UIView alloc]init];
        aview.frame = CGRectMake(0, -64, width, test+64);
        
        if ([UIScreen mainScreen].bounds.size.height>740) {
            test = 275-69+40;
            aview.frame = CGRectMake(0, -94, width, test+64);
        }
        aview.backgroundColor = [RHUtility colorForHex:@"#44bbc1"];
        [self.view addSubview:aview];
        UIImageView * aimageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"背景个人中心"]];
        
        aimageview.frame = CGRectMake(0, 0, width, test+64);
        
        [aview addSubview:aimageview];
        
        self.backgroundiamge = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Path1"]];
        self.backgroundiamge2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Path2"]];
        self.backgroundiamge3 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Path3"]];
        
        self.backgroundiamge.frame =CGRectMake(-150, CGRectGetMaxY(aimageview.frame)-80, [UIScreen mainScreen].bounds.size.width+300, 100);
        self.backgroundiamge2.frame =CGRectMake(-150, CGRectGetMaxY(aimageview.frame)-80, [UIScreen mainScreen].bounds.size.width+300, 100);
        self.backgroundiamge3.frame =CGRectMake(-150, CGRectGetMaxY(aimageview.frame)-80, [UIScreen mainScreen].bounds.size.width+300, 100);
        [aimageview addSubview:self.backgroundiamge];
        [aimageview addSubview:self.backgroundiamge2];
        [aimageview addSubview:self.backgroundiamge3];
        
        
        
        
        
        UILabel * lab = [[UILabel alloc]init];
        lab.text = @"账户总额(元)";
        lab.font = [UIFont systemFontOfSize: 14.0];
        lab.frame = CGRectMake(width/2 -45, 150-69-10-5+64, 90, 40);
        lab.textColor = [UIColor whiteColor];
        [aview addSubview:lab];
        self.moneyLab = [[UILabel alloc]init];
        //self.hkfLab.textAlignment = NSTextAlignmentRight;
        self.moneyLab.textAlignment = NSTextAlignmentCenter;
        self.moneyLab.frame =  CGRectMake(width/2 - 100, 90 - 69+64, 200, 60);
        self.moneyLab.font = [UIFont systemFontOfSize: 28.0];
        [aview addSubview:self.moneyLab];
        if ([UIScreen mainScreen].bounds.size.height>740) {
           lab.frame = CGRectMake(width/2 -45, 150-69-10-5+64+25, 90, 40);
             self.moneyLab.frame =  CGRectMake(width/2 - 100, 90 - 69+64+25, 200, 60);
        }
        
        UIButton * accoutbutton = [[UIButton alloc]init];
        accoutbutton.frame = CGRectMake(CGRectGetMinX(self.moneyLab.frame)-40-30, CGRectGetMinY(self.moneyLab.frame), self.moneyLab.frame.size.width+120+30, self.moneyLab.frame.size.height+80+40);
//        accoutbutton.backgroundColor = [UIColor redColor];
        
         [accoutbutton addTarget:self action:@selector(myaccount) forControlEvents:UIControlEventTouchUpInside];
        [aview addSubview:accoutbutton];
        
        self.symoneyLab = [[UILabel alloc]init];
        self.symoneyLab.textAlignment = NSTextAlignmentCenter;
        self.symoneyLab.frame = CGRectMake(0, test-25-30-20+64, width/2, 40);
        self.symoneyLab.textAlignment = NSTextAlignmentCenter;
        self.symoneyLab.font = [UIFont systemFontOfSize: 26.0];
        [aview addSubview:self.symoneyLab];
        
        UILabel * mytestlab = [[UILabel alloc]init];
        mytestlab.frame = CGRectMake(width/2-1, CGRectGetMinY(self.symoneyLab.frame)+15, 1, 40);
        
        [aview addSubview:mytestlab];
        
        mytestlab.backgroundColor = [UIColor whiteColor];
        
        UILabel * lab2 = [[UILabel alloc]init];
        lab2.textColor = [UIColor whiteColor];
        lab2.frame = CGRectMake(52, CGRectGetMaxY(self.symoneyLab.frame)-10 , width/2-52-52, 30);
        lab2.textAlignment =  NSTextAlignmentCenter;
        lab2.text = @"累计收益(元)";
        lab2.font = [UIFont systemFontOfSize: 14.0];
        [aview addSubview:lab2];
        
        self.kymoneyLab = [[UILabel alloc]init];
        self.kymoneyLab.font = [UIFont systemFontOfSize: 26.0];
        self.kymoneyLab.frame = CGRectMake(width/2 + 10, test-25-30-20+64, width/2-10-10, 40);
        //self.kymoneyLab.backgroundColor = [UIColor redColor];
        [aview addSubview:self.kymoneyLab];
        self.kymoneyLab.textAlignment = NSTextAlignmentCenter;
        
        self.kymoneyLab1 = [[UILabel alloc]init];
        self.kymoneyLab1.textAlignment = NSTextAlignmentCenter;
        self.kymoneyLab1.frame = CGRectMake(width/2+52, CGRectGetMinY(lab2.frame) , width/2-52-52, 30);
        
        self.kymoneyLab1.text = @"可用余额(元)";
        self.kymoneyLab1.textColor = [UIColor whiteColor];
        self.kymoneyLab1.font = [UIFont systemFontOfSize: 14.0];
        [aview addSubview:self.kymoneyLab1];
        
        self.shauxiniamge = [[UIImageView alloc]init];
        
        self.shauxiniamge.frame = CGRectMake(CGRectGetMaxX(self.kymoneyLab1.frame)+4, CGRectGetMinY(self.kymoneyLab1.frame), 25, 25);
        self.shauxiniamge.userInteractionEnabled = YES;
        
        [self.shauxiniamge addGestureRecognizer:tap];
        self.shauxiniamge.image = [UIImage imageNamed:@"shuaxina"];
        
    //    [aview addSubview:self.shauxiniamge];
        
        UIButton * czbtn = [[UIButton alloc]init];
        
        // czbtn.frame = CGRectMake(0, 400, 200, 100);
        czbtn.frame = CGRectMake(0, CGRectGetMaxY(aview.frame), width/2, 62);
        // czbtn.titleLabel.text = @"充值";
        [czbtn setTitle:@"充值" forState:UIControlStateNormal];
        [self.view addSubview:czbtn];
        [czbtn addTarget:self action:@selector(cbxcz) forControlEvents:UIControlEventTouchUpInside];
        //[czbtn setTintColor:[UIColor blackColor]];
        //czbtn.titleLabel.textColor = [UIColor blackColor];
        [czbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        czbtn.backgroundColor = [UIColor whiteColor];
        
        UIButton * tixbtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(czbtn.frame), CGRectGetMaxY(aview.frame), width/2, 62)];
        //txbtn.frame = CGRectMake(width/2, CGRectGetMaxY(aview.frame), width/2, 62);
        //txbtn.titleLabel.text = @"提现";
        tixbtn.backgroundColor = [UIColor whiteColor];
        [tixbtn setTitle:@"提现" forState:UIControlStateNormal];
        //[txbtn setTintColor:[UIColor blackColor]];
        // tixbtn.titleLabel.textColor = [UIColor blackColor];
        [tixbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [tixbtn addTarget:self action:@selector(cbxtixian) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:tixbtn];
        
        UIImageView * cbxView = [[UIImageView alloc]init];
        cbxView.frame = CGRectMake(width/2, CGRectGetMaxY(aview.frame)+10, 1, 42);
        
        cbxView.backgroundColor = [RHUtility colorForHex:@"#c6c6c6"];
        
        [self.view addSubview:cbxView];
        
        for (int j = 0; j < 3 ; j++) {
            
            for (int i = 0 ; i < 3; i ++) {
                
                UIButton * button = [[UIButton alloc]init];
                
                button.frame = CGRectMake(i * width/3, CGRectGetMaxY(tixbtn.frame)+10+j*110, width/3, 110);
                button.backgroundColor = [UIColor whiteColor];
                //[button setTitle:self.array[j*3+i ] forState:UIControlStateNormal];
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                // [button setImage:[UIImage imageNamed:@"jsqsx"] forState:UIControlStateNormal];
                [self.view addSubview:button];
                button.tag = 1111+j*3+i;
                UIImageView * ynaimage = [[UIImageView alloc]init];
                ynaimage.frame = CGRectMake(width/3/2-14, 20+5, 28, 28);
                ynaimage.image = [UIImage imageNamed:self.imagearray[j*3+i]];
                
                [button addSubview:ynaimage];
                [button addTarget:self action:@selector(cbxaccont:) forControlEvents:UIControlEventTouchUpInside];
                
                UILabel * ynlab = [[UILabel alloc]init];
                ynlab.frame = CGRectMake(0, CGRectGetMaxY(ynaimage.frame)+5, width/3, 30);
                ynlab.text = self.array[j*3+i ];
                ynlab.textAlignment = NSTextAlignmentCenter;
                ynlab.textColor = [RHUtility colorForHex:@"#232323"];
                [button addSubview:ynlab];
                
                
                UIImageView * cbxoneimage = [[UIImageView alloc]init];
                cbxoneimage.frame = CGRectMake(CGRectGetMinX(button.frame), CGRectGetMaxY(button.frame)-1, width/3, 1);
                if (j!=2) {
                    [self.view addSubview:cbxoneimage];
                }
                cbxoneimage.backgroundColor = [RHUtility colorForHex:@"#c6c6c6"];
                UIImageView * cbxtwoimage = [[UIImageView alloc]init];
                cbxtwoimage.frame = CGRectMake(CGRectGetMaxX(button.frame)-1, CGRectGetMinY(button.frame), 1, 110);
                [self.view addSubview:cbxtwoimage];
                cbxtwoimage.backgroundColor = [RHUtility colorForHex:@"#c6c6c6"];
                // cbxtwoimage.backgroundColor = [UIColor redColor];
                
                //ynlab.backgroundColor = [UIColor redColor];
                if (j==2&&i==2) {
                    ynlab.textColor = [RHUtility colorForHex:@"#999999"];
                }
            }
            
            
            
            
        }
        
    }
    
//    self.view.backgroundColor = [RHUtility colorForHex:@"#DCE6EB"];
    
    
    
}

-(void)khbutton:(UIButton *)sender{
    [DQViewController Sharedbxtabar].tarbar.hidden = YES;

    RHOpenCountViewController* controller1=[[RHOpenCountViewController alloc]initWithNibName:@"RHOpenCountViewController" bundle:nil];
    [self.navigationController pushViewController:controller1 animated:NO];
//    NSLog(@"开通汇付");
    
}

- (void)cbxcz{
    
    //[self.giftView removeFromSuperview];
    
    
    
    if ([RHUserManager sharedInterface].custId.length>0) {
        
        if (![self.passwordbool isEqualToString:@"yes"]) {
            
            [self.bankbtn setTitle:@"设置交易密码" forState:UIControlStateNormal];
            self.banklab.text = @"资金更安全，请先设置交易密码再进行出借／提现";
            self.mengbanview.hidden = NO;
            self.kaihuview.hidden = NO;
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            return ;
        }
        self.navigationController.navigationBar.subviews.firstObject.alpha = 1;
        [DQViewController Sharedbxtabar].tarbar.hidden = YES;
    RHRechargeViewController* controller=[[RHRechargeViewController alloc]initWithNibName:@"RHRechargeViewController" bundle:nil];
    controller.balance=self.kymoneyLab.text;
        controller.bankdic = self.bankdic;
        controller.bankress = self.bankress;
//        controller.baofuress = @"1";
    [self.navigationController pushViewController:controller animated:NO];
        
    NSLog(@"cbxcz");
    }else{
        
       
        self.mengbanview.hidden = NO;
        self.kaihuview.hidden = NO;
       
    }
    
}

- (void)cbxtixian{
    
    if ([RHUserManager sharedInterface].custId.length<=0) {
        
        
        
  
        self.mengbanview.hidden = NO;
        self.kaihuview.hidden = NO;
        
     
    }
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[RHNetworkService instance] POST:@"app/front/payment/appBankCardJx/isBindBankCard" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            //NSDictionary * array = responseObject[@"cards"];
            self.navigationController.navigationBar.subviews.firstObject.alpha = 1;
            if ([RHUserManager sharedInterface].custId.length>0) {
                if (![self.passwordbool isEqualToString:@"yes"]) {
                    
                    [self.bankbtn setTitle:@"设置交易密码" forState:UIControlStateNormal];
                    self.banklab.text = @"资金更安全，请先设置交易密码再进行出借／提现";
                    self.mengbanview.hidden = NO;
                    self.kaihuview.hidden = NO;
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                    return ;
                }
                if ([responseObject[@"msg"] isEqualToString:@"notBank"]) {
//                    [RHUtility showTextWithText:@"meiyoutixianka"];
                    self.mengbanview.hidden = NO;
                    self.kaihuview.hidden = NO;
                   
                    [self.bankbtn setTitle:@"立即绑卡" forState:UIControlStateNormal];
                    self.tishilable.text = @"绑卡提示：";
                    self.banklab.text = @"资金更安全，请先绑定银行卡再进行充值／提现";
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                    return ;
                }
                
                RHWithdrawViewController* controller=[[RHWithdrawViewController alloc] initWithNibName:@"RHWithdrawViewController" bundle:nil];
                controller.bankdic = self.bankdic;
                controller.hidesBottomBarWhenPushed = YES;
                controller.myswitch = self.sqswitch;
                [self.navigationController pushViewController:controller animated:NO];
            }else{
                
                self.mengbanview.hidden = NO;
                self.kaihuview.hidden = NO;
               
            }
            
        }
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSLog(@"%@---",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSLog(@"%@",error);
        
    }];
    
    
   
}
-(void)getmyjxpassword{
    
    [[RHNetworkService instance] POST:@"app/front/payment/appJxAccount/isSetPassword" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"----===============-1111---%@",responseObject);
        self.passwordbool = [NSString stringWithFormat:@"%@",responseObject[@"setPwd"]];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
        DLog(@"%@",[[NSString alloc] initWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
        
    }];
    
}
- (void)cbxaccont:(UIButton *)sender{
    self.navigationController.navigationBar.subviews.firstObject.alpha = 1;
    if (sender.tag == 1111) {
        
        RHMyInvestmentViewController* controller=[[RHMyInvestmentViewController alloc]initWithNibName:@"RHMyInvestmentViewController" bundle:nil];
        [DQViewController Sharedbxtabar].tarbar.hidden = YES;
      //  self.tabBarController.tabBar.hidden = YES;
        [self.navigationController pushViewController:controller animated:NO];
         controller.hidesBottomBarWhenPushed = YES;
//        self.hidesBottomBarWhenPushed=YES;
//        self.hidesBottomBarWhenPushed=YES;
        NSLog(@"我的出借");
    }else if (sender.tag==1112){
        
//        RHOpenAccountScuessViewController * vc1 = [[RHOpenAccountScuessViewController alloc]initWithNibName:@"RHOpenAccountScuessViewController" bundle:nil];
//        [self.navigationController pushViewController:vc1 animated:YES];
//        
//        return;
        RHRLViewController * vc = [RHRLViewController new];
        
        [DQViewController Sharedbxtabar].tarbar.hidden = YES;
        
         [self.navigationController pushViewController:vc animated:NO];
         NSLog(@"回款计划");
    }else if (sender.tag==1113){
        
//         [RHUtility showTextWithText:@"敬请期待"];
//        RHZQZRViewController * vc = [[RHZQZRViewController alloc]initWithNibName:@"RHZQZRViewController" bundle:nil];
//    
//        [DQViewController Sharedbxtabar].tarbar.hidden = YES;
//        [self.navigationController pushViewController:vc animated:YES];
        if ([RHUserManager sharedInterface].custId.length>0) {
            [self myaccount];
        }else{
            self.mengbanview.hidden = NO;
            self.kaihuview.hidden = NO;
        }
        
        
         NSLog(@"债权转让");
    }else if (sender.tag==1114){
        
        [DQViewController Sharedbxtabar].tarbar.hidden = YES;
        
//        if ([self.giftswitch isEqualToString:@"ON"]) {
//            RHXMJWebViewController *office = [[RHXMJWebViewController alloc] initWithNibName:@"RHXMJWebViewController" bundle:nil];
//            office.nametitle = @"我的红包";
//            office.xmjurl = [NSString stringWithFormat:@"%@app/common/appMain/giftAppLink",[RHNetworkService instance].newdoMain];
//            [self.navigationController pushViewController:office animated:NO];
//
//            return;
//        }
        
        RHMyGiftViewController* controller=[[RHMyGiftViewController alloc] initWithNibName:@"RHMyGiftViewController" bundle:nil];
        [self.navigationController pushViewController:controller animated:NO];
        controller.hidesBottomBarWhenPushed = YES;
        
         NSLog(@"我的红包");
    }else if (sender.tag==1115){
        [DQViewController Sharedbxtabar].tarbar.hidden = YES;
//        RHJPTableViewController * vc = [[RHJPTableViewController alloc] initWithNibName:@"RHJPTableViewController" bundle:nil];
        RHMynewgiftViewController * controller=[[RHMynewgiftViewController alloc] initWithNibName:@"RHMynewgiftViewController" bundle:nil];
        [self.navigationController pushViewController:controller animated:NO];
        
         NSLog(@"我的奖品");
    }else if (sender.tag==1116){
        [DQViewController Sharedbxtabar].tarbar.hidden = YES;
        RHFriendViewController * controller=[[RHFriendViewController alloc] initWithNibName:@"RHFriendViewController" bundle:nil];
        [self.navigationController pushViewController:controller animated:NO];
        
         NSLog(@"邀请好友");
    }else if (sender.tag==1117){
        
        
        if ([RHUserManager sharedInterface].custId.length>0) {
            
            if ([UIScreen mainScreen].bounds.size.height < 300){
                [DQViewController Sharedbxtabar].tarbar.hidden = YES;
                RHsmallMybankViewController * controller = [[RHsmallMybankViewController alloc]initWithNibName:@"RHsmallMybankViewController" bundle:nil];
                [self.navigationController pushViewController:controller animated:NO];
            }else{
                
                
            [DQViewController Sharedbxtabar].tarbar.hidden = YES;
            RHBngkCardDetailViewController * controller = [[RHBngkCardDetailViewController alloc]initWithNibName:@"RHBngkCardDetailViewController" bundle:nil];
                
                controller.passwordress = self.passwordbool;
                controller.ress = self.bankress;
            [self.navigationController pushViewController:controller animated:NO];
            }
            NSLog(@"银行卡");
        }else{
            self.mengbanview.hidden = NO;
            self.kaihuview.hidden = NO;
           
            
            
        }
        
    }else if (sender.tag==1118){
        
        [DQViewController Sharedbxtabar].tarbar.hidden = YES;
        // [[DQViewController Sharedbxtabar].tabBar setHidden:NO];
      
        RHTradingViewController * vc = [[RHTradingViewController alloc]initWithNibName:@"RHTradingViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:NO];
         NSLog(@"交易记录");
    }else if (sender.tag==1119){
        self.navigationController.navigationBar.subviews.firstObject.alpha = 0;
        return;
        if ([RHUserManager sharedInterface].custId.length>0) {
            
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            [[RHNetworkService instance] POST:@"app/front/payment/appAccount/appMyCashData" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                
                if ([responseObject isKindOfClass:[NSDictionary class]]) {
                    NSArray * array = responseObject[@"cards"];
                    if ([RHUserManager sharedInterface].custId.length>0) {
                        
                        if (array.count <1) {
                            //                    [RHUtility showTextWithText:@"meiyoutixianka"];
                            self.mengbanview.hidden = NO;
                            self.kaihuview.hidden = NO;
                            
                            [self.bankbtn setTitle:@"去绑提现银行卡" forState:UIControlStateNormal];
                            self.tishilable.text = @"绑卡提示：";
                            self.banklab.text = @"您尚未绑定提现银行卡，请先绑定再提现。";
                            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                            self.navigationController.navigationBar.subviews.firstObject.alpha = 0;
                            return ;
                        }
                        [DQViewController Sharedbxtabar].tarbar.hidden = YES;
                        RHSLBViewController * vc = [[RHSLBViewController alloc]initWithNibName:@"RHSLBViewController" bundle:nil];
                        
                        
                        vc.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:vc animated:NO];
                    }else{
                        
                        self.mengbanview.hidden = NO;
                        self.kaihuview.hidden = NO;
                       
                    }
                    
                }
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                NSLog(@"%@---",responseObject);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                ;
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                NSLog(@"%@",error);
                
                
            }];
            
         NSLog(@"生利包");
            
        }else{
            [self cbxtixian];
            
        }
    }
    
    

}

-(void)getMyAccountData1
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"动画shuaxin" ofType:@"gif"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    //self.shauxiniamge.image = [UIImage sd_animatedGIFWithData:data];
    
    NSString * str = @"app/front/payment/appJxAccount/myAccountData";
    //    NSString * newstr = @"app/front/payment/appAccount/appMyAccountData";
   // [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[RHNetworkService instance] POST:str parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"%@",responseObject);
        
        NSString* average=@"0.00";
        if (![[responseObject objectForKey:@"average"] isKindOfClass:[NSNull class]]) {
            average=[responseObject objectForKey:@"average"] ;
        }
        // self.averageLabel.text=average;
        
        NSString* FrzBal=@"0.00";
        if (![[responseObject objectForKey:@"FrzBal"] isKindOfClass:[NSNull class]]) {
            FrzBal=[responseObject objectForKey:@"FrzBal"] ;
        }
        //self.FrzBalLabel.text=FrzBal;
        
        NSString* AvlBal=@"0.00";
        if (![[responseObject objectForKey:@"AvlBal"] isKindOfClass:[NSNull class]]) {
            AvlBal=[responseObject objectForKey:@"AvlBal"] ;
        }
        //self.balanceLabel.text=AvlBal; 可用
        self.kymoneyLab.text = AvlBal;
        NSString* total=@"0.00元";
        if (![[responseObject objectForKey:@"total"] isKindOfClass:[NSNull class]]) {
            total=[responseObject objectForKey:@"total"] ;
        }
        total = [NSString stringWithFormat:@"%@",total];
        
        NSMutableAttributedString *arrString = [[NSMutableAttributedString alloc] initWithString:total];
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor grayColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:15.0],NSFontAttributeName, nil];
        [arrString addAttributes:dic range:NSMakeRange(total.length - 1, 1)];
        //  self.totalLabel.attributedText = arrString; 总资产
        //        self.moneyLab.attributedText = arrString;
        if (![total isEqualToString:@"(null)"]) {
            self.moneyLab.text  = total;
        }
        
        NSString* collectCapital=@"0.00";
        if (![[responseObject objectForKey:@"collectCapital"] isKindOfClass:[NSNull class]]) {
            collectCapital=[responseObject objectForKey:@"collectCapital"] ;
        }
        // self.collectCapitalLabel.text=collectCapital;
        NSString* collectInterest=@"0";
        if (![[responseObject objectForKey:@"collectInterest"] isKindOfClass:[NSNull class]]) {
            collectInterest=[responseObject objectForKey:@"collectInterest"] ;
        }
        // self.collectInterestLabel.text=collectInterest;
        
        NSString* collect=@"0.00";
        if (![[responseObject objectForKey:@"collect"] isKindOfClass:[NSNull class]]) {
            collect=[responseObject objectForKey:@"collect"];
        }
        // self.collectPrepaymentPenaltyLabel.text=collect;
        
        NSString* earnInterest=@"0.00";
        if (![[responseObject objectForKey:@"earnedInRYH"] isKindOfClass:[NSNull class]]) {
            earnInterest=[responseObject objectForKey:@"earnedInRYH"];
        }
        self.symoneyLab.text = earnInterest;
        
        // self.earnInterestLabel.text=earnInterest; 收益
        
        NSString* investCash=@"0.00";
        if (![[responseObject objectForKey:@"insteadCash"] isKindOfClass:[NSNull class]]) {
            investCash=[responseObject objectForKey:@"insteadCash"];
        }
        if (investCash.length <= 0) {
            investCash = @"0.00";
        }
        // self.investCashLabel.text=investCash;
        
        NSString* ProfitCash=@"0.00";
        if (![[responseObject objectForKey:@"rebateCash"] isKindOfClass:[NSNull class]]) {
            ProfitCash=[responseObject objectForKey:@"rebateCash"];
        }
        if (ProfitCash.length <= 0) {
            ProfitCash = @"0.00";
        }
       // self.shauxiniamge.image = [UIImage imageNamed:@"shuaxina"];
        [RHUtility showTextWithText:@"刷新成功"];
        //self.profitCashLabel.text=ProfitCash;
        //[MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //        DLog(@"%@",error);
    //    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        DLog(@"2222%@",[[NSString alloc] initWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
//        [[RHUserManager sharedInterface] logout];
//        [[RHTabbarManager sharedInterface] selectALogin];
    }];
}

-(void)getMyAccountData
{
    
    NSString * str = @"app/front/payment/appJxAccount/myAccountData";
//    NSString * newstr = @"app/front/payment/appAccount/appMyAccountData";
    NSString* session=[[NSUserDefaults standardUserDefaults] objectForKey:@"RHSESSION"];
    if (session&&[session length]>0) {
       // [manager.requestSerializer setValue:session forHTTPHeaderField:@"cookie"];
        
    }
    if (self.mobress) {
         [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[RHNetworkService instance] POST:str parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"%@",responseObject);
        
        NSString* average=@"0.00";
        if (![[responseObject objectForKey:@"average"] isKindOfClass:[NSNull class]]) {
            average=[responseObject objectForKey:@"average"] ;
        }
       // self.averageLabel.text=average;
        
        NSString* FrzBal=@"0.00";
        if (![[responseObject objectForKey:@"FrzBal"] isKindOfClass:[NSNull class]]) {
            FrzBal=[responseObject objectForKey:@"FrzBal"] ;
        }
        //self.FrzBalLabel.text=FrzBal;
        
        NSString* AvlBal=@"0.00";
        if (![[responseObject objectForKey:@"AvlBal"] isKindOfClass:[NSNull class]]) {
            AvlBal=[responseObject objectForKey:@"AvlBal"] ;
        }
        //self.balanceLabel.text=AvlBal; 可用
        self.kymoneyLab.text = AvlBal;
        NSString* total=@"0.00元";
        if (![[responseObject objectForKey:@"total"] isKindOfClass:[NSNull class]]) {
            total=[responseObject objectForKey:@"total"] ;
        }
        total = [NSString stringWithFormat:@"%@",total];
        
        NSMutableAttributedString *arrString = [[NSMutableAttributedString alloc] initWithString:total];
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor grayColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:15.0],NSFontAttributeName, nil];
        [arrString addAttributes:dic range:NSMakeRange(total.length - 1, 1)];
      //  self.totalLabel.attributedText = arrString; 总资产
//        self.moneyLab.attributedText = arrString;
        if (![total isEqualToString:@"(null)"]) {
            self.moneyLab.text  = total;
        }
        
        NSString* collectCapital=@"0.00";
        if (![[responseObject objectForKey:@"collectCapital"] isKindOfClass:[NSNull class]]) {
            collectCapital=[responseObject objectForKey:@"collectCapital"] ;
        }
       // self.collectCapitalLabel.text=collectCapital;
        NSString* collectInterest=@"0";
        if (![[responseObject objectForKey:@"collectInterest"] isKindOfClass:[NSNull class]]) {
            collectInterest=[responseObject objectForKey:@"collectInterest"] ;
        }
       // self.collectInterestLabel.text=collectInterest;
        
        NSString* collect=@"0.00";
        if (![[responseObject objectForKey:@"collect"] isKindOfClass:[NSNull class]]) {
            collect=[responseObject objectForKey:@"collect"];
        }
       // self.collectPrepaymentPenaltyLabel.text=collect;
        
        NSString* earnInterest=@"0.00";
        if (![[responseObject objectForKey:@"earnedInRYH"] isKindOfClass:[NSNull class]]) {
            earnInterest=[responseObject objectForKey:@"earnedInRYH"];
        }
        self.symoneyLab.text = earnInterest;
        
       // self.earnInterestLabel.text=earnInterest; 收益
        
        NSString* investCash=@"0.00";
        if (![[responseObject objectForKey:@"insteadCash"] isKindOfClass:[NSNull class]]) {
            investCash=[responseObject objectForKey:@"insteadCash"];
        }
        if (investCash.length <= 0) {
            investCash = @"0.00";
        }
       // self.investCashLabel.text=investCash;
        
        NSString* ProfitCash=@"0.00";
        if (![[responseObject objectForKey:@"rebateCash"] isKindOfClass:[NSNull class]]) {
            ProfitCash=[responseObject objectForKey:@"rebateCash"];
        }
        if (ProfitCash.length <= 0) {
            ProfitCash = @"0.00";
        }
        
        //self.profitCashLabel.text=ProfitCash;
         [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        self.mobress = YES;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //        DLog(@"%@",error);
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
         self.mobress = YES;
        NSLog(@"sessiom==111=====%@",session);
        [[RHUserManager sharedInterface] logout];
        [[RHTabbarManager sharedInterface] selectALogin];
        DLog(@"2222%@",[[NSString alloc] initWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
    }];
}



-(void)myaccount{
    
//    RHMyMoneyyViewController * vc = [[RHMyMoneyyViewController alloc]initWithNibName:@"RHMyMoneyyViewController" bundle:nil];
    
//    mytestsyViewController * vc = [[mytestsyViewController  alloc]initWithNibName:@"mytestsyViewController" bundle:nil];
    RHMyMoneyViewController * vc = [[RHMyMoneyViewController  alloc]initWithNibName:@"RHMyMoneyViewController" bundle:nil];
    
    [DQViewController Sharedbxtabar].tarbar.hidden = YES;
    [self.navigationController pushViewController:vc animated:NO];
    
}

- (IBAction)hiddenmengban:(id)sender {
     self.navigationController.navigationBar.subviews.firstObject.alpha = 0;
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    self.mengbanview.hidden = YES;
    self.kaihuview.hidden = YES;
}

- (IBAction)khttbutton:(id)sender {
    UIButton * btn = sender;
    if ([btn.titleLabel.text isEqualToString:@"设置交易密码"]) {
        
        RHJXPassWordViewController * controller =[[RHJXPassWordViewController alloc]initWithNibName:@"RHJXPassWordViewController" bundle:nil];
        
        controller.urlstr = @"app/front/payment/appJxAccount/passwordSetJxData";
        [DQViewController Sharedbxtabar].tarbar.hidden = YES;
        self.mengbanview.hidden = YES;
        self.kaihuview.hidden = YES;
        [self.navigationController pushViewController:controller animated:NO];
        return;
    }
    if ([btn.titleLabel.text isEqualToString:@"立即绑卡"]) {
        self.mengbanview.hidden = YES;
        self.kaihuview.hidden = YES;
        RHBngkCardDetailViewController * controller = [[RHBngkCardDetailViewController alloc]initWithNibName:@"RHBngkCardDetailViewController" bundle:nil];
         [DQViewController Sharedbxtabar].tarbar.hidden = YES;
        controller.ress = self.bankress;
        [self.navigationController pushViewController:controller animated:NO];
        [DQViewController Sharedbxtabar].tarbar.hidden = YES;
        //[self.navigationController pushViewController:vc animated:YES];
    }else{
     [DQViewController Sharedbxtabar].tarbar.hidden = YES;
    self.mengbanview.hidden = YES;
    self.kaihuview.hidden = YES;
        RHOpenCountViewController* controller1=[[RHOpenCountViewController alloc]initWithNibName:@"RHOpenCountViewController" bundle:nil];
        [self.navigationController pushViewController:controller1 animated:NO];
    
    NSLog(@"开通汇付");
    }
}


-(void)gif{
    RHMyGiftViewController* controller=[[RHMyGiftViewController alloc] initWithNibName:@"RHMyGiftViewController" bundle:nil];
    [RHhelper ShraeHelp].giftres =2;
    controller.myblock = ^{
        [self firsttouzi];
    };
    
    [self.navigationController pushViewController:controller animated:NO];
//    controller.hidesBottomBarWhenPushed = YES;
    
    NSLog(@"我的红包");
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 84;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.giftArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"CellIdentifier";
    RHShowGiftTableViewCell *cell = (RHShowGiftTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"RHShowGiftTableViewCell" owner:nil options:nil] objectAtIndex:0];
    }
    
    NSDictionary *dic = self.giftArray[indexPath.row];
    [cell setGiftData:dic];
    return cell;
    
}


-(void)startAnimation {

    
    
    CALayer *viewLayer = self.backgroundiamge.layer;
    // 获取当前View的位置
    CGPoint position = viewLayer.position;
    // 移动的两个终点位置
    CGPoint x = CGPointMake(position.x + 150, position.y);
    CGPoint y = CGPointMake(position.x - 150, position.y);
    // 设置动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    // 设置运动形式
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    // 设置开始位置
    [animation setFromValue:[NSValue valueWithCGPoint:x]];
    // 设置结束位置
    [animation setToValue:[NSValue valueWithCGPoint:y]];
    // 设置自动反转
    [animation setAutoreverses:YES];
    // 设置时间
    [animation setDuration:3];
    // 设置次数
    [animation setRepeatCount:9999999];
    // 添加上动画
    [viewLayer addAnimation:animation forKey:nil];
    
    
    CALayer *viewLayer1 = self.backgroundiamge2.layer;
    // 获取当前View的位置
    CGPoint position1 = viewLayer.position;
    // 移动的两个终点位置
    CGPoint x1 = CGPointMake(position1.x + 150, position1.y);
    CGPoint y1 = CGPointMake(position1.x - 150, position1.y);
    // 设置动画
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"position"];
    // 设置运动形式
    [animation1 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    // 设置开始位置
    [animation1 setFromValue:[NSValue valueWithCGPoint:x1]];
    // 设置结束位置
    [animation1 setToValue:[NSValue valueWithCGPoint:y1]];
    // 设置自动反转
    [animation1 setAutoreverses:YES];
    // 设置时间
    [animation1 setDuration:3.5];
    // 设置次数
    [animation1 setRepeatCount:9999999];
    // 添加上动画
    [viewLayer1 addAnimation:animation1 forKey:nil];
    
    
    
    CALayer *viewLayer2 = self.backgroundiamge3.layer;
    // 获取当前View的位置
    CGPoint position2 = viewLayer.position;
    // 移动的两个终点位置
    CGPoint x2 = CGPointMake(position2.x + 150, position2.y);
    CGPoint y2 = CGPointMake(position2.x - 150, position2.y);
    // 设置动画
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"position"];
    // 设置运动形式
    [animation2 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    // 设置开始位置
    [animation2 setFromValue:[NSValue valueWithCGPoint:x2]];
    // 设置结束位置
    [animation2 setToValue:[NSValue valueWithCGPoint:y2]];
    // 设置自动反转
    [animation2 setAutoreverses:YES];
    // 设置时间
    [animation2 setDuration:2.5];
    // 设置次数
    [animation2 setRepeatCount:9999999];
    // 添加上动画
    [viewLayer2 addAnimation:animation2 forKey:nil];
}

-(void)stopAnimation {
    [self.backgroundiamge.layer removeAllAnimations];
    [self.backgroundiamgecopy.layer removeAllAnimations];
}


-(void)sqmyswitch{
    
    [[RHNetworkService instance] POST:@"front/payment/reformAccountJx/authSwitch" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        DLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            self.sqswitch = responseObject[@"checkSwitch"];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //  NSLog(@"%@",error);
        DLog(@"%@",[[NSString alloc] initWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
        
    }];
    
}

@end
