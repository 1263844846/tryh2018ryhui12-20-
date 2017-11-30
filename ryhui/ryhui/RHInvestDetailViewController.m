//
//  RHInvestDetailViewController.m
//  ryhui
//
//  Created by jufenghudong on 15/4/9.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHInvestDetailViewController.h"
#import "RHInvestDetaiTableViewCell.h"
#import "MBProgressHUD.h"

@interface RHInvestDetailViewController ()

{
    EGORefreshTableHeaderView *_headerView;
    AITableFooterVew *_footerView;
    BOOL _reloading;
    BOOL showLoadMoreButton;
}
@property (nonatomic, assign) int currentPageIndex;
@property(nonatomic,strong)NSMutableArray* dataArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *myimage;
@property (weak, nonatomic) IBOutlet UILabel *mylab;

@end

@implementation RHInvestDetailViewController
@synthesize dataArray;
@synthesize currentPageIndex = _currentPageIndex;
@synthesize projectId;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configBackButton];
    [self configTitleWithString:@"回款计划"];
    self.dataArray=[[NSMutableArray alloc]initWithCapacity:0];
    
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    self.tableView.backgroundColor=[UIColor clearColor];

    // Do any additional setup after loading the view.
    [self getInvestDetail];
    self.myimage.hidden = YES;
    self.mylab.hidden = YES;
    if (self.res==3) {
        self.myimage.hidden = NO;
        self.mylab.hidden = NO;
        
    }
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    _headerView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.view.frame.size.width, self.tableView.bounds.size.height-10)];
//    _headerView.delegate = self;
//    [self.tableView addSubview:_headerView];
//    
//    _footerView = [[AITableFooterVew alloc] initWithFrame:CGRectMake(0.0, 0.0,[UIScreen mainScreen].bounds.size.width,50.0)];
//    [_footerView.footerButton addTarget:self action:@selector(showMoreApp:) forControlEvents:UIControlEventTouchUpInside];
//    self.tableView.tableFooterView = _footerView;
//    _footerView.hidden=YES;
//    
//    showLoadMoreButton=YES;
//    [_headerView egoRefreshScrollViewDataSourceStartManualLoading:self.tableView];
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
//    self.myblock();
}
//{"class":"view.JqRow","id":1935,"version":null,"cell":{"id":1935,"fee":null,"custId":"6000060000735977","relatedId":null,"description":"期数:3","userId":"29","money":2293.05,"dateCreated":"2015-09-12 00:02:27","projectId":248,"type":"PenaltyInterest","orderId":"00000000000000014557"}
-(void)getInvestDetail
{
    //,@"sidx":@"payDate",@"sord":@"desc"
   // NSDictionary* parameters=@{@"projectId":projectId,@"rows":@"10",@"page":[NSString stringWithFormat:@"%d",_currentPageIndex],@"_search":@"false"};
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDictionary* parameters = @{@"projectId":projectId};
    [[RHNetworkService instance] POST:@"app/common/user/appAllPlan/AppPaymentPlanList" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        DLog(@"%@",responseObject);
        NSMutableArray* tempArray=[[NSMutableArray alloc]initWithCapacity:0];
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
//            NSArray* array=[responseObject objectForKey:@"rows"];
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
               // _footerView.hidden=NO;
//                if ([responseObject count]<10) {
                    //已经到底了
                   // [_footerView.footerButton setEnabled:NO];
//                    if ([responseObject count]==0) {
////                        [_footerView.footerButton setTitle:@"亲暂时没有数据" forState:UIControlStateDisabled];
//                        [self showNoDataWithFrame:self.tableView.frame insertView:self.tableView];
//                    }else{
//                        [self hiddenNoData];
//                    }
//    
//                    showLoadMoreButton=NO;
//                }else{
//                    [_footerView.footerButton setEnabled:YES];
//                    showLoadMoreButton=YES;
//                }
                for (NSDictionary* dic in responseObject) {
                    if ([dic objectForKey:@"cell"]&&!([[dic objectForKey:@"cell"] isKindOfClass:[NSNull class]])) {
                        [tempArray addObject:[dic objectForKey:@"cell"]];
                    }
                } 
//            }else{
//                _footerView.hidden=YES;
//            }
                }
//        }
        }
//        if (_reloading) {
//            [self.dataArray removeAllObjects];
//        }
        //self.currentPageIndex++;
        [dataArray addObjectsFromArray:responseObject];
        if ([dataArray count]<10) {
           // _footerView.hidden=YES;
        }
        [self.tableView reloadData];
       // [_footerView.activityIndicatorView stopAnimating];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        DLog(@"%@",error);
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
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
//        DLog(@"加载更多");
        [_footerView.activityIndicatorView startAnimating];
        _reloading=NO;
        [self getInvestDetail];
    }
}

- (void)refreshApp:(BOOL)showloading{
    if (!_reloading){
        _reloading = YES;
        self.currentPageIndex = 1;
        [self getInvestDetail];
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
    return 55;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    
    RHInvestDetaiTableViewCell *cell = (RHInvestDetaiTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"RHInvestDetaiTableViewCell" owner:nil options:nil] objectAtIndex:0];
    }
    
    NSDictionary* dataDic=[self.dataArray objectAtIndex:indexPath.row];
    
    [cell updateCell:dataDic];
    
    return cell;
}

- (IBAction)pushMain:(id)sender {
    [[[RHTabbarManager sharedInterface] selectTabbarMain] popToRootViewControllerAnimated:NO];
}

- (IBAction)pushUser:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)pushMore:(id)sender {
    [[[RHTabbarManager sharedInterface] selectTabbarMore] popToRootViewControllerAnimated:NO];
}

@end
