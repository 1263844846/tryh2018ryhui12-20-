//
//  ViewController.m
//  ryhui
//
//  Created by 江 云龙 on 15/2/13.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "ViewController.h"
#import "RHLoginViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    RHLoginViewController* controller=[[RHLoginViewController alloc]initWithNibName:@"RHLoginViewController" bundle:nil];
    UINavigationController* nav=[[UINavigationController alloc]initWithRootViewController:controller];

    [self presentViewController:nav animated:NO completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
