//
//  RHAgreement1ViewController.m
//  ryhui
//
//  Created by stefan on 15/3/1.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHAgreement1ViewController.h"

@interface RHAgreement1ViewController ()

@end

@implementation RHAgreement1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configBackButton];
    
    [self configTitleWithString:@"融益汇用户协议"];
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

@end
