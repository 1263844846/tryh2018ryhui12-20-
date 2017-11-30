//
//  RHLoginViewController.m
//  ryhui
//
//  Created by stefan on 15/2/13.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHLoginViewController.h"
#import "RHALoginViewController.h"
#import "RHRegisterViewController.h"
#import "RHMainViewController.h"

@interface RHLoginViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIView *buttonView;

@end

@implementation RHLoginViewController
@synthesize nav;

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.bgImageView.frame=[UIScreen mainScreen].bounds;
    
    [self.view addSubview:self.buttonView];
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
    if (nav) {
        [self.nav pushViewController:controller animated:YES];
    }else{
        [self.navigationController pushViewController:controller animated:YES];
    }
}

- (IBAction)registerAction:(id)sender {
    //11
    RHRegisterViewController* controller=[[RHRegisterViewController alloc]initWithNibName:@"RHRegisterViewController" bundle:nil];
    if (nav) {
        [self.nav pushViewController:controller animated:YES];
    }else{
        [self.navigationController pushViewController:controller animated:YES];
    }}

- (IBAction)qRegisterAction:(id)sender {
    
  RHMainViewController  * controller=[[RHMainViewController alloc]initWithNibName:@"RHMainViewController" bundle:nil];
    // controller.type= @"4";
    
    DQview * aview = [DQview Shareview];
    //aview.str = @"cbx";
    //aview.delegate = self;
    [aview btnClick:[[UIButton alloc]init]];
    [[DQViewController Sharedbxtabar]tabBar:(DQview *)controller.view didSelectedIndex:0];
    
    [[RHTabbarManager sharedInterface] initTabbar];
    
    [[[RHTabbarManager sharedInterface] selectTabbarMain] popToRootViewControllerAnimated:NO];
}
@end
