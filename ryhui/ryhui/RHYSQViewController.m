//
//  RHYSQViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 2018/5/14.
//  Copyright © 2018年 stefan. All rights reserved.
//

#import "RHYSQViewController.h"
#import "RHXYWebviewViewController.h"
@interface RHYSQViewController ()
@property (weak, nonatomic) IBOutlet UILabel *sqmoneylab;
@property (weak, nonatomic) IBOutlet UILabel *sqtimelab;

@end

@implementation RHYSQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configTitleWithString:@"缴费授权"];
    [self configBackButton];
    
    self.sqtimelab.text = self.time;
    self.sqmoneylab.text = self.money;
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
- (IBAction)xieyi:(id)sender {
    RHXYWebviewViewController * vc= [[RHXYWebviewViewController alloc]initWithNibName:@"RHXYWebviewViewController" bundle:nil];
    vc.namestr = @"缴费授权协议";
    [self.navigationController pushViewController:vc animated:YES];
}

@end
