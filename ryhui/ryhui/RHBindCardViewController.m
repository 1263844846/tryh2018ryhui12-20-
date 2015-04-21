//
//  RHBindCardViewController.m
//  ryhui
//
//  Created by jufenghudong on 15/4/12.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHBindCardViewController.h"
#import "RHRechargeWebViewController.h"
#import "RHBankListViewController.h"

@interface RHBindCardViewController ()

@end

@implementation RHBindCardViewController
@synthesize amountStr;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configBackButton];
    [self configTitleWithString:@"绑定快捷卡"];
    NSString* tempStr=nil;
    NSString* endStr=nil;
    if ([amountStr rangeOfString:@"."].location!=NSNotFound) {
        tempStr=[amountStr substringToIndex:[amountStr rangeOfString:@"."].location];
        endStr=[amountStr substringFromIndex:[amountStr rangeOfString:@"."].location];
    }else{
        tempStr=amountStr;
    }
    
    
    int index=0;
    NSMutableString* resultStr=[[NSMutableString alloc]initWithCapacity:0];
    for (int i=0; i<[tempStr length]; i++) {
        DLog(@"%@",tempStr);
        if (index==2&&i!=[tempStr length]-1) {
            index=0;
            [resultStr insertString:[NSString stringWithFormat:@",%@",[tempStr substringWithRange:NSRangeFromString([NSString stringWithFormat:@"{%d;1}",[[NSNumber numberWithInteger:[tempStr length]] intValue]-i-1])]] atIndex:0];
        }else{
            [resultStr insertString:[tempStr substringWithRange:NSRangeFromString([NSString stringWithFormat:@"{%d;1}",[[NSNumber numberWithInteger:[tempStr length]] intValue]-i-1])] atIndex:0];
            index++;
        }
        
        DLog(@"%@",resultStr);
    }
    if (endStr&&[endStr length]>0) {
        [resultStr appendString:endStr];
    }
    
    NSArray* array=[resultStr componentsSeparatedByString:@","];
    NSMutableString* amountTempStr=[[NSMutableString alloc]initWithCapacity:0];
    for (NSString* str in array) {
        [amountTempStr appendString:str];
    }
    amountStr=amountTempStr;
    self.amountLabel.text=resultStr;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pushMain:(id)sender {
    [[RHTabbarManager sharedInterface] selectTabbarMain];
}

- (IBAction)pushUser:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)pushMore:(id)sender {
    [[RHTabbarManager sharedInterface] selectTabbarMore];
}

- (IBAction)bindAction:(id)sender {
    RHRechargeWebViewController* controllers=[[RHRechargeWebViewController alloc]initWithNibName:@"RHRegisterWebViewController" bundle:nil];
    controllers.price=amountStr;
    [self.navigationController pushViewController:controllers animated:YES];

}

- (IBAction)pushBankList:(id)sender {
    RHBankListViewController* controllers=[[RHBankListViewController alloc]initWithNibName:@"RHBankListViewController" bundle:nil];
    [self.navigationController pushViewController:controllers animated:YES];
}
@end
