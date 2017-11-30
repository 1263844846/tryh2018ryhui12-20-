//
//  RHProjectListContentViewController.m
//  ryhui
//
//  Created by 江 云龙 on 15/3/17.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHProjectListContentViewController.h"
#import "RHMainViewCell.h"
//#import "RHProjectDetailViewController.h"
#import "RHMainTableViewCell.h"
#import "RHZZListTableViewCell.h"
#import "RHZZDetailViewController.h"
#import "RHProjectdetailthreeViewController.h"
#import "RHXFDViewController.h"
#import "RHHFJXViewController.h"
@interface RHProjectListContentViewController ()
{
    EGORefreshTableHeaderView *_headerView;
    AITableFooterVew *_footerView;
    BOOL _reloading;
    BOOL showLoadMoreButton;
}
@property (nonatomic,strong)NSString* currentSort;
@property (nonatomic,strong)NSString* currentSixd;
@property (nonatomic, assign) int currentPageIndex;

@end

@implementation RHProjectListContentViewController
@synthesize dataArray;
@synthesize type;
@synthesize currentPageIndex = _currentPageIndex;
@synthesize prarentNav;
@synthesize currentSixd;
@synthesize currentSort;


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
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].applicationFrame.size.height-75-40-self.navigationController.navigationBar.frame.size.height+35) style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.backgroundColor=[UIColor clearColor];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor=[UIColor clearColor];

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

-(void)refreshWithData:(NSString *)data
{
    
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

-(void)sordListWithSidx:(NSString*)sidx sord:(NSString*)sord
{
    _reloading=YES;
    self.currentPageIndex = 1;
    self.currentSort=sord;
    self.currentSixd=sidx;

    [self getListDataWithFilters:sidx sord:sord];
}

-(void)getListDataWithFilters:(NSString*)filters sord:(NSString*)sord
{
    NSDictionary* parameters=@{@"_search":@"true",@"rows":@"10",@"page":[NSString stringWithFormat:@"%d",_currentPageIndex],@"sidx":filters,@"sord":sord,@"filters":@"{\"groupOp\":\"AND\",\"rules\":[]}"};
    
    NSString* url=nil;
    if ([type isEqualToString:@"0"]) {
        url=@"app/common/appMain/projectListAllData";
    }else{
        url=@"common/main/xueListData";
    }
//    DLog(@"%@--url==%@",parameters,url);

    [[RHNetworkService instance] POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        DLog(@"%@",responseObject);
        NSMutableArray* tempArray=[[NSMutableArray alloc]initWithCapacity:0];
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSArray* array=[responseObject objectForKey:@"rows"];
            if ([array isKindOfClass:[NSArray class]]) {
                _footerView.hidden=NO;
                if ([array count]<10) {
                    //已经到底了
                    if ([array count]==0) {
//                        [_footerView.footerButton setTitle:@"亲暂时没有数据" forState:UIControlStateNormal];
                        
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
                        [tempArray addObject:[dic objectForKey:@"cell"]];
//                        NSLog(@"----234----%@",dic[@"id"]);
//                        NSString * str = [NSString stringWithFormat:@"%@",dic[@"id"]];
//                        
                        
                    }
                }
            }else{
                _footerView.hidden=YES;
            }
        }
        
        if (_reloading) {
            [self.dataArray removeAllObjects];
        }
        self.currentPageIndex++;

        [dataArray addObjectsFromArray:tempArray];
        if ([dataArray count] <= 6) {
            _footerView.hidden = YES;
        
        }
        [self reloadTableView];
        [_footerView.activityIndicatorView stopAnimating];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        DLog(@"%@",error);
        [_footerView.activityIndicatorView stopAnimating];
        _reloading = NO;
        [_headerView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
    }];
}

-(void)getinvestListData
{
    NSString* sixd=@"";
    if (self.currentSixd&&[self.currentSixd length]>0) {
        sixd=self.currentSixd;
    }
    NSString* sort=@"desc";
    if (self.currentSort&&[self.currentSort length]>0) {
        sort=self.currentSort;
    }
    [self getListDataWithFilters:sixd sord:sort];
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


#pragma mark-TableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   // [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if ([self.type isEqualToString:@"0"]) {
     
    if ([UIScreen mainScreen].bounds.size.width > 319) {
        
    
    static NSString *CellIdentifier = @"CellIdentifier";
    
    RHMainViewCell *cell = (RHMainViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"RHMainViewCell" owner:nil options:nil] objectAtIndex:0];
    }
        if (self.dataArray.count >0) {
     NSDictionary* dataDic=[self.dataArray objectAtIndex:indexPath.row];
    cell.myblock = ^{
        self.myblock(dataDic);
    };
   
    
    NSString  * string = [NSString stringWithFormat:@"%@",dataDic[@"investorRate"]];
    //dataDic[@"investorRate"] = (id)string
    if (string.length > 5) {
        NSArray *array = [string componentsSeparatedByString:@"."];
        string = array.lastObject;
        string =  [string substringToIndex:2];
        
        int a = [string intValue];
        
        int b  = a /10;
        
        int c = a - b * 10;
        
        if (c > 5) {
            b= b+1;
            
            string = [NSString stringWithFormat:@"%@.%d",array.firstObject,b];
            // [dataDic setValue:string forKey:@"investorRate"];
            // dataDic[@"investorRate"] = string;
        }else{
            
            string = [NSString stringWithFormat:@"%@.%d",array.firstObject,b];
            //[dataDic setValue:string forKey:@"investorRate"];
            
        }
    }
    cell.lilv = string;
    [cell updateCell:dataDic];
        }
    return cell;
    }else{
        static NSString *CellIdentifier = @"CellIdentifier1";
        
        RHMainTableViewCell *cell = (RHMainTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"RHMainTableViewCell" owner:nil options:nil] objectAtIndex:0];
        }
        NSDictionary* dataDic=[self.dataArray objectAtIndex:indexPath.row-2];
//        cell.myblock = ^{
//            self.myblock(dataDic);
//        };
        
        
        NSString  * string = [NSString stringWithFormat:@"%@",dataDic[@"investorRate"]];
        //dataDic[@"investorRate"] = (id)string
        if (string.length > 5) {
            NSArray *array = [string componentsSeparatedByString:@"."];
            string = array.lastObject;
            string =  [string substringToIndex:2];
            
            int a = [string intValue];
            
            int b  = a /10;
            
            int c = a - b * 10;
            
            if (c > 5) {
                b= b+1;
                
                string = [NSString stringWithFormat:@"%@.%d",array.firstObject,b];
                // [dataDic setValue:string forKey:@"investorRate"];
                // dataDic[@"investorRate"] = string;
            }else{
                
                string = [NSString stringWithFormat:@"%@.%d",array.firstObject,b];
                //[dataDic setValue:string forKey:@"investorRate"];
                
            }
        }
//        cell.lilv = string;
        [cell updateCell:dataDic];
        
        return cell;


        
    }
    }else{
        
       static NSString * CellIdentifier = @"rhzzlistcell";
//        static NSString *CellIdentifier = @"CellIdentifier1";
        
        RHZZListTableViewCell *cell = (RHZZListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"RHZZListTableViewCell" owner:nil options:nil] objectAtIndex:0];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.dataArray.count >0) {
             NSDictionary* dataDic=[self.dataArray objectAtIndex:indexPath.row];
            cell.myblock = ^{
                self.myblock(dataDic);
            };
            
            
            NSString  * string = [NSString stringWithFormat:@"%@",dataDic[@"investorRate"]];
            //dataDic[@"investorRate"] = (id)string
            if (string.length > 5) {
                NSArray *array = [string componentsSeparatedByString:@"."];
                string = array.lastObject;
                string =  [string substringToIndex:2];
                
                int a = [string intValue];
                
                int b  = a /10;
                
                int c = a - b * 10;
                
                if (c > 5) {
                    b= b+1;
                    
                    string = [NSString stringWithFormat:@"%@.%d",array.firstObject,b];
                    // [dataDic setValue:string forKey:@"investorRate"];
                    // dataDic[@"investorRate"] = string;
                }else{
                    
                    string = [NSString stringWithFormat:@"%@.%d",array.firstObject,b];
                    //[dataDic setValue:string forKey:@"investorRate"];
                    
                }
                
            }
            cell.lilv = string;
            [cell updateCell:dataDic];
        }else{
            
        }
        
        
        
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //if ([self.type isEqualToString:@"0"]) {
    
    
    
   
   
    
    
    
   NSMutableDictionary* dataDic=[self.dataArray objectAtIndex:indexPath.row];
    
   
    
    RHProjectdetailthreeViewController* controller=[[RHProjectdetailthreeViewController alloc]initWithNibName:@"RHProjectdetailthreeViewController" bundle:nil];
        controller.zzimage.hidden = YES;
        controller.zzlasttimelab.hidden = YES;
        controller.zzlasttimeminlab.hidden = YES;
        controller.zztimelogoiamge.hidden = YES;
    
    NSString  * string = [NSString stringWithFormat:@"%@",dataDic[@"investorRate"]];
   //dataDic[@"investorRate"] = (id)string
    if (string.length > 5) {
        NSArray *array = [string componentsSeparatedByString:@"."];
        string = array.lastObject;
       string =  [string substringToIndex:2];
        
        int a = [string intValue];
        
        int b  = a /10;
        
        int c = a - b * 10;
        
        if (c > 5) {
            b= b+1;
            
            string = [NSString stringWithFormat:@"%@.%d",array.firstObject,b];
           // [dataDic setValue:string forKey:@"investorRate"];
           // dataDic[@"investorRate"] = string;
        }else{
            
            string = [NSString stringWithFormat:@"%@.%d",array.firstObject,b];
            //[dataDic setValue:string forKey:@"investorRate"];
            
        }
    }

    controller.lilv = string;
    controller.dataDic=dataDic;
    controller.getType=type;
    NSString * projectStatus;
    if (![[dataDic objectForKey:@"percent"] isKindOfClass:[NSNull class]]) {
        projectStatus=[dataDic objectForKey:@"projectStatus"] ;
        
    }
    if ([projectStatus isEqualToString:@"finished"]) {
        
        controller.zhaungtaistr =  @"还款完毕";
        
    }else if ([projectStatus isEqualToString:@"repayment_normal"]||[projectStatus isEqualToString:@"repayment_abnormal"]){
        
        controller.zhaungtaistr =@"还款中";
        
    }else if ([projectStatus isEqualToString:@"loans"]||[projectStatus isEqualToString:@"loans_audit"]){
        
        controller.zhaungtaistr =@"项目审核";
        
    }else if ([projectStatus isEqualToString:@"full"]){
        
        controller.zhaungtaistr =@"已满标";
        
    }
    
    [self.prarentNav pushViewController:controller animated:YES];

    
    
    
}

-(NSString *)roundUp:(float)number afterPoint:(int)position{
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundUp scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *ouncesDecimal;
    NSDecimalNumber *roundedOunces;
    ouncesDecimal = [[NSDecimalNumber alloc] initWithFloat:number];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    //[ouncesDecimal release];
    return [NSString stringWithFormat:@"%@",roundedOunces];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [dataArray removeAllObjects];
   //  [self getListDataWithFilters:nil sord:nil];
    [self startPost];
    
}

@end
