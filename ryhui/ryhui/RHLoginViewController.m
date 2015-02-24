//
//  RHLoginViewController.m
//  ryhui
//
//  Created by 江 云龙 on 15/2/13.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHLoginViewController.h"
#import "RHALoginViewController.h"

@interface RHLoginViewController ()

@end

@implementation RHLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bgImageView.frame=self.view.bounds;
    self.buttonView.frame=CGRectMake(0, self.view.frame.size.height-25-15, 320, 25);

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

- (IBAction)loginAction:(id)sender {
    RHALoginViewController* controller=[[RHALoginViewController alloc]initWithNibName:@"RHALoginViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)registerAction:(id)sender {
}

- (IBAction)qRegisterAction:(id)sender {
}
@end
