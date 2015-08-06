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

@interface RHErrorViewController ()

@property (weak, nonatomic) IBOutlet UIButton *secButton;
@property (weak, nonatomic) IBOutlet UIView *errorView;
@property (weak, nonatomic) IBOutlet UIImageView *errorImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipsLabel;

//红包
@property (strong, nonatomic) IBOutlet UIView *giftView;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *giftNoticeLabel;
@property (weak, nonatomic) IBOutlet UIButton *doButton;
@property (weak, nonatomic) IBOutlet UIImageView *giftTypeImageView;

@end

@implementation RHErrorViewController
@synthesize type;
@synthesize tipsStr;
@synthesize titleStr;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configBackButton];
    switch (type) {
        case RHInvestmentSucceed:
            [self configTitleWithString:@"投资成功"];
            [self succeed];
            [self myInvestMent];
            
            //首次投资成功显示
            [self cheTheGift];
//
            break;
        case RHPaySucceed:
            [self configTitleWithString:@"充值成功"];
            [self succeed];
            [self myAccount];
            break;
        case RHWithdrawSucceed:
            [self configTitleWithString:@"提现成功"];
            [self succeed];
            [self myAccount];
            break;
        case RHInvestmentFail:
            [self configTitleWithString:@"投资失败"];
            [self fail];
            [self myInvestMent];
            break;
        case RHPayFail:
            [self configTitleWithString:@"充值失败"];
            [self fail];
            [self myAccount];
            break;
        case RHWithdrawFail:
            [self configTitleWithString:@"提现失败"];
            [self fail];
            [self myAccount];
            break;
        default:
            break;
    }

    CGRect tipsRect = self.tipsLabel.frame;
    tipsRect.size.height = [tipsStr sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(204, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping].height;
    self.tipsLabel.frame = tipsRect;
    
    CGRect errorRect = self.errorImageView.frame;
    errorRect.origin.x = (239 - (50 + 7 + [titleStr sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(MAXFLOAT, 21) lineBreakMode:NSLineBreakByCharWrapping].width))/2.0;
    self.errorImageView.frame = errorRect;
    
    CGRect titleRect = self.titleLabel.frame;
    titleRect.origin.x = self.errorImageView.frame.origin.x+50+7;
    self.titleLabel.frame = titleRect;
    
    self.titleLabel.text = titleStr;
    self.tipsLabel.text = tipsStr;
}

//检查是否发红包
-(void)cheTheGift {
    AFHTTPRequestOperationManager* manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[[AFCompoundResponseSerializer alloc]init];
    NSString* session=[[NSUserDefaults standardUserDefaults] objectForKey:@"RHSESSION"];
    NSLog(@"------------------%@",session);
    if (session&&[session length]>0) {
        [manager.requestSerializer setValue:session forHTTPHeaderField:@"cookie"];
    }
    [manager POST:[NSString stringWithFormat:@"%@front/payment/account/queryInvestmentBonuses",[RHNetworkService instance].doMain] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"------------------%@",responseObject);
        
        if ([responseObject isKindOfClass:[NSData class]]) {
            NSDictionary* dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"------------------%@",dic);
            NSString* amount=[dic objectForKey:@"money"];
            if (amount&&[amount length]>0) {
                self.giftView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) + 64);
                self.moneyLabel.text = [NSString stringWithFormat:@"%.2f元返利现金已放入账户",[amount floatValue]];
                [self setTheAttributeString:self.moneyLabel.text];
                [[[UIApplication sharedApplication].delegate window] addSubview:self.giftView];
                [self performSelector:@selector(closeButtonClicked:) withObject:nil afterDelay:15.0];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"%@",[[NSString alloc] initWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
    }];
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

- (void)succeed {
    self.errorImageView.image = [UIImage imageNamed:@"error1.png"];
    self.titleLabel.textColor = [RHUtility colorForHex:@"#ff5d25"];
    self.tipsLabel.textColor = [RHUtility colorForHex:@"#989898"];
}

- (void)fail {
    self.errorImageView.image = [UIImage imageNamed:@"error2.png"];
    self.titleLabel.textColor = [RHUtility colorForHex:@"#40b5b8"];
    self.tipsLabel.textColor = [RHUtility colorForHex:@"#989898"];
}

-(void)myInvestMent {
    [self.secButton setTitle:@"我的投资" forState:UIControlStateNormal];
    _secButton.tag = 10;
    [self.secButton addTarget:self action:@selector(pushMyAccount:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)myAccount {
    [self.secButton setTitle:@"我的账户" forState:UIControlStateNormal];
    _secButton.tag = 20;
    [self.secButton addTarget:self action:@selector(pushMyAccount:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pushProjectList:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:NO];
    UINavigationController* nav = [[RHTabbarManager sharedInterface] selectTabbarMain];
    RHProjectListViewController *controller = [[RHProjectListViewController alloc]initWithNibName:@"RHProjectListViewController" bundle:nil];
    controller.type = @"0";
    [nav pushViewController:controller animated:YES];
}

- (void)pushMyAccount:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:NO];
    UINavigationController* nav = [[RHTabbarManager sharedInterface] selectTabbarUser];
    UIViewController *controller;
    if (sender.tag == 10) {
        controller = [[RHMyInvestmentViewController alloc] initWithNibName:@"RHMyInvestmentViewController" bundle:nil];
    } else {
        controller = [[RHMyAccountViewController alloc]initWithNibName:@"RHMyAccountViewController" bundle:nil];
    }
    [nav pushViewController:controller animated:YES];
}


//红包
- (IBAction)closeButtonClicked:(UIButton *)sender {
    
    [self.giftView removeFromSuperview];
}

- (IBAction)doButtonClicked:(UIButton *)sender {
    [self.giftView removeFromSuperview];
    UIViewController *controller = [[RHMyGiftViewController alloc]initWithNibName:@"RHMyGiftViewController" bundle:nil];
    [[[RHTabbarManager sharedInterface] selectTabbarUser] pushViewController:controller animated:NO];
    
}
@end
