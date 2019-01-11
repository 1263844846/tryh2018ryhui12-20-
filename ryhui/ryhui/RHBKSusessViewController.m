//
//  RHBKSusessViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 2018/5/8.
//  Copyright © 2018年 stefan. All rights reserved.
//

#import "RHBKSusessViewController.h"

@interface RHBKSusessViewController ()
{
    int secondsCountDown;
    NSTimer *countDownTimer;
}
@property (weak, nonatomic) IBOutlet UILabel *miaolab;

@end

@implementation RHBKSusessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self reSendMessage];
    [self configTitleWithString:@"绑卡成功"];
    [self goback];
    
}
- (void)goback{
    UIButton* button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(myaccount:) forControlEvents:UIControlEventTouchUpInside];
    //    UIImage * image = [UIImage imageNamed:@"back.png"];
    
    [button setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    button.frame=CGRectMake(0, 0, 30, 50);
    
    // button.backgroundColor = [UIColor colorWithHexString:@"44bbc1"];
    self.navigationItem.leftBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:button];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)reSendMessage {
    secondsCountDown = 5;
    //[self.yanzhengmatf becomeFirstResponder];
    // self.huoqubtn.enabled = NO;
    countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
}

- (void)timeFireMethod {
    secondsCountDown --;
    
    self.miaolab.text = [NSString stringWithFormat:@"%dS后自动跳转",secondsCountDown] ;
    if (secondsCountDown == 0) {
        [self myaccount:nil];
        [countDownTimer invalidate];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)myaccount:(id)sender {
    
    RHUserCountViewController *controller = [[RHUserCountViewController alloc]initWithNibName:@"RHUserCountViewController" bundle:nil];
    [self.navigationController popToRootViewControllerAnimated:NO];
    //            controller.type = @"0";
    //                [nav pushViewController:controller animated:YES];
    
    
    [[DQViewController Sharedbxtabar]tabBar:(DQview *)controller.view didSelectedIndex:2];
    UIButton *btn = [[UIButton alloc]init];
    btn.tag = 2;
    [[DQview Shareview] btnClick:btn];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [countDownTimer invalidate];
}
@end
