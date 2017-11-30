//
//  RHMyAccountViewController.m
//  ryhui
//
//  Created by stefan on 15/3/15.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHMyAccountViewController.h"
#import "TestViewController.h"

@interface RHMyAccountViewController ()

@property(nonatomic,strong)NSString* balance;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *collectCapitalLabel;
@property (weak, nonatomic) IBOutlet UILabel *averageLabel;

//shouyi
@property (weak, nonatomic) IBOutlet UILabel *earnInterestLabel;
@property (weak, nonatomic) IBOutlet UILabel *collectInterestLabel;
@property (weak, nonatomic) IBOutlet UILabel *collectPrepaymentPenaltyLabel;

//可用余额
@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;
//总资产
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UILabel *FrzBalLabel;
@property (weak, nonatomic) IBOutlet UILabel *investCashLabel;
@property (weak, nonatomic) IBOutlet UILabel *profitCashLabel;

@end

@implementation RHMyAccountViewController
@synthesize balance;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configBackButton];
    [self configTitleWithString:@"我的账户"];
   
    self.scrollView.contentSize=CGSizeMake(self.scrollView.frame.size.width, 503);
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getMyAccountData];
    [self checkout];
}
//average = "9.35";
//collectCapital = 241400;
//collectInterest = "91720.75";
//collectPrepaymentPenalty = 0;
//earnInterest = "92289.23";
//earnPenaltyInterest = "2914.46";
//earnPrepaymentPenalty = 600;
//myAccount = 1;

-(void)getMyAccountData
{
    [[RHNetworkService instance] POST:@"app/front/payment/account/myAccountData" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"%@",responseObject);
        
        NSString* average=@"0.00";
        if (![[responseObject objectForKey:@"average"] isKindOfClass:[NSNull class]]) {
            average=[responseObject objectForKey:@"average"] ;
        }
        self.averageLabel.text=average;
        
        NSString* FrzBal=@"0.00";
        if (![[responseObject objectForKey:@"FrzBal"] isKindOfClass:[NSNull class]]) {
            FrzBal=[responseObject objectForKey:@"FrzBal"] ;
        }
        self.FrzBalLabel.text=FrzBal;
        
        NSString* AvlBal=@"0.00";
        if (![[responseObject objectForKey:@"AvlBal"] isKindOfClass:[NSNull class]]) {
            AvlBal=[responseObject objectForKey:@"AvlBal"] ;
        }
        self.balanceLabel.text=AvlBal;
        
        NSString* total=@"0.00元";
        if (![[responseObject objectForKey:@"total"] isKindOfClass:[NSNull class]]) {
            total=[responseObject objectForKey:@"total"] ;
        }
        total = [NSString stringWithFormat:@"%@元",total];
        
        NSMutableAttributedString *arrString = [[NSMutableAttributedString alloc] initWithString:total];
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor grayColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:15.0],NSFontAttributeName, nil];
       [arrString addAttributes:dic range:NSMakeRange(total.length - 1, 1)];
        self.totalLabel.attributedText = arrString;
        
        
        NSString* collectCapital=@"0.00";
        if (![[responseObject objectForKey:@"collectCapital"] isKindOfClass:[NSNull class]]) {
            collectCapital=[responseObject objectForKey:@"collectCapital"] ;
        }
        self.collectCapitalLabel.text=collectCapital;
        NSString* collectInterest=@"0";
        if (![[responseObject objectForKey:@"collectInterest"] isKindOfClass:[NSNull class]]) {
            collectInterest=[responseObject objectForKey:@"collectInterest"] ;
        }
        self.collectInterestLabel.text=collectInterest;
        
        NSString* collect=@"0.00";
        if (![[responseObject objectForKey:@"collect"] isKindOfClass:[NSNull class]]) {
            collect=[responseObject objectForKey:@"collect"];
        }
        self.collectPrepaymentPenaltyLabel.text=collect;
        
        NSString* earnInterest=@"0.00";
        if (![[responseObject objectForKey:@"earnInterest"] isKindOfClass:[NSNull class]]) {
            earnInterest=[responseObject objectForKey:@"earnInterest"];
        }
        self.earnInterestLabel.text=earnInterest;
        
        NSString* investCash=@"0.00";
        if (![[responseObject objectForKey:@"insteadCash"] isKindOfClass:[NSNull class]]) {
            investCash=[responseObject objectForKey:@"insteadCash"];
        }
        if (investCash.length <= 0) {
            investCash = @"0.00";
        }
        self.investCashLabel.text=investCash;
        
        NSString* ProfitCash=@"0.00";
        if (![[responseObject objectForKey:@"rebateCash"] isKindOfClass:[NSNull class]]) {
            ProfitCash=[responseObject objectForKey:@"rebateCash"];
        }
        if (ProfitCash.length <= 0) {
            ProfitCash = @"0.00";
        }
        self.profitCashLabel.text=ProfitCash;
                
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        DLog(@"%@",error);
    }];
}

- (void)checkout
{
    [[RHNetworkService instance] POST:@"app/front/payment/account/queryBalance" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        DLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSString* AvlBal=[responseObject objectForKey:@"AvlBal"];
            if (AvlBal&&[AvlBal length]>0) {
                self.balance=AvlBal;
                self.balanceLabel.text=AvlBal;
            }else{
                self.balance=@"0";
                self.balanceLabel.text=@"0.00";
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        DLog(@"%@",error);
    }];
}

- (IBAction)pushMain:(id)sender {
    [[[RHTabbarManager sharedInterface] selectTabbarMain] popToRootViewControllerAnimated:NO];
}

- (IBAction)pushUser:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
- (IBAction)addbutton:(id)sender {
    
//    UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"666" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
//    [alertView show];
//
    TestViewController * test = [[TestViewController alloc]initWithNibName:@"TestViewController" bundle:nil];
    [self.navigationController pushViewController:test animated:YES];
   // [self presentViewController:test animated:YES completion:nil];
    
}

- (IBAction)pushMore:(id)sender {
    [[[RHTabbarManager sharedInterface] selectTabbarMore] popToRootViewControllerAnimated:NO];
}
- (IBAction)pushPay:(id)sender {
    
    RHRechargeViewController* controller=[[RHRechargeViewController alloc]initWithNibName:@"RHRechargeViewController" bundle:nil];
    controller.balance=self.balance;
    [self.navigationController pushViewController:controller animated:YES];
}
@end
