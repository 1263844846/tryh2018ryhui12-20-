//
//  RHBaseViewController.m
//  ryhui
//
//  Created by stefan on 15/2/13.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHBaseViewController.h"

@interface RHBaseViewController ()

@end

@implementation RHBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if(([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        self.edgesForExtendedLayout= UIRectEdgeNone;
        [self.navigationController.navigationBar setBarTintColor:[RHUtility colorForHex:@"318fc5"]];
    }else{
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navBG.png"] forBarMetrics:UIBarMetricsDefault];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)configBackButton
{
    UIButton* button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    button.frame=CGRectMake(0, 0, 11, 17);
    self.navigationItem.leftBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)configRightButtonWithTitle:(NSString*)title action:(SEL)action
{
    UIButton* button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:title forState:UIControlStateNormal];
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    button.frame=CGRectMake(0, 0, 100, 20);
    self.navigationItem.rightBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)configTitleWithString:(NSString*)title
{
    CGFloat font=20;
    
    UILabel* titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 30)];
    titleLabel.font=[UIFont boldSystemFontOfSize:font];
    titleLabel.textAlignment=NSTextAlignmentCenter;
    titleLabel.textColor=[UIColor whiteColor];
    titleLabel.backgroundColor=[UIColor clearColor];
    titleLabel.text=title;
    self.navigationItem.titleView = titleLabel;
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
-(BOOL)prefersStatusBarHidden
{
    return NO;
}
@end
