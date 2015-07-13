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
@property (weak, nonatomic) IBOutlet UIImageView *typeImageView;
@property (weak, nonatomic) IBOutlet UILabel *noticeLabel;    
@property (weak, nonatomic) IBOutlet UILabel *giftMoneyLabel;  //红包现金


@end

@implementation RHGetGiftViewController
@synthesize amount;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.amountLabel.text=[NSString stringWithFormat:@"￥%@元",amount];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden=NO;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (IBAction)pushRecharge:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:NO];
    UIViewController *controller;
    if (sender.tag == 0) {
        controller=[[RHRechargeViewController alloc]initWithNibName:@"RHRechargeViewController" bundle:nil];
    } else {
        controller=[[RHMyGiftViewController alloc]initWithNibName:@"RHMyGiftViewController" bundle:nil];
    }
    [[[RHTabbarManager sharedInterface] selectTabbarUser] pushViewController:controller animated:NO];
}

//立即充值等事件处理
- (IBAction)toDoButtonClicked:(UIButton *)sender {
}

- (IBAction)closeButtonClicked:(UIButton *)sender {
}

@end
