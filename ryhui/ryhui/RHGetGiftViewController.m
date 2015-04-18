//
//  RHGetGiftViewController.m
//  ryhui
//
//  Created by jufenghudong on 15/4/16.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHGetGiftViewController.h"

@interface RHGetGiftViewController ()

@end

@implementation RHGetGiftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
    
    
}
@end
