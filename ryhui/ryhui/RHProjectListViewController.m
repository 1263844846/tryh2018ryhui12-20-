//
//  RHProjectListViewController.m
//  ryhui
//
//  Created by 江 云龙 on 15/3/17.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHProjectListViewController.h"
#import "RHProjectListContentViewController.h"
#import "RHGesturePasswordViewController.h"
#import "RHALoginViewController.h"
#import "RHRegisterWebViewController.h"
#import "RHInvestmentViewController.h"
#import "DQViewController.h"
#import "RHmainModel.h"
#import "RHZZBuyViewController.h"
#import "RHOpenCountViewController.h"
#import "RHJXPassWordViewController.h"

@interface RHProjectListViewController ()
{
    int currentPage;
}
@property(nonatomic,strong)RHSegmentContentView* segmentContentView;

@property(nonatomic,strong)NSMutableArray* viewControllers;
@property (weak, nonatomic) IBOutlet UILabel *segmentLabel;
@property (weak, nonatomic) IBOutlet UILabel *segmentLabel1;
//
@property (weak, nonatomic) IBOutlet UILabel *segmentLabel3;
@property (weak, nonatomic) IBOutlet UILabel *segmentLabel4;
//
@property (weak, nonatomic) IBOutlet UIView *segmentView1;
@property (weak, nonatomic) IBOutlet UIView *segmentView2;

@property(nonatomic,assign)BOOL * res;
@property (weak, nonatomic) IBOutlet UIView *mengban;
@property (weak, nonatomic) IBOutlet UIView *kaihu;
@property (weak, nonatomic) IBOutlet UIButton *kaihubtn;
@property (weak, nonatomic) IBOutlet UILabel *passwordlab;


@property(nonatomic,copy)NSString * passwordbool;
- (void)didSelectSegmentAtIndex:(int)index;

@end

@implementation RHProjectListViewController
@synthesize segmentContentView=_segmentContentView;
@synthesize viewControllers=_viewControllers;
@synthesize type=_type;

-(void)viewWillAppear:(BOOL)animated{
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    [[DQViewController Sharedbxtabar].tabBar setHidden:YES];
    [[DQViewController Sharedbxtabar].tabBar removeFromSuperview];
    [super viewWillAppear:animated];
    [self.navigationController popViewControllerAnimated:NO];
    [RHmainModel ShareRHmainModel].maintest = @"hehe";
    
    [DQViewController Sharedbxtabar].tarbar.hidden = NO;
//    UIButton*leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,30,20)];
//   // [leftButton setImage:[UIImage imageNamed:@"xiaoxipng.png"]forState:UIControlStateNormal];
//    //[leftButton addTarget:self action:@selector(chongzhi)forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem*leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
//    
//    self.navigationItem.leftBarButtonItem = leftItem;
    RHProjectListContentViewController* controller=[_viewControllers objectAtIndex:0];
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    [self getmyjxpassword];
    [controller startPost];
}
- (void)viewDidLoad {
    [[UIApplication sharedApplication].keyWindow addSubview:self.mengban];
    [[UIApplication sharedApplication].keyWindow addSubview:self.kaihu];
    
    self.mengban.frame = CGRectMake(0, -100, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height+200);
   // self.kaihu.frame = CGRectMake(40, 150, [UIScreen mainScreen].bounds.size.width-80, 206*[UIScreen mainScreen].bounds.size.width/320);
    if ([UIScreen mainScreen].bounds.size.width>376) {
        self.kaihu.frame = CGRectMake(40, CGRectGetMinY(self.kaihu.frame), [UIScreen mainScreen].bounds.size.width-80, 310);
    }else{
        self.kaihu.frame = CGRectMake(40, CGRectGetMinY(self.kaihu.frame), [UIScreen mainScreen].bounds.size.width-80, 245);
    }
    self.kaihu.hidden = YES;
    self.mengban.hidden = YES;
    self.kaihu.layer.masksToBounds=YES;
    self.kaihu.layer.cornerRadius=8;

    _type = @"0";
    [super viewDidLoad];
    self.viewControllers=[[NSMutableArray alloc]initWithCapacity:0];
    self.segmentLabel1.tag = 2020;
    self.segmentLabel4.tag = 2021;
    
   // [self configBackButton];
    [self configTitleWithString:@"项目列表"];
    
    self.segmentContentView = [[RHSegmentContentView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].applicationFrame.size.height-75-40-self.navigationController.navigationBar.frame.size.height-10+35+35+4+5)];
//    DLog(@"%f----%f",[UIScreen mainScreen].applicationFrame.size.height-75-40-self.navigationController.navigationBar.frame.size.height,self.navigationController.navigationBar.frame.size.height);
    [_segmentContentView setDelegate:self];
    [self.view addSubview:_segmentContentView];
    
    RHProjectListContentViewController* controller1=[[RHProjectListContentViewController alloc]init];
    controller1.myblock = ^(NSDictionary *dd){
        [self toubiao:dd];
    };
    controller1.type=@"0";
    controller1.prarentNav=self.navigationController;
//    [controller1.dataArray removeAllObjects];
    [_viewControllers addObject:controller1];
    
    RHProjectListContentViewController* controller2=[[RHProjectListContentViewController alloc]init];
    controller2.myblock = ^(NSDictionary *dd){
        [self toubiao:dd];
    };
    controller2.type=@"1";
    controller2.prarentNav=self.navigationController;
//    [_viewControllers addObject:controller2];
    
//    RHProjectListContentViewController* controller3=[[RHProjectListContentViewController alloc]init];
//    controller3.type=@"2";
//    controller3.prarentNav=self.navigationController;
//    [_viewControllers addObject:controller3];
//    
    [_segmentContentView setViews:_viewControllers];
    
    if ([_type isEqualToString:@"0"]) {
        [self segmentContentView:_segmentContentView selectPage:0];
        
        self.segmentView1.hidden=NO;
        self.segmentView2.hidden=YES;
        [self didSelectSegmentAtIndex:0];
    }else{
        [self segmentContentView:_segmentContentView selectPage:1];
        
        self.segmentView1.hidden=YES;
        self.segmentView2.hidden=NO;
        [self didSelectSegmentAtIndex:1];

    }
    self.segmentLabel.layer.cornerRadius=8;
    self.segmentLabel.layer.masksToBounds=YES;
    self.segmentLabel1.layer.cornerRadius=8;
    self.segmentLabel1.layer.masksToBounds=YES;
    self.segmentLabel3.layer.cornerRadius=8;
    self.segmentLabel3.layer.masksToBounds=YES;
    self.segmentLabel4.layer.cornerRadius=8;
    self.segmentLabel4.layer.masksToBounds=YES;
    self.segmentLabel.hidden=YES;
    self.segmentLabel1.hidden=YES;
    self.segmentLabel3.hidden=YES;
    self.segmentLabel4.hidden=YES;
    [self getSegmentnum1];
    [self getSegmentnum2];
    
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(shuaxin) name:@"666" object:nil];
    
}

- (void)shuaxin{
    
    [self getSegmentnum1];
    [self getSegmentnum2];
    //NSLog(@"--------------------------");
}
#pragma mark-network
-(void)getSegmentnum1
{
    NSDictionary* parameters=@{@"_search":@"true",@"rows":@"1000",@"page":@"1",@"filters":@"{\"groupOp\":\"AND\",\"rules\":[{\"field\":\"percent\",\"op\":\"lt\",\"data\":100}]}"};
    
    [[RHNetworkService instance] POST:@"common/main/shangListData" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        DLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            int num=[[responseObject objectForKey:@"records"] intValue];
            if (num >=0 ) {
                self.segmentLabel.text=[NSString stringWithFormat:@"可投%d",num];
                self.segmentLabel.hidden=NO;
                self.segmentLabel3.text=[NSString stringWithFormat:@"可投%d",num];
                self.segmentLabel3.hidden=NO;
            } else {
                self.segmentLabel.hidden=YES;
                self.segmentLabel3.hidden=YES;
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        DLog(@"%@",error);
    }];
}
-(void)getSegmentnum2
{
    NSDictionary* parameters=@{@"_search":@"true",@"rows":@"1000",@"page":@"1",@"filters":@"{\"groupOp\":\"AND\",\"rules\":[{\"field\":\"percent\",\"op\":\"lt\",\"data\":100}]}"};
    int uu = 1;
    NSLog(@"%d",uu++);
    [[RHNetworkService instance] POST:@"common/main/xueListData" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"----===============-1111---%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            int num=[[responseObject objectForKey:@"records"] intValue];
            if (num>=0) {
                self.segmentLabel1.text=[NSString stringWithFormat:@"可投%d",num];
                self.segmentLabel1.hidden=NO;
                self.segmentLabel4.text=[NSString stringWithFormat:@"可投%d",num];
                self.segmentLabel4.hidden=NO;
            } else {
                self.segmentLabel1.hidden=YES;
                self.segmentLabel4.hidden=YES;
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        DLog(@"%@",error);
    }];
}

- (void)didSelectSegmentAtIndex:(int)index
{
    [self getSegmentnum1];
    [self getSegmentnum2];
    RHProjectListContentViewController* controller=[_viewControllers objectAtIndex:index];
    [controller.tableView setContentOffset:CGPointMake(0,0) animated:YES];
    [_segmentContentView setSelectPage:index];

}

- (void)segmentContentView:(RHSegmentContentView *)segmentContentView selectPage:(NSUInteger)page{
    
    currentPage=[[NSNumber numberWithInteger:page] intValue];
    switch (page) {
        case 0:
            [self segmentAction1:nil];
            break;
        case 1:
            [self segmentAction2:nil];
            break;
        default:
            break;
    }
    [self getSegmentnum1];
    [self getSegmentnum2];
    
    RHProjectListContentViewController* controller=[_viewControllers objectAtIndex:page];
    if ([[NSNumber numberWithInteger:[controller.dataArray count]] intValue]<=0) {
        [controller startPost];
        //[self getSegmentnum1];
        //[self getSegmentnum2];
    }
}


- (IBAction)yearEarnAction:(id)sender {
    //zheli
//    [self getSegmentnum1];
//    [self getSegmentnum2];
    self.res = YES;
    UIButton* button=sender;
    RHProjectListContentViewController* controller=[_viewControllers objectAtIndex:currentPage];
    if (!button.selected) {
        [controller sordListWithSidx:@"" sord:@""];
        button.selected=YES;
    }else{
        [controller sordListWithSidx:@"" sord:@""];
        button.selected=NO;
    }
}

- (IBAction)deadlineAction:(id)sender {
    [self getSegmentnum1];
    [self getSegmentnum2];
    RHProjectListContentViewController* controller=[_viewControllers objectAtIndex:currentPage];
    UIButton* button=sender;
    
    if (!button.selected) {
        [controller sordListWithSidx:@"limitTime" sord:@"desc"];
        button.selected=YES;
    }else{
        [controller sordListWithSidx:@"limitTime" sord:@"asc"];
        button.selected=NO;
    }
}

- (IBAction)totalMoneyAction:(id)sender {
    [self getSegmentnum1];
    [self getSegmentnum2];
    RHProjectListContentViewController* controller=[_viewControllers objectAtIndex:currentPage];
    UIButton* button=sender;
    if (!button.selected) {
        [controller sordListWithSidx:@"projectFund" sord:@"desc"];
        button.selected=YES;
    }else{
        [controller sordListWithSidx:@"projectFund" sord:@"asc"];
        button.selected=NO;
    }
}


- (IBAction)investmentProgressAction:(id)sender {
    [self getSegmentnum1];
    [self getSegmentnum2];
    RHProjectListContentViewController* controller=[_viewControllers objectAtIndex:currentPage];
    UIButton* button=sender;
    if (!button.selected) {
        [controller sordListWithSidx:@"percent" sord:@"desc"];
        button.selected=YES;
    }else{
        [controller sordListWithSidx:@"percent" sord:@"asc"];
        button.selected=NO;
    }
}

- (IBAction)segmentAction1:(id)sender {
    if (self.segmentView1.hidden) {
        self.segmentView1.hidden=NO;
        self.segmentView2.hidden=YES;
        [self didSelectSegmentAtIndex:0];
        RHProjectListContentViewController* controller = _viewControllers[0];
        [controller.dataArray removeAllObjects];
        
        
    }
}

- (IBAction)segmentAction2:(id)sender {
    //11111
    return;
    if (self.segmentView2.hidden) {
        self.segmentView2.hidden=NO;
        self.segmentView1.hidden=YES;
        [self didSelectSegmentAtIndex:1];
        RHProjectListContentViewController* controller = _viewControllers[1];
        [controller.dataArray removeAllObjects];
    }
}

- (IBAction)pushMain:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)pushUser:(id)sender {
    [[[RHTabbarManager sharedInterface] selectTabbarUser] popToRootViewControllerAnimated:NO];
}

- (IBAction)pushMore:(id)sender {
    [[[RHTabbarManager sharedInterface] selectTabbarMore] popToRootViewControllerAnimated:NO];
}

- (IBAction)test:(id)sender {
    
    RHGesturePasswordViewController* VC=[[RHGesturePasswordViewController alloc]init];
    //controller.isForgotV=self.isForgotV;
    [self.navigationController pushViewController:VC animated:NO];
}

- (void)toubiao:(NSDictionary *)dic{
    //NSLog(@"----------");
    // NSString* session=[[NSUserDefaults standardUserDefaults] objectForKey:@"RHSESSION"];
    
  
   /* RHJXPassWordViewController * controller =[[RHJXPassWordViewController alloc]initWithNibName:@"RHJXPassWordViewController" bundle:nil];
    
    controller.urlstr = @"app/front/payment/appJxAccount/passwordSetJxData";
    [self.navigationController pushViewController:controller animated:YES];
    [DQViewController Sharedbxtabar].tarbar.hidden = YES;
    return;
  */
    if (![RHUserManager sharedInterface].username) {
        //        [self.investmentButton setTitle:@"请先登录" forState:UIControlStateNormal];
        [DQViewController Sharedbxtabar].tarbar.hidden = YES;
        NSLog(@"ddddddd");
        RHALoginViewController* controller=[[RHALoginViewController alloc] initWithNibName:@"RHALoginViewController" bundle:nil];
        [self.navigationController pushViewController:controller animated:YES];
    }else{
        if (![RHUserManager sharedInterface].custId) {
            //            [self.investmentButton setTitle:@"请先开户" forState:UIControlStateNormal];
            NSLog(@"kkkkkkk");
            self.mengban.hidden = NO;
            self.kaihu.hidden = NO;
            
            return;
            [DQViewController Sharedbxtabar].tarbar.hidden = YES;
            RHRegisterWebViewController* controller1=[[RHRegisterWebViewController alloc]initWithNibName:@"RHRegisterWebViewController" bundle:nil];
            [self.navigationController pushViewController:controller1 animated:YES];
        }else{
            if (![self.passwordbool isEqualToString:@"yes"]) {
                
                 [self.kaihubtn setTitle:@"设置交易密码" forState:UIControlStateNormal];
               self.passwordlab.text = @"资金更安全，请先设置交易密码在进行投资／提现";
                self.mengban.hidden = NO;
                self.kaihu.hidden = NO;
            }else{
            
            if (currentPage ==0) {
                //wb1083852544
            
            RHInvestmentViewController* contoller=[[RHInvestmentViewController alloc]initWithNibName:@"RHInvestmentViewController" bundle:nil];
            NSString * str = dic[@"available"];
            int a = [str intValue];
            contoller.projectFund= a;
            contoller.dataDic=dic;
            //            if (self.panduan == 10) {
            // contoller.panduan = 10;
            //            }
            NSString * str1 =  dic[@"investorRate"];
            //contoller.lilv =str1;
            [self.navigationController pushViewController:contoller animated:YES];
            }else{
                RHZZBuyViewController* contoller=[[RHZZBuyViewController alloc]initWithNibName:@"RHZZBuyViewController" bundle:nil];
                NSString * str = dic[@"available"];
                int a = [str intValue];
                contoller.projectFund= a;
                contoller.dataDic=dic;
                //            if (self.panduan == 10) {
                // contoller.panduan = 10;
                //            }
                NSString * str1 =  dic[@"investorRate"];
                //contoller.lilv =str1;
                [self.navigationController pushViewController:contoller animated:YES];
            }
            }
        }
    }
    
    
    
    
}

- (IBAction)hidenmengban:(id)sender {
    
    self.kaihu.hidden = YES;
    self.mengban.hidden = YES;
}
- (IBAction)kaihu:(id)sender {
    self.kaihu.hidden = YES;
    self.mengban.hidden = YES;
    [DQViewController Sharedbxtabar].tarbar.hidden = YES;
    
    if ([self.kaihubtn.titleLabel.text isEqualToString:@"设置交易密码"]) {
        
        RHJXPassWordViewController * controller =[[RHJXPassWordViewController alloc]initWithNibName:@"RHJXPassWordViewController" bundle:nil];
        
        controller.urlstr = @"app/front/payment/appJxAccount/passwordSetJxData";
        [self.navigationController pushViewController:controller animated:YES];
        return;
    }
    
    RHOpenCountViewController* controller1=[[RHOpenCountViewController alloc]initWithNibName:@"RHOpenCountViewController" bundle:nil];
    [self.navigationController pushViewController:controller1 animated:YES];
}

-(void)getmyjxpassword{
    
    [[RHNetworkService instance] POST:@"app/front/payment/appJxAccount/isSetPassword" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"----===============-1111---%@",responseObject);
        self.passwordbool = [NSString stringWithFormat:@"%@",responseObject[@"setPwd"]];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
        DLog(@"%@",[[NSString alloc] initWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
        
    }];
    
}
@end
