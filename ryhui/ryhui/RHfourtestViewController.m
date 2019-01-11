//
//  RHfourtestViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 16/3/8.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import "RHfourtestViewController.h"
#import "DQViewController.h"
@interface RHfourtestViewController ()

@end

@implementation RHfourtestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [DQViewController Sharedbxtabar].tarbar.hidden = YES;
     NSLog(@"%f",[UIScreen mainScreen].bounds.size.width);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)toubiao:(id)sender {
    
    
    
}

@end
