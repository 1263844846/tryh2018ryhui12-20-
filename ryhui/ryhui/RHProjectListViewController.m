//
//  RHProjectListViewController.m
//  ryhui
//
//  Created by 江 云龙 on 15/3/17.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHProjectListViewController.h"
#import "RHProjectListContentViewController.h"

@interface RHProjectListViewController ()

@end

@implementation RHProjectListViewController
@synthesize segmentContentView=_segmentContentView;
@synthesize viewControllers=_viewControllers;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewControllers=[[NSMutableArray alloc]initWithCapacity:0];


    
    [self configBackButton];
    [self configTitleWithString:@"项目列表"];
    
    self.segmentContentView = [[RHSegmentContentView alloc] initWithFrame:CGRectMake(0, 75, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].applicationFrame.size.height-75-40-self.navigationController.navigationBar.frame.size.height)];
    DLog(@"%f----%f",[UIScreen mainScreen].applicationFrame.size.height-75-40-self.navigationController.navigationBar.frame.size.height,self.navigationController.navigationBar.frame.size.height);
    [_segmentContentView setDelegate:self];
    [self.view addSubview:_segmentContentView];
    
    RHProjectListContentViewController* controller1=[[RHProjectListContentViewController alloc]init];
    controller1.type=@"0";
    controller1.prarentNav=self.navigationController;
    
    [_viewControllers addObject:controller1];
    
    RHProjectListContentViewController* controller2=[[RHProjectListContentViewController alloc]init];
    controller2.type=@"1";
    controller2.prarentNav=self.navigationController;
    [_viewControllers addObject:controller2];
    
    [_segmentContentView setViews:_viewControllers];
    
    [self segmentContentView:_segmentContentView selectPage:0];
    
    self.segmentView1.hidden=NO;
    self.segmentView2.hidden=YES;
    [self didSelectSegmentAtIndex:0];
    self.segmentLabel.layer.cornerRadius=8;
    self.segmentLabel1.layer.cornerRadius=8;
    self.segmentLabel3.layer.cornerRadius=8;
    self.segmentLabel4.layer.cornerRadius=8;
    self.segmentLabel.hidden=YES;
    self.segmentLabel1.hidden=YES;
    self.segmentLabel3.hidden=YES;
    self.segmentLabel4.hidden=YES;
    [self getSegmentnum1];
    [self getSegmentnum2];
}

#pragma mark-network
-(void)getSegmentnum1
{
    
    
    NSDictionary* parameters=@{@"search":@"true",@"rows":@"1000",@"page":@"1",@"filters":@"{\"groupOp\":\"AND\",\"rules\":[{\"field\":\"percent\",\"op\":\"lt\",\"data\":100}]}"};
    
    [[RHNetworkService instance] POST:@"common/main/shangListData" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            int num=[[responseObject objectForKey:@"records"] intValue];
            if (num>0) {
                self.segmentLabel.text=[NSString stringWithFormat:@"可投%d",num];
                self.segmentLabel.hidden=NO;
                self.segmentLabel3.text=[NSString stringWithFormat:@"可投%d",num];
                self.segmentLabel3.hidden=NO;
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"%@",error);
    }];
}
-(void)getSegmentnum2
{
    
    
    NSDictionary* parameters=@{@"search":@"true",@"rows":@"1000",@"page":@"1",@"filters":@"{\"groupOp\":\"AND\",\"rules\":[{\"field\":\"percent\",\"op\":\"lt\",\"data\":100}]}"};
    [[RHNetworkService instance] POST:@"common/main/xueListData" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            int num=[[responseObject objectForKey:@"records"] intValue];
            if (num>0) {
                self.segmentLabel1.text=[NSString stringWithFormat:@"可投%d",num];
                self.segmentLabel1.hidden=NO;
                self.segmentLabel4.text=[NSString stringWithFormat:@"可投%d",num];
                self.segmentLabel4.hidden=NO;
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"%@",error);
    }];
}

- (void)didSelectSegmentAtIndex:(int)index
{
    RHProjectListContentViewController* controller=[_viewControllers objectAtIndex:index];
    [controller.tableView setContentOffset:CGPointMake(0,0) animated:YES];
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
        default:
            break;
    }
    
    RHProjectListContentViewController* controller=[_viewControllers objectAtIndex:page];
    if ([[NSNumber numberWithInteger:[controller.dataArray count]] intValue]<=0) {
        [controller startPost];
    }
}


- (IBAction)yearEarnAction:(id)sender {
}

- (IBAction)deadlineAction:(id)sender {
}

- (IBAction)totalMoneyAction:(id)sender {
}

- (IBAction)investmentProgressAction:(id)sender {
}

- (IBAction)segmentAction1:(id)sender {
    if (self.segmentView1.hidden) {
        self.segmentView1.hidden=NO;
        self.segmentView2.hidden=YES;
        [self didSelectSegmentAtIndex:0];
    }
}

- (IBAction)segmentAction2:(id)sender {
    if (self.segmentView2.hidden) {
        self.segmentView2.hidden=NO;
        self.segmentView1.hidden=YES;
        [self didSelectSegmentAtIndex:1];
    }
}

- (IBAction)pushMain:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)pushUser:(id)sender {
    [[RHTabbarManager sharedInterface] selectTabbarUser];
}

- (IBAction)pushMore:(id)sender {
    [[RHTabbarManager sharedInterface] selectTabbarMore];
}


@end
