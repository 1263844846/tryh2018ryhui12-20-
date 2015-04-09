//
//  RHProjectDetailViewController.m
//  ryhui
//
//  Created by stefan on 15/3/14.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHProjectDetailViewController.h"

@interface RHProjectDetailViewController ()
{
    int available;
}
@end

@implementation RHProjectDetailViewController
@synthesize projectId;
@synthesize dataDic;
@synthesize dataArray;
@synthesize type;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.dataArray=[[NSMutableArray alloc] initWithCapacity:0];

    [self configBackButton];
    
    [self configTitleWithString:@"项目详情"];
    
    [self setupWithDic:self.dataDic];
    
    [self projectInvestmentList];
    if ([type isEqualToString:@"0"]) {
        [self appShangDetailData];
    }else{
        [self appXueDetailData];
    }
    
    if (![RHUserManager sharedInterface].username) {
        [self.investmentButton setTitle:@"立即登录" forState:UIControlStateNormal];
    }else{
        if (![RHUserManager sharedInterface].custId) {
            [self.investmentButton setTitle:@"请先开户" forState:UIControlStateNormal];
        }
    }
    
    self.scrollView.frame=CGRectMake(0, 35, self.segmentView1.frame.size.width, [UIScreen mainScreen].applicationFrame.size.height-self.navigationController.navigationBar.frame.size.height-280);
    
    self.scrollView.contentSize=CGSizeMake(self.segmentView1.frame.size.width,267);
}


-(void)setupWithDic:(NSDictionary*)dic
{
    self.segmentView1.frame=CGRectMake(8, 170, self.segmentView1.frame.size.width, [UIScreen mainScreen].applicationFrame.size.height-self.navigationController.navigationBar.frame.size.height-75);
    self.scrollView.frame=CGRectMake(0, 35, self.segmentView1.frame.size.width, self.segmentView1.frame.size.height-35);
    
    self.segmentView2.frame=CGRectMake(8, 170, self.segmentView2.frame.size.width, [UIScreen mainScreen].applicationFrame.size.height-self.navigationController.navigationBar.frame.size.height-75);
    
    self.segment2ContentView.frame=CGRectMake(0, 35, self.segmentView2.frame.size.width, self.segmentView2.frame.size.height-35);
    
    if ([type isEqualToString:@"0"]) {
        self.segmentView1.hidden=NO;
        self.segmentView3.hidden=YES;
    }else{
        self.segmentView1.hidden=YES;
        self.segmentView3.hidden=NO;
    }
    self.segmentView2.hidden=YES;
    [self didSelectSegmentAtIndex:0];
    
    if ([[dic objectForKey:@"id"] isKindOfClass:[NSNull class]]) {
        self.projectId=@"";
    }else{
        self.projectId=[dic objectForKey:@"id"];
    }
    
    if ([[dic objectForKey:@"name"] isKindOfClass:[NSNull class]]) {
        self.nameLabel.text=@"";
    }else{
        self.nameLabel.text=[dic objectForKey:@"name"];
    }
    
    if ([[dic objectForKey:@"paymentName"] isKindOfClass:[NSNull class]]) {
        self.paymentNameLabel.text=@"";
    }else{
        self.paymentNameLabel.text=[dic objectForKey:@"paymentName"];
    }

    if ([[dic objectForKey:@"investorRate"] isKindOfClass:[NSNull class]]) {
        self.investorRateLabel.text=@"";
    }else{
        self.investorRateLabel.text=[[dic objectForKey:@"investorRate"] stringValue];
    }
    if ([[dic objectForKey:@"limitTime"] isKindOfClass:[NSNull class]]) {
        self.limitTimeLabel.text=@"";
    }else{
        self.limitTimeLabel.text=[[dic objectForKey:@"limitTime"] stringValue];

    }
    self.projectFundLabel.text=[NSString stringWithFormat:@"%.1f",([[dic objectForKey:@"projectFund"] floatValue]/10000.0)];
    
    if ([[dic objectForKey:@"insuranceMethod"] isKindOfClass:[NSNull class]]) {
        self.insuranceMethodLabel.text=@"";
    }else{
        self.insuranceMethodLabel.text=[dic objectForKey:@"insuranceMethod"];
    }
    
 
    
    CGFloat percent=[[dic objectForKey:@"percent"] floatValue]/100.0;
    
    self.progressImageView.frame=CGRectMake(0, self.progressImageView.frame.origin.y, ([UIScreen mainScreen].bounds.size.width-40-16)*percent, self.progressImageView.frame.size.height);
    self.progressLabel.text=[NSString stringWithFormat:@"%d%%",[[dic objectForKey:@"percent"] intValue]];
    self.progressLabel.frame=CGRectMake(self.progressImageView.frame.size.width+1, 130,34, 14);
    if ([self.progressLabel.text isEqualToString:@"100%"]) {
        [self.investmentButton setTitle:@"已满标" forState:UIControlStateNormal];
        self.investmentButton.enabled=NO;
        [self.investmentButton setBackgroundColor:[UIColor lightGrayColor]];
    }
    
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
//project =     {
//    available = 0;
//    available2 = "0.00";
//    class = "view.ProjectStudentDetailView";
//    id = 310;
//    insuranceMethod = "\U5c31\U4e1a\U62c5\U4fdd\U4e0e\U98ce\U9669\U4fdd\U8bc1\U91d1\U53cc\U91cd\U672c\U606f\U4fdd\U969c";
//    investorRate = 10;
//    limitTime = "6.0";
//    name = "\U7231\U59d1\U5a18\U4eec\U554a\U4e24\U4e2a\U4f60";
//    partnerInfo = fdsfa;
//    paymentName = "\U6309\U6708\U4ed8\U606f\U3001\U5230\U671f\U8fd8\U672c";
//    paymentType = 04;
//    percent = 100;
//    projectFund = "16,800.00";
//    projectStatus = finished;
//    studentAge = 0;
//    studentCity = "\U5e02\U8f96\U533a";
//    studentEducation = "\U7855\U58eb\U7814\U7a76\U751f";
//    studentGender = "\U5973";
//    studentName = "\U5b66**";
//    studentNation = "\U8499\U53e4\U65cf";
//    studentProfession = "\U8f6f\U4ef6\U5de5\U7a0b";
//    studentSchool = "\U534e\U7535";
//    version = 13;
//};
-(void)appXueDetailData
{
    NSDictionary* parameters=@{@"id":projectId};
    
    [[RHNetworkService instance] POST:@"common/main/appXueDetailData" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary* project=[responseObject objectForKey:@"project"];
            DLog(@"%@",project);
            self.studentNameLabel.text=[project objectForKey:@"studentName"];
            self.studentCityLabel.text=[project objectForKey:@"studentCity"];
            self.studentSchoolLabel.text=[project objectForKey:@"studentSchool"];
            self.studentGenderLabel.text=[project objectForKey:@"studentGender"];
            self.studentNationLabel.text=[project objectForKey:@"studentNation"];
            self.studentProfessionLabel.text=[project objectForKey:@"studentProfession"];
            self.studentAgeLabel.text=[[project objectForKey:@"studentAge"] stringValue];
            self.studentEducationLabel.text=[project objectForKey:@"studentEducation"];
            self.partnerInfoLabel.text=[project objectForKey:@"partnerInfo"];
            
            if ([[project objectForKey:@"available2"] isKindOfClass:[NSNull class]]) {
                self.availableLabel.text=@"";
            }else{
                self.availableLabel.text=[project objectForKey:@"available2"];
            }
            available=[[project objectForKey:@"available"] intValue];


        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
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
                [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@common/main/attachment/%@",[RHNetworkService instance].doMain,[insuranceDic objectForKey:@"filepath"]]]];
                DLog(@"%@",[NSString stringWithFormat:@"%@common/main/attachment/%@",[RHNetworkService instance].doMain,[insuranceDic objectForKey:@"filepath"]]);
                
                [self.insuranceScrollView addSubview:imageView];
            }
            self.insuranceScrollView.contentSize=CGSizeMake([insuranceImages count]*55,53);
            
            NSDictionary* projectDic=[responseObject objectForKey:@"project"];
            self.projectDetail.text=[projectDic objectForKey:@"projectInfo"];
            
            NSArray* projectImages=[responseObject objectForKey:@"projectImages"];
            for (NSDictionary* projectImagesDic in projectImages) {
                int index=[[NSNumber numberWithInteger:[projectImages indexOfObject:projectImagesDic]] intValue];
                UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(index*(45+10),4, 45, 45)];
                [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@common/main/attachment/%@",[RHNetworkService instance].doMain,[projectImagesDic objectForKey:@"filepath"]]]];
                DLog(@"%@",[NSString stringWithFormat:@"%@%@",[RHNetworkService instance].doMain,[projectImagesDic objectForKey:@"filepath"]]);
                [self.projectScrollView addSubview:imageView];
            }
            if ([[projectDic objectForKey:@"available2"] isKindOfClass:[NSNull class]]) {
                self.availableLabel.text=@"";
            }else{
                self.availableLabel.text=[projectDic objectForKey:@"available2"];
            }
            
            available=[[projectDic objectForKey:@"available"] intValue];

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
        if ([type isEqualToString:@"0"]) {
            self.segmentView1.hidden=NO;
            self.segmentView3.hidden=YES;
        }else{
            self.segmentView1.hidden=YES;
            self.segmentView3.hidden=NO;
        }
        self.segmentView2.hidden=YES;
        [self didSelectSegmentAtIndex:0];
    }
    
}

- (IBAction)segment2Action:(id)sender {
    if (self.segmentView2.hidden) {
        self.segmentView2.hidden=NO;
        self.segmentView1.hidden=YES;
        self.segmentView3.hidden=YES;

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
    return 40;
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
- (IBAction)Investment:(id)sender {
    RHInvestmentViewController* contoller=[[RHInvestmentViewController alloc]initWithNibName:@"RHInvestmentViewController" bundle:nil];
    contoller.projectFund=available;
    contoller.dataDic=self.dataDic;
    [self.navigationController pushViewController:contoller animated:YES];
}
@end
