//
//  RHHFTXViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 16/2/29.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import "RHHFTXViewController.h"
#import "RHHFphonenumberViewController.h"
#import "RHHFPhoneWEBViewController.h"
#import "RHHFWebviewViewController.h"
@interface RHHFTXViewController ()
@property (weak, nonatomic) IBOutlet UILabel *secondlab;
@property (weak, nonatomic) IBOutlet UILabel *firsrlab;
@property (weak, nonatomic) IBOutlet UIButton *abtn;

@end

@implementation RHHFTXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configTitleWithString:@"汇付手机号"];
    [self configBackButton];
    if ([UIScreen mainScreen].bounds.size.width ==320) {
        self.firsrlab.text = @"请登录汇付天下账户后,点击[设置]";
        self.firsrlab.font = [UIFont systemFontOfSize: 13.0];
        self.secondlab.font = [UIFont systemFontOfSize: 13.0];
    }
    [self.abtn.layer setMasksToBounds:YES];
    [self.abtn.layer setCornerRadius:5.0];
    
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
- (IBAction)xiugai:(id)sender {
    
    RHHFWebviewViewController * vc = [[RHHFWebviewViewController alloc]initWithNibName:@"RHHFWebviewViewController" bundle:nil];
//    [self.navigationController pushViewController:vc animated:YES];
    
//    RHHFphonenumberViewController * vc = [[RHHFphonenumberViewController alloc]initWithNibName:@"RHHFphonenumberViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
    
    NSLog(@"xiugai");
    
}

@end
