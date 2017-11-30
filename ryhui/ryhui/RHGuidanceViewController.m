//
//  RHGuidanceViewController.m
//  ryhui
//
//  Created by 江 云龙 on 15/3/17.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHGuidanceViewController.h"
#import "RHLoginViewController.h"

@interface RHGuidanceViewController () <RHSegmentContentViewDelegate,UIScrollViewDelegate>
@property(nonatomic,strong)RHLoginViewController* loginVC;
@property (weak, nonatomic) IBOutlet UIPageControl *pageController;
@property(nonatomic,strong)RHSegmentContentView* segmentContentView;
@property(nonatomic,strong)NSMutableArray* views;
@property (weak, nonatomic) IBOutlet UIScrollView *scollView;

@end

@implementation RHGuidanceViewController
@synthesize segmentContentView=_segmentContentView;
@synthesize views=_views;
@synthesize loginVC=_loginVC;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.views=[[NSMutableArray alloc]initWithCapacity:0];

    self.segmentContentView = [[RHSegmentContentView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [_segmentContentView setDelegate:self];
    [self.view addSubview:_segmentContentView];
    
    UIImageView* imageView1=[[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    imageView1.image=[UIImage imageNamed:@"ydyy1"];
    [_views addObject:imageView1];
    UIImageView* imageView2=[[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    imageView2.image=[UIImage imageNamed:@"ydyy2"];
    [_views addObject:imageView2];
    UIImageView* imageView3=[[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    imageView3.image=[UIImage imageNamed:@"ydyy3"];
    [_views addObject:imageView3];
    
    self.loginVC=[[RHLoginViewController alloc]initWithNibName:@"RHLoginViewController" bundle:nil];
    self.loginVC.nav=self.navigationController;
    [_views addObject:self.loginVC.view];

    [_segmentContentView setViews:_views];
    
    [self.view addSubview:self.pageController];
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

- (void)segmentContentView:(RHSegmentContentView *)segmentContentView selectPage:(NSUInteger)page{
    self.pageController.currentPage=page;
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}
@end
