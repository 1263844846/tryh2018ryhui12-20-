//
//  RHMyInvestmentViewController.m
//  ryhui
//
//  Created by stefan on 15/3/15.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHMyInvestmentViewController.h"
#import "RHInvestmentContentViewController.h"

@interface RHMyInvestmentViewController ()

@property(nonatomic,strong)RHSegmentContentView* segmentContentView;
@property(nonatomic,strong)NSMutableArray* viewControllers;
@property (weak, nonatomic) IBOutlet UIView *segmentView1;
@property (weak, nonatomic) IBOutlet UIView *segmentView2;
@property (weak, nonatomic) IBOutlet UIView *segmentView3;
@property (weak, nonatomic) IBOutlet UIView *myaview;
@property (weak, nonatomic) IBOutlet UIView *titleview;


@end

@implementation RHMyInvestmentViewController
@synthesize segmentContentView=_segmentContentView;
@synthesize viewControllers=_viewControllers;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
     self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
       if (self) {
         // Custom initialization.
       //  self.hidesBottomBarWhenPushed = YES;
    }
      return self;
 }

-(void)hindetabbar{
    
  ///  self.hidesBottomBarWhenPushed = NO;
}
-(void)hindetabbar1{
    
  ///  self.hidesBottomBarWhenPushed = YES;
}
-(void)viewWillAppear:(BOOL)animated{
   self.navigationController.navigationBar.hidden=YES;
    
        [RYHViewController Sharedbxtabar].tarbar.hidden = YES;
   
    [super viewWillAppear:animated];

   NSLog(@"====-%@-=======",self.navigationController.navigationBar.backgroundColor);
    
    NSLog(@"====-%f-=======",self.navigationController.navigationBar.alpha);
    
}


-(void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
    //[self hindetabbar1];
}
- (void)configBackButton
{
    UIButton* button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    //    UIImage * image = [UIImage imageNamed:@"back.png"];
    
    [button setImage:[UIImage imageNamed:@"icon_back.png"] forState:UIControlStateNormal];
     button.frame=CGRectMake(0, 0, 25, 40);
    
    // button.backgroundColor = [UIColor colorWithHexString:@"44bbc1"];
    self.navigationItem.leftBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   

    self.viewControllers=[[NSMutableArray alloc]initWithCapacity:0];

    [self configBackButton];
    [self configTitleWithString:@"我的出借"];
//    self.tabBarController.tabBar.hidden = YES;
   
    [RYHViewController Sharedbxtabar].tarbar.hidden = YES;
    self.segmentContentView = [[RHSegmentContentView alloc] initWithFrame:CGRectMake(0, 110, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].applicationFrame.size.height-50-40-self.navigationController.navigationBar.frame.size.height-10+40)];
    
    if ([UIScreen mainScreen].bounds.size.height>740) {
        self.titleview.frame = CGRectMake(0, 40, self.titleview.frame.size.width, 65);
         self.segmentContentView = [[RHSegmentContentView alloc] initWithFrame:CGRectMake(0, 150, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].applicationFrame.size.height-50-40-self.navigationController.navigationBar.frame.size.height-10+40)];
        self.segmentView1.frame = CGRectMake(0, 105, self.segmentView1.frame.size.width, 50);
        self.segmentView2.frame = CGRectMake(0, 105, self.segmentView1.frame.size.width, 50);
        self.segmentView3.frame = CGRectMake(0, 105, self.segmentView1.frame.size.width, 50);
    }
    
//    DLog(@"%f----%f",[UIScreen mainScreen].applicationFrame.size.height-50-40-self.navigationController.navigationBar.frame.size.height,self.navigationController.navigationBar.frame.size.height);
    [_segmentContentView setDelegate:self];
    [self.view addSubview:_segmentContentView];
  
     //[self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
     [self initData];
    
    NSString* one=@"{\"groupOp\":\"AND\",\"rules\":[{\"field\":\"project.project_status\",\"op\":\"in\",\"data\":[\"repayment_normal\",\"repayment_abnormal\"]}]}";
    
    
    NSString* two=@"{\"groupOp\":\"AND\",\"rules\":[{\"field\":\"project.project_status\",\"op\":\"in\",\"data\":[\"full\",\"loans\",\"published\",\"loans_audit\"]}]}";
    
    NSString* three=@"{\"groupOp\":\"AND\",\"rules\":[{\"field\":\"project.project_status\",\"op\":\"in\",\"data\":[\"finished\"]}]}";
    
    
    RHInvestmentContentViewController* controller1=[[RHInvestmentContentViewController alloc]init];
//    controller1.nav=self.navigationController;
   controller1.nav = [[RHTabbarManager sharedInterface] selectTabbarUser];
    controller1.type=one;
//    controller1.ressss =  self.hidesBottomBarWhenPushed ;
    controller1.resstr = self.resstr;
    controller1.myblock = ^{
        [self hindetabbar];
    };
    controller1.myblock1 = ^{
        [self hindetabbar1];
    };
    [_viewControllers addObject:controller1];
    
    RHInvestmentContentViewController* controller2=[[RHInvestmentContentViewController alloc]init];
    //controller2.nav=self.navigationController;
    controller2.nav = [[RHTabbarManager sharedInterface] selectTabbarUser];
    controller2.type=two;
     controller2.resstr = self.resstr;
    controller2.myblock = ^{
        [self hindetabbar];
    };
    controller2.myblock1 = ^{
        [self hindetabbar1];
    };
//    controller2.ressss =  self.hidesBottomBarWhenPushed ;
    [_viewControllers addObject:controller2];
    
    RHInvestmentContentViewController* controller3=[[RHInvestmentContentViewController alloc]init];
//    controller3.nav=self.navigationController;
    controller3.nav = [[RHTabbarManager sharedInterface] selectTabbarUser];
     controller3.resstr = self.resstr;
    controller3.type=three;
    controller3.myblock = ^{
        [self hindetabbar];
    };
    controller3.myblock1 = ^{
        [self hindetabbar1];
    };
//    controller3.ressss =  self.hidesBottomBarWhenPushed ;
    [_viewControllers addObject:controller3];
    
    [_segmentContentView setViews:_viewControllers];

    [self segmentContentView:_segmentContentView selectPage:0];
//     self.hidesBottomBarWhenPushed=YES;
    
    // [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.164 green:0.657 blue:0.915 alpha:1.000]];
}

-(void)initData
{
    self.segmentView1.hidden=NO;
    self.segmentView2.hidden=YES;
    self.segmentView3.hidden=YES;
}


- (IBAction)segmentAction1:(id)sender {
    self.segmentView1.hidden=NO;
    self.segmentView2.hidden=YES;
    self.segmentView3.hidden=YES;
    [self didSelectSegmentAtIndex:0];
}

- (IBAction)segmentAction2:(id)sender {
    self.segmentView1.hidden=YES;
    self.segmentView2.hidden=NO;
    self.segmentView3.hidden=YES;
    [self didSelectSegmentAtIndex:1];
}

- (IBAction)segmentAction3:(id)sender {
    self.segmentView1.hidden=YES;
    self.segmentView2.hidden=YES;
    self.segmentView3.hidden=NO;
    [self didSelectSegmentAtIndex:2];
}

- (IBAction)pushMain:(id)sender {
    [[[RHTabbarManager sharedInterface] selectTabbarMain] popToRootViewControllerAnimated:NO];
}

- (IBAction)pushUser:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)pushMore:(id)sender {
    [[[RHTabbarManager sharedInterface] selectTabbarMore] popToRootViewControllerAnimated:NO];
}

- (void)didSelectSegmentAtIndex:(int)index
{
    [_segmentContentView setSelectPage:index];

}

- (void)segmentContentView:(RHSegmentContentView *)segmentContentView selectPage:(NSUInteger)page{
    switch (page) {
        case 0:
            [self segmentAction1:nil];
            break;
        case 1:
            [self segmentAction2:nil];
            break;
        case 2:
            [self segmentAction3:nil];
            break;
        default:
            break;
    }
    
    RHInvestmentContentViewController* controller=[_viewControllers objectAtIndex:page];
    if ([[NSNumber numberWithInteger:[controller.dataArray count]] intValue]<=0) {
        [controller startPost];
    }
}
- (IBAction)popmycount:(id)sender {
    self.navigationController.navigationBar.hidden=NO;
     [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.hidden=NO;
    [super viewWillDisappear:animated];
    
}
@end
