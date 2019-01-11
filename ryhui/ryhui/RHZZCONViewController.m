//
//  RHZZCONViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 16/3/18.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import "RHZZCONViewController.h"
#import "RHMyGiftViewCell.h"
#import "RHMyNewGiftTableViewCell.h"
#import "RHProjectListViewController.h"
#import "MBProgressHUD.h"
#import "DQViewController.h"
#import "DQview.h"
#import "RHZZTableViewCell.h"
#import "RHZZDetailViewController.h"
@interface RHZZCONViewController ()<UIAlertViewDelegate,DQviewDelegate>

{
    EGORefreshTableHeaderView *_headerView;
    AITableFooterVew *_footerView;
    BOOL _reloading;
    BOOL showLoadMoreButton;
}
@property(nonatomic,strong)UITableView* tableView;
@property (nonatomic, assign) int currentPageIndex;

@end

@implementation RHZZCONViewController

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
    
    //[self reloadTableView];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(4,20, [UIScreen mainScreen].bounds.size.width-8, [UIScreen mainScreen].applicationFrame.size.height-50-30-self.navigationController.navigationBar.frame.size.height - 75) style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
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
    _reloading = NO;
}


-(void)startPost
{
    [_headerView egoRefreshScrollViewDataSourceStartManualLoading:self.tableView];
}

-(void)getinvestListData
{
//    NSDictionary* parameters=@{@"_search":@"true",@"rows":@"10",@"page":[NSString stringWithFormat:@"%d",_currentPageIndex],@"sidx":@"usingTime",@"sord":@"desc",@"filters":@"{\"groupOp\":\"AND\",\"rules\":[]}"};
//    //    DLog(@"%@",type);
//    [[RHNetworkService instance] POST:type parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"＝＝＝＝＝＝＝%@",responseObject);
//        NSMutableArray* tempArray=[[NSMutableArray alloc]initWithCapacity:0];
//        
//        if ([responseObject isKindOfClass:[NSDictionary class]]) {
//            NSArray* array=[responseObject objectForKey:@"rows"];
//            if ([array isKindOfClass:[NSArray class]]) {
//                _footerView.hidden=NO;
//                if ([array count]<10) {
//                    //已经到底了
//                    if ([array count]==0) {
//                        //                        [_footerView.footerButton setTitle:@"亲暂时没有数据" forState:UIControlStateDisabled];
//                        [self showNoDataWithFrame:self.tableView.frame insertView:self.tableView];
//                        
//                    }else{
//                        [self hiddenNoData];
//                    }
//                    [_footerView.footerButton setEnabled:NO];
//                    showLoadMoreButton=NO;
//                }else{
//                    [_footerView.footerButton setEnabled:YES];
//                    showLoadMoreButton=YES;
//                }
//                for (NSDictionary* dic in array) {
//                    if ([dic objectForKey:@"cell"]&&!([[dic objectForKey:@"cell"] isKindOfClass:[NSNull class]])) {
//                        [tempArray addObject:[dic objectForKey:@"cell"]];
//                    }
//                }
//            }else{
//                _footerView.hidden=YES;
//            }
//        }
//        if (_reloading) {
//            [self.dataArray removeAllObjects];
//        }
//        self.currentPageIndex++;
//        [dataArray addObjectsFromArray:tempArray];
//        if (dataArray.count <= 8) {
//            _footerView.hidden=YES;
//        }
//        [self reloadTableView];
//        [_footerView.activityIndicatorView stopAnimating];
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        //        DLog(@"%@",error);
//        [_footerView.activityIndicatorView stopAnimating];
//        _reloading = NO;
//        [_headerView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
//    }];
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
    return 200;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    
    RHZZTableViewCell *cell = (RHZZTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"RHZZTableViewCell" owner:nil options:nil] objectAtIndex:0];
    }
//    [cell.clickButton addTarget:self action:@selector(chooseCellButton:) forControlEvents:UIControlEventTouchUpInside];
//    if (self.dataArray.count > 0) {
//        NSDictionary* dataDic=[self.dataArray objectAtIndex:indexPath.row];
//        [cell updateCell:dataDic with:type];
//    }
//    cell.type = self.test;
    
    [cell updateCell:nil with:self.test];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)chooseCellButton:(UIButton *)btn {
    if (btn.tag == 10) {
        //投资
        RHProjectListViewController* controller=[[RHProjectListViewController alloc]initWithNibName:@"RHProjectListViewController" bundle:nil];
        // controller.type= @"4";
        
        DQview * aview = [DQview Shareview];
        aview.str = @"cbx";
        //aview.delegate = self;
        [aview btnClick:[[UIButton alloc]init]];
        [[DQViewController Sharedbxtabar]tabBar:(DQview *)controller.view didSelectedIndex:3];
        
        //        [nav pushViewController:controller animated:YES];
        //        [DQViewController Sharedbxtabar].tabBar.hidden = NO;
        //        [self presentViewController:controller animated:YES completion:nil];
        //        [[[RHTabbarManager sharedInterface] selectTabbarMain] pushViewController:controller animated:YES];
        
    } else {
        //兑换
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSDictionary* parameters=@{@"giftId":[NSString stringWithFormat:@"%ld",(long)btn.tag]};
        AFHTTPRequestOperationManager* manager=[AFHTTPRequestOperationManager manager];
        manager.securityPolicy = [[RHNetworkService instance] customSecurityPolicy];
        manager.responseSerializer=[[AFCompoundResponseSerializer alloc]init];
        NSString* session=[[NSUserDefaults standardUserDefaults] objectForKey:@"RHSESSION"];
        NSLog(@"------------------%@",session);
        NSString* session1=[[NSUserDefaults standardUserDefaults] objectForKey:@"RHNEWMYSESSION"];
        
        if (session1.length>12) {
            session = [NSString stringWithFormat:@"%@,%@",session,session1];
        }
        if (session&&[session length]>0) {
            [manager.requestSerializer setValue:session forHTTPHeaderField:@"cookie"];
        }
        [manager POST:[NSString stringWithFormat:@"%@front/payment/account/useRebateGift",[RHNetworkService instance].newdoMain] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"------------------%@",responseObject);
            if ([responseObject isKindOfClass:[NSData class]]) {
                NSDictionary* dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                NSLog(@"------------------%@",dic);
                if ([dic[@"msg"] isEqualToString:@"成功"]) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"兑换成功！现金已充入您的账户余额，可到【我的账户】查询." delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                    [alert show];
                } else {
                    [RHUtility showTextWithText:@"兑换现金失败"];
                }
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //            DLog(@"%@",[[NSString alloc] initWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [RHUtility showTextWithText:@"兑换现金失败"];
        }];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self.dataArray removeAllObjects];
    [self startPost];
    _reloading = NO;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"mgl");
    [_footerView.activityIndicatorView stopAnimating];
    _reloading = NO;
    [_headerView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
   // _headerView.hidden = YES;
    RHZZDetailViewController * vc = [[RHZZDetailViewController alloc]initWithNibName:@"RHZZDetailViewController" bundle:nil];
    
    [nav pushViewController:vc animated:YES];


}
@end
