//
//  RHMyInvestmentViewController.m
//  ryhui
//
//  Created by stefan on 15/3/15.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHMyInvestmentViewController.h"
#import "RHMyInvestmentViewCell.h"

@interface RHMyInvestmentViewController ()

@end

@implementation RHMyInvestmentViewController
@synthesize dataArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configBackButton];
    [self configTitleWithString:@"我的投资"];
    
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
    [[RHTabbarManager sharedInterface] selectTabbarMain];
}

- (IBAction)pushUser:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)pushMore:(id)sender {
    [[RHTabbarManager sharedInterface] selectTabbarMore];
}

- (void)didSelectSegmentAtIndex:(int)index
{
    switch (index) {
        case 0:
            
            break;
        case 1:
            
            break;
        case 2:
            
            break;
            
        default:
            break;
    }
}
#pragma mark-TableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 86;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    
    RHMyInvestmentViewCell *cell = (RHMyInvestmentViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"RHMyInvestmentViewCell" owner:nil options:nil] objectAtIndex:0];
    }
    
    NSDictionary* dataDic=[self.dataArray objectAtIndex:indexPath.row];
    
    [cell updateCell:dataDic];
    
    return cell;
}
@end
