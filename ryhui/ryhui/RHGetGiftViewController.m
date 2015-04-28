//
//  RHGetGiftViewController.m
//  ryhui
//
//  Created by jufenghudong on 15/4/16.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHGetGiftViewController.h"
#import "RHRechargeViewController.h"
#import "RHMyGiftViewController.h"

@interface RHGetGiftViewController ()

@end

@implementation RHGetGiftViewController
@synthesize amount;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.amountLabel.text=[NSString stringWithFormat:@"￥%@元",amount];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden=NO;
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}

- (IBAction)pushRecharge:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];

    RHRechargeViewController* controller=[[RHRechargeViewController alloc]initWithNibName:@"RHRechargeViewController" bundle:nil];
    [[[RHTabbarManager sharedInterface] selectTabbarUser] pushViewController:controller animated:NO];
    
}

- (IBAction)pushMyGift:(id)sender {
    
    [self.navigationController popViewControllerAnimated:NO];
    RHMyGiftViewController* controller=[[RHMyGiftViewController alloc]initWithNibName:@"RHMyGiftViewController" bundle:nil];
    [[[RHTabbarManager sharedInterface] selectTabbarUser] pushViewController:controller animated:NO];
}
@end
