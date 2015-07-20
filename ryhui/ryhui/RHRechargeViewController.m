//
//  RHRechargeViewController.m
//  ryhui
//
//  Created by stefan on 15/3/15.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHRechargeViewController.h"
#import "RHRechargeWebViewController.h"
#import "MBProgressHUD.h"
#import "RHBindCardViewController.h"
@interface RHRechargeViewController ()
{
    BOOL isQpCard;
}
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *rechargeButton;
@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;

@end

@implementation RHRechargeViewController
@synthesize balance;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configBackButton];
    
    self.rechargeButton.layer.masksToBounds=YES;
    self.rechargeButton.layer.cornerRadius=9;
    
    [self configTitleWithString:@"充值"];
//    [self.textField becomeFirstResponder];
    if (balance&&[balance length]>0) {
        self.balanceLabel.text=balance;
    }else{
        self.balanceLabel.text=@"0.00";
    }
    
     [self getBindCard];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=NO;
    self.rechargeButton.userInteractionEnabled = YES;
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
        NSURL *dic = [error.userInfo objectForKey:@"NSErrorFailingURLKey"];
        
        NSString *str = [dic absoluteString];
        
        if ([str rangeOfString:@"/common/user/login/index"].location != NSNotFound) {
            self.rechargeButton.userInteractionEnabled = NO;
        }
    }];

}

-(void)getBindCard
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[RHNetworkService instance] POST:@"front/payment/account/myCashDataForApp" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        DLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSArray* array=nil;
            if ([responseObject objectForKey:@"qpCard"]) {
                array=[responseObject objectForKey:@"qpCard"];
                if ([array isKindOfClass:[NSArray class]]&&[array count]>0) {
                    isQpCard=YES;
                    self.rechargeButton.userInteractionEnabled = YES;
                }
            }
        }
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    }];
}

- (IBAction)recharge:(id)sender {
    [self.textField resignFirstResponder];
    if ([self.textField.text length]<=0) {
        [RHUtility showTextWithText:@"请输入充值金额"];
        return;
    }else{
        if ([self.textField.text floatValue] <= 0) {
            [RHUtility showTextWithText:@"请输入正确金额"];
            return;
        }else if ([_textField.text floatValue] < 1.0 ){
            [RHUtility showTextWithText:@"充值金额应大于等于 1 元"];
            return;
        }
    }
    if (!isQpCard) {
        RHBindCardViewController* contoller=[[RHBindCardViewController alloc] initWithNibName:@"RHBindCardViewController" bundle:nil];
        contoller.amountStr=self.textField.text;
        [self.navigationController pushViewController:contoller animated:YES];
    }else{
        RHRechargeWebViewController* controllers=[[RHRechargeWebViewController alloc]initWithNibName:@"RHRegisterWebViewController" bundle:nil];
        controllers.price=self.textField.text;
        [self.navigationController pushViewController:controllers animated:YES];
    }
    self.rechargeButton.userInteractionEnabled = NO;
    
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
//        DLog(@"%@",temp);
        if ([temp length]>2) {
            return NO;
        }
    }
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.textField resignFirstResponder];
}

-(void)viewWillDisappear:(BOOL)animated
{
    for (UIView *subView in [UIApplication sharedApplication].keyWindow.subviews) {
        if (subView.tag == 1000) {
            [subView removeFromSuperview];
        }
    }
    [super viewWillDisappear:animated];
}
@end
