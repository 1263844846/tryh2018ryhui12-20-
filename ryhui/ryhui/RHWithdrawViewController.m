//
//  RHWithdrawViewController.m
//  ryhui
//
//  Created by 江 云龙 on 15/3/29.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHWithdrawViewController.h"
#import "RHWithdrawWebViewController.h"
#import "RHBindCardWebViewController.h"

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
    self.overView.hidden=YES;
    self.scrollView.contentSize=CGSizeMake(self.scrollView.frame.size.width, 630);
    self.changeCardsButton.layer.cornerRadius=9;
    self.changeCardsButton.layer.masksToBounds=YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
    self.withdrawTF.enabled=NO;
    self.cardsView.hidden=YES;
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
        NSString* balance=[NSString stringWithFormat:@"%0.2f",[[responseObject objectForKey:@"balance"] doubleValue]];
        self.balanceLabel.text=balance;
        
        NSArray* qpCard=[responseObject objectForKey:@"qpCard"];
        NSArray* cards=[responseObject objectForKey:@"cards"];
        
        if ((cards&&[cards count]>0)||(qpCard&&[qpCard count]>0)) {
            self.overView.hidden=YES;
            self.withdrawTF.enabled=YES;
        }else{
            self.overView.hidden=NO;
            self.withdrawTF.enabled=NO;
        }

        NSString* bankType=nil;
        NSString* cardId=nil;
        NSString* cardType=nil;
        
        if (![qpCard isKindOfClass:[NSNull class]]&&qpCard&&[qpCard count]>0) {
            
            for (NSString* idStr in qpCard) {
                
                int index=[[NSNumber numberWithUnsignedInteger:[qpCard indexOfObject:idStr]] intValue];
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
            self.qbCardTipsView.hidden=NO;
            self.cardsView.hidden=YES;
        }else{
            if (![cards isKindOfClass:[NSNull class]]&&cards&&[cards count]>0) {
                DLog(@"%@",cards);
                for (NSString* idStr in [cards objectAtIndex:0]) {
                    DLog(@"%@",idStr);
                    int index=[[NSNumber numberWithUnsignedInteger:[[cards objectAtIndex:0] indexOfObject:idStr]] intValue];
                    DLog(@"%d",index);
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
                self.qbCardTipsView.hidden=YES;
                self.cardsView.hidden=NO;
//                CGRect rect=self.contentView.frame;
//                rect.origin.y=80;
//                self.contentView.frame=rect;
            }

        }
        DLog(@"%@",[NSString stringWithFormat:@"%@.jgp",bankType]);
        
        DLog(@"%@",cardId);
        
        if(cardId != nil)
        {
            self.cardLabel.text=[NSString stringWithFormat:@"%@ **** **** %@",[cardId substringToIndex:4],[cardId substringFromIndex:[cardId length]-4]];
        }
        self.iconImageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",bankType]];
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
    if ([self.withdrawTF.text floatValue]<=0) {
        [RHUtility showTextWithText:@"提现最小金额为0.01元"];
        return;
    }
    RHWithdrawWebViewController* controller=[[RHWithdrawWebViewController alloc]initWithNibName:@"RHWithdrawWebViewController" bundle:nil];
    controller.amount=self.withdrawTF.text;
    controller.captcha=self.captchaTF.text;
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)bindCardAction:(id)sender {
    RHBindCardWebViewController* controller=[[RHBindCardWebViewController alloc]initWithNibName:@"RHBindCardWebViewController" bundle:nil];
    controller.delegate=self;
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)changeCards:(id)sender {
    
    [self bindCardAction:nil];
}


-(void)textFieldTextDidChange:(NSNotification*)nots
{
    double price=[self.withdrawTF.text doubleValue];
    if (price>[self.balanceLabel.text doubleValue]) {
        price=[self.balanceLabel.text doubleValue];
        self.withdrawTF.text=[NSString stringWithFormat:@"%0.2f",[self.balanceLabel.text doubleValue]];
    }
    double tempPrice=free-price;
    if (tempPrice>0) {
        self.freeLabel.text=@"0.00";
        self.getAmountLabel.text=[NSString stringWithFormat:@"%0.2f",[self.withdrawTF.text doubleValue]];
    }else{
        tempPrice=price-free;
        double getAmount=tempPrice*0.005>1.00?tempPrice*0.005:1.00;
        self.freeLabel.text=[NSString stringWithFormat:@"%0.2f",getAmount];
        if (price+getAmount<=[self.balanceLabel.text doubleValue]) {
            self.getAmountLabel.text=[NSString stringWithFormat:@"%.2f",price];
        }else{
            if ([self.balanceLabel.text doubleValue]-getAmount>0) {
                self.getAmountLabel.text=[NSString stringWithFormat:@"%0.2f",[self.balanceLabel.text doubleValue]-getAmount];
            }else{
                self.getAmountLabel.text=@"0.00";
            }
  
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
            if ([restult isEqualToString:@"{\"msg\":\"手机验证码发送成功\"}"]||[restult isEqualToString:@"success"]) {
                //短信发送成功
                [RHUtility showTextWithText:@"验证码已发送至您的手机"];
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
    [self.captchaButton setTitle:[NSString stringWithFormat:@"重新发送(%d)",secondsCountDown] forState:UIControlStateNormal];
    if (secondsCountDown==0) {
        self.captchaButton.enabled=YES;
        [self.captchaButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [countDownTimer invalidate];
    }
    
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
- (IBAction)hiddenKeyBorad:(id)sender {
    [self.withdrawTF resignFirstResponder];
    [self.captchaTF resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSCharacterSet *cs;
    NSString* str=@"0123456789.";
    cs = [[NSCharacterSet characterSetWithCharactersInString:str] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basicTest = [string isEqualToString:filtered];
    if(!basicTest)
    {
        return NO;
    }
    
    NSString* result=[NSString stringWithFormat:@"%@%@",textField.text,string];
    NSArray* array=[result componentsSeparatedByString:@"."];
    if (array&&[array count]>2) {
        return NO;
    }
    NSRange ranges=[result rangeOfString:@"."];
    if (ranges.location!=NSNotFound) {
        NSString* temp=[result substringFromIndex:ranges.location+1];
        DLog(@"%@",temp);
        if ([temp length]>2) {
            return NO;
        }
    }
    return YES;
}

- (IBAction)gestureTape:(UITapGestureRecognizer *)sender {
    [self.withdrawTF resignFirstResponder];
    [self.captchaTF resignFirstResponder];
}

@end
