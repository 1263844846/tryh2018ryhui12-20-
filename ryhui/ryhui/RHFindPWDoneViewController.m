//
//  RHFindPWDoneViewController.m
//  ryhui
//
//  Created by 江 云龙 on 15/3/29.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHFindPWDoneViewController.h"

@interface RHFindPWDoneViewController ()

@end

@implementation RHFindPWDoneViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self configBackButton];
    [self configTitleWithString:@"完成"];
}
-(void)back
{
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
}

- (IBAction)loginAciton:(id)sender {
    
    [self.navigationController popToRootViewControllerAnimated:NO];
    [[RHTabbarManager sharedInterface] selectALogin];
}
@end
