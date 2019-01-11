//
//  RHErrorViewController.m
//  ryhui
//
//  Created by 江 云龙 on 15/3/30.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHErrorViewController.h"
#import "RHProjectListViewController.h"
#import "RHMyAccountViewController.h"
#import "RHMyInvestmentViewController.h"
#import "RHMyGiftViewController.h"
#import "RHBankListViewController.h"
#import "RHInvestmentViewController.h"
#import "RHUserCountViewController.h"
#import "RHWithdrawViewController.h"
#import "RHRechargeViewController.h"
#import "RHhelper.h"
#import "RHMoreWebViewViewController.h"
#import "RHShowGiftTableViewCell.h"
@interface RHErrorViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIButton *firstbutton;

@property (weak, nonatomic) IBOutlet UIButton *secButton;
@property (weak, nonatomic) IBOutlet UIView *errorView;
@property (weak, nonatomic) IBOutlet UIImageView *errorImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipsLabel;
@property (weak, nonatomic) IBOutlet UILabel *backlab;

@property (weak, nonatomic) IBOutlet UITableView *giftTableView;
//红包
@property (strong, nonatomic) IBOutlet UIView *giftView;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *giftNoticeLabel;
@property (weak, nonatomic) IBOutlet UIButton *doButton;
@property (weak, nonatomic) IBOutlet UIImageView *giftTypeImageView;
@property (weak, nonatomic) IBOutlet UILabel *errorNotice;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumber;
@property (weak, nonatomic) IBOutlet UIView *errorNoticeView;
@property (weak, nonatomic) IBOutlet UIView *chongzhihiden;
@property (weak, nonatomic) IBOutlet UILabel *firsecman;
@property (weak, nonatomic) IBOutlet UILabel *coulorlab;


@property(nonatomic,strong)NSMutableArray * giftArray;

@property (weak, nonatomic) IBOutlet UIImageView *hiddenimage;
@property (weak, nonatomic) IBOutlet UILabel *hidenmoneylab;

@property (weak, nonatomic) IBOutlet UILabel *hiddenlab;
@property (weak, nonatomic) IBOutlet UILabel *hiddentestlab;
@property (weak, nonatomic) IBOutlet UILabel *bankbacklab;
@property (weak, nonatomic) IBOutlet UILabel *kefulab;

@end

@implementation RHErrorViewController
@synthesize type;
@synthesize tipsStr;
@synthesize titleStr;
-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    if ([RHhelper ShraeHelp].filres ==1||[RHhelper ShraeHelp].filres ==2) {
        self.firstbutton.hidden = YES;
        self.secButton.hidden = YES;
        self.coulorlab.hidden = YES;
        [RHhelper ShraeHelp].filres =3;
    }
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([RHhelper ShraeHelp].filres ==2) {
        self.firstbutton.hidden = NO;
        self.secButton.hidden = NO;
        self.coulorlab.hidden = NO;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [RHhelper ShraeHelp].withdrawtest=10;
  //  self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.hiddenlab.hidden = YES;
    self.hiddenimage.hidden = YES;
    self.hiddentestlab.hidden = YES;
    self.hidenmoneylab.hidden = YES;
    self.bankbacklab.hidden = YES;
    self.kefulab.hidden = YES;
    [self backbutton];
    self.chongzhihiden.hidden = YES;
    //[self configBackButton];
    self.giftTableView.delegate = self;
    self.giftTableView.dataSource = self;
    self.giftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    switch (type) {
        case RHInvestmentSucceed:
            [self configTitleWithString:@"出借成功"];
            [self succeed];
            //[self myInvestMent];
            
            self.backlab.text = @"出借成功";
            //首次投资成功显示
//            [self cheTheGift];
//            [self.secButton setTitle:@"出借记录" forState:UIControlStateNormal ];
//             [self.firstbutton setTitle:@"我的出借" forState:UIControlStateNormal ];
            [self.secButton setTitle:@"项目列表" forState:UIControlStateNormal ];
            [self cheTheGift];
//
            break;
        case RHPaySucceed:
            [self configTitleWithString:@"充值成功"];
            [self succeed];
           // [self myAccount];
            self.backlab.text = @"充值成功";
            [self.firstbutton setTitle:@"我的账户" forState:UIControlStateNormal ];
            
            break;
        case RHWithdrawSucceed:
            [self configTitleWithString:@"提现成功"];
            [self succeed];
            //[self myAccount];
            self.backlab.text = @"提现成功";
             [self.firstbutton setTitle:@"项目列表" forState:UIControlStateNormal ];
            [self.secButton setTitle:@"我的账户" forState:UIControlStateNormal ];
            break;
        case RHInvestmentFail:
            
         
            if ([self.bankbackstr isEqualToString:@"null"]||[self.bankbackstr isKindOfClass:[NSNull class]]) {
                self.bankbacklab.hidden = NO;
                 self.kefulab.hidden = NO;
            }else{
                self.bankbacklab.hidden = NO;
                self.kefulab.hidden = NO;
                self.bankbacklab.text = [NSString stringWithFormat:@"银行返回值：%@",self.bankbackstr];
            }
            
            [self configTitleWithString:@"出借失败"];
            [self fail];
          //  [self myInvestMent];
            self.backlab.text = @"出借失败";
            [self.firstbutton setTitle:@"我的账户" forState:UIControlStateNormal ];
            [self.secButton setTitle:@"项目列表" forState:UIControlStateNormal ];
            break;
        case RHPayFail:
            [self configTitleWithString:@"充值失败"];
            [self fail];
            if ([UIScreen mainScreen].bounds.size.width <321) {
            [RHhelper ShraeHelp].filres =1;
            }
//            self.titleLabel.text = ";
          //  [self myAccount];
            self.backlab.text = @"充值失败";
            self.tipsLabel.hidden = YES;
             [self.firstbutton setTitle:@"我的账户" forState:UIControlStateNormal ];
             [self.secButton setTitle:@"重试" forState:UIControlStateNormal ];
//            self.chongzhihiden.hidden = NO;
            break;
        case RHWithdrawFail:
            [self configTitleWithString:@"提现申请失败"];
            [self fail];
            self.titleLabel.hidden = YES;
         //   [self myAccount];
            self.backlab.text = @"提现申请失败";
            [self.firstbutton setTitle:@"我的账户" forState:UIControlStateNormal ];
            [self.secButton setTitle:@"重试" forState:UIControlStateNormal ];
            break;
        case RHSLBSucceed:
            [self configTitleWithString:@"转入成功"];
            [self succeed];
        //    [self myAccount];
            self.backlab.text = @"转入成功";
            break;
        case RHSLBFail:
            [self configTitleWithString:@"转入失败"];
            [self fail];
            //[self myAccount];
            self.backlab.text = @"转入失败";
            break;
        case RHZCSLBSucceed:
            [self configTitleWithString:@"转出成功"];
            [self succeed];
            //    [self myAccount];
            self.backlab.text = @"转出成功";
            break;
        case RHZCSLBFail:
            [self configTitleWithString:@"转出失败"];
            [self fail];
            //[self myAccount];
            self.backlab.text = @"转出失败";
            break;
        case RHInvestmentchixu:
            [self configTitleWithString:@"出借处理中"];
            [self chixu];
            //  [self myInvestMent];
            self.backlab.text = @"出借持续处理中";
            [self.firstbutton setTitle:@"我的出借" forState:UIControlStateNormal ];
            [self.secButton setTitle:@"项目列表" forState:UIControlStateNormal ];
            
        default:
            break;
    }
    
    
    
    self.errorNotice.hidden = YES;
//    CGRect tipsRect = self.tipsLabel.frame;
//    tipsRect.size.height = [tipsStr sizeWithFont:[UIFont systemFontOfSize:12.0] constrainedToSize:CGSizeMake(204, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping].height;
//    self.tipsLabel.frame = tipsRect;
    
    self.tipsLabel.text = tipsStr;
    if (self.tipsLabel.text.length>251) {
        self.tipsLabel.font = [UIFont systemFontOfSize:13];
    }
    self.tipsLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    CGSize maximumLabelSize = CGSizeMake(320, 9999);//labelsize的最大值
    //关键语句
    CGSize expectSize = [self.tipsLabel sizeThatFits:maximumLabelSize];
    //别忘了把frame给回label，如果用xib加了约束的话可以只改一个约束的值
    self.tipsLabel.frame = CGRectMake(5, CGRectGetMaxY(self.titleLabel.frame), [UIScreen mainScreen].bounds.size.width-13, expectSize.height);
    
    if (RHScreeWidth >390) {
        self.tipsLabel.frame = CGRectMake(5, CGRectGetMaxY(self.titleLabel.frame), [UIScreen mainScreen].bounds.size.width-50, expectSize.height);
    }
    
//    self.titleLabel.backgroundColor = [UIColor redColor];
//    
//    self.tipsLabel.backgroundColor = [UIColor redColor];
//    CGRect errorRect = self.errorImageView.frame;
//    errorRect.origin.x = (239 - (50 + 7 + [titleStr sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(MAXFLOAT, 21) lineBreakMode:NSLineBreakByCharWrapping].width))/2.0;
////    errorRect.origin.x = 30;
    //self.errorImageView.frame = errorRect;
    
//    CGRect titleRect = self.titleLabel.frame;
//    titleRect.origin.x = self.errorImageView.frame.origin.x+50+7;
    
//    titleRect.origin.x = 0;
//    self.titleLabel.frame = titleRect;
    
    self.titleLabel.text = titleStr;
    self.tipsLabel.text = tipsStr;
//    self.tipsLabel.backgroundColor = [UIColor redColor];
    if (self.recongestrsec.length >2) {
        self.chongzhihiden.hidden = YES;
//        self.tipsLabel.text = self.recongestrsec;
        self.firsecman.text = self.recongestrsec;
//        self.errorView.hidden = YES;
        self.errorNotice.hidden = YES;
    }
    if (self.errorType==435) {
        self.chongzhihiden.hidden = NO;
        self.errorNotice.hidden = NO;
        
        self.secondlab.text = @"银行卡余额不足";
        self.threelab.text = @"充值金额超过快捷支付限额";
        self.firstlab.hidden = YES;
        
        
    }else if(self.errorType==436){
        self.chongzhihiden.hidden = NO;
        self.errorNotice.hidden = NO;
        self.xianebtn.hidden = YES;
    }
        
        
    
    /*
    if (self.errorType == 435) {
        
        
        
        titleRect.origin.y = 60+60+80;
        titleRect.size.height = [@"银行卡余额不足\n充值金额超过快捷支付限额" sizeWithFont:[UIFont systemFontOfSize:15.0] constrainedToSize:CGSizeMake(204, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping].height;
        self.titleLabel.frame = titleRect;
        self.errorNotice.frame = CGRectMake(titleRect.origin.x, self.errorNotice.frame.origin.y, self.errorNotice.frame.size.width, self.errorNotice.frame.size.height);
        self.tipsLabel.frame = CGRectMake(titleRect.origin.x, titleRect.origin.y + titleRect.size.height , CGRectGetWidth(self.tipsLabel.frame), 50);
        self.errorNotice.hidden = NO;
        self.titleLabel.text = @"银行卡余额不足\n充值金额超过快捷支付限额";
//        self.tipsLabel.text = @"查看快捷支付限额";
        NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithString:@"查看快捷支付限额"];
        NSRange contentRange = {0, [content length]};
        [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleThick] range:contentRange];
        NSDictionary *dic = @{NSForegroundColorAttributeName:[UIColor colorWithRed:36.0/255 green:108.0/255 blue:161.0/255 alpha:1.0],NSFontAttributeName:[UIFont systemFontOfSize:14.0]};
        [content addAttributes:dic range:contentRange];
        
        self.tipsLabel.attributedText = content;
        
//        _tipsLabel.textColor = [UIColor colorWithRed:36.0/255 green:108.0/255 blue:161.0/255 alpha:1.0];
//        self.tipsLabel.font = [UIFont systemFontOfSize:14.0];
    }
   
    */

    
//    self.errorNotice.hidden = YES;
//    CGRect tipsRect = self.tipsLabel.frame;
//    tipsRect.size.height = [tipsStr sizeWithFont:[UIFont systemFontOfSize:12.0] constrainedToSize:CGSizeMake(204, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping].height;
//    self.tipsLabel.frame = tipsRect;
//    
////    CGRect errorRect = self.errorImageView.frame;
////    errorRect.origin.x = (239 - (50 + 7 + [titleStr sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(MAXFLOAT, 21) lineBreakMode:NSLineBreakByCharWrapping].width))/2.0;
////    self.errorImageView.frame = errorRect;
//    
//    CGRect titleRect = self.titleLabel.frame;
//    titleRect.origin.x = 100;
//    self.titleLabel.frame = titleRect;
//    
//    self.titleLabel.text = titleStr;
//    self.tipsLabel.text = tipsStr;
//    
//    if (self.errorType == 435) {
//        titleRect.origin.y = 180;
//        titleRect.size.height = [@"银行卡余额不足\n充值金额超过快捷支付限额" sizeWithFont:[UIFont systemFontOfSize:15.0] constrainedToSize:CGSizeMake(204, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping].height;
//        self.titleLabel.frame = CGRectMake(0,160 , CGRectGetWidth(self.titleLabel.frame), 50);
//        self.errorNotice.frame = CGRectMake(titleRect.origin.x, CGRectGetMaxY(self.tipsLabel.frame)+10, self.errorNotice.frame.size.width, self.errorNotice.frame.size.height);
//        self.tipsLabel.frame = CGRectMake(100, titleRect.origin.y + titleRect.size.height , CGRectGetWidth(self.tipsLabel.frame), 50);
//        self.errorNotice.hidden = NO;
//        self.titleLabel.text = @"银行卡余额不足\n充值金额超过快捷支付限额";
//        //        self.tipsLabel.text = @"查看快捷支付限额";
//        NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithString:@"查看快捷支付限额"];
//        NSRange contentRange = {0, [content length]};
//        [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleThick] range:contentRange];
//        NSDictionary *dic = @{NSForegroundColorAttributeName:[UIColor colorWithRed:36.0/255 green:108.0/255 blue:161.0/255 alpha:1.0],NSFontAttributeName:[UIFont systemFontOfSize:14.0]};
//        [content addAttributes:dic range:contentRange];
//        
//        self.tipsLabel.attributedText = content;
//        
//        //        _tipsLabel.textColor = [UIColor colorWithRed:36.0/255 green:108.0/255 blue:161.0/255 alpha:1.0];
//        //        self.tipsLabel.font = [UIFont systemFontOfSize:14.0];
//    }
    
    
    
    if ([UIScreen mainScreen].bounds.size.height<481) {
//        self.errorView.hidden = YES;
        self.tipsLabel.hidden = YES;
        self.tipsLabel.hidden = YES;
        self.chongzhihiden.hidden = YES;
        self.errorNotice.hidden = YES;
    }
}

//检查是否发红包
-(void)cheTheGift {
    AFHTTPRequestOperationManager* manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[[AFCompoundResponseSerializer alloc]init];
    manager.securityPolicy = [[RHNetworkService instance] customSecurityPolicy];
    NSString* session=[[NSUserDefaults standardUserDefaults] objectForKey:@"RHSESSION"];
    NSString* session1=[[NSUserDefaults standardUserDefaults] objectForKey:@"RHNEWMYSESSION"];
    
    if (session1.length>12) {
        session = [NSString stringWithFormat:@"%@,%@",session,session1];
    }
    NSLog(@"------------------%@",session);
    if (session&&[session length]>0) {
        [manager.requestSerializer setValue:session forHTTPHeaderField:@"cookie"];
    }
    [manager POST:[NSString stringWithFormat:@"%@app/front/payment/appAccount/newsAppQueryInvestmentBonuses",[RHNetworkService instance].newdoMain] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSLog(@"------------------%@",responseObject);
        
        if ([responseObject isKindOfClass:[NSData class]]) {
            NSDictionary* dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"------------------%@",dic);
            NSString* isShow=[dic objectForKey:@"isShow"];
//            self.giftMoneyLabel.text = [dic objectForKey:@"giftMoney"];
            if (![[dic objectForKey:@"giftMoney"] isKindOfClass:[NSNull class]]) {
                
                CGFloat a = [[dic objectForKey:@"giftMoney"] doubleValue];
                if (a>5) {
                    self.hidenmoneylab.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"giftMoney"]];
                }else{
                    self.hidenmoneylab.text = [NSString stringWithFormat:@"%@%%",[dic objectForKey:@"giftMoney"]];
                    self.hiddenlab.hidden = YES;
                    self.hidenmoneylab.font = [UIFont systemFontOfSize:35];
                }
                
            }
            if (![[dic objectForKey:@"giftContent"] isKindOfClass:[NSNull class]]) {
                self.hiddentestlab.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"giftContent"]];
                
            }
            
        }

    /*
        NSLog(@"------------------%@",responseObject);
        
        if ([responseObject isKindOfClass:[NSData class]]) {
            NSDictionary* dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"------------------%@",dic);
            NSString* amount=[dic objectForKey:@"money"];
            if (amount&&[amount length]>0) {
                self.giftView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame)+6, CGRectGetHeight(self.view.frame) + 150);
                 [[UIApplication sharedApplication].keyWindow addSubview:self.giftView];
                self.moneyLabel.text = [NSString stringWithFormat:@"%.2f元返利现金已放入账户",[amount floatValue]];
                [self setTheAttributeString:self.moneyLabel.text];
                [[[UIApplication sharedApplication].delegate window] addSubview:self.giftView];
                [self performSelector:@selector(closeButtonClicked:) withObject:nil afterDelay:15.0];
            }
        }
     */
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"%@",[[NSString alloc] initWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
        
        self.hiddenlab.hidden = YES;
        self.hiddenimage.hidden = YES;
        self.hiddentestlab.hidden = YES;
        self.hidenmoneylab.hidden = YES;
    }];
}

-(void)cheisshowTheGift {
    AFHTTPRequestOperationManager* manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[[AFCompoundResponseSerializer alloc]init];
    manager.securityPolicy = [[RHNetworkService instance] customSecurityPolicy];
    NSString* session=[[NSUserDefaults standardUserDefaults] objectForKey:@"RHSESSION"];
    NSString* session1=[[NSUserDefaults standardUserDefaults] objectForKey:@"RHNEWMYSESSION"];
    
    if (session1.length>12) {
        session = [NSString stringWithFormat:@"%@,%@",session,session1];
    }
    NSLog(@"------------------%@",session);
    if (session&&[session length]>0) {
        [manager.requestSerializer setValue:session forHTTPHeaderField:@"cookie"];
    }
    [manager POST:[NSString stringWithFormat:@"%@app/front/payment/appAccount/newsAppQueryInvestmentBonuses",[RHNetworkService instance].newdoMain] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"------------------%@",responseObject);
        
        if ([responseObject isKindOfClass:[NSData class]]) {
            NSDictionary* dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"------------------%@",dic);
            NSString* isShow=[dic objectForKey:@"isShow"];
            //            if (amount&&[amount length]>0) {
            //                //                self.giftView.frame = CGRectMake(0, -20, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) + 64);
            //                self.giftView.hidden = NO;
            //                self.giftMoneyLabel.text = [NSString stringWithFormat:@"%d元投资现金已放入账户",[amount intValue]];
            //                [self setTheAttributeString:self.giftMoneyLabel.text];
            //                [self.navigationController.navigationBar addSubview:self.giftView];
            //                [self performSelector:@selector(fiftCloseButtonClicked:) withObject:nil afterDelay:15.0];
            //                self.kaihumybtn.userInteractionEnabled = NO;
            //            }
            //            self.giftArray = [dic objectForKey:@"giftList"];
            self.giftArray = [NSMutableArray arrayWithArray:[dic objectForKey:@"giftList"]];
            if ([isShow isEqualToString:@"true"]) {
//                self.kaihumybtn.userInteractionEnabled = NO;
                self.giftNoticeLabel.text = [dic objectForKey:@"giftContent"];
               // self.giftView.hidden = NO;
                self.giftView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame)+6, CGRectGetHeight(self.view.frame) + 120);
                [[[UIApplication sharedApplication].delegate window] addSubview:self.giftView];
                [self performSelector:@selector(closeButtonClicked:) withObject:nil afterDelay:15.0];
              //  [self.giftTableView reloadData];
            }
        }
        
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"%@",[[NSString alloc] initWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
    }];
}

- (void)backbutton{
    
    UIButton* button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(back1) forControlEvents:UIControlEventTouchUpInside];
    //    UIImage * image = [UIImage imageNamed:@"back.png"];
    
    [button setImage:[UIImage imageNamed:@"icon_back.png"] forState:UIControlStateNormal];
    button.frame=CGRectMake(0, 0, 11, 17);
    self.navigationItem.leftBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:button];
    
}
- (void)back1{
    
    NSArray *temArray = self.navigationController.viewControllers;
    
    
    
    
    
    for(RHInvestmentViewController *temVC in temArray)
        
    {
        
        if ([temVC isKindOfClass:[RHInvestmentViewController class]])
            
        {
            
            [self.navigationController popToViewController:temVC animated:YES];
            return;
            
        }
        
    }
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    //[self.navigationController popToViewController:test animated:YES];
//    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)setTheAttributeString:(NSString *)string {
    NSDictionary *attribute = @{NSForegroundColorAttributeName : [UIColor colorWithRed:249.0/255 green:212.0/255 blue:37.0/255 alpha:1.0], NSFontAttributeName: [UIFont systemFontOfSize:22.0]};
    NSDictionary *attribute1 = @{NSForegroundColorAttributeName : [UIColor colorWithRed:249.0/255 green:212.0/255 blue:37.0/255 alpha:1.0]};
    
    NSString *subString = [string componentsSeparatedByString:@"元"][0];
    
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:string];
    
    [attributeString setAttributes:attribute range:NSMakeRange(0, subString.length)];
    [attributeString setAttributes:attribute1 range:NSMakeRange(subString.length, 1)];
    self.moneyLabel.attributedText = attributeString;
}
//second
- (IBAction)secbutton:(id)sender {
//     [self.navigationController popToRootViewControllerAnimated:YES];
     UINavigationController* nav = [[RHTabbarManager sharedInterface] selectTabbarUser];
    UIButton * bttn ;
    bttn = sender;
    if ([bttn.titleLabel.text isEqualToString:@"出借记录"]) {
        [RHhelper ShraeHelp].resss =1;
        
        RHMyInvestmentViewController*   controller = [[RHMyInvestmentViewController alloc] initWithNibName:@"RHMyInvestmentViewController" bundle:nil];
        // [DQViewController Sharedbxtabar].tarbar.hidden = YES;
//        controller.nav = self.navigationController;
        controller.resstr = @"test";
        [[DQViewController Sharedbxtabar]tabBar:(DQview *)controller.view didSelectedIndex:2];
        UIButton *btn = [[UIButton alloc]init];
        btn.tag = 2;
        [[DQview Shareview] btnClick:btn];
        nav.navigationController.navigationBar.alpha = 1.00;
        [nav pushViewController:controller animated:YES];
        
        [self.navigationController popToRootViewControllerAnimated:NO];
        return;

    }
    
    if ([bttn.titleLabel.text isEqualToString:@"我的账户"]) {
        
        [RHhelper ShraeHelp].resss =5;
        
        [self.navigationController popToRootViewControllerAnimated:NO];
        return;
    }else if ([bttn.titleLabel.text isEqualToString:@"项目列表"]){
        
        if ([self.backlab.text isEqualToString:@"充值成功"]) {
            [RHhelper ShraeHelp].resss =5;
//            [self.navigationController popToRootViewControllerAnimated:NO];
//            return;
        }
        if ([self.backlab.text isEqualToString:@"出借失败"]) {
            [RHhelper ShraeHelp].resss =10;
            RHProjectListViewController *controller = [[RHProjectListViewController alloc]initWithNibName:@"RHProjectListViewController" bundle:nil];
            controller.type = @"0";
            //    [nav pushViewController:controller animated:YES];
            [[DQViewController Sharedbxtabar]tabBar:(DQview *)controller.view didSelectedIndex:1];
            UIButton *btn = [[UIButton alloc]init];
            btn.tag = 1;
            [[DQview Shareview] btnClick:btn];
            [self.navigationController popToRootViewControllerAnimated:NO];
            return;
        }
        
        RHProjectListViewController *controller = [[RHProjectListViewController alloc]initWithNibName:@"RHProjectListViewController" bundle:nil];
        controller.type = @"0";
        //    [nav pushViewController:controller animated:YES];
        [[DQViewController Sharedbxtabar]tabBar:(DQview *)controller.view didSelectedIndex:1];
        UIButton *btn = [[UIButton alloc]init];
        btn.tag = 1;
        [[DQview Shareview] btnClick:btn];
        [self.navigationController popToRootViewControllerAnimated:NO];
    }else{
        
        if ([self.backlab.text isEqualToString:@"充值失败"]) {
            RHRechargeViewController*   controller = [[RHRechargeViewController alloc] initWithNibName:@"RHRechargeViewController" bundle:nil];
//                    [nav pushViewController:controller animated:YES];
//            [nav popViewControllerAnimated:NO];
            NSArray *temArray = self.navigationController.viewControllers;
            
            for(UIViewController *temVC in temArray)
                
            {
                
                if ([temVC isKindOfClass:[RHRechargeViewController class]])
                    
                {
                    
                    [self.navigationController popToViewController:temVC animated:YES];
                    
                }
                
            }
//            [self.navigationController popViewControllerAnimated:YES];
            return;
//            [[DQViewController Sharedbxtabar]tabBar:(DQview *)controller.view didSelectedIndex:2];
//            UIButton *btn = [[UIButton alloc]init];
//            btn.tag = 2;
//            [[DQview Shareview] btnClick:btn];
//            [DQViewController Sharedbxtabar].tarbar.hidden = YES;
        }else{
            
            RHWithdrawViewController*   controller = [[RHWithdrawViewController alloc] initWithNibName:@"RHWithdrawViewController" bundle:nil];
            NSArray *temArray = self.navigationController.viewControllers;
            
            for(UIViewController *temVC in temArray)
                
            {
                
                if ([temVC isKindOfClass:[RHWithdrawViewController class]])
                    
                {
                    
                    [self.navigationController popToViewController:temVC animated:YES];
                    
                }
                
            }
//            [[DQViewController Sharedbxtabar]tabBar:(DQview *)controller.view didSelectedIndex:2];
//            UIButton *btn = [[UIButton alloc]init];
//            btn.tag = 2;
//            [[DQview Shareview] btnClick:btn];
//            [DQViewController Sharedbxtabar].tarbar.hidden = YES;
//            [nav pushViewController:controller animated:NO];
            return;
        }
        
        
        
        
    }
//[self.navigationController popToRootViewControllerAnimated:NO];
    
}

- (void)succeed {
    
    self.errorImageView.image = [UIImage imageNamed:@"PNG_成功"];
    self.titleLabel.textColor = [RHUtility colorForHex:@"555555"];
    self.tipsLabel.textColor =[RHUtility colorForHex:@"555555"];
}
//shibai
- (void)fail {
    
    self.errorImageView.image = [UIImage imageNamed:@"PNG_失败"];
    self.titleLabel.textColor = [RHUtility colorForHex:@"555555"];
    self.tipsLabel.textColor = [RHUtility colorForHex:@"555555"];
}

- (void)chixu {
    
    self.errorImageView.image = [UIImage imageNamed:@"持续处理中"];
    self.titleLabel.textColor = [RHUtility colorForHex:@"555555"];
    self.tipsLabel.textColor = [RHUtility colorForHex:@"555555"];
}

-(void)myInvestMent {
    
    [self.secButton setTitle:@"我的出借" forState:UIControlStateNormal];
    _secButton.tag = 10;
//    [self.secButton addTarget:self action:@selector(pushMyAccount:) forControlEvents:UIControlEventTouchUpInside];
}
//zhanghu
- (void)myAccount {
    [self.secButton setTitle:@"我的账户" forState:UIControlStateNormal];
    _secButton.tag = 20;
//    [self.secButton addTarget:self action:@selector(pushMyAccount:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//first
- (IBAction)pushProjectList:(id)sender {
    UINavigationController* nav = [[RHTabbarManager sharedInterface] selectTabbarUser];
    UIButton * bttn ;
    bttn = sender;
    if ([bttn.titleLabel.text isEqualToString:@"我的出借"]) {
        [RHhelper ShraeHelp].resss =1;
        
        RHMyInvestmentViewController*   controller = [[RHMyInvestmentViewController alloc] initWithNibName:@"RHMyInvestmentViewController" bundle:nil];
       // [DQViewController Sharedbxtabar].tarbar.hidden = YES;
        controller.nav = self.navigationController;
        [[DQViewController Sharedbxtabar]tabBar:(DQview *)controller.view didSelectedIndex:2];
        UIButton *btn = [[UIButton alloc]init];
        btn.tag = 2;
        [[DQview Shareview] btnClick:btn];
        [nav pushViewController:controller animated:YES];
        
         [self.navigationController popToRootViewControllerAnimated:NO];
        
        return;
    }
//     [self.navigationController popToRootViewControllerAnimated:YES];
    if ([bttn.titleLabel.text isEqualToString:@"我的账户"]) {
        if( [self.backlab.text isEqualToString:@"出借成功"]){
            [RHhelper ShraeHelp].resss =5;
            RHUserCountViewController *controller = [[RHUserCountViewController alloc]initWithNibName:@"RHUserCountViewController" bundle:nil];
            //            controller.type = @"0";
            [nav pushViewController:controller animated:YES];
            [[DQViewController Sharedbxtabar]tabBar:(DQview *)controller.view didSelectedIndex:2];
            UIButton *btn = [[UIButton alloc]init];
            btn.tag = 2;
            [[DQview Shareview] btnClick:btn];
                        [self.navigationController popToRootViewControllerAnimated:NO];
            
            
            return;
        }else{
            [RHhelper ShraeHelp].resss =5;
            RHUserCountViewController *controller = [[RHUserCountViewController alloc]initWithNibName:@"RHUserCountViewController" bundle:nil];
            //            controller.type = @"0";
            [nav pushViewController:controller animated:YES];
            [[DQViewController Sharedbxtabar]tabBar:(DQview *)controller.view didSelectedIndex:2];
            UIButton *btn = [[UIButton alloc]init];
            btn.tag = 2;
            [[DQview Shareview] btnClick:btn];
            [self.navigationController popToRootViewControllerAnimated:NO];
            
            
            return;
        }
        
        [self.navigationController popToRootViewControllerAnimated:NO];
        return;
    }else if ([bttn.titleLabel.text isEqualToString:@"项目列表"]){
        RHProjectListViewController *controller = [[RHProjectListViewController alloc]initWithNibName:@"RHProjectListViewController" bundle:nil];
        controller.type = @"0";
        //    [nav pushViewController:controller animated:YES];
        [[DQViewController Sharedbxtabar]tabBar:(DQview *)controller.view didSelectedIndex:1];
        UIButton *btn = [[UIButton alloc]init];
        btn.tag = 1;
        [[DQview Shareview] btnClick:btn];
        
        
//        [RHhelper ShraeHelp].resss =10;
//        RHProjectListViewController *controller = [[RHProjectListViewController alloc]initWithNibName:@"RHProjectListViewController" bundle:nil];
//        controller.type = @"0";
//        //    [nav pushViewController:controller animated:YES];
//        [[DQViewController Sharedbxtabar]tabBar:(DQview *)controller.view didSelectedIndex:1];
//        UIButton *btn = [[UIButton alloc]init];
//        btn.tag = 1;
//        [[DQview Shareview] btnClick:btn];
//        [self.navigationController popToRootViewControllerAnimated:NO];
//        return;
        
        
    }else{
//        [RHmainModel ShareRHmainModel].maintest = @"";
//        RHUserCountViewController *controller1 = [[RHUserCountViewController alloc]initWithNibName:@"RHUserCountViewController" bundle:nil];
//        RHUserCountViewC ontroller *controller1 = [[RHUserCountViewController alloc]initWithNibName:@"RHUserCountViewController" bundle:nil];
        //        controller.type = @"0";
        
        [RHhelper ShraeHelp].resss =1;
        
        RHMyInvestmentViewController*   controller = [[RHMyInvestmentViewController alloc] initWithNibName:@"RHMyInvestmentViewController" bundle:nil];
        // [DQViewController Sharedbxtabar].tarbar.hidden = YES;
        controller.nav = self.navigationController;
        [[DQViewController Sharedbxtabar]tabBar:(DQview *)controller.view didSelectedIndex:2];
        UIButton *btn = [[UIButton alloc]init];
        btn.tag = 2;
        [[DQview Shareview] btnClick:btn];
        [nav pushViewController:controller animated:NO];
        
        [self.navigationController popToRootViewControllerAnimated:NO];
        
        return;
      
    }
    
//    [self.navigationController popViewControllerAnimated:NO];
    //firstbutton
    [self.navigationController popToRootViewControllerAnimated:NO];
//    UINavigationController* nav = [[RHTabbarManager sharedInterface] selectTabbarMain];
    
}

- (void)pushMyAccount:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:NO];
    UINavigationController* nav = [[RHTabbarManager sharedInterface] selectTabbarUser];
    UIViewController *controller;
    if (sender.tag == 10) {
    RHMyInvestmentViewController*    controller = [[RHMyInvestmentViewController alloc] initWithNibName:@"RHMyInvestmentViewController" bundle:nil];
        [nav pushViewController:controller animated:YES];
        [[DQViewController Sharedbxtabar]tabBar:(DQview *)controller.view didSelectedIndex:2];
        controller.nav = self.navigationController;
        
        UIButton *btn = [[UIButton alloc]init];
        btn.tag = 2;
        [[DQview Shareview] btnClick:btn];
        [DQViewController Sharedbxtabar].tarbar.hidden = YES;
        
    } else {
        controller = [[RHMyAccountViewController alloc]initWithNibName:@"RHMyAccountViewController" bundle:nil];
        //[nav pushViewController:controller animated:YES];
        [[DQViewController Sharedbxtabar]tabBar:(DQview *)controller.view didSelectedIndex:2];
        UIButton *btn = [[UIButton alloc]init];
        btn.tag = 2;
        [[DQview Shareview] btnClick:btn];
    }
    
//    [DQViewController Sharedbxtabar]
    
   
}


//红包
- (IBAction)closeButtonClicked:(UIButton *)sender {
    
    [self.giftView removeFromSuperview];
}

- (IBAction)doButtonClicked:(UIButton *)sender {
    [self.giftView removeFromSuperview];
    [RHhelper ShraeHelp].giftres =1;
    UINavigationController* nav = [[RHTabbarManager sharedInterface] selectTabbarUser];
    RHMyGiftViewController *   controller = [[RHMyGiftViewController alloc] initWithNibName:@"RHMyGiftViewController" bundle:nil];
    
    [[DQViewController Sharedbxtabar]tabBar:(DQview *)controller.view didSelectedIndex:2];
    UIButton *btn = [[UIButton alloc]init];
    btn.tag = 2;
    [[DQview Shareview] btnClick:btn];
    [DQViewController Sharedbxtabar].tarbar.hidden = YES;
    [self.navigationController popToRootViewControllerAnimated:NO];
//    [nav pushViewController:controller animated:NO];
    

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.view];
    
//    if (CGRectContainsPoint(_phoneNumber.frame, touchPoint)) {
//        _phoneNumber.textColor = [UIColor blueColor];
//    }
//    CGPoint touchPoint2 = [touch locationInView:self.errorView];
//    if (CGRectContainsPoint(_tipsLabel.frame, touchPoint2)) {
//        _tipsLabel.textColor = [UIColor blueColor];
//    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//    UITouch *touch = [touches anyObject];
//    CGPoint touchPoint = [touch locationInView:self.view];
//    if (CGRectContainsPoint(_phoneNumber.frame, touchPoint)) {
//        
//        _phoneNumber.textColor = [UIColor colorWithRed:36.0/255 green:108.0/255 blue:161.0/255 alpha:1.0];
//        self.errorNoticeView.hidden = NO;
//    }
//    
//    CGPoint touchPoint2 = [touch locationInView:self.errorView];
//    if (CGRectContainsPoint(_tipsLabel.frame, touchPoint2)) {
//        _tipsLabel.textColor = [UIColor colorWithRed:36.0/255 green:108.0/255 blue:161.0/255 alpha:1.0];
//        
//        if ([_tipsLabel.text isEqualToString:@"查看快捷支付限额"]) {
//            RHBankListViewController *controllers = [[RHBankListViewController alloc]initWithNibName:@"RHBankListViewController" bundle:nil];
//            [self.navigationController pushViewController:controllers animated:YES];
//        }
//       
//    }
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
//    _phoneNumber.textColor = [UIColor colorWithRed:36.0/255 green:108.0/255 blue:161.0/255 alpha:1.0];
//    _tipsLabel.textColor = [UIColor colorWithRed:36.0/255 green:108.0/255 blue:161.0/255 alpha:1.0];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
//    UITouch *touch = [touches anyObject];
//    CGPoint touchPoint = [touch locationInView:self.view];
//    if (!CGRectContainsPoint(_phoneNumber.frame, touchPoint)) {
//        _phoneNumber.textColor = [UIColor colorWithRed:36.0/255 green:108.0/255 blue:161.0/255 alpha:1.0];
//    }
//    CGPoint touchPoint2 = [touch locationInView:self.errorView];
//    if (!CGRectContainsPoint(_tipsLabel.frame, touchPoint2)) {
//        _tipsLabel.textColor = [UIColor colorWithRed:36.0/255 green:108.0/255 blue:161.0/255 alpha:1.0];
//    }
}

- (IBAction)callService:(UIButton *)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:4000104001"]];
}

- (IBAction)cancleCall:(UIButton *)sender {
    self.errorNoticeView.hidden = YES;
}
- (IBAction)chakanxiane:(id)sender {
    
    RHMoreWebViewViewController * vc = [[RHMoreWebViewViewController alloc]initWithNibName:@"RHMoreWebViewViewController" bundle:nil];
    vc.namestr = @"快捷限额";
    vc.urlstr  = [NSString stringWithFormat:@"%@bindKJCard",[RHNetworkService instance].newdoMain];
    [self.navigationController pushViewController:vc animated:YES];
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

@end
