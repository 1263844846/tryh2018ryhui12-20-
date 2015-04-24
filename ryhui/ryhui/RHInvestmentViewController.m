//
//  RHInvestmentViewController.m
//  ryhui
//
//  Created by 江 云龙 on 15/3/18.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHInvestmentViewController.h"
#import "RHInvestmentWebViewController.h"
#import "RHRechargeViewController.h"
#import "RHContractViewContoller.h"

@interface RHInvestmentViewController ()
{
    float changeY;
    float keyboardHeight;
    
    float currentThreshold;
    
    int currentMoney;
}
@end

@implementation RHInvestmentViewController
@synthesize projectId;
@synthesize dataDic;
@synthesize projectFund;
@synthesize giftId=_giftId;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configBackButton];
    
    [self configTitleWithString:@"投资"];
    
    [self setupWithDic:self.dataDic];

    [self checkout];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textchange:) name:UITextFieldTextDidChangeNotification object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    
    CGRect rect=self.contentView.frame;
    rect.origin.x=([UIScreen mainScreen].bounds.size.width-320)/2.0;
    
    self.contentView.frame=rect;
    
    currentThreshold=0.0;
    currentMoney=0;
    self.giftView.hidden=YES;
    self.gifticon.image=[UIImage imageNamed:@"gift.png"];
    self.giftId=@"";
}

-(void)setupWithDic:(NSDictionary*)dic
{
    self.projectId=[dic objectForKey:@"id"];
    self.nameLabel.text=[dic objectForKey:@"name"];
    self.investorRateLabel.text=[[dic objectForKey:@"investorRate"] stringValue];
    self.limitTimeLabel.text=[[dic objectForKey:@"limitTime"] stringValue];
    self.projectFundLabel.text=[NSString stringWithFormat:@"%.2f",(projectFund/10000.0)];
}

- (void)checkout
{
    [[RHNetworkService instance] POST:@"front/payment/account/queryBalance" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSString* AvlBal=[responseObject objectForKey:@"AvlBal"];
            if (AvlBal&&[AvlBal length]>0) {
                self.balanceLabel.text=AvlBal;
                [RHUserManager sharedInterface].balance=AvlBal;
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"%@",error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)pushAreegment:(id)sender {
    RHContractViewContoller* controller=[[RHContractViewContoller alloc]initWithNibName:@"RHContractViewContoller" bundle:nil];
    controller.isAgreen=YES;
    [self.navigationController pushViewController:controller animated:YES];
}
- (IBAction)Investment:(id)sender {
    int amount=[self.textFiled.text intValue];
    if (amount%100!=0||amount==0) {
        [RHUtility showTextWithText:@"投资金额需为100的整数倍"];
        return;
    }
    if ([self.textFiled.text length]<=0) {
        [RHUtility showTextWithText:@"请输入投资金额"];
        return;
    }
    if ([self.textFiled.text floatValue]>projectFund) {
        [RHUtility showTextWithText:@"请输入可投范围内的金额"];
        return;
    }
    
    NSMutableString* balance=[[NSMutableString alloc]initWithCapacity:0];
    ;
    for (NSString* subStr in [self.balanceLabel.text componentsSeparatedByString:@","]) {
        [balance appendString:subStr];
    }
    
    if ([self.textFiled.text intValue]-currentMoney>[balance intValue]) {
        [RHUtility showTextWithText:@"您账户余额不足"];
        return;
    }
    [self.textFiled resignFirstResponder];
    RHInvestmentWebViewController* controller=[[RHInvestmentWebViewController alloc]initWithNibName:@"RHInvestmentWebViewController" bundle:nil];
    controller.price=self.textFiled.text;
    controller.projectId=self.projectId;
    controller.giftId=self.giftId;
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)allIn:(id)sender {
    [self.textFiled resignFirstResponder];
    NSArray* stringArray=[[RHUserManager sharedInterface].balance componentsSeparatedByString:@","];
    NSMutableString* resultString=[NSMutableString string];
    for (NSString* subStr in stringArray) {
        [resultString appendString:subStr];
    }
    if ([resultString length]<=0) {
        [resultString appendString:@"0"];
    }
    
    int balance=[resultString intValue];
    int allinAmount=(balance/100)*100;
    int project=(projectFund/100)*100;
    DLog(@"project=%d",project);
    DLog(@"allinAmount=%d  balance=%d",allinAmount,balance);
    if (allinAmount>project) {
        self.textFiled.text=[NSString stringWithFormat:@"%d",project];
    }else{
        self.textFiled.text=[NSString stringWithFormat:@"%d",allinAmount];
    }
    
    if (!self.giftView.hidden) {
        self.label1.text=[NSString stringWithFormat:@"实际扣减账户金额%d元",[self.textFiled.text intValue]-currentMoney];
    }
}

- (IBAction)recharge:(id)sender {
    [self.textFiled resignFirstResponder];
    RHRechargeViewController* controller=[[RHRechargeViewController alloc]initWithNibName:@"RHRechargeViewController" bundle:nil];
    controller.balance=self.balanceLabel.text;
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)chooseGift:(id)sender {
    [self.textFiled resignFirstResponder];

    RHChooseGiftViewController* controller=[[RHChooseGiftViewController alloc] initWithNibName:@"RHChooseGiftViewController" bundle:nil];
    int investNum=0;
    if ([self.textFiled.text length]>0) {
        investNum=[self.textFiled.text intValue];
    }
    controller.investNum=investNum;
    controller.delegate=self;
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)chooseGiftWithnNum:(NSString *)num threshold:(NSString *)threshold giftId:(NSString *)giftId
{
    self.giftId=giftId;
    currentMoney=[num intValue];
    
    currentThreshold=[threshold floatValue];
    
    self.label0.text=[NSString stringWithFormat:@"红包抵扣金额%@元",num];
    self.label1.text=[NSString stringWithFormat:@"实际扣减账户金额%d元",[self.textFiled.text intValue]-[num intValue]];
    self.chooseButton.hidden=YES;
    self.giftView.hidden=NO;
    self.gifticon.image=[UIImage imageNamed:@"gift1.png"];

}

-(void)keyboardHide:(NSNotification*)not
{
    [UIView animateWithDuration:.2 animations:^{
        self.view.frame = CGRectMake(0, 64, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    }];
}

-(void)keyboardShow:(NSNotification*)not
{
    DLog(@"%@",not.userInfo);
    NSValue* value=[not.userInfo objectForKey:@"UIKeyboardBoundsUserInfoKey"];
    
    CGRect rect=[value CGRectValue];
    keyboardHeight=rect.size.height;
    
    changeY = self.textFiled.frame.origin.y + self.textFiled.frame.size.height ;
    
    if (changeY + self.contentView.frame.origin.y  >= (CGRectGetHeight([UIScreen mainScreen].bounds) - keyboardHeight - 64)) {
        CGRect viewRect=self.view.frame;
        viewRect.origin.y = - ((self.view.frame.size.height - keyboardHeight) - self.textFiled.frame.origin.y - 74 - self.textFiled.frame.size.height );
        [UIView animateWithDuration:.4 animations:^{
            self.view.frame=viewRect;
        }];
    }
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    CGRect rect=self.view.frame;
    rect.origin.y=64;
    self.view.frame=rect;
    
    [textField resignFirstResponder];
    
    return YES;
}

-(void)textchange:(NSNotification*)not
{
    if (self.textFiled.text.length > 0) {
        self.textFiled.font = [UIFont systemFontOfSize:18.0];
    }else{
        self.textFiled.font = [UIFont systemFontOfSize:12.0];
    }
    if ([self.textFiled.text floatValue]<currentThreshold) {
        self.chooseButton.hidden=NO;
        self.giftView.hidden=YES;
        self.gifticon.image=[UIImage imageNamed:@"gift.png"];
        self.giftId=@"";
        currentMoney=0;
        
    }else{
        self.label1.text=[NSString stringWithFormat:@"实际扣减账户金额%d元",[self.textFiled.text intValue]-currentMoney];
    }

}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSCharacterSet *cs;
    NSString* str=@"0123456789";
    cs = [[NSCharacterSet characterSetWithCharactersInString:str] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basicTest = [string isEqualToString:filtered];
    if(!basicTest)
    {
        return NO;
    }
    
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.textFiled resignFirstResponder];
}

@end
