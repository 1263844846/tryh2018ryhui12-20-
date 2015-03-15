//
//  RHMainViewController.m
//  ryhui
//
//  Created by stefan on 15/2/28.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHMainViewController.h"
#import "RHMainViewCell.h"
#import "RHProjectDetailViewController.h"

@interface RHMainViewController ()

@end

@implementation RHMainViewController
@synthesize segment1Array;
@synthesize segment2Array;
@synthesize dataArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configTitleWithString:@"融益汇"];
    
    RHSegmentView* segmentView=[[[NSBundle mainBundle] loadNibNamed:@"RHSegmentView" owner:nil options:nil] objectAtIndex:0];
    segmentView.delegate=self;
    segmentView.frame=CGRectMake(segmentView.frame.origin.x, 115, segmentView.frame.size.width, segmentView.frame.size.height);
    [segmentView initData];
    [self.headerView addSubview:segmentView];
    
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor=[UIColor clearColor];
    self.tableView.frame=CGRectMake(0, 305, [UIScreen mainScreen].applicationFrame.size.width, [UIScreen mainScreen].applicationFrame.size.height-self.navigationController.navigationBar.frame.size.height-40-305);
    
    self.segment1Array=[[NSMutableArray alloc]initWithCapacity:0];
    self.segment2Array=[[NSMutableArray alloc]initWithCapacity:0];
    self.dataArray=[[NSMutableArray alloc]initWithCapacity:0];
    
}

#pragma mark-network
-(void)segment1Post
{
    int arrayCount=[[NSNumber numberWithInteger:[segment1Array count]] intValue];
    
    
    NSString* page=[[NSNumber numberWithInt:(arrayCount/10+1)] stringValue];
    
    NSDictionary* parameters=@{@"search":@"true",@"rows":@"10",@"page":page,@"sidx":@"",@"sord":@"",@"filters":@"{\"groupOp\":\"AND\",\"rules\":[]}"};
    
    [[RHNetworkService instance] POST:@"common/main/shangListData" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSArray* array=[responseObject objectForKey:@"rows"];
            if ([array isKindOfClass:[NSArray class]]) {
                for (NSDictionary* dic in array) {
                    if ([dic objectForKey:@"cell"]&&!([[dic objectForKey:@"cell"] isKindOfClass:[NSNull class]])) {
                        [self.segment1Array addObject:[dic objectForKey:@"cell"]];
                    }
    
                }
            }
            NSString* records=[responseObject objectForKey:@"records"];
            if (records&&[records intValue]<10) {
                //已经到底了
            }
            [self.dataArray removeAllObjects];
            [self.dataArray addObjectsFromArray:self.segment1Array];
            [self.tableView reloadData];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"%@",error);
        [RHUtility showTextWithText:@"请求失败"];
    }];
}

-(void)segment2Post
{
    int arrayCount=[[NSNumber numberWithInteger:[segment1Array count]] intValue];
    
    
    NSString* page=[[NSNumber numberWithInt:(arrayCount/10+1)] stringValue];
    
    NSDictionary* parameters=@{@"search":@"true",@"rows":@"10",@"page":page,@"sidx":@"",@"sord":@"",@"filters":@"{\"groupOp\":\"AND\",\"rules\":[]}"};
    
    [[RHNetworkService instance] POST:@"common/main/shangListData" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"%@",responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"%@",error);
    }];

}

#pragma mark-RHSegmentDelegate
-(void)didSelectSegmentAtIndex:(int)index
{
    switch (index) {
        case 0:
            if ([self.segment1Array count]<=0) {
                [self segment1Post];
            }else{
                [self.dataArray removeAllObjects];
                [self.dataArray addObjectsFromArray:self.segment1Array];
                [self.tableView reloadData];
            }
            break;
        case 1:
            if ([self.segment2Array count]<=0) {
                [self segment2Array];
            }else{
                [self.dataArray removeAllObjects];
                [self.dataArray addObjectsFromArray:self.segment2Array];
                [self.tableView reloadData];
            }
            break;
        default:
            break;
    }
}

#pragma mark-TableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 103;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";

    RHMainViewCell *cell = (RHMainViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"RHMainViewCell" owner:nil options:nil] objectAtIndex:0];
    }
    
    NSDictionary* dataDic=[self.dataArray objectAtIndex:indexPath.row];
    
    [cell updateCell:dataDic];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RHProjectDetailViewController* controller=[[RHProjectDetailViewController alloc]initWithNibName:@"RHProjectDetailViewController" bundle:nil];
    NSDictionary* dataDic=[self.dataArray objectAtIndex:indexPath.row];
    controller.dataDic=dataDic;
    [self.navigationController pushViewController:controller animated:YES];

}

#pragma mark-Push

- (IBAction)pushUserCenter:(id)sender {
    
    [[RHTabbarManager sharedInterface] selectTabbarUser];
}

- (IBAction)pushMore:(id)sender {
    
    [[RHTabbarManager sharedInterface] selectTabbarMore];
}
@end
