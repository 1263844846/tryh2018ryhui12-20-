//
//  RHMoreViewController.m
//  ryhui
//
//  Created by stefan on 15/3/15.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHMoreViewController.h"
#import "RHAboutViewController.h"

@interface RHMoreViewController ()

@end

@implementation RHMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.alertView.hidden=YES;
}

- (IBAction)pushMain:(id)sender {
    [[RHTabbarManager sharedInterface] selectTabbarMain];
}

- (IBAction)pushUser:(id)sender {
    [[RHTabbarManager sharedInterface] selectTabbarUser];
}

- (IBAction)pushAbout:(id)sender {
    RHAboutViewController* controller=[[RHAboutViewController alloc]initWithNibName:@"RHAboutViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)callPhone:(id)sender {
    
    self.alertView.hidden=NO;
}

- (IBAction)call:(id)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:4000104001"]];
}

- (IBAction)cancelCall:(id)sender {
    self.alertView.hidden=YES;
}

@end
