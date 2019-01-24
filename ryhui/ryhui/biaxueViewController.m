//
//  biaxueViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 16/6/24.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import "biaxueViewController.h"
#import "EGORefreshTableHeaderView.h"
#import "AITableFooterVew.h"
@interface biaxueViewController ()<UITableViewDelegate,UITableViewDataSource,EGORefreshTableHeaderDelegate,UIAlertViewDelegate>
{
    EGORefreshTableHeaderView *_headerView;
    AITableFooterVew *_footerView;
    BOOL _reloading;
    BOOL showLoadMoreButton;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,assign)int currentPageIndex;
@property(nonatomic,strong)NSMutableArray * array;
@end

@implementation biaxueViewController
-(NSMutableArray *)array{
    
    if (!_array) {
        _array = [NSMutableArray array];
    }
    return _array;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self getdata];
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"testcell";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSDictionary* dataDic=[self.array objectAtIndex:indexPath.row];
    NSString  * string = [NSString stringWithFormat:@"%@",dataDic[@"name"]];
    cell.textLabel.text = string;
    
    return cell;
}


-(void)getdata{
    
     NSDictionary* parameters=@{@"_search":@"true",@"rows":@"10",@"page":[NSString stringWithFormat:@"%d",_currentPageIndex],@"sidx":@"",@"sord":@"desc",@"filters":@"{\"groupOp\":\"AND\",\"rules\":[]}"};
    
    [[RHNetworkService instance] POST:@"app/common/appMain/projectListAllData" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSMutableArray* tempArray=[[NSMutableArray alloc]initWithCapacity:0];
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            NSArray* array=[responseObject objectForKey:@"rows"];
            _footerView.hidden=NO;
            if ([array count]==0) {
            
            if (array.count==0) {
            
                [self showNoDataWithFrame:self.tableView.frame insertView:self.tableView];
                
            }else{
                
                [self hiddenNoData];
            
            }
                [_footerView.footerButton setEnabled:NO];
                showLoadMoreButton=NO;
            }else{
                
                [_footerView.footerButton setEnabled:YES];
                showLoadMoreButton=YES;
            }
            
            for (NSDictionary* dic in array) {
                if ([dic objectForKey:@"cell"]&&!([[dic objectForKey:@"cell"] isKindOfClass:[NSNull class]])) {
                    [self.array addObject:[dic objectForKey:@"cell"]];
                 
                }
            }
            
//            [self.array addObject:tempArray];
            
        }
        //[self.array addObject: responseObject[@"rows"]];
        
        
        if (_reloading) {
            [self.array removeAllObjects];
        }
        self.currentPageIndex++;
        [self reloadTableView];
        [_footerView.activityIndicatorView stopAnimating];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
        [self getdata];
    }
}

- (void)refreshApp:(BOOL)showloading{
    if (!_reloading){
        _reloading = YES;
        self.currentPageIndex = 1;
        [self getdata];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    [_headerView egoRefreshScrollViewDidEndDragging:scrollView];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"666" object:nil];
    
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    NSLog(@"%ld",(long)indexPath.row);
    
    UIAlertView * altew = [[UIAlertView alloc]initWithTitle:@"cbx" message:@"csy" delegate:self cancelButtonTitle:@"cyh" otherButtonTitles:@"cmm", nil];
    [altew show];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        NSLog(@"cbx");
    }else{
        NSLog(@"cmmcyncnn");
        
    }
    
}
@end
