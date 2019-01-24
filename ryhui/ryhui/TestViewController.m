//
//  TestViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 15/10/14.
//  Copyright © 2015年 stefan. All rights reserved.
//

#import "TestViewController.h"
#import "EGORefreshTableHeaderView.h"
#import "AITableFooterVew.h"
#import <WebKit/WebKit.h>
@interface TestViewController ()<UITableViewDataSource,UITableViewDelegate,EGORefreshTableHeaderDelegate>
{
    
    
        EGORefreshTableHeaderView *_headerView;
        AITableFooterVew *_footerView;
        BOOL _reloading;
        BOOL showLoadMoreButton;
    

}

@property (nonatomic, assign) int currentPageIndex;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong)NSMutableArray * dataArray;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.dataArray = [NSMutableArray array];
//    [self.dataArray addObject:@"22"];
    
   // self.tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds];
   // [self.view addSubview:self.tableView];
//    self.tableView.dataSource = self;
//    self.tableView.delegate = self;
    
    
    
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height - 20)];
    // 2.创建请求
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://www.cnblogs.com/mddblog/"]];
    // 3.加载网页
    
    [request setHTTPMethod:@"POST"];
    [webView loadRequest:request];
    
    // 最后将webView添加到界面
    [self.view addSubview:webView];
    
}
- (NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        [_dataArray addObject:@"222"];
    }
    return _dataArray;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
//    self.dataArray=[[NSMutableArray alloc]initWithCapacity:0];
//    
//    // Do any additional setup after loading the view.
//    _headerView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.view.frame.size.width, self.tableView.bounds.size.height)];
//    _headerView.delegate = self;
//    [self.tableView addSubview:_headerView];
//    
//    _footerView = [[AITableFooterVew alloc] initWithFrame:CGRectMake(0.0, 0.0,[UIScreen mainScreen].bounds.size.width,50.0)];
//    [_footerView.footerButton addTarget:self action:@selector(showMoreApp:) forControlEvents:UIControlEventTouchUpInside];
//    self.tableView.tableFooterView = _footerView;
//    _footerView.hidden=YES;
//    
//    showLoadMoreButton=YES;
//    _reloading = NO;
//    [_headerView egoRefreshScrollViewDataSourceStartManualLoading:self.tableView];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [_footerView.activityIndicatorView stopAnimating];
    //    _footerView.activityIndicatorView = nil;
    //    [_footerView.footerButton removeTarget:self action:@selector(showMoreApp:) forControlEvents:UIControlEventTouchUpInside];
    //    _footerView.footerButton = nil;
    //    _footerView = nil;
    //    self.tableView = nil;
    //    _headerView = nil;
    //    _reloading = NO;
    
}
- (void)reloadTableView{
    [self.tableView reloadData];
    _reloading = NO;
    [_headerView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
}
- (void)showMoreApp:(id)sender
{
    
    if (![_footerView.activityIndicatorView isAnimating]) {
        //        DLog(@"加载更多");
        [_footerView.activityIndicatorView startAnimating];
        _reloading=NO;
        NSLog(@"666");
        [self getTrading];
    }
}

- (void)refreshApp:(BOOL)showloading{
    if (!_reloading){
        _reloading = YES;
        self.currentPageIndex = 1;
        [self getTrading];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    [_headerView egoRefreshScrollViewDidEndDragging:scrollView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)getTrading{
    NSLog(@"777");
    [self.dataArray addObject:@"hehe"];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    [_headerView egoRefreshScrollViewDidScroll:scrollView];
    
    if (showLoadMoreButton)  {
        CGFloat currentOffset = scrollView.contentOffset.y;
        CGFloat maximumOffset = _footerView.frame.origin.y - (scrollView.frame.size.height - 2*_footerView.frame.size.height);
        
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
