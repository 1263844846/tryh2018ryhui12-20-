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

@end
