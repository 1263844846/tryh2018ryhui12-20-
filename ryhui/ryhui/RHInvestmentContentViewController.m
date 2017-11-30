//
//  RHInvestmentContentViewController.m
//  ryhui
//
//  Created by 江 云龙 on 15/3/16.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHInvestmentContentViewController.h"
#import "RHMyInvestmentViewCell.h"
#import "RHContractViewContoller.h"
//#import "RHProjectDetailViewController.h"
#import "RHProjectdetailthreeViewController.h"
#import "MBProgressHUD.h"

#import "RHNEWpeopleViewController.h"
#import "RHhelper.h"
@interface RHInvestmentContentViewController ()

{
    EGORefreshTableHeaderView *_headerView;
    AITableFooterVew *_footerView;
    BOOL _reloading;
    BOOL showLoadMoreButton;
}
@property(nonatomic,strong)UITableView* tableView;
@property (nonatomic, assign) int currentPageIndex;
@property(assign,nonatomic)NSInteger row;
@end

@implementation RHInvestmentContentViewController
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
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];

//    self.hidesBottomBarWhenPushed=YES;
  //  [[UIApplication sharedApplication].keyWindow addSubview:self.view];
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].applicationFrame.size.height-50-40-self.navigationController.navigationBar.frame.size.height+30) style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:self.tableView];
     
    _headerView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.view.frame.size.width, self.tableView.bounds.size.height)];
    _headerView.delegate = self;
    [self.tableView addSubview:_headerView];
    
    _footerView = [[AITableFooterVew alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width,50.0)];
    [_footerView.footerButton addTarget:self action:@selector(showMoreApp:) forControlEvents:UIControlEventTouchUpInside];
    [_footerView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    self.tableView.tableFooterView = _footerView;
    _footerView.hidden=YES;
    showLoadMoreButton=YES;
    // Do any additional setup after loading the view.
//    [[UIApplication sharedApplication].keyWindow addSubview:self.tableView];
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
    
    NSDictionary* parameters=@{@"_search":@"true",@"rows":@"10",@"page":[NSString stringWithFormat:@"%d",_currentPageIndex],@"sidx":@"realGiveTime",@"sord":@"desc",@"filters":type};
//    DLog(@"%@",type);
    [[RHNetworkService instance] POST:@"app/front/payment/appAccount/appInvestListData" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        DLog(@"%@",responseObject);
        NSMutableArray* tempArray=[[NSMutableArray alloc]initWithCapacity:0];
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSArray* array=[responseObject objectForKey:@"rows"];
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
        
        self.currentPageIndex++;
        [dataArray addObjectsFromArray:tempArray];
        if ([dataArray count]<=7) {
            _footerView.hidden=YES;
        }
        [self reloadTableView];
        [_footerView.activityIndicatorView stopAnimating];
       [_headerView setHidden:YES];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        DLog(@"%@",error);
        [_footerView.activityIndicatorView stopAnimating];
        _reloading = NO;
        [_headerView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
        [_headerView setHidden:YES];
       
    }];
}

- (void)reloadTableView{
//     self.hidesBottomBarWhenPushed = YES;
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
    return 180;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     //UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(qingpaishijian)];
    static NSString *CellIdentifier = @"CellIdentifier";
    
    RHMyInvestmentViewCell *cell = (RHMyInvestmentViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"RHMyInvestmentViewCell" owner:nil options:nil] objectAtIndex:0];
    }
    
    NSDictionary* dataDic=[self.dataArray objectAtIndex:indexPath.row];
    _row = indexPath.row;
    cell.nav=nav;
    cell.type = self.type;
    [cell updateCell:dataDic];
   // [cell.nameLabel addGestureRecognizer:tap];
     NSLog(@"----");
    return cell;
}

- (void)qingpaishijian{
     NSLog(@"----");
//    RHProjectDetailViewController* controller=[[RHProjectDetailViewController alloc]initWithNibName:@"RHProjectDetailViewController" bundle:nil];
//    NSDictionary* dataDic=[self.dataArray objectAtIndex:_row];
//    controller.dataDic=dataDic;
//    //controller.getType=type;
//    [nav pushViewController:controller animated:YES];
//    
//    NSLog(@"----");
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//     self.ressss = NO;
    self.myblock();
    
   
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDictionary* parameters=@{@"id":[NSString stringWithFormat:@"%@",self.dataArray[indexPath.row][@"id"]]};
    
    [[RHNetworkService instance] POST:@"app/common/appDetails/appProjectDetailData" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
    [RHhelper ShraeHelp].myinsert = 11;
        RHProjectdetailthreeViewController* controller=[[RHProjectdetailthreeViewController alloc]initWithNibName:@"RHProjectdetailthreeViewController" bundle:nil];
        
        
        NSMutableDictionary* dataDic=responseObject[@"project"];
        NSString * str = [NSString stringWithFormat:@"%@",dataDic[@"product"]];
        
        if ([str isEqualToString:@"5"]) {
            RHNEWpeopleViewController * controller = [[RHNEWpeopleViewController alloc]initWithNibName:@"RHNEWpeopleViewController" bundle:nil];
            //            NSDictionary* dataDic=[self.segment1Array objectAtIndex:indexPath.row];
            //            controller.newpeopletype = YES;
            //
            //
           
                controller.judge = @"ketou";
            
            controller.dataDic=dataDic;
            controller.getType=type;
            //            controller.newpeopletype =YES;
            //            controller.postnewpeopletype = self.newpeoplebool;
            //            //controller.view.frame = CGRectMake(0, 0, self.view.frame.size.width, 700);
            //            //controller.view.backgroundColor = [UIColor orangeColor];
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
            //[RHhelper ShraeHelp].myinsert = 10;
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [self.nav pushViewController:controller animated:YES];
           
        }else{
        
        NSString  * string = [NSString stringWithFormat:@"%@",dataDic[@"project"][@"investorRate"]];
//        controller.
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
        
        //    controller.lilv = string;
        
        controller.myblock = ^{
            self.myblock1();
        };
        
        
        controller.myinsertres = 10;
        controller.dataDic=dataDic;
            controller.getType=@"0";
        controller.panduan =10;
        controller.projectId = [NSString stringWithFormat:@"%@",self.dataArray[indexPath.row][@"id"]];
        NSString * projectStatus;
        if (![[dataDic objectForKey:@"percent"] isKindOfClass:[NSNull class]]) {
            projectStatus=[dataDic objectForKey:@"projectStatus"] ;
            
        }
        if ([projectStatus isEqualToString:@"finished"]) {
            
            controller.zhaungtaistr =  @"还款完毕";
            
        }else if ([projectStatus isEqualToString:@"repayment_normal"]||[projectStatus isEqualToString:@"repayment_abnormal"]){
            
            controller.zhaungtaistr =@"还款中";
            
        }else if ([projectStatus isEqualToString:@"loans"]||[projectStatus isEqualToString:@"loans_audit"]){
            
            controller.zhaungtaistr =@"放款审核";
            
        }else if ([projectStatus isEqualToString:@"full"]){
            
            controller.zhaungtaistr =@"已满标";
            
        }
            
         [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self.nav pushViewController:controller animated:YES];
        }
        NSLog(@"%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
    }];
    
    
   
    
    
    
    
    
    /*
    [[RHNetworkService instance] POST:@"app/common/main/appXueDetailData" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * dic = responseObject;
        
        NSLog(@"%@",dic[@"project"]);
        NSString  * string = [NSString stringWithFormat:@"%@",dic[@"project"][@"investorRate"]];
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
        controller.dataDic = dic[@"project"];
        controller.getType = @"1";
        
        
        NSLog(@"%@",controller.dataDic[@"limitTime"]);
        if (dic.count> 0) {
            [nav pushViewController:controller animated:YES];
            return ;
        }
       // return ;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
    }];
    
    [[RHNetworkService instance] POST:@"app/common/main/appShangDetailData" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary * dic = responseObject;
        NSString  * string = [NSString stringWithFormat:@"%@",dic[@"project"][@"investorRate"]];
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
        
        NSLog(@"%@",dic[@"project"]);
        controller.dataDic = dic[@"project"];
        controller.getType = @"0";
//        NSString * str = dic[@"project"][@"limitTime"];
//        int a = [str intValue];
        
        
        NSLog(@"666");
        if (dic.count> 0) {
            [nav pushViewController:controller animated:YES];
            return ;
        }
        //[nav pushViewController:controller animated:YES];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
    }];
    
    
    
    
    
    
    */
    
//
//    NSLog(@"----");
}



/*
 
 {
 available = 0;
 available2 = "0.00";
 class = "view.ProjectStudentDetailView";
 fullTime = "2015-10-23 13:18:15";
 id = 762;
 insuranceMethod = "\U5c31\U4e1a\U62c5\U4fdd\U4e0e\U98ce\U9669\U4fdd\U8bc1\U91d1\U53cc\U91cd\U672c\U606f\U4fdd\U969c";
 investorRate = 8;
 limitTime = "3.0";
 name = "\U52a9\U5b66\U8d372";
 partnerInfo = "\U4e2d\U56fd\U9752\U5e74\U804c\U4e1a\U80fd\U529b\U57f9\U8bad\U4e2d\U5173\U6751\U8f6f\U4ef6\U56ed\U4eba\U624d\U57f9\U8bad\U57fa\U5730\Uff08\U4ee5\U4e0b\U7b80\U79f0\U4eba\U624d\U57fa\U5730\Uff09\U7531\U4e2d\U5173\U6751\U8f6f\U4ef6\U56ed\U4eba\U624d\U57fa\U5730\U63d0\U4f9b\U4eba\U624d\U9700\U6c42\U4fe1\U606f\U53ca\U5b66\U751f\U5c31\U4e1a\U8f93\U9001\U6e20\U9053\Uff0c\U662f\U4e3a\U6ee1\U8db3\U4e2d\U5173\U6751\U8f6f\U4ef6\U56ed\U4eba\U624d\U53d1\U5c55\U6218\U7565\U5efa\U7acb\U7684\U4eba\U529b\U8d44\U6e90\U4e13\U4e1a\U5316\U670d\U52a1\U5e73\U53f0\Uff0c\U4e0d\U65ad\U4e3a\U56ed\U533a\U4f01\U4e1a\U63d0\U4f9b\U9ad8\U8d28\U91cf\U7684\U4eba\U529b\U8d44\U6e90\U4f9b\U7ed9\U3002
 \n
 \n\U4e2d\U5173\U6751\U8f6f\U4ef6\U56ed\U4f5c\U4e3a\U56fd\U5bb6\U8f6f\U4ef6\U4ea7\U4e1a\U57fa\U5730\U3001\U56fd\U5bb6\U8f6f\U4ef6\U51fa\U53e3\U57fa\U5730\U3001\U56fd\U5bb6\U7ea7\U5de5\U7a0b\U5b9e\U8df5\U6559\U80b2\U57fa\U5730\U59cb\U5efa\U4e8e2000\U5e74\Uff0c\U662f\U4e2d\U56fd\U8f6f\U4ef6\U4ea7\U4e1a\U7684\U9f99\U5934\U56ed\U533a\Uff0c\U76ee\U524d\U5df2\U805a\U96c6\U56fd\U9645\U9876\U5c16\U8f6f\U4ef6\U4f01\U4e1a300\U591a\U5bb6\Uff0c\U5305\U62ecIBM\U3001\U7532\U9aa8\U6587\U3001\U4e2d\U56fd\U5de5\U5546\U94f6\U884c\U5f00\U53d1\U4e2d\U5fc3\U3001\U8def\U900f\U3001\U897f\U95e8\U5b50\U3001\U767e\U5ea6\U3001\U8054\U60f3\U3001\U817e\U8baf\U3001\U534e\U4e3a\U3001\U4fe1\U5a01\U901a\U4fe1\U3001\U56fd\U5bb6\U7535\U7f51\U3001\U6587\U601d\U6d77\U8f89\U3001\U8f6f\U901a\U52a8\U529b\U7b49\U3002
 \n
 \n\U4e0a\U8ff0\U56ed\U533a\U4f01\U4e1a\U7684\U8f6f\U4ef6\U4eba\U624d\U9700\U6c42\U5448\U73b0\U51fa\U201c\U957f\U5e74\U4f9b\U7ed9\U4e0d\U8db3\U201d\U7684\U72b6\U6001\Uff0c\U4eba\U624d\U57fa\U5730\U6574\U5408\U4f01\U4e1a\U4e13\U5bb6\U53ca\U6280\U672f\U8d44\U6e90\Uff0c\U5efa\U7acb\U9488\U5bf9\U8f6f\U4ef6\U884c\U4e1a\U4e0d\U540c\U5c97\U4f4d\U7684\U804c\U4e1a\U9700\U6c42\U6a21\U578b\Uff0c\U9996\U5148\U4ece\U62a5\U540d\U5b66\U5458\U4e2d\U9009\U51fa\U6709\U6280\U80fd\U57fa\U7840\U7684\U5b66\U5458\Uff0c\U5e76\U6309\U4f01\U4e1a\U7528\U4eba\U9700\U6c42\U5212\U5206\U4ece\U4e1a\U65b9\U5411\Uff0c\U800c\U540e\U5f00\U5c55\U5b9e\U4e60\U5b9e\U8bad\U3001\U5353\U8d8a\U5de5\U7a0b\U5e08\U57f9\U517b\Uff0c\U5c31\U4e1a\U8f85\U5bfc\U3001\U804c\U4e1a\U53d1\U5c55\U8f85\U5bfc\U3001\U5c97\U524d\U8f85\U5bfc\U7b49\U6559\U5b66\U5de5\U4f5c\Uff0c2012\U5e74\U30012013\U5e74\U30012014\U5e74\U8fde\U7eed\U4e09\U5e74\U6ee1\U8db3\U5b66\U5458\U5c31\U4e1a\U7387\U5747\U4e3a100%\U3002
 \n
 \n\U4eba\U624d\U57fa\U5730\U4f4d\U4e8e\U4e2d\U5173\U6751\U8f6f\U4ef6\U56ed\U533a\U5185\Uff0c\U7531\U56fd\U5bb6\U53d1\U6539\U59d4\U6295\U8d44\U5174\U5efa\Uff0c\U5b9e\U8bad\U573a\U57303000\U591a\U5e73\U7c73\Uff0c\U62e5\U6709\U5b66\U5458\U9910\U5385\U3001\U5de5\U7a0b\U5e08\U516c\U5bd3\U3001\U591a\U529f\U80fd\U62a5\U544a\U5385\U3001\U5f71\U97f3\U5ba4\U3001\U5b66\U751f\U6d3b\U52a8\U533a\U7b49\U591a\U79cd\U573a\U5730\U8bbe\U65bd\Uff0c\U5317\U4eac\U767e\U77e5\U6559\U80b2\U79d1\U6280\U6709\U9650\U516c\U53f8\U662f\U4eba\U624d\U57fa\U5730\U7684\U6559\U5b66\U670d\U52a1\U5355\U4f4d\Uff0c\U62e5\U6709\U4e30\U5bcc\U7684\U9ad8\U6821\U5e08\U8d44\Uff0c\U5e2e\U6276\U8bf8\U591a\U9ad8\U6821\U5efa\U8bbe\U8f6f\U4ef6\U4e13\U4e1a\U8bfe\U7a0b\U53ca\U5de5\U7a0b\U5b9e\U8df5\U8bfe\U7a0b\Uff0c\U5728\U884c\U4e1a\U5185\U88ab\U8a89\U4e3a\U201c\U8f6f\U4ef6\U5de5\U7a0b\U5e08\U7684\U6447\U7bee\U201d\U3002";
 paymentName = "\U7b49\U989d\U672c\U606f";
 paymentType = 01;
 percent = 100;
 projectFund = "50,000.00";
 projectStatus = full;
 studentAge = 26;
 studentCity = "\U592a\U539f\U5e02";
 studentEducation = "\U5927\U4e13";
 studentGender = "\U5973";
 studentName = "\U67d0**";
 studentNation = "\U58ee\U65cf";
 studentProfession = "\U8f6f\U4ef6\U5de5\U7a0b";
 studentSchool = "\U5317\U4eac\U79d1\U6280\U5927\U5b66";
 version = 6;
 }

 
 
 
 
 
 
 */
@end
