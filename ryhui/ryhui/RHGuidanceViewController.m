//
//  RHGuidanceViewController.m
//  ryhui
//
//  Created by 江 云龙 on 15/3/17.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHGuidanceViewController.h"

@interface RHGuidanceViewController ()

@end

@implementation RHGuidanceViewController
@synthesize segmentContentView=_segmentContentView;
@synthesize views=_views;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.views=[[NSMutableArray alloc]initWithCapacity:0];

    self.segmentContentView = [[RHSegmentContentView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [_segmentContentView setDelegate:self];
    [self.view addSubview:_segmentContentView];
    
    UIImageView* imageView1=[[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    imageView1.image=[UIImage imageNamed:@"guidan1.jpg"];
    [_views addObject:imageView1];
    UIImageView* imageView2=[[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    imageView2.image=[UIImage imageNamed:@"guidan2.jpg"];
    [_views addObject:imageView2];
    UIImageView* imageView3=[[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    imageView3.image=[UIImage imageNamed:@"guidan3.jpg"];
    [_views addObject:imageView3];
    
    [_segmentContentView setViews:_views];
    
}
- (void)segmentContentView:(RHSegmentContentView *)segmentContentView selectPage:(NSUInteger)page{
    DLog(@"%lu",(unsigned long)page);
    if (page==2) {
        [[RHTabbarManager sharedInterface] performSelector:@selector(selectLogin) withObject:nil afterDelay:3];
    }
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}
@end
