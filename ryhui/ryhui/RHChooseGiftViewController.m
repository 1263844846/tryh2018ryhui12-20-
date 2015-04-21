//
//  RHChooseGiftViewController.m
//  ryhui
//
//  Created by jufenghudong on 15/4/14.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHChooseGiftViewController.h"

#import "RHChooseGiftViewCell.h"

@interface RHChooseGiftViewController ()

@end

@implementation RHChooseGiftViewController
@synthesize dataArray;
@synthesize currentPageIndex = _currentPageIndex;
@synthesize investNum;
@synthesize delegate;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configBackButton];
    [self configTitleWithString:@"请选择红包"];
    
    self.dataArray=[[NSMutableArray alloc]initWithCapacity:0];
    
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    self.tableView.backgroundColor=[UIColor clearColor];
    
    // Do any additional setup after loading the view.
    _headerView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.view.frame.size.width, self.tableView.bounds.size.height)];
    _headerView.delegate = self;
    [self.tableView addSubview:_headerView];
    
    _footerView = [[AITableFooterVew alloc] initWithFrame:CGRectMake(0.0, 0.0, self.tableView.frame.size.width,50.0)];
    [_footerView.footerButton addTarget:self action:@selector(showMoreApp:) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.tableFooterView = _footerView;
    _footerView.hidden=YES;
    
    showLoadMoreButton=NO;
    [_headerView egoRefreshScrollViewDataSourceStartManualLoading:self.tableView];
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

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
//    
//    [_footerView.activityIndicatorView stopAnimating];
//    _footerView.activityIndicatorView = nil;
//    [_footerView.footerButton removeTarget:self action:@selector(showMoreApp:) forControlEvents:UIControlEventTouchUpInside];
//    _footerView.footerButton = nil;
//    _footerView = nil;
    self.tableView = nil;
    _headerView = nil;
}
//{"class":"view.JqRow","id":1935,"version":null,"cell":{"id":1935,"fee":null,"custId":"6000060000735977","relatedId":null,"description":"期数:3","userId":"29","money":2293.05,"dateCreated":"2015-09-12 00:02:27","projectId":248,"type":"PenaltyInterest","orderId":"00000000000000014557"}
-(void)getMyMessage
{
    
//    NSDictionary* parameters=@{@"_search":@"true",@"rows":@"10",@"page":[NSString stringWithFormat:@"%d",_currentPageIndex],@"forApp":@"true",@"filters":@"{\"groupOp\":\"AND\",\"rules\":[{\"field\":\"state\",\"op\":\"in\",\"data\":[1,2]}]}"};
    
    [[RHNetworkService instance] POST:@"front/payment/account/loadAvailGifts" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"%@",responseObject);
        NSMutableArray* tempArray=[[NSMutableArray alloc]initWithCapacity:0];
        
        if ([responseObject isKindOfClass:[NSArray class]]) {
            NSArray* array=responseObject;
            if ([array isKindOfClass:[NSArray class]]) {
                _footerView.hidden=NO;
                if ([array count]<10) {
                    //已经到底了
                    if ([array count]==0) {
//                        [_footerView.footerButton setTitle:@"亲暂时没有数据" forState:UIControlStateDisabled];
                        [self showNoDataWithFrame:self.tableView.frame insertView:self.tableView];

                    }else{
                        [self hiddenNoData];
                    }
                    [_footerView.footerButton setEnabled:NO];
                    showLoadMoreButton=NO;
                }
                for (NSDictionary* dic in array) {
                    if (dic&&!([dic isKindOfClass:[NSNull class]])) {
                        [tempArray addObject:dic];
                    }
                }
            }
        }
        if (_reloading) {
            [self.dataArray removeAllObjects];
        }
        else {
            self.currentPageIndex++;
        }
        [dataArray addObjectsFromArray:tempArray];
        if ([dataArray count]>0) {
            _footerView.hidden=YES;
            self.tableView.tableFooterView=nil;
            [self hiddenNoData];
        }
    
        [self reloadTableView];
        [_footerView.activityIndicatorView stopAnimating];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"%@",error);
        
    }];
}

- (void)reloadTableView{
    [self.tableView reloadData];
    _reloading = NO;
    [_headerView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
}
- (void)showMoreApp:(id)sender
{
    return;
    if (![_footerView.activityIndicatorView isAnimating]) {
        DLog(@"加载更多");
        [_footerView.activityIndicatorView startAnimating];
        _reloading=NO;
        [self getMyMessage];
    }
}

- (void)refreshApp:(BOOL)showloading{
    if (!_reloading){
        _reloading = YES;
        self.currentPageIndex = 1;
        [self getMyMessage];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    [_headerView egoRefreshScrollViewDidEndDragging:scrollView];
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    [_headerView egoRefreshScrollViewDidScroll:scrollView];
    
    if (!_footerView.hidden&&showLoadMoreButton)  {
        CGFloat currentOffset = scrollView.contentOffset.y;
        CGFloat maximumOffset = _footerView.frame.origin.y - (scrollView.frame.size.height - _footerView.frame.size.height);
        
        if (currentOffset >= maximumOffset && ![_footerView.activityIndicatorView isAnimating]) {
            // Load the next 20 records.
            return;
            [self showMoreApp:self];
        }
    }
}
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    [self refreshApp:NO];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
    
    return _reloading; // should return if data source model is reloading
    
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
    
    return [NSDate date]; // should return date data source was last changed
    
}
#pragma mark-TableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    
    RHChooseGiftViewCell *cell = (RHChooseGiftViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"RHChooseGiftViewCell" owner:nil options:nil] objectAtIndex:0];
    }
    cell.investNum=investNum;

    NSDictionary* dataDic=[self.dataArray objectAtIndex:indexPath.row];
    
    [cell updateCell:dataDic];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary* dataDic=[self.dataArray objectAtIndex:indexPath.row];
    
    NSString* threshold=@"";
    if (![[dataDic objectForKey:@"threshold"] isKindOfClass:[NSNull class]]) {
        if ([[dataDic objectForKey:@"threshold"] isKindOfClass:[NSNumber class]]) {
            threshold=[[dataDic objectForKey:@"threshold"] stringValue];
        }else{
            threshold=[dataDic objectForKey:@"threshold"];
        }
    }
    DLog(@"%@--%d",threshold,investNum);
    if (investNum<[threshold intValue]&&investNum>0) {
        [RHUtility showTextWithText:@"投资金额不符合该红包的使用条件"];
        return;
    }
    if (investNum<1) {
        [RHUtility showTextWithText:@"请先输入投资金额"];
        return;
    }
    
    NSString* money=@"";
    if (![[dataDic objectForKey:@"money"] isKindOfClass:[NSNull class]]) {
        if ([[dataDic objectForKey:@"money"] isKindOfClass:[NSNumber class]]) {
            money=[NSString stringWithFormat:@"%@",[[dataDic objectForKey:@"money"] stringValue]];
        }else{
            money=[NSString stringWithFormat:@"%@",[dataDic objectForKey:@"money"]];
        }
    }
    
    NSString* ids=@"";
    if (![[dataDic objectForKey:@"id"] isKindOfClass:[NSNull class]]) {
        if ([[dataDic objectForKey:@"id"] isKindOfClass:[NSNumber class]]) {
            ids=[NSString stringWithFormat:@"%@",[[dataDic objectForKey:@"id"] stringValue]];
        }else{
            ids=[NSString stringWithFormat:@"%@",[dataDic objectForKey:@"id"]];
        }
    }
    
    
    [delegate chooseGiftWithnNum:money threshold:threshold giftId:ids];
    
    [self.navigationController popViewControllerAnimated:YES];

}

@end
