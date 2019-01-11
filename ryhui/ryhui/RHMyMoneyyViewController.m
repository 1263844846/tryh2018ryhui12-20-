//
//  RHMyMoneyyViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 16/4/22.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import "RHMyMoneyyViewController.h"
#import "MBProgressHUD.h"

@interface RHMyMoneyyViewController ()
@property (weak, nonatomic) IBOutlet UIView *smallView;
@property (weak, nonatomic) IBOutlet UIView *bigView;

//big
@property (weak, nonatomic) IBOutlet UILabel *zongzichanlab;
@property (weak, nonatomic) IBOutlet UILabel *zongshouyilab;
@property (weak, nonatomic) IBOutlet UILabel *keyongjinelab;
@property (weak, nonatomic) IBOutlet UILabel *dongjiezijinlab;
@property (weak, nonatomic) IBOutlet UILabel *daishoubenjin;
@property (weak, nonatomic) IBOutlet UILabel *daishoulixi;
@property (weak, nonatomic) IBOutlet UILabel *shenglibaoyue;
@property (weak, nonatomic) IBOutlet UILabel *yizhuanlixi;

@property (weak, nonatomic) IBOutlet UILabel *touzifanli;
@property (weak, nonatomic) IBOutlet UILabel *fanlixianjin;
@property (weak, nonatomic) IBOutlet UILabel *shenglibaoshouyi;


//small
@property (weak, nonatomic) IBOutlet UILabel *smallky;
@property (weak, nonatomic) IBOutlet UILabel *smalldj;
@property (weak, nonatomic) IBOutlet UILabel *smallds;

@property (weak, nonatomic) IBOutlet UILabel *smalldsbj;
@property (weak, nonatomic) IBOutlet UILabel *smallslbye;
@property (weak, nonatomic) IBOutlet UILabel *smallzsy;
@property (weak, nonatomic) IBOutlet UILabel *smallzzc;
@property (weak, nonatomic) IBOutlet UILabel *smallyzlx;
@property (weak, nonatomic) IBOutlet UILabel *smalltzfx;
@property (weak, nonatomic) IBOutlet UILabel *smallfxxj;
@property (weak, nonatomic) IBOutlet UILabel *smallslbsy;
@property (weak, nonatomic) IBOutlet UILabel *hidensmalllab;

@end

@implementation RHMyMoneyyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configTitleWithString:@"资产总览"];
    [self configBackButton];
    
    if ([UIScreen mainScreen].bounds.size.width > 320) {
        self.bigView.hidden = NO;
    }else{
        
        self.bigView.hidden = YES;
    }
    
    [self getdata];
    
    if ([UIScreen mainScreen].bounds.size.height<481) {
        
        self.hidensmalllab.hidden = YES;
        
        self.smallfxxj.hidden = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

-(void)getdata{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[RHNetworkService instance] POST:@"app/front/payment/appAccount/appMyAssetOverview" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            [self setdatato:responseObject];
            
           [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        
        
    }];
    
    
}

- (void)setdatato:(NSDictionary *)dic{
    if (dic[@"total"]&&![dic[@"total"] isKindOfClass:[NSNull class]]) {
        self.zongzichanlab.text = [NSString stringWithFormat:@"%@",dic[@"total"]];
        self.smallzzc.text = [NSString stringWithFormat:@"%@",dic[@"total"]];
    }
    if (dic[@"earnedInRYH"]&&![dic[@"earnedInRYH"] isKindOfClass:[NSNull class]]) {
        self.zongshouyilab.text = [NSString stringWithFormat:@"%@",dic[@"earnedInRYH"]];
        self.smallzsy.text = [NSString stringWithFormat:@"%@",dic[@"earnedInRYH"]];
//        self.smallzsy.text = dic[@"earnedInRYH"];
    }
    
//    self.zongshouyilab.text = dic[@"earnedInRYH"];
    self.keyongjinelab.text = dic[@"AvlBal"];
    self.dongjiezijinlab.text = dic[@"FrzBal"];
    self.daishoubenjin.text = dic[@"collectCapital"];
    self.daishoulixi.text = dic[@"collectInterest"];
    self.yizhuanlixi.text = dic[@"earnInterest"];
    self.touzifanli.text = dic[@"insteadCash"];
    self.fanlixianjin.text = dic[@"rebateCash"];
    self.shenglibaoyue.text = dic[@"totalAsset"];
    self.shenglibaoshouyi.text = dic[@"toTalProfit"];
    
    
    
    
    self.smallky.text =  dic[@"AvlBal"];
    self.smalldj.text = dic[@"FrzBal"];
    self.smallds.text = dic[@"collectCapital"];
    self.smalldsbj.text =  dic[@"collectInterest"];
    
    self.smallslbye.text =dic[@"totalAsset"];
    
    self.smallyzlx.text =  dic[@"earnInterest"];
    self.smalltzfx.text = dic[@"insteadCash"];
    self.smallfxxj.text = dic[@"rebateCash"];
    self.smallslbsy.text = dic[@"toTalProfit"];
}

@end
