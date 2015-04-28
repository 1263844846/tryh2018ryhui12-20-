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

@end

@implementation RHUserCenterMainViewController
@synthesize balance;

- (void)viewDidLoad {
    [super viewDidLoad];
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

    [[RHNetworkService instance] POST:@"front/payment/account/countUnReadMessage" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"%@",responseObject);
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
    
    AFHTTPRequestOperationManager* manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[[AFCompoundResponseSerializer alloc]init];
    NSString* session=[[NSUserDefaults standardUserDefaults] objectForKey:@"RHSESSION"];
    if (session&&[session length]>0) {
        [manager.requestSerializer setValue:session forHTTPHeaderField:@"cookie"];
    }
    [manager POST:[NSString stringWithFormat:@"%@front/payment/account/queryAccountFinishedBonuses",[RHNetworkService instance].doMain] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"result==%@ <<<",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        if ([responseObject isKindOfClass:[NSData class]]) {
            
            NSDictionary* dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSString* amount=[dic objectForKey:@"msg"];
            if (amount&&[amount length]>0) {
                RHGetGiftViewController* controller=[[RHGetGiftViewController alloc]initWithNibName:@"RHGetGiftViewController" bundle:nil];
                controller.amount=amount;
                [self.navigationController pushViewController:controller animated:NO];

            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"%@",[[NSString alloc] initWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
    }];

    
    
    self.myMessageNumLabel.layer.cornerRadius=8;
    self.myMessageNumLabel.layer.masksToBounds=YES;
    self.myMessageNumLabel.hidden=YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkout) name:@"RHSELECTUSER" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refesh) name:UIApplicationWillEnterForegroundNotification object:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self checkout];
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
        DLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSString* AvlBal=[responseObject objectForKey:@"AvlBal"];
            if (AvlBal&&[AvlBal length]>0) {
                self.balance=AvlBal;
                [RHUserManager sharedInterface].balance=AvlBal;
                self.balanceLabel.text=[NSString stringWithFormat:@"可用余额%@元",AvlBal];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"%@",error);
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
    if ([button.titleLabel.text isEqualToString:@"立即开户"]) {
        RHRegisterWebViewController* controller=[[RHRegisterWebViewController alloc] initWithNibName:@"RHRegisterWebViewController" bundle:nil];
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
@end
