//
//  RHMyGiftContentViewController.m
//  ryhui
//
//  Created by jufenghudong on 15/4/14.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHMyGiftContentViewController.h"
#import "RHMyGiftViewCell.h"
//#import "RHContractViewContoller.h"
@interface RHMyGiftContentViewController ()

@end

@implementation RHMyGiftContentViewController
@synthesize dataArray;
@synthesize type;
@synthesize currentPageIndex = _currentPageIndex;
@synthesize nav;

-(instancetype)init
{
    self=[super init];
    if (self) {
        _currentPageIndex = 1;
        self.dataArray=[[NSMutableArray alloc]initWithCapacity:0];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].applicationFrame.size.height-50-40-self.navigationController.navigationBar.frame.size.height) style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    // Do any additional setup after loading the view.
    _headerView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.view.frame.size.width, self.tableView.bounds.size.height)];
    _headerView.delegate = self;
    [self.tableView addSubview:_headerView];
    
    _footerView = [[AITableFooterVew alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width,50.0)];
    [_footerView.footerButton addTarget:self action:@selector(showMoreApp:) forControlEvents:UIControlEventTouchUpInside];
    [_footerView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    self.tableView.tableFooterView = _footerView;
    _footerView.hidden=YES;
    showLoadMoreButton=YES;
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [_footerView.activityIndicatorView stopAnimating];
    _footerView.activityIndicatorView = nil;
    [_footerView.footerButton removeTarget:self action:@selector(showMoreApp:) forControlEvents:UIControlEventTouchUpInside];
    _footerView.footerButton = nil;
    _footerView = nil;
    self.tableView = nil;
    _headerView = nil;
}
-(void)startPost
{
    [_headerView egoRefreshScrollViewDataSourceStartManualLoading:self.tableView];
}

-(void)getinvestListData
{
    
    NSDictionary* parameters=@{@"_search":@"true",@"rows":@"10",@"page":[NSString stringWithFormat:@"%d",_currentPageIndex],@"sidx":@"usingTime",@"sord":@"desc",@"filters":@"{\"groupOp\":\"AND\",\"rules\":[]}"};
    DLog(@"%@",type);
    [[RHNetworkService instance] POST:type parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"%@",responseObject);
        NSMutableArray* tempArray=[[NSMutableArray alloc]initWithCapacity:0];
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSArray* array=[responseObject objectForKey:@"rows"];
            if ([array isKindOfClass:[NSArray class]]) {
                _footerView.hidden=NO;
                if ([array count]<10) {
                    //已经到底了
                    if ([array count]==0) {
                        [_footerView.footerButton setTitle:@"亲暂时没有数据" forState:UIControlStateDisabled];
                    }
                    [_footerView.footerButton setEnabled:NO];
                    showLoadMoreButton=NO;
                }else{
                    [_footerView.footerButton setEnabled:YES];
                    showLoadMoreButton=YES;
                }
                for (NSDictionary* dic in array) {
                    if ([dic objectForKey:@"cell"]&&!([[dic objectForKey:@"cell"] isKindOfClass:[NSNull class]])) {
                        [tempArray addObject:[dic objectForKey:@"cell"]];
                    }
                }
            }else{
                _footerView.hidden=YES;
            }
        }
        if (_reloading) {
            [self.dataArray removeAllObjects];
        }
        else {
            self.currentPageIndex++;
        }
        [dataArray addObjectsFromArray:tempArray];
        if ([dataArray count]<10) {
            if ([dataArray count]==0) {
                _footerView.hidden=NO;
            }else{
                _footerView.hidden=YES;
            }
        }
        [self reloadTableView];
        [_footerView.activityIndicatorView stopAnimating];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"%@",error);
        [_footerView.activityIndicatorView stopAnimating];
        _reloading = NO;
        [_headerView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
    }];
}

- (void)reloadTableView{
    [self.tableView reloadData];
    _reloading = NO;
    [_headerView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
}
- (void)showMoreApp:(id)sender
{
    
    if (![_footerView.activityIndicatorView isAnimating]) {
        DLog(@"加载更多");
        [_footerView.activityIndicatorView startAnimating];
        _reloading=NO;
        [self getinvestListData];
    }
}

- (void)refreshApp:(BOOL)showloading{
    if (!_reloading){
        _reloading = YES;
        self.currentPageIndex = 1;
        [self getinvestListData];
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
    
    RHMyGiftViewCell *cell = (RHMyGiftViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"RHMyGiftViewCell" owner:nil options:nil] objectAtIndex:0];
    }
    
    NSDictionary* dataDic=[self.dataArray objectAtIndex:indexPath.row];
    [cell updateCell:dataDic with:type];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
@end
