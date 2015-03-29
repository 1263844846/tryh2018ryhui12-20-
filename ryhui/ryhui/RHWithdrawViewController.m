//
//  RHWithdrawViewController.m
//  ryhui
//
//  Created by 江 云龙 on 15/3/29.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHWithdrawViewController.h"
#import "RHWithdrawWebViewController.h"

@interface RHWithdrawViewController ()
{
    int secondsCountDown;
    NSTimer* countDownTimer;
}

@end

@implementation RHWithdrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configBackButton];
    [self configTitleWithString:@"提现"];
    [self getWithdrawData];
    
    self.scrollView.contentSize=CGSizeMake(self.scrollView.frame.size.width, 530);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
}
//balance = "80.29000000000001";
//cards =     (
//             (
//              CCB,
//              6217000010044159260,
//              QP
//              )
//             );
//defaultCardId = 6217000010044159260;
//free = "218.97";
//qpCard =     (
//              CCB,
//              6217000010044159260,
//              QP
//              );
-(void)getWithdrawData
{
    [[RHNetworkService instance] POST:@"front/payment/account/myCashDataForApp" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"%@",responseObject);
        NSString* balance=[NSString stringWithFormat:@"%2.f",[[responseObject objectForKey:@"balance"] doubleValue]];
        self.balanceLabel.text=balance;
        
        NSArray* qpCard=[responseObject objectForKey:@"qpCard"];
        NSArray* cards=[responseObject objectForKey:@"cards"];

        NSString* bankType=nil;
        NSString* cardId=nil;
        NSString* cardType=nil;
        if (qpCard&&[qpCard count]>0) {
            for (NSString* idStr in qpCard) {
                int index=[[NSNumber numberWithInteger:[qpCard indexOfObject:idStr]] intValue];
                if (index==0) {
                    bankType=idStr;
                }
                if (index==1) {
                    cardId=idStr;
                }
                if (index==2) {
                    cardType=idStr;
                }
            }
        }else{
            if (cards&&[cards count]>0) {
                for (NSString* idStr in [cards objectAtIndex:0]) {
                    int index=[[NSNumber numberWithInteger:[qpCard indexOfObject:idStr]] intValue];
                    if (index==0) {
                        bankType=idStr;
                    }
                    if (index==1) {
                        cardId=idStr;
                    }
                    if (index==2) {
                        cardType=idStr;
                    }
                }
            }

        }
        DLog(@"%@",[NSString stringWithFormat:@"%@.jgp",bankType]);
        self.iconImageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",bankType]];
        self.cardLabel.text=[NSString stringWithFormat:@"%@ **** **** %@",[cardId substringToIndex:4],[cardId substringFromIndex:[cardId length]-4]];
        free=[[responseObject objectForKey:@"free"] doubleValue];

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"%@",error);
    }];
}

- (IBAction)withdrawAction:(id)sender {
    if ([self.withdrawTF.text length]<=0) {
        [RHUtility showTextWithText:@"请填写提现金额"];
        return;
    }
    if ([self.captchaTF.text length]<=0) {
        [RHUtility showTextWithText:@"请填写提验证码"];
        return;
    }
    RHWithdrawWebViewController* controller=[[RHWithdrawWebViewController alloc]initWithNibName:@"RHWithdrawWebViewController" bundle:nil];
    controller.amount=self.withdrawTF.text;
    controller.captcha=self.captchaTF.text;
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)textFieldTextDidChange:(NSNotification*)not
{
    int price=[self.withdrawTF.text intValue];
    if (price>[self.balanceLabel.text doubleValue]) {
        price=[self.balanceLabel.text intValue];
        self.withdrawTF.text=[NSString stringWithFormat:@"%d",[self.balanceLabel.text intValue]];
    }
    double tempPrice=[[NSNumber numberWithDouble:free] intValue]-price;
    if (tempPrice>0) {
        self.freeLabel.text=@"0";
        self.getAmountLabel.text=self.withdrawTF.text;
    }else{
        tempPrice=price-[[NSNumber numberWithDouble:free] intValue];
        double getAmount=tempPrice*0.005;
        if (getAmount>1) {
            self.freeLabel.text=[NSString stringWithFormat:@"%d",[[NSNumber numberWithDouble:getAmount] intValue]];
            self.getAmountLabel.text=[NSString stringWithFormat:@"%d",price-[[NSNumber numberWithDouble:getAmount] intValue]];
        }else{
            self.freeLabel.text=@"1";
            self.getAmountLabel.text=[NSString stringWithFormat:@"%d",price-1];
        }
    }
    
}

- (IBAction)getCaptchaAction:(id)sender {
    
    NSDictionary *parameters = @{@"telephone":[RHUserManager sharedInterface].telephone,@"type":@"SMS_CAPTCHA_CASH"};
    AFHTTPRequestOperationManager* manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[[AFCompoundResponseSerializer alloc]init];
    [manager POST:[NSString stringWithFormat:@"%@common/user/general/sendTelCaptcha",[RHNetworkService instance].doMain] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"result==%@ <<<",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        if ([responseObject isKindOfClass:[NSData class]]) {
            NSString* restult=[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            if ([restult isEqualToString:@"success"]) {
                //短信发送成功
                [RHUtility showTextWithText:@"短信发送成功"];
                [self reSendMessage];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"%@",error);
    }];
}

-(void)reSendMessage
{
    secondsCountDown=60;
    self.captchaButton.enabled=NO;
    countDownTimer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
}
-(void)timeFireMethod
{
    secondsCountDown--;
    [self.captchaButton setTitle:[NSString stringWithFormat:@"%d后重新发送",secondsCountDown] forState:UIControlStateNormal];
    if (secondsCountDown==0) {
        self.captchaButton.enabled=YES;
        [self.captchaButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [countDownTimer invalidate];
    }
    
}
@end
