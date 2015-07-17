//
//  RHMyGiftViewController.m
//  ryhui
//
//  Created by jufenghudong on 15/4/14.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHMyGiftViewController.h"
#import "RHMyGiftContentViewController.h"

@interface RHMyGiftViewController ()

@property(nonatomic,strong)RHSegmentContentView* segmentContentView;
@property(nonatomic,strong)NSMutableArray* viewControllers;
@property (weak, nonatomic) IBOutlet UIView *segmentView1;
@property (weak, nonatomic) IBOutlet UIView *segmentView2;
@property (weak, nonatomic) IBOutlet UIView *segmentView3;

@end

@implementation RHMyGiftViewController
@synthesize segmentContentView=_segmentContentView;
@synthesize viewControllers=_viewControllers;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewControllers=[[NSMutableArray alloc]initWithCapacity:0];
    
    [self configBackButton];
    [self configTitleWithString:@"我的红包"];
    
    self.segmentContentView = [[RHSegmentContentView alloc] initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].applicationFrame.size.height-50-40-self.navigationController.navigationBar.frame.size.height)];
//    DLog(@"%f----%f",[UIScreen mainScreen].applicationFrame.size.height-50-40-self.navigationController.navigationBar.frame.size.height,self.navigationController.navigationBar.frame.size.height);
    [_segmentContentView setDelegate:self];
    [self.view addSubview:_segmentContentView];

    
    RHMyGiftContentViewController* controller1=[[RHMyGiftContentViewController alloc]init];
    controller1.nav=self.navigationController;
    controller1.type=@"front/payment/account/myInitGiftListData";
    [_viewControllers addObject:controller1];
    
    RHMyGiftContentViewController* controller2=[[RHMyGiftContentViewController alloc]init];
    controller2.nav=self.navigationController;
    controller2.type=@"front/payment/account/myUsedGiftListData";
    [_viewControllers addObject:controller2];
    
    RHMyGiftContentViewController* controller3=[[RHMyGiftContentViewController alloc]init];
    controller3.nav=self.navigationController;
    controller3.type=@"front/payment/account/myPastGiftListData";
    [_viewControllers addObject:controller3];
    
    [_segmentContentView setViews:_viewControllers];
    
    [self segmentContentView:_segmentContentView selectPage:0];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=NO;
     [self initData];
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
    
    RHMyGiftContentViewController* controller=[_viewControllers objectAtIndex:page];
    if ([[NSNumber numberWithInteger:[controller.dataArray count]] intValue]<=0) {
        [controller startPost];
    }
}
@end
