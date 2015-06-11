//
//  RHMyMessageViewController.m
//  ryhui
//
//  Created by 江 云龙 on 15/3/29.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHMyMessageViewController.h"
#import "RHMyMessageCell.h"

@interface RHMyMessageViewController ()<EGORefreshTableHeaderDelegate,UITableViewDataSource,UITableViewDelegate,RHMessageDetailDelegate,UIAlertViewDelegate>
{
    EGORefreshTableHeaderView *_headerView;
    AITableFooterVew *_footerView;
    BOOL _reloading;
    BOOL showLoadMoreButton;
    UIButton *rightButton;
    NSMutableArray *readMessages;
    UIButton *leftButton;
    BOOL isAllSelected;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *tabBarView;
@property (weak, nonatomic) IBOutlet UIView *selecteBar;

@property (nonatomic, assign) int currentPageIndex;
@property(nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation RHMyMessageViewController
@synthesize dataArray;
@synthesize currentPageIndex = _currentPageIndex;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configBackButton];
    [self configTitleWithString:@"我的消息"];
    
    isAllSelected = NO;
    showLoadMoreButton = YES;
    readMessages = [[NSMutableArray alloc] init];
    self.dataArray = [[NSMutableArray alloc]initWithCapacity:0];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];

    _headerView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.view.frame.size.width, self.tableView.bounds.size.height)];
    _headerView.delegate = self;
    [self.tableView addSubview:_headerView];
    
    _footerView = [[AITableFooterVew alloc] initWithFrame:CGRectMake(0.0, 0.0, self.tableView.frame.size.width,50.0)];
    [_footerView.footerButton addTarget:self action:@selector(showMoreApp:) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.tableFooterView = _footerView;
    _footerView.hidden = YES;
    [_headerView egoRefreshScrollViewDataSourceStartManualLoading:self.tableView];
    
    [self setRightButtonItem];
    self.selecteBar.hidden = YES;
}

- (void)setRightButtonItem {
    rightButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setTitle:@"编辑" forState:UIControlStateNormal];
    rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    rightButton.font = [UIFont systemFontOfSize:17.0];
    [rightButton addTarget:self action:@selector(enteringToEditingMessages:) forControlEvents:UIControlEventTouchUpInside];
    rightButton.frame=CGRectMake(0, 0, 70, 30);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}

- (void)enteringToEditingMessages:(UIButton *)btn {
    self.selecteBar.hidden = NO;
    [self.tableView setEditing:(!self.tableView.editing) animated:YES];
    [readMessages removeAllObjects];
    if (self.tableView.isEditing) {
       leftButton =[UIButton buttonWithType:UIButtonTypeCustom];
        [leftButton setTitle:@"全选" forState:UIControlStateNormal];
        leftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        leftButton.font = [UIFont systemFontOfSize:17.0];
        [leftButton addTarget:self action:@selector(chooseMoreMessage:) forControlEvents:UIControlEventTouchUpInside];
        leftButton.frame=CGRectMake(0, 0, 70, 30);
        self.navigationItem.leftBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:leftButton];
        [btn setTitle:@"取消编辑" forState:UIControlStateNormal];
    } else {
        self.selecteBar.hidden = YES;
        [btn setTitle:@"编辑" forState:UIControlStateNormal];
        [self configBackButton];
    }
}

- (void)chooseMoreMessage:(UIButton *)btn {
    btn.selected = !btn.selected;
    if (btn.selected) {
        isAllSelected = YES;
        [leftButton setTitle:@"取消全选" forState:UIControlStateNormal];
        for (int i = 0; i < self.dataArray.count; i ++) {
                NSDictionary *addObject = [self.dataArray objectAtIndex:i];
                NSString *messageID = [addObject objectForKey:@"id"];
                [readMessages addObject:messageID];
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
                [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        }
    } else {
        isAllSelected = NO;
        [readMessages removeAllObjects];
        [leftButton setTitle:@"全选" forState:UIControlStateNormal];
        [self.tableView selectRowAtIndexPath:nil animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
}

- (void)manageTheChooseMessagesWithState:(int)state {
    NSString * appendString = @"";
    if (state == 1) {
        //标为已读
        appendString = @"markMessageReaded";
    } else {
        // 删除
        appendString = @"markMessageDelete";
    }
    if (readMessages.count > 0) {
        NSString *ids = @"";
        for (int i = 0 ; i < readMessages.count ; i ++) {
            NSString *messageID = readMessages[i];
            NSString *temp = @"";
            if (i < readMessages.count - 1) {
                temp = [NSString stringWithFormat:@"%@,",messageID];
                ids = [ids stringByAppendingString:temp];
            } else {
                temp = [NSString stringWithFormat:@"%@",messageID];
                ids = [ids stringByAppendingString:temp];
            }
        }
        ids = [NSString stringWithFormat:@"[%@]",ids];
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc] initWithObjectsAndKeys:ids,@"ids", nil];
//        NSLog(@"=======%@",parameters);
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [[AFCompoundResponseSerializer alloc]init];
        [manager POST:[NSString stringWithFormat:@"%@front/payment/account/%@",[RHNetworkService instance].doMain,appendString] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSRange range = [result rangeOfString:@"success"];
            if (range.location != NSNotFound) {
                if (state == 1) {
                    [RHUtility showTextWithText:@"标记已读成功!"];
                } else {
                    [RHUtility showTextWithText:@"删除成功!"];
                }
                [readMessages removeAllObjects];
                [self refresh];
                if (isAllSelected) {
                    [self chooseMoreMessage:leftButton];
                }
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        }];
    } else {
        [RHUtility showTextWithText:@"您未选择消息"];
    }
}

- (void)refresh {
    [self refreshApp:YES];
    [[RHNetworkService instance] POST:@"front/payment/account/countUnReadMessage" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSString *numStr = nil;
            if (![[responseObject objectForKey:@"msgCount"] isKindOfClass:[NSNull class]]) {
                if ([[responseObject objectForKey:@"msgCount"] isKindOfClass:[NSNumber class]]) {
                    numStr = [[responseObject objectForKey:@"msgCount"] stringValue];
                } else {
                    numStr = [responseObject objectForKey:@"msgCount"];
                }
            }
            if (numStr) {
                [[NSUserDefaults standardUserDefaults] setObject:numStr forKey:@"RHMessageNumSave"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"RHMessageNum" object:numStr];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
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

- (IBAction)deleteButton:(UIButton *)sender {
    if (readMessages.count > 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"消息删除后不可恢复，是否确认删除？" delegate:self cancelButtonTitle:@"删除" otherButtonTitles:@"取消", nil];
        [alert show];
    }  else {
        [RHUtility showTextWithText:@"您未选择消息"];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self performSelector:@selector(manageTheChooseMessagesWithState:) withObject:nil afterDelay:.5];
    }
}

- (IBAction)readedMessageButton:(UIButton *)sender {
    [self manageTheChooseMessagesWithState:1];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_footerView.activityIndicatorView stopAnimating];
    _footerView.activityIndicatorView = nil;
    [_footerView.footerButton removeTarget:self action:@selector(showMoreApp:) forControlEvents:UIControlEventTouchUpInside];
    _footerView.footerButton = nil;
    _footerView = nil;
    self.tableView = nil;
    _headerView = nil;
}
//{"class":"view.JqRow","id":1935,"version":null,"cell":{"id":1935,"fee":null,"custId":"6000060000735977","relatedId":null,"description":"期数:3","userId":"29","money":2293.05,"dateCreated":"2015-09-12 00:02:27","projectId":248,"type":"PenaltyInterest","orderId":"00000000000000014557"}
- (void)getMyMessage {
    NSDictionary *parameters = @{@"_search":@"true",@"rows":@"10",@"page":[NSString stringWithFormat:@"%d",_currentPageIndex],@"forApp":@"true",@"filters":@"{\"groupOp\":\"AND\",\"rules\":[{\"field\":\"state\",\"op\":\"in\",\"data\":[1,2]}]}"};
    
    [[RHNetworkService instance] POST:@"front/payment/account/myMessageListData" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        DLog(@"%@",responseObject);
        NSMutableArray *tempArray = [[NSMutableArray alloc]initWithCapacity:0];
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSArray *array=[responseObject objectForKey:@"rows"];
            if ([array isKindOfClass:[NSArray class]]) {
                _footerView.hidden = NO;
                if ([array count] < 10) {
                    //已经到底了
                    if ([array count] == 0) {
                        if (_reloading) {
                            [self showNoDataWithFrame:self.tableView.frame insertView:self.tableView];
                        }
                    } else {
                        [self hiddenNoData];
                    }
                    [_footerView.footerButton setEnabled:NO];
                    showLoadMoreButton = NO;
                } else {
                    [_footerView.footerButton setEnabled:YES];
                    showLoadMoreButton = YES;
                }
                for (NSDictionary *dic in array) {
                    if ([dic objectForKey:@"cell"] && !([[dic objectForKey:@"cell"] isKindOfClass:[NSNull class]])) {
                        [tempArray addObject:[dic objectForKey:@"cell"]];
                    }
                }
            } else {
                _footerView.hidden = YES;
            }
        }
        if (_reloading) {
            [self.dataArray removeAllObjects];
        }
        self.currentPageIndex ++;
        [dataArray addObjectsFromArray:tempArray];
        if ([dataArray count] <= 10) {
            _footerView.hidden = YES;
        }
        if (dataArray.count == 0) {
            self.selecteBar.hidden = YES;
            [self configBackButton];
            [rightButton setTitle:@"编辑" forState:UIControlStateNormal];
        }
        [self reloadTableView];
        [_footerView.activityIndicatorView stopAnimating];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        DLog(@"%@",error);
    }];
}

- (void)reloadTableView {
    [self.tableView reloadData];
    _reloading = NO;
    [_headerView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
    if (isAllSelected) {
        leftButton.selected = NO;
        [self chooseMoreMessage:leftButton];
    }
}

- (void)showMoreApp:(id)sender {
    if (![_footerView.activityIndicatorView isAnimating]) {
//        DLog(@"加载更多");
        [_footerView.activityIndicatorView startAnimating];
        _reloading = NO;
        [self getMyMessage];
    }
}

- (void)refreshApp:(BOOL)showloading {
    if (!_reloading){
        _reloading = YES;
        self.currentPageIndex = 1;
        [self getMyMessage];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [_headerView egoRefreshScrollViewDidEndDragging:scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_headerView egoRefreshScrollViewDidScroll:scrollView];
    if (showLoadMoreButton)  {
        CGFloat currentOffset = scrollView.contentOffset.y;
        CGFloat maximumOffset = _footerView.frame.origin.y - (scrollView.frame.size.height - _footerView.frame.size.height);
        if (currentOffset >= maximumOffset && ![_footerView.activityIndicatorView isAnimating]) {
            // Load the next 20 records.
            [self showMoreApp:self];
        }
    }
}

#pragma mark EGORefreshTableHeaderDelegate Methods
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view {
    [self refreshApp:NO];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view {
    return _reloading; // should return if data source model is reloading
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view {
    return [NSDate date]; // should return date data source was last changed
}

#pragma mark-TableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CellIdentifier";
    RHMyMessageCell *cell = (RHMyMessageCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"RHMyMessageCell" owner:nil options:nil] objectAtIndex:0];
    }
    NSDictionary *dataDic=[self.dataArray objectAtIndex:indexPath.row];
    [cell updateCell:dataDic];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!tableView.isEditing) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        NSDictionary *dataDic=[self.dataArray objectAtIndex:indexPath.row];
        RHMyMessageDetailViewController *controller = [[RHMyMessageDetailViewController alloc]initWithNibName:@"RHMyMessageDetailViewController" bundle:nil];
        controller.delegate = self;
        controller.ids = [dataDic objectForKey:@"id"];
        controller.titleStr = [dataDic objectForKey:@"title"];
        controller.contentStr = [dataDic objectForKey:@"content"];
        [self.navigationController pushViewController:controller animated:YES];
    } else {
        NSDictionary *addObject = [self.dataArray objectAtIndex:indexPath.row];
        NSString *messageID = [addObject objectForKey:@"id"];
        [readMessages addObject:messageID];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete|UITableViewCellEditingStyleInsert;
}

@end
