//
//  RHProjectDetailViewController.m
//  ryhui
//
//  Created by stefan on 15/3/14.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHProjectDetailViewController.h"

@interface RHProjectDetailViewController ()

@end

@implementation RHProjectDetailViewController
@synthesize projectId;
@synthesize dataDic;
@synthesize dataArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.dataArray=[[NSMutableArray alloc] initWithCapacity:0];

    [self configBackButton];
    
    [self configTitleWithString:@"项目详情"];
    
    [self setupWithDic:self.dataDic];
    
    [self projectInvestmentList];
    
    [self appShangDetailData];
}


-(void)setupWithDic:(NSDictionary*)dic
{
    self.segmentView1.frame=CGRectMake(8, 170, self.segmentView1.frame.size.width, [UIScreen mainScreen].applicationFrame.size.height-self.navigationController.navigationBar.frame.size.height-75);
    self.scrollView.frame=CGRectMake(0, 35, self.segmentView1.frame.size.width, self.segmentView1.frame.size.height-35);
    
    self.segmentView2.frame=CGRectMake(8, 170, self.segmentView2.frame.size.width, [UIScreen mainScreen].applicationFrame.size.height-self.navigationController.navigationBar.frame.size.height-75);
    
    self.segment2ContentView.frame=CGRectMake(0, 35, self.segmentView2.frame.size.width, self.segmentView2.frame.size.height-35);
    
    self.segmentView1.hidden=NO;
    self.segmentView2.hidden=YES;
    [self didSelectSegmentAtIndex:0];
    
    self.projectId=[dic objectForKey:@"id"];
    
    self.nameLabel.text=[dic objectForKey:@"name"];
    self.paymentNameLabel.text=[dic objectForKey:@"paymentName"];
    self.investorRateLabel.text=[[dic objectForKey:@"investorRate"] stringValue];
    self.limitTimeLabel.text=[[dic objectForKey:@"limitTime"] stringValue];
    self.projectFundLabel.text=[NSString stringWithFormat:@"%.1f",([[dic objectForKey:@"projectFund"] floatValue]/10000.0)];
    self.insuranceMethodLabel.text=[dic objectForKey:@"insuranceMethod"];
    
    self.availableLabel.text=[[dic objectForKey:@"available"] stringValue];
    
    CGFloat percent=[[dic objectForKey:@"percent"] floatValue]/100.0;
    
    self.progressImageView.frame=CGRectMake(0, self.progressImageView.frame.origin.y, ([UIScreen mainScreen].bounds.size.width-34-16)*percent, self.progressImageView.frame.size.height);
    self.progressLabel.frame=CGRectMake(self.progressImageView.frame.size.width+1, 130,34, 14);
    
}

-(void)projectInvestmentList
{
    int arrayCount=[[NSNumber numberWithInteger:[dataArray count]] intValue];
    
    
    NSString* page=[[NSNumber numberWithInt:(arrayCount/10+1)] stringValue];
    
    NSDictionary* parameters=@{@"projectId":self.projectId,@"search":@"true",@"rows":@"10",@"page":page,@"sidx":@"",@"sord":@"",@"filters":@"{\"groupOp\":\"AND\",\"rules\":[]}"};    [[RHNetworkService instance] POST:@"common/main/projectInvestmentList" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        DLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSArray* array=[responseObject objectForKey:@"rows"];
            if ([array isKindOfClass:[NSArray class]]) {
                for (NSDictionary* dic in array) {
                    if ([dic objectForKey:@"cell"]&&!([[dic objectForKey:@"cell"] isKindOfClass:[NSNull class]])) {
                        [self.dataArray addObject:[dic objectForKey:@"cell"]];
                    }
                    
                }
            }
            NSString* records=[responseObject objectForKey:@"records"];
            if (records&&[records intValue]<10) {
                //已经到底了
            }

            [self.tableView reloadData];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"%@",error);
        [RHUtility showTextWithText:@"请求失败"];
    }];
}

-(void)appShangDetailData
{
    NSDictionary* parameters=@{@"id":projectId};
    
    [[RHNetworkService instance] POST:@"common/main/appShangDetailData" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSArray* insuranceImages=[responseObject objectForKey:@"insuranceImages"];
            for (NSDictionary* insuranceDic in insuranceImages) {
                int index=[[NSNumber numberWithInteger:[insuranceImages indexOfObject:insuranceDic]] intValue];
                UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(index*(45+10),4, 45, 45)];
                [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[RHNetworkService instance].doMain,[insuranceDic objectForKey:@"filepath"]]]];
                DLog(@"%@",[NSString stringWithFormat:@"%@common/main/%@",[RHNetworkService instance].doMain,[insuranceDic objectForKey:@"filepath"]]);
                
                [self.insuranceScrollView addSubview:imageView];
            }
            self.insuranceScrollView.contentSize=CGSizeMake([insuranceImages count]*55,53);
            
            NSDictionary* projectDic=[responseObject objectForKey:@"project"];
            self.projectDetail.text=[projectDic objectForKey:@"projectInfo"];
            
            NSArray* projectImages=[responseObject objectForKey:@"projectImages"];
            for (NSDictionary* projectImagesDic in projectImages) {
                int index=[[NSNumber numberWithInteger:[projectImages indexOfObject:projectImagesDic]] intValue];
                UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(index*(45+10),4, 45, 45)];
                [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[RHNetworkService instance].doMain,[projectImagesDic objectForKey:@"filepath"]]]];
                DLog(@"%@",[NSString stringWithFormat:@"%@%@",[RHNetworkService instance].doMain,[projectImagesDic objectForKey:@"filepath"]]);
                [self.projectScrollView addSubview:imageView];
            }
            self.projectScrollView.contentSize=CGSizeMake([projectImages count]*55,53);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [RHUtility showTextWithText:@"请求失败"];
    }];
}
- (IBAction)pushMain:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)pushUserCenter:(id)sender {
    
    [[RHTabbarManager sharedInterface] selectTabbarUser];
}

- (IBAction)pushMore:(id)sender {
    [[RHTabbarManager sharedInterface] selectTabbarMore];
}



- (IBAction)segment1Action:(id)sender {
    if (self.segmentView1.hidden) {
        self.segmentView1.hidden=NO;
        self.segmentView2.hidden=YES;
        [self didSelectSegmentAtIndex:0];
    }
    
}

- (IBAction)segment2Action:(id)sender {
    if (self.segmentView2.hidden) {
        self.segmentView2.hidden=NO;
        self.segmentView1.hidden=YES;
        [self didSelectSegmentAtIndex:1];
    }
}

-(void)didSelectSegmentAtIndex:(int)index
{
    switch (index) {
        case 0:

            break;
        case 1:
  
            break;
        default:
            break;
    }
}

#pragma mark-TableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 25;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    
    RHProjectDetailViewCell *cell = (RHProjectDetailViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"RHProjectDetailViewCell" owner:nil options:nil] objectAtIndex:0];
    }
    
    NSDictionary* dataDic=[self.dataArray objectAtIndex:indexPath.row];
    
    [cell updateCell:dataDic];
    
    return cell;
}
@end
