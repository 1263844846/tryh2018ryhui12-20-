//
//  RHMyFriendViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 16/7/7.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import "RHMyFriendViewController.h"
#import "RHMyFriendTableViewCell.h"
#import "EGORefreshTableHeaderView.h"
#import "AITableFooterVew.h"

@interface RHMyFriendViewController ()<UITableViewDelegate,UITableViewDataSource,EGORefreshTableHeaderDelegate>
{
    EGORefreshTableHeaderView *_headerView;
    AITableFooterVew *_footerView;
    BOOL _reloading;
    BOOL showLoadMoreButton;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) int currentPageIndex;
@property(nonatomic,strong)NSMutableArray * Array;

@property(nonatomic,assign)BOOL res;
@end

@implementation RHMyFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self configTitleWithString:@"邀请记录"];
    [self configBackButton];
    self.tableView.separatorStyle = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self getmydata];
    
//    if ([UIScreen mainScreen].bounds.size.width <321) {
//        self.tableView.frame = CGRectMake(0, 51,[UIScreen mainScreen].bounds.size.width , 591);
//    }
//    
    _headerView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.view.frame.size.width, self.tableView.bounds.size.height)];
    _headerView.delegate = self;
    [self.tableView addSubview:_headerView];
    
    _footerView = [[AITableFooterVew alloc] initWithFrame:CGRectMake(0.0, 0.0,[UIScreen mainScreen].bounds.size.width,20.0)];
    [_footerView.footerButton addTarget:self action:@selector(showMoreApp:) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.tableFooterView = _footerView;
    _footerView.hidden=YES;
    
    showLoadMoreButton=YES;
    _reloading = NO;
    [_headerView egoRefreshScrollViewDataSourceStartManualLoading:self.tableView];
    
    self.res = YES;
    
}
- (void)reloadTableView{
    if (self.Array.count==0) {
        CGRect myrect = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y-40, self.tableView.frame.size.width, self.tableView.frame.size.height);
        
        [self showNoDataWithFrame:myrect insertView:self.view];
    }else{
        [self hiddenNoData];
        //        self.tableView.hidden
    }
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
        [self getmydata];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)refreshApp:(BOOL)showloading{
    if (!_reloading){
        _reloading = YES;
        self.currentPageIndex = 1;
        [self getmydata];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    [_headerView egoRefreshScrollViewDidEndDragging:scrollView];
    
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


-(void)getmydata{
    
    NSDictionary* parameters=@{@"rows":@"10",@"page":[NSString stringWithFormat:@"%d",_currentPageIndex],@"sidx":@"dateCreated",@"sord":@"desc"};
    [[RHNetworkService instance] POST:@"app/front/payment/appInviteFriends/MyInviteRecords" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSMutableArray *tempArray = [[NSMutableArray alloc]initWithCapacity:0];
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSArray *array=[responseObject objectForKey:@"rows"];
            if ([array isKindOfClass:[NSArray class]]) {
                _footerView.hidden = NO;
                if ([array count] < 10) {
                    //已经到底了
                    if ([array count] == 0) {
//                        if (_reloading) {
//                            [self showNoDataWithFrame:self.tableView.frame insertView:self.tableView];
//                        }
                    } else {
//                        [self hiddenNoData];
                    }
                    [_footerView.footerButton setEnabled:NO];
                    showLoadMoreButton = NO;
                } else {
                    [_footerView.footerButton setEnabled:YES];
                    showLoadMoreButton = YES;
                }
                for (NSDictionary *dic in array) {
                    if ([dic objectForKey:@"cell"] && !([[dic objectForKey:@"cell"] isKindOfClass:[NSNull class]])) {
                        [tempArray addObject:dic];
                    }
                }
            } else {
                _footerView.hidden = YES;
            }
        }
      
        if (_reloading) {
            [self.Array removeAllObjects];
        }
        [self.Array addObjectsFromArray:tempArray];
        if (self.res) {
            [self.Array removeAllObjects];
            self.res = NO;
            self.currentPageIndex --;
        }
        self.currentPageIndex ++;
        
        if ([self.Array count] <= 10) {
            _footerView.hidden = YES;
        }
        if (self.Array.count == 0) {
            //self.selecteBar.hidden = YES;
            //[self configBackButton];
           // [rightButton setTitle:@"全部" forState:UIControlStateNormal];
        }
        [self reloadTableView];
        [_footerView.activityIndicatorView stopAnimating];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
        
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    
    return self.Array.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 66;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RHMyFriendTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"rhmyfriendtestcell"];
    
    if (!cell) {
    
     cell = [[[NSBundle mainBundle]loadNibNamed:@"RHMyFriendTableViewCell" owner:nil options:nil] lastObject];
    }
    [cell updata:self.Array[indexPath.row][@"cell"]];
     [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}


- (NSMutableArray *)Array{
    
    if (!_Array) {
        _Array = [NSMutableArray array];
    }
    return _Array;
}
@end
