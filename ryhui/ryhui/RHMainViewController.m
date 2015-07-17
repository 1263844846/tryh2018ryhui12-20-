//
//  RHMainViewController.m
//  ryhui
//
//  Created by stefan on 15/2/28.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHMainViewController.h"
#import "RHMainViewCell.h"
#import "RHProjectDetailViewController.h"
#import "RHProjectListViewController.h"
#import "RHOfficeNetAndWeiBoViewController.h"
#import "RHLogoViewController.h"
@interface RHMainViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *bannerImageView; //banner图片
@property (nonatomic, strong) NSArray *bannersArray;//banner集合
@property (strong, nonatomic) IBOutlet UIView *footView;
@property (strong, nonatomic) IBOutlet UIView *tbHeaderView;
@property (weak, nonatomic) IBOutlet UIScrollView *headerScrollView;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSMutableArray* segment1Array;
@property (nonatomic,strong)NSMutableArray* segment2Array;
@property (nonatomic,strong)NSMutableArray* dataArray;
@property (nonatomic,strong)RHSegmentView* segmentView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (nonatomic,strong)NSString* type;

@end

@implementation RHMainViewController
@synthesize segment1Array;
@synthesize segment2Array;
@synthesize dataArray;
@synthesize segmentView;
@synthesize type;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configTitleWithString:@"融益汇"];
    _bannersArray = [[NSArray alloc] init];
    
    self.segmentView=[[[NSBundle mainBundle] loadNibNamed:@"RHSegmentView" owner:nil options:nil] objectAtIndex:0];
    segmentView.delegate=self;
    segmentView.frame=CGRectMake(segmentView.frame.origin.x, 115, segmentView.frame.size.width, segmentView.frame.size.height);
    [segmentView initData];
    [self.headerView addSubview:segmentView];
    
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor=[UIColor clearColor];
    self.tableView.frame=CGRectMake(0, 148, [UIScreen mainScreen].applicationFrame.size.width, [UIScreen mainScreen].applicationFrame.size.height-self.navigationController.navigationBar.frame.size.height-40-148);
    self.tableView.tableHeaderView=self.tbHeaderView;
    
    self.segment1Array=[[NSMutableArray alloc]initWithCapacity:0];
    self.segment2Array=[[NSMutableArray alloc]initWithCapacity:0];
    self.dataArray=[[NSMutableArray alloc]initWithCapacity:0];
    self.segmentView.segmentLabel.layer.cornerRadius=8;
    self.segmentView.segmentLabel.layer.masksToBounds=YES;
    self.segmentView.segmentLabel1.layer.cornerRadius=8;
    self.segmentView.segmentLabel1.layer.masksToBounds=YES;
    self.segmentView.segmentLabel3.layer.cornerRadius=8;
    self.segmentView.segmentLabel3.layer.masksToBounds=YES;
    self.segmentView.segmentLabel4.layer.cornerRadius=8;
    self.segmentView.segmentLabel4.layer.masksToBounds=YES;
    self.segmentView.segmentLabel.hidden=YES;
    self.segmentView.segmentLabel1.hidden=YES;
    self.segmentView.segmentLabel3.hidden=YES;
    self.segmentView.segmentLabel4.hidden=YES;
    
    self.tableView.tableFooterView=self.footView;
    
  
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refeshMainViewDataWithState:) name:UIApplicationWillEnterForegroundNotification object:nil];
    
    [self getAppBanner];
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"AppUpdate"]) {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"AppUpdate"];
        //获取本地软件的版本号
        NSString *localVersion = [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        [self onCheckVersion:localVersion];
    }
}

- (void)onCheckVersion:(NSString *)currentVersion {
    NSURL *url = [NSURL URLWithString:@"http://itunes.apple.com/lookup?id=977505438"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    [request setTimeoutInterval:10.0];
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
        } else {
            NSError* jasonErr = nil;
            // jason 解析
            NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jasonErr];
            if (responseDict && [responseDict objectForKey:@"results"]) {
                NSDictionary* results = [[responseDict objectForKey:@"results"] objectAtIndex:0];;
                if (results) {
                    CGFloat  fVeFromNet = [[results objectForKey:@"version"] floatValue];
                    NSLog(@"========%f",fVeFromNet);
                    NSString *strVerUrl = [results objectForKey:@"trackViewUrl"];
                    if (0 < fVeFromNet && strVerUrl) {
                        CGFloat fCurVer = [currentVersion floatValue];
                         NSLog(@"========%f",fCurVer);
                        if (fCurVer < fVeFromNet) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""message:@"发现新版本，立即去更新吧！" delegate:self cancelButtonTitle:@"立即更新" otherButtonTitles:@"稍后提醒", nil];
                                [alert show];
                            });
                        }
                    }
                }
            }
        }
    }];
}

//响应升级提示按钮
- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    //如果选择“现在升级”
    if (buttonIndex == 0){
        //打开iTunes  方法一
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/rong-yi-hui/id977505438?mt=8"]];
    }
}

- (void)getAppBanner {
    [[RHNetworkService instance] POST:@"common/main/appBannerList" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        _bannersArray = responseObject;
        [self setBannersImageView];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [_bannerImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"NewBanner.png"]];
    }];
}

- (void)setBannersImageView {
    if (_bannersArray.count > 0) {
         [_bannerImageView removeFromSuperview];
        for (int i = 0 ; i < _bannersArray.count; i ++) {
            UIImageView *bannerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * CGRectGetWidth([UIScreen mainScreen].bounds), 0,  CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight(_headerScrollView.frame))];
            bannerImageView.userInteractionEnabled = YES;
            bannerImageView.tag = i + 100;
            NSDictionary *dic = _bannersArray[i];
            RHNetworkService *netService = [RHNetworkService instance];
            NSString *urlString = [NSString stringWithFormat:@"%@%@%@",[netService doMain],@"common/main/attachment/",dic[@"bg"]];
            [bannerImageView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"NewBanner.png"]];
            [_headerScrollView addSubview:bannerImageView];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goForBannerDetailViewController:)];
            [bannerImageView addGestureRecognizer:tap];
        }
        _headerScrollView.contentSize = CGSizeMake(_bannersArray.count * CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight(_headerScrollView.frame));
    }else{
        [_bannerImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"NewBanner.png"]];
    }
}

- (void)goForBannerDetailViewController:(UITapGestureRecognizer *)tap {
    UIView *tapView = tap.view;
    NSDictionary *dic = _bannersArray[tapView.tag - 100];
    NSString *linkURl = dic[@"link"];
    NSString *logoUrl = dic[@"logo"];
    NSString *naviTitle = dic[@"title"];
    if (linkURl.length > 0) {
        RHOfficeNetAndWeiBoViewController *office = [[RHOfficeNetAndWeiBoViewController alloc] initWithNibName:@"RHOfficeNetAndWeiBoViewController" bundle:nil];
        office.NavigationTitle = naviTitle;
        office.Type = 3;
        if (([linkURl rangeOfString:@"http://"].location == NSNotFound) || ([linkURl rangeOfString:@"https://"].location == NSNotFound)) {
            office.urlString = [NSString stringWithFormat:@"http://%@",linkURl];
        }else{
            office.urlString = linkURl;
        }
        [self.navigationController pushViewController:office animated:YES];
    }else if (logoUrl.length > 0 ) {
        RHLogoViewController *logo = [[RHLogoViewController alloc] initWithNibName:@"RHLogoViewController" bundle:nil];
        logo.logoRrl = [NSString stringWithFormat:@"%@%@%@",[[RHNetworkService instance] doMain],@"common/main/attachment/",logoUrl];
        logo.navigationTitle = naviTitle;
        [self.navigationController pushViewController:logo animated:YES];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self refeshMainViewDataWithState:0];
    
    [[RHNetworkService instance] POST:@"front/payment/account/countUnReadMessage" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        DLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSString* numStr=nil;
            if (![[responseObject objectForKey:@"msgCount"] isKindOfClass:[NSNull class]]) {
                if ([[responseObject objectForKey:@"msgCount"] isKindOfClass:[NSNumber class]]) {
                    numStr=[[responseObject objectForKey:@"msgCount"] stringValue];
                }else{
                    numStr=[responseObject objectForKey:@"msgCount"];
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

- (void)refeshMainViewDataWithState:(int) state {
    if (state == 0) {
        //刷新全部数据
        [self.segment1Array removeAllObjects];
        [self.segment2Array removeAllObjects];
    } else if (state == 1){
        //刷新商业贷数据
        [self.segment1Array removeAllObjects];
    } else {
        //刷新就业贷数据
        [self.segment2Array removeAllObjects];
    }
    [self segment1Post];
    [self segment2Post];
    [self getSegmentnum1];
    [self getSegmentnum2];
}

#pragma mark-network
- (void)getSegmentnum1 {
    NSDictionary* parameters=@{@"_search":@"true",@"rows":@"1000",@"page":@"1",@"filters":@"{\"groupOp\":\"AND\",\"rules\":[{\"field\":\"percent\",\"op\":\"lt\",\"data\":100}]}"};
    [[RHNetworkService instance] POST:@"common/main/shangListData" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            int num=[[responseObject objectForKey:@"records"] intValue];
            if (num>0) {
                self.segmentView.segmentLabel.text=[NSString stringWithFormat:@"可投%d",num];
                self.segmentView.segmentLabel.hidden=NO;
                self.segmentView.segmentLabel3.text=[NSString stringWithFormat:@"可投%d",num];
                self.segmentView.segmentLabel3.hidden=NO;
            } else {
                self.segmentView.segmentLabel.hidden = YES;
                self.segmentView.segmentLabel3.hidden = YES;
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
}

- (void)getSegmentnum2 {
    NSDictionary* parameters=@{@"_search":@"true",@"rows":@"1000",@"page":@"1",@"filters":@"{\"groupOp\":\"AND\",\"rules\":[{\"field\":\"percent\",\"op\":\"lt\",\"data\":100}]}"};
    [[RHNetworkService instance] POST:@"common/main/xueListData" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            int num=[[responseObject objectForKey:@"records"] intValue];
            if (num>0) {
                self.segmentView.segmentLabel1.text=[NSString stringWithFormat:@"可投%d",num];
                self.segmentView.segmentLabel1.hidden=NO;
                self.segmentView.segmentLabel4.text=[NSString stringWithFormat:@"可投%d",num];
                self.segmentView.segmentLabel4.hidden=NO;
            } else {
                self.segmentView.segmentLabel1.hidden = YES;
                self.segmentView.segmentLabel4.hidden = YES;
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
}

- (void)segment1Post {
    int arrayCount=[[NSNumber numberWithInteger:[segment1Array count]] intValue];
    NSString* page=[[NSNumber numberWithInt:(arrayCount/10+1)] stringValue];
    NSDictionary* parameters=@{@"_search":@"true",@"rows":@"10",@"page":page,@"sidx":@"",@"sord":@"",@"filters":@"{\"groupOp\":\"AND\",\"rules\":[]}"};
    [[RHNetworkService instance] POST:@"common/main/shangListData" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        DLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSArray* array=[responseObject objectForKey:@"rows"];
            if ([array isKindOfClass:[NSArray class]]) {
                for (NSDictionary* dic in array) {
                    if ([dic objectForKey:@"cell"]&&!([[dic objectForKey:@"cell"] isKindOfClass:[NSNull class]])) {
                        [self.segment1Array addObject:[dic objectForKey:@"cell"]];
                    }
                }
            }
            NSString* records=[responseObject objectForKey:@"records"];
            if (records&&[records intValue]<10) {
                //已经到底了
            }
            if ([type isEqualToString:@"0"]) {
                [self.dataArray removeAllObjects];
                [self.dataArray addObjectsFromArray:self.segment1Array];
                [self.tableView reloadData];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [RHUtility showTextWithText:@"请求失败"];
    }];
}

- (void)segment2Post {
    int arrayCount=[[NSNumber numberWithInteger:[segment2Array count]] intValue];
    NSString* page=[[NSNumber numberWithInt:(arrayCount/10+1)] stringValue];
    NSDictionary* parameters=@{@"_search":@"true",@"rows":@"10",@"page":page,@"sidx":@"",@"sord":@"",@"filters":@"{\"groupOp\":\"AND\",\"rules\":[]}"};
    [[RHNetworkService instance] POST:@"common/main/xueListData" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        DLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSArray* array=[responseObject objectForKey:@"rows"];
            if ([array isKindOfClass:[NSArray class]]) {
                for (NSDictionary* dic in array) {
                    if ([dic objectForKey:@"cell"]&&!([[dic objectForKey:@"cell"] isKindOfClass:[NSNull class]])) {
                        [self.segment2Array addObject:[dic objectForKey:@"cell"]];
                    }
                }
            }
            NSString* records=[responseObject objectForKey:@"records"];
            if (records&&[records intValue]<10) {
                //已经到底了
            }
            if ([type isEqualToString:@"1"]) {
                [self.dataArray removeAllObjects];
                [self.dataArray addObjectsFromArray:self.segment2Array];
                [self.tableView reloadData];
            }
         }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [RHUtility showTextWithText:@"请求失败"];
    }];
}

#pragma mark-RHSegmentDelegate
- (void)didSelectSegmentAtIndex:(int)index {
    self.type=[NSString stringWithFormat:@"%d",index];
    switch (index) {
        case 0:
            self.contentLabel.text=@"       借款方为经营良好的中小微企业及个体工商户。为保障投资人权益，融益汇通过评级严格筛选合作机构。所有借款项目均由合作机构评审后推荐，并经融益汇多轮再评审后发布。所有项目均由合作机构提供全额本息担保。";
            [self refeshMainViewDataWithState:1];
            break;
        case 1:
            self.contentLabel.text=@"       借款方为接受就业培训的在读学生，贷款用于支付就业培训费用。培训机构承诺为学生就业提供保障，并承担未就业学生的全部还款本息；同时融益汇从每笔就业贷款的服务费中提取一定比例的资金作为就业贷专项风险保障金以备代偿。通过就业担保和风险保障金双重本息保障机制为您的投资保驾护航。";
            [self refeshMainViewDataWithState:2];
            break;
        default:
            break;
    }
    [self.tableView setContentOffset:CGPointMake(0,0) animated:YES];
}

- (void)didSelectInvestment {
    RHProjectListViewController* controller=[[RHProjectListViewController alloc]initWithNibName:@"RHProjectListViewController" bundle:nil];
    controller.type=self.type;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark-TableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 108;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (dataArray.count>4) {
        return 4;
    }
    return dataArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CellIdentifier";
    RHMainViewCell *cell = (RHMainViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"RHMainViewCell" owner:nil options:nil] objectAtIndex:0];
    }
    NSDictionary* dataDic=[self.dataArray objectAtIndex:indexPath.row];
    [cell updateCell:dataDic];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RHProjectDetailViewController* controller=[[RHProjectDetailViewController alloc]initWithNibName:@"RHProjectDetailViewController" bundle:nil];
    NSDictionary* dataDic=[self.dataArray objectAtIndex:indexPath.row];
    controller.dataDic=dataDic;
    controller.getType=type;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark-Push
- (IBAction)pushUserCenter:(id)sender {
    [[[RHTabbarManager sharedInterface] selectTabbarUser] popToRootViewControllerAnimated:NO];
}

- (IBAction)pushMore:(id)sender {
    [[[RHTabbarManager sharedInterface] selectTabbarMore] popToRootViewControllerAnimated:NO];
}

- (IBAction)pushProjectList:(id)sender {
    [self didSelectInvestment];
}

- (void)viewWillDisappear:(BOOL)animated {
    for (UIView *subView in [UIApplication sharedApplication].keyWindow.subviews) {
        if (subView.tag == 1000) {
            [subView removeFromSuperview];
        }
    }
    [super viewWillDisappear:animated];
}

@end
