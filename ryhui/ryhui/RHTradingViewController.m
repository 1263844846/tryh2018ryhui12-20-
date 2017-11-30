//
//  RHTradingViewController.m
//  ryhui
//
//  Created by stefan on 15/3/15.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHTradingViewController.h"
#import "RHTradViewCell.h"
#import "biaxueViewController.h"

@interface RHTradingViewController ()

{
    EGORefreshTableHeaderView *_headerView;
    AITableFooterVew *_footerView;
    BOOL _reloading;
    BOOL showLoadMoreButton;
}
@property (nonatomic, assign) int currentPageIndex;
@property(nonatomic,strong)NSMutableArray* dataArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(strong,nonatomic)NSMutableArray * keyArray;
@property(nonatomic,strong)NSMutableDictionary * datadic;
@property(nonatomic,strong)NSMutableDictionary * datadic1;
@property(nonatomic,assign)int removea;
@end

@implementation RHTradingViewController
@synthesize dataArray;
@synthesize currentPageIndex = _currentPageIndex;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configBackButton];
    [self configTitleWithString:@"交易记录"];
   
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor=[UIColor clearColor];
    self.removea = 1;
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
   
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
   
        
        [DQViewController Sharedbxtabar].tarbar.hidden = YES;
//      [[DQViewController Sharedbxtabar].tabBar setHidden:YES];
    
    self.removea = 1;
    self.dataArray=[[NSMutableArray alloc]initWithCapacity:0];
    
    // Do any additional setup after loading the view.
    _headerView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.view.frame.size.width, self.tableView.bounds.size.height)];
    _headerView.delegate = self;
    [self.tableView addSubview:_headerView];
    
    _footerView = [[AITableFooterVew alloc] initWithFrame:CGRectMake(0.0, 0.0,[UIScreen mainScreen].bounds.size.width,50.0)];
    [_footerView.footerButton addTarget:self action:@selector(showMoreApp:) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.tableFooterView = _footerView;
    _footerView.hidden=YES;
    
    showLoadMoreButton=YES;
    _reloading = NO;
    [_headerView egoRefreshScrollViewDataSourceStartManualLoading:self.tableView];
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

//- (void)dealloc
//{
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//
//    [_footerView.activityIndicatorView stopAnimating];
//    _footerView.activityIndicatorView = nil;
//    [_footerView.footerButton removeTarget:self action:@selector(showMoreApp:) forControlEvents:UIControlEventTouchUpInside];
//    _footerView.footerButton = nil;
//    _footerView = nil;
//    self.tableView = nil;
//    _headerView = nil;
//}
//{"class":"view.JqRow","id":1935,"version":null,"cell":{"id":1935,"fee":null,"custId":"6000060000735977","relatedId":null,"description":"期数:3","userId":"29","money":2293.05,"dateCreated":"2015-09-12 00:02:27","projectId":248,"type":"PenaltyInterest","orderId":"00000000000000014557"}
-(void)getTrading
{
    NSDictionary* parameters=@{@"rows":@"10",@"page":[NSString stringWithFormat:@"%d",_currentPageIndex],@"sidx":@"id",@"sord":@"desc",@"type":@"person"};
    
    [[RHNetworkService instance] POST:@"app/common/user/appOperationRecord/appTradeInvestListData" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {

        // NSMutableArray* tempArray=[[NSMutableArray alloc]initWithCapacity:0];
        
        if (_reloading) {
            //                if (_currentPageIndex==1) {
            //
            //                }else{
            //                 [self.datadic removeAllObjects];
            //                }
            if (self.removea>1) {
                [self.datadic removeAllObjects];
            }else{
                
                
            }
            
            
            
            
        }
        self.removea=2;
        NSMutableArray* array=[[NSMutableArray alloc]initWithCapacity:0];
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            NSArray * arra = [responseObject[@"transaction"] allKeys];
           
            
            for (NSString * str  in arra) {
                NSMutableArray* tempArray=[[NSMutableArray alloc]initWithCapacity:0];
                for (NSDictionary * dic in responseObject[@"transaction"][str]) {
                    
                    NSMutableArray * arr = self.datadic[str];
                    if (arr.count >0) {
                        [arr addObject:dic];
                        [self.datadic setObject:arr forKey:str];
                    }else{
                        [tempArray addObject:dic];
                         [self.datadic setObject:tempArray forKey:str];
                        //[self.datadic setObject:tempArray forKey:str];
                    }
                    [array addObject:dic];
//                    [tempArray addObject:dic];
                   // [self.datadic setObject:tempArray forKey:str];
                    
                }
                
                
            }
            
            if ([array count]<10) {
                //已经到底了
                if ([array count]==0) {
                    //                        [_footerView.footerButton setTitle:@"亲暂时没有数据" forState:UIControlStateNormal];
                   // if (_reloading) {
                        [self showNoDataWithFrame:self.tableView.frame insertView:self.tableView];
                   // }
                    //[self showNoDataWithFrame:self.tableView.frame insertView:self.tableView];
                    
                }else{
                    [self hiddenNoData];
                }
                [_footerView.footerButton setEnabled:NO];
                showLoadMoreButton=NO;
            }else{
                [_footerView.footerButton setEnabled:YES];
                showLoadMoreButton=YES;
            }
//            for (NSDictionary* dic in array) {
//                if ([dic objectForKey:@"cell"]&&!([[dic objectForKey:@"cell"] isKindOfClass:[NSNull class]])) {
//                    [tempArray addObject:[dic objectForKey:@"cell"]];
//                }
//            }
        }
        
        
            [self reloadTableView];
            self.currentPageIndex++;
        
        
            [_footerView.activityIndicatorView stopAnimating];
        
     
        
 
        
        
        
        
//        NSMutableArray* tempArray=[[NSMutableArray alloc]initWithCapacity:0];
//        NSArray * keymyarray = responseObject[@"months"];
//        if ([responseObject isKindOfClass:[NSDictionary class]]) {
//            
//            for (int i = 0; i < keymyarray.count; i++) {
//                NSArray* array=[responseObject[@"transaction"] objectForKey:keymyarray[i]];
//                if ([array isKindOfClass:[NSArray class]]) {
//                    _footerView.hidden=NO;
//                    if ([array count]<8) {
//                        //已经到底了
//                        if ([array count]==0) {
//                            //                        [_footerView.footerButton setTitle:@"亲暂时没有数据" forState:UIControlStateNormal];
//                            [self showNoDataWithFrame:self.tableView.frame insertView:self.tableView];
//                            
//                        }else{
//                            [self hiddenNoData];
//                        }
//                        [_footerView.footerButton setEnabled:NO];
//                        showLoadMoreButton=NO;
//                    }else{
//                        [_footerView.footerButton setEnabled:YES];
//                        showLoadMoreButton=YES;
//                    }
//                    for (NSDictionary* dic in array) {
//                        
//                            [tempArray addObject:dic];
//                        
//                    }
//                }else{
//                    _footerView.hidden=YES;
//                }
//            
//            
//            
//            if (_reloading) {
//                [self.dataArray removeAllObjects];
//                [self.datadic removeAllObjects];
//            }
//            
//            [self.datadic setObject:tempArray forKey:keymyarray[i]];
//                
//            }
//        }
//            
//           self.currentPageIndex++;
//        
//        //        if ([dataArray count] <= 12) {
//        //            _footerView.hidden = YES;
//        //        }
//        
//        [self reloadTableView];
//        [_footerView.activityIndicatorView stopAnimating];
//        
        
        
        
        
        
        
     
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        DLog(@"%@",error);

        
        NSLog(@"%@",error);
    }];
}

- (void)reloadTableView{
    
    self.keyArray = [NSMutableArray arrayWithArray:[self.datadic allKeys]];
    
    self.keyArray = (NSMutableArray *)[self.keyArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM"];
        if (obj1 == [NSNull null]) {
            obj1 = @"0000-00";
        }
        if (obj2 == [NSNull null]) {
            obj2 = @"0000-00";
        }
        NSDate *date1 = [formatter dateFromString:obj1];
        NSDate *date2 = [formatter dateFromString:obj2];
        NSComparisonResult result = [date1 compare:date2];
        return result == NSOrderedAscending;
    }];
    for (int i = 0; i< self.keyArray.count; i++) {
        
        [self.datadic1 setObject:self.datadic[self.keyArray[i]] forKey:self.keyArray[i]];
        
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
        [self getTrading];
    }
}

- (void)refreshApp:(BOOL)showloading{
    if (!_reloading){
        _reloading = YES;
        self.currentPageIndex = 1;
       // [self.datadic removeAllObjects];
        [self getTrading];
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
   // self.removea = 1;
    
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
    
    return _reloading; // should return if data source model is reloading
    
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
    
    return [NSDate date]; // should return date data source was last changed
    
}

#pragma mark-TableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //分组数 也就是section数
    NSArray * array = [self.datadic allKeys];
   // self.keyArray = array;
//    array = (NSMutableArray *)[array sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        [formatter setDateFormat:@"yyyy/MM/dd/"];
//        if (obj1 == [NSNull null]) {
//            obj1 = @"0000/00/00";
//        }
//        if (obj2 == [NSNull null]) {
//            obj2 = @"0000/00/00";
//        }
//        NSDate *date1 = [formatter dateFromString:obj1];
//        NSDate *date2 = [formatter dateFromString:obj2];
//        NSComparisonResult result = [date1 compare:date2];
//        return result == NSOrderedDescending;
//    }];
    return self.keyArray.count;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    UIView * headerview = [[UIView alloc]init];
    headerview.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30);
    UILabel * newpersonlab = [[UILabel alloc]init];
    newpersonlab.frame = CGRectMake(20,0, 100, 30);
    //    newpersonlab.backgroundColor = [UIColor redColor];
    [headerview addSubview:newpersonlab];
    newpersonlab.font =[UIFont systemFontOfSize: 14.0];
    headerview.backgroundColor = [RHUtility colorForHex:@"#E4E6E6"];
    NSArray * array = [self.datadic allKeys];
//    array = (NSMutableArray *)[array sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        [formatter setDateFormat:@"yyyy/MM/dd/"];
//        if (obj1 == [NSNull null]) {
//            obj1 = @"0000/00/00";
//        }
//        if (obj2 == [NSNull null]) {
//            obj2 = @"0000/00/00";
//        }
//        NSDate *date1 = [formatter dateFromString:obj1];
//        NSDate *date2 = [formatter dateFromString:obj2];
//        NSComparisonResult result = [date1 compare:date2];
//        return result == NSOrderedDescending;
//    }];
    newpersonlab.text = self.keyArray[section];
    
    return headerview;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray * array = [self.datadic allKeys];
    NSString * str = self.keyArray[section];
    NSArray * arr =self.datadic[str];
    return arr.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    
    RHTradViewCell *cell = (RHTradViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"RHTradViewCell" owner:nil options:nil] objectAtIndex:0];
    }
//    NSMutableArray * arr = [NSMutableArray arrayWithArray:[self.datadic allKeys]];
//   
//    arr = (NSMutableArray *)[arr sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        [formatter setDateFormat:@"yyyy-MM"];
//        if (obj1 == [NSNull null]) {
//            obj1 = @"0000-00";
//        }
//        if (obj2 == [NSNull null]) {
//            obj2 = @"0000-00";
//        }
//        NSDate *date1 = [formatter dateFromString:obj1];
//        NSDate *date2 = [formatter dateFromString:obj2];
//        NSComparisonResult result = [date1 compare:date2];
//        return result == NSOrderedAscending;
//    }];
    NSArray * array = self.datadic[self.keyArray[indexPath.section]];
    NSDictionary* dataDic=[array objectAtIndex:indexPath.row];
    
    [cell updateCell:dataDic];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    biaxueViewController * vc = [[biaxueViewController alloc]initWithNibName:@"biaxueViewController" bundle:nil];
//    [self.navigationController pushViewController:vc animated:YES];
    
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

-(NSMutableArray *)keyArray{
    
    if (!_keyArray) {
        _keyArray = [NSMutableArray array];
    }
    return _keyArray;
    
}

-(NSMutableDictionary *)datadic{
    
    if (!_datadic) {
        _datadic = [NSMutableDictionary dictionary];
    }
    return _datadic;
    
}
-(NSMutableDictionary *)datadic1{
    
    if (!_datadic1) {
        _datadic1 = [NSMutableDictionary dictionary];
    }
    return _datadic1;
    
}

/*
 
 //        DLog(@"%@",responseObject);
 NSArray * arr = [responseObject[@"transaction"] allKeys];
 // [self.keyArray addObject: [responseObject[@"transaction"] allKeys]];
 
 NSMutableArray* tempArray=[[NSMutableArray alloc]initWithCapacity:0];
 //[self.datadic removeAllObjects];
 for (NSString * str in arr) {
 
 [self.keyArray addObject:str];
 if ([responseObject isKindOfClass:[NSDictionary class]]) {
 
 
 
 
 NSArray* array=responseObject[@"transaction"][str];
 if ([array isKindOfClass:[NSArray class]]) {
 [self.datadic setObject:array forKey:str];
 _footerView.hidden=NO;
 if ([array count]<10) {
 //已经到底了
 if ([array count]==0) {
 //                        [_footerView.footerButton setTitle:@"亲暂时没有数据" forState:UIControlStateNormal];
 [self showNoDataWithFrame:self.tableView.frame insertView:self.tableView];
 
 //         po responseObject[@"transaction"][@"2016-12"][0][@"description"]
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
 //                    if ([dic objectForKey:@"cell"]&&!([[dic objectForKey:@"cell"] isKindOfClass:[NSNull class]])) {
 [tempArray addObject:dic];
 //                    }
 }
 }else{
 _footerView.hidden=YES;
 }
 
 }
 if (_reloading) {
 // [self.keyArray removeAllObjects];
 if ( self.removea==1) {
 NSLog(@"1111");
 }else{
 
 [self.dataArray removeAllObjects];
 [self.datadic removeAllObjects];
 [self.keyArray removeAllObjects];
 //[self.keyArray removeAllObjects];
 [self reloadTableView];
 return;
 }
 self.removea++;
 
 }
 self.currentPageIndex++;
 //[dataArray addObjectsFromArray:tempArray];
 //        [self.datadic setObject:tempArray forKey:str];
 
 // [tempArray removeAllObjects];
 
 if ([dataArray count] <= 12) {
 _footerView.hidden = YES;
 }
 }
 
 //        NSSet * set = [NSSet setWithArray:self.keyArray];
 //        //  [self.keyArray removeAllObjects];
 //
 //        self.keyArray = [NSMutableArray arrayWithObject:set];
 //        [self.keyArray removeAllObjects];
 [self reloadTableView];
 [_footerView.activityIndicatorView stopAnimating];
 
 */
@end
