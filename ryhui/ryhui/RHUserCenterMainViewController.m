//
//  RHUserCenterMainViewController.m
//  ryhui
//
//  Created by stefan on 15/3/15.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHUserCenterMainViewController.h"
#import "RHUserCenterViewController.h"
#import "RHMyAccountViewController.h"
#import "RHTradingViewController.h"
#import "RHMyInvestmentViewController.h"
#import "RHRechargeViewController.h"
#import "RHMyMessageViewController.h"
#import "RHWithdrawViewController.h"
#import "RHALoginViewController.h"
#import "RHRegisterWebViewController.h"
#import "RHMyGiftViewController.h"
#import "RHGetGiftViewController.h"

@interface RHUserCenterMainViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (weak, nonatomic) IBOutlet UILabel *myMessageNumLabel;
@property(nonatomic,strong)NSString* balance;
@property (weak, nonatomic) IBOutlet UIButton *topButton;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *ryUsername;
@property (weak, nonatomic) IBOutlet UIView *overView;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;
@property (weak, nonatomic) IBOutlet UIButton *errorButton;
@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UIView *noticeView;
@property (weak, nonatomic) IBOutlet UIView *lastNoticeView;

//红包
@property (strong, nonatomic) IBOutlet UIView *giftView;
@property (weak, nonatomic) IBOutlet UIImageView *giftTypeImageView;
@property (weak, nonatomic) IBOutlet UILabel *giftMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *giftNoticeLabel;
@property (weak, nonatomic) IBOutlet UIButton *doButton;

@end

@implementation RHUserCenterMainViewController
@synthesize balance;

- (void)viewDidLoad {
    [super viewDidLoad];
    _mainScrollView.contentSize = CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), 420);
    _mainScrollView.scrollEnabled = NO;
    [self configTitleWithString:@"个人中心"];
    self.username.text=[RHUserManager sharedInterface].username;
    if ([RHUserManager sharedInterface].custId) {
        self.ryUsername.text=[NSString stringWithFormat:@"ryh_%@",[RHUserManager sharedInterface].username];
    }
    
    if (![RHUserManager sharedInterface].username) {
        self.errorLabel.text=@"您尚未登录账号";
        [self.errorButton setTitle:@"账号登录" forState:UIControlStateNormal];
        self.overView.hidden=NO;
        self.topButton.hidden=YES;
    }else{
        [self checkout];
        
        if ([RHUserManager sharedInterface].custId) {
            self.overView.hidden=YES;
        }else{
            self.overView.hidden=NO;
        }
    }
    
    AFHTTPRequestOperationManager* manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[[AFCompoundResponseSerializer alloc]init];
    NSString* session=[[NSUserDefaults standardUserDefaults] objectForKey:@"RHSESSION"];
    NSLog(@"------------------%@",session);
    
    if (session&&[session length]>0) {
        [manager.requestSerializer setValue:session forHTTPHeaderField:@"cookie"];
    }
    [manager POST:[NSString stringWithFormat:@"%@front/payment/account/queryAccountFinishedBonuses",[RHNetworkService instance].doMain] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        DLog(@"result==%@ <<<",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        if ([responseObject isKindOfClass:[NSData class]]) {
            
            NSDictionary* dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            NSLog(@"------------------%@",dic);
            
            NSString* amount=[dic objectForKey:@"money"];
            if (amount&&[amount length]>0) {
                RHGetGiftViewController* controller=[[RHGetGiftViewController alloc]initWithNibName:@"RHGetGiftViewController" bundle:nil];
                controller.amount=amount;
                [self.navigationController pushViewController:controller animated:NO];
//                self.giftView.frame = CGRectMake(0, -20, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) + 64);
//                [self.navigationController.navigationBar addSubview:self.giftView];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        DLog(@"%@",[[NSString alloc] initWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
    }];

    
    
    self.myMessageNumLabel.layer.cornerRadius=8;
    self.myMessageNumLabel.layer.masksToBounds=YES;
    self.myMessageNumLabel.hidden=YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkout) name:@"RHSELECTUSER" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refesh) name:UIApplicationWillEnterForegroundNotification object:nil];
    
    NSDictionary *attributes = @{NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *netString = [[NSMutableAttributedString alloc] initWithString:_questionLabel.text];
    [netString addAttributes:attributes range:NSMakeRange(8, netString.length - 8)];
    _questionLabel.attributedText = netString;
    
    self.noticeView.hidden = YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.lastNoticeView];
    
    if (CGRectContainsPoint(_questionLabel.frame, touchPoint)) {
        _questionLabel.textColor = [UIColor blueColor];
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.lastNoticeView];
    if (CGRectContainsPoint(_questionLabel.frame, touchPoint)) {
        self.noticeView.hidden = NO;
        _questionLabel.textColor = [UIColor colorWithRed:36.0/255 green:108.0/255 blue:161.0/255 alpha:1.0];
    }
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    _questionLabel.textColor = [UIColor colorWithRed:36.0/255 green:108.0/255 blue:161.0/255 alpha:1.0];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.lastNoticeView];
    if (!CGRectContainsPoint(_questionLabel.frame, touchPoint)) {
        _questionLabel.textColor = [UIColor colorWithRed:36.0/255 green:108.0/255 blue:161.0/255 alpha:1.0];
    }
}

- (IBAction)callService:(UIButton *)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:4000104001"]];
}
- (IBAction)cancleCall:(UIButton *)sender {
    self.noticeView.hidden = YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self checkout];
    
    [[RHNetworkService instance] POST:@"front/payment/account/countUnReadMessage" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        DLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSString* numStr=nil;
            if (![[responseObject objectForKey:@"msgCount"] isKindOfClass:[NSNull class]]) {
                if ([[responseObject objectForKey:@"msgCount"] isKindOfClass:[NSNumber class]]) {
                    numStr=[[responseObject objectForKey:@"msgCount"] stringValue];
                }else{
                    numStr=[responseObject objectForKey:@"msgCount"];
                }
            }
            if (numStr) {
                [[NSUserDefaults standardUserDefaults] setObject:numStr forKey:@"RHMessageNumSave"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"RHMessageNum" object:numStr];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];

}

-(void)refesh
{
    [self checkout];
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"RHSELECTUSER" object:nil];
}
-(void)setMessageNum:(NSNotification*)nots
{
    [super setMessageNum:nots];
    if ([RHUserManager sharedInterface].custId) {
        self.myMessageNumLabel.hidden=self.messageNumLabel.hidden;
        self.myMessageNumLabel.text=self.messageNumLabel.text;
    }
}
- (void)checkout
{
    [[RHNetworkService instance] POST:@"front/payment/account/queryBalance" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        DLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSString* AvlBal=[responseObject objectForKey:@"AvlBal"];
            if (AvlBal&&[AvlBal length]>0) {
                self.balance=AvlBal;
                [RHUserManager sharedInterface].balance=AvlBal;
                self.balanceLabel.text=[NSString stringWithFormat:@"可用余额%@元",AvlBal];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        DLog(@"%@",error);
    }];
}

- (IBAction)pushAccountInfo:(id)sender {
    
    RHUserCenterViewController* controller=[[RHUserCenterViewController alloc]initWithNibName:@"RHUserCenterViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)pushMyAccount:(id)sender {
    RHMyAccountViewController* controller=[[RHMyAccountViewController alloc]initWithNibName:@"RHMyAccountViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)pushTradingRecord:(id)sender {
    RHTradingViewController* controller=[[RHTradingViewController alloc]initWithNibName:@"RHTradingViewController" bundle:nil];
    
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)pushMyInvestment:(id)sender {
    RHMyInvestmentViewController* controller=[[RHMyInvestmentViewController alloc]initWithNibName:@"RHMyInvestmentViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
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

- (IBAction)pushPay:(id)sender {
    
    RHRechargeViewController* controller=[[RHRechargeViewController alloc]initWithNibName:@"RHRechargeViewController" bundle:nil];
    controller.balance=self.balance;
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)extractPayment:(id)sender {
    RHWithdrawViewController* controller=[[RHWithdrawViewController alloc] initWithNibName:@"RHWithdrawViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)pushMyMessage:(id)sender {
    RHMyMessageViewController* controller=[[RHMyMessageViewController alloc] initWithNibName:@"RHMyMessageViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)openAccount:(id)sender {
    
    UIButton * button=sender;
    if ([button.titleLabel.text isEqualToString:@"开户领红包"]) {
        RHRegisterWebViewController* controller=[[RHRegisterWebViewController alloc] initWithNibName:@"RHRegisterWebViewController" bundle:nil];
        controller.isUserCenterTurn = YES;
        [self.navigationController pushViewController:controller animated:YES];
    }else{
        RHALoginViewController* controller=[[RHALoginViewController alloc] initWithNibName:@"RHALoginViewController" bundle:nil];
        [self.navigationController pushViewController:controller animated:YES];
    }
}
- (IBAction)pushMyGift:(id)sender {
    RHMyGiftViewController* controller=[[RHMyGiftViewController alloc] initWithNibName:@"RHMyGiftViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)pushMyInvestMentCode:(id)sender {
//    我的邀请码
}


//红包
- (IBAction)closeButtonClicked:(UIButton *)sender {
}

- (IBAction)doButtonClicked:(UIButton *)sender {
}

@end
