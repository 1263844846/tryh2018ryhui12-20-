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

@end

@implementation RHMyInvestmentViewController
@synthesize segmentContentView=_segmentContentView;
@synthesize viewControllers=_viewControllers;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewControllers=[[NSMutableArray alloc]initWithCapacity:0];
    
    [self configBackButton];
    [self configTitleWithString:@"我的投资"];
    
    [self initData];
    
    self.segmentContentView = [[RHSegmentContentView alloc] initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].applicationFrame.size.height-50-40-self.navigationController.navigationBar.frame.size.height)];
//    DLog(@"%f----%f",[UIScreen mainScreen].applicationFrame.size.height-50-40-self.navigationController.navigationBar.frame.size.height,self.navigationController.navigationBar.frame.size.height);
    [_segmentContentView setDelegate:self];
    [self.view addSubview:_segmentContentView];
    
    NSString* one=@"{\"groupOp\":\"AND\",\"rules\":[{\"field\":\"projectStatus\",\"op\":\"in\",\"data\":[\"loans\",\"repayment_normal\",\"repayment_abnormal\"]}]}";
    
    NSString* two=@"{\"groupOp\":\"AND\",\"rules\":[{\"field\":\"projectStatus\",\"op\":\"in\",\"data\":[\"full\",\"published\"]}]}";
    
    NSString* three=@"{\"groupOp\":\"AND\",\"rules\":[{\"field\":\"projectStatus\",\"op\":\"in\",\"data\":[\"finished\"]}]}";
    
    RHInvestmentContentViewController* controller1=[[RHInvestmentContentViewController alloc]init];
    controller1.nav=self.navigationController;
    controller1.type=one;
    [_viewControllers addObject:controller1];
    
    RHInvestmentContentViewController* controller2=[[RHInvestmentContentViewController alloc]init];
    controller2.nav=self.navigationController;
    controller2.type=two;
    [_viewControllers addObject:controller2];
    
    RHInvestmentContentViewController* controller3=[[RHInvestmentContentViewController alloc]init];
    controller3.nav=self.navigationController;
    controller3.type=three;
    [_viewControllers addObject:controller3];
    
    [_segmentContentView setViews:_viewControllers];

    [self segmentContentView:_segmentContentView selectPage:0];
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

@end
