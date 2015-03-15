//
//  RHTradingViewController.m
//  ryhui
//
//  Created by stefan on 15/3/15.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHTradingViewController.h"
#import "RHTradViewCell.h"
@interface RHTradingViewController ()

@end

@implementation RHTradingViewController
@synthesize dataArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configBackButton];
    [self configTitleWithString:@"交易记录"];
    self.dataArray=[[NSMutableArray alloc]initWithCapacity:0];
    [self getTrading];
    
}

-(void)getTrading
{
    int arrayCount=[[NSNumber numberWithInteger:[dataArray count]] intValue];
    
    
    NSString* page=[[NSNumber numberWithInt:(arrayCount/10+1)] stringValue];
  
    NSDictionary* parameters=@{@"_search":@"true",@"rows":@"10",@"page":page,@"sidx":@"dateCreated",@"sord":@"desc",@"filters":@"{\"groupOp\":\"AND\",\"rules\":[]}"};
    
//    [[RHNetworkService instance] POST:@"front/payment/account/tradeInvestListData" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        DLog(@"%@",responseObject);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        DLog(@"%@",error);
//
//    }];
//    
    AFHTTPRequestOperationManager* manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[[AFCompoundResponseSerializer alloc]init];
    
    [manager POST:[NSString stringWithFormat:@"%@front/payment/account/tradeInvestListData",[RHNetworkService instance].doMain] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"result==%@ <<<",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"%@",error);
    }];
}

#pragma mark-TableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    
    RHTradViewCell *cell = (RHTradViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"RHTradViewCell" owner:nil options:nil] objectAtIndex:0];
    }
    
    NSDictionary* dataDic=[self.dataArray objectAtIndex:indexPath.row];
    
    [cell updateCell:dataDic];
    
    return cell;
}

- (IBAction)pushMain:(id)sender {
    [[RHTabbarManager sharedInterface] selectTabbarMain];
}

- (IBAction)pushUser:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)pushMore:(id)sender {
    [[RHTabbarManager sharedInterface] selectTabbarMore];
}
@end
