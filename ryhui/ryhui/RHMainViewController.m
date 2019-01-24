//
//  RHMainViewController.m
//  ryhui
//
//  Created by stefan on 15/2/28.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHMainViewController.h"
#import "RHMainViewCell.h"
//#import "RHProjectDetailViewController.h"
#import "RHProjectListViewController.h"
#import "RHOfficeNetAndWeiBoViewController.h"
#import "RHLogoViewController.h"
#import "XMyScrollView.h"
#import "CycleScrollView.h"
#import "NSTimer+Addition.h"
//#import "RYHViewController.h"
#import "MBProgressHUD.h"
#import "RHmainModel.h"
#import "PageView.h"
#import "PagedFlowView.h"
#import "UIColor+ZXLazy.h"
#import "RHNewMainCell.h"
//#import "RHProjectDetailViewController.h"
#import "RHALoginViewController.h"
#import "RHRegisterWebViewController.h"
//#import "RHProjectdetailtwoViewController.h"
#import "RYHViewController.h"
#import "RHProjectdetailthreeViewController.h"
#import "RHfourtestViewController.h"
#import "RHMainTableViewCell.h"
#import "RYHView.h"
#import "RHInvestmentViewController.h"
#import "RHNEWpeopleViewController.h"
#import <SobotKit/SobotKit.h>
#import <SobotKit/ZCUIChatController.h>
#import "AppDelegate.h"
#import "RHRNewShareWebViewController.h"
#import "RHMainTableViewCell.h"
#import "RHOpenCountViewController.h"
#import "RHJXPassWordViewController.h"
#import "RHhelper.h"
#import "RHHFJXViewController.h"
#import "RHHFjiaochengViewController.h"
#import "RHDBSJViewController.h"
#import "RHXMJTableViewCell.h"
#import "RHXMJWebViewController.h"
#import "RHXMJProjectViewController.h"
#import "RHProjectCollectionViewCell.h"

@interface RHMainViewController ()<XmyScrollViewDatasource,XmyScrollViewDelegate,PageViewDelegate,MBProgressHUDDelegate,PagedFlowViewDataSource,PagedFlowViewDelegate,UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSArray *imageArray;
    NSArray * titleArray;
    NSArray * baozhengArray;
}
@property (weak, nonatomic) IBOutlet UIView *navgationrightView;
@property (weak, nonatomic) IBOutlet UILabel *gonggaolab;

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
@property(nonatomic,strong)UIActivityIndicatorView *act;

@property(nonatomic,strong)XMyScrollView* mySCrorllView;

@property (nonatomic , retain) CycleScrollView *mainScorllView;
@property (nonatomic, strong) NSMutableArray *bannerViewsArray;
@property (nonatomic, strong) MBProgressHUD *progressBox;
@property(nonatomic,assign)int shangye;
@property(nonatomic,assign)int zhuxue;
@property(nonatomic,assign)int shouyepanduan;
@property(nonatomic,assign)int shouyepanduan1;

@property(nonatomic,strong)NSMutableArray * didbannerarray;
@property(nonatomic,strong)NSMutableArray * webtitlearray;
@property(nonatomic,strong)NSMutableArray * bannertitleArray;
@property(nonatomic,strong)NSMutableArray * bannerlogoArray;
@property(nonatomic,strong)NSMutableArray * ShareArray;


@property(nonatomic,strong)PagedFlowView * RHcbxview;

@property(nonatomic,strong)UILabel * rhcdbxlab;
@property(nonatomic,retain)UIScrollView *scrview;


@property(nonatomic ,strong)UILabel * rhbxblab;

@property(nonatomic,assign)int bx;

@property(nonatomic,strong)NSDictionary * newdic;
@property (weak, nonatomic) IBOutlet UILabel *gonggao2;
@property (weak, nonatomic) IBOutlet UILabel *gonggao3;

@property (weak, nonatomic) IBOutlet UILabel *gonggao4;
@property (weak, nonatomic) IBOutlet UILabel *gonggao5;


@property(nonatomic,assign)BOOL newpeoplebool;
@property (weak, nonatomic) IBOutlet UIButton *footbutton;
@property(nonatomic,assign)BOOL newpeopleress;

@property (weak, nonatomic) IBOutlet UIView *mengbanview;

@property (weak, nonatomic) IBOutlet UIView *kaihuview;
//渐变公告
@property (weak, nonatomic) IBOutlet UIView *newsView;
@property (weak, nonatomic) IBOutlet UILabel *newslab;
@property (weak, nonatomic) IBOutlet UIButton *newsdatabtn;
@property(nonatomic,copy)NSString * gonggaourlstr;
@property(nonatomic,copy)NSString *moreurlstr;
// 透明度使用
@property(nonatomic,assign)CGFloat a;
@property(nonatomic,assign)int key;
@property(nonatomic,strong)NSMutableArray* keyarr;
//collectionview数组
@property(nonatomic,strong)NSMutableArray* collectionArr;
//底部投资人累积
@property (weak, nonatomic) IBOutlet UILabel *leijimoney;
@property (weak, nonatomic) IBOutlet UILabel *yizhuanmoney;

@property(nonatomic,strong)NSTimer * timers;

//导航蓝
@property(nonatomic,strong)UIButton * leftbutton;
@property(nonatomic,strong)UIButton * rightbutton;
@property (weak, nonatomic) IBOutlet UILabel *publicktimelab;

@property(nonatomic,copy)NSString * webtitle;

@property (weak, nonatomic) IBOutlet UILabel *bankpdlab;
@property(nonatomic,copy)NSString *passwordbool;

@property (weak, nonatomic) IBOutlet UIButton *kaihubtn;


@property (weak, nonatomic) IBOutlet UIView *zhuanyiview;


@property (weak, nonatomic) IBOutlet UILabel *hfzylab;
@property (weak, nonatomic) IBOutlet UIButton *hfzybtn;
@property (weak, nonatomic) IBOutlet UIButton *guanbihfbtn;

@property (weak, nonatomic) IBOutlet UIView *mengban2;

@property(nonatomic,strong)UIView *mengbanview2;
@property(nonatomic,copy)NSString *dbsxstr;


@property (weak, nonatomic) IBOutlet UIView *ryhnewsview;

@property (weak, nonatomic) IBOutlet UIImageView *ryhimage;


@property(nonatomic,copy)NSString *  ryhnewslink;
@property(nonatomic,copy)NSString *  ryhnewstitle;
@property(nonatomic,strong)NSArray *xmjarray;
@property (weak, nonatomic) IBOutlet UIView *newscollectionview;


@property (weak, nonatomic) IBOutlet UICollectionView *mycollection;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *colleclayout;
@property (weak, nonatomic) IBOutlet UIImageView *collectionimage;

@property(nonatomic,copy)NSString * projectLocal;

@end

@implementation RHMainViewController
@synthesize segment1Array;
@synthesize segment2Array;
@synthesize dataArray;
@synthesize segmentView;
@synthesize type;
- (IBAction)ryhpushnewslink:(id)sender {
    self.ryhnewsview.hidden = YES;
    self.mengbanview.hidden = YES;
    RHOfficeNetAndWeiBoViewController *office = [[RHOfficeNetAndWeiBoViewController alloc] initWithNibName:@"RHOfficeNetAndWeiBoViewController" bundle:nil];
    
    office.urlString = self.ryhnewslink;
    office.NavigationTitle = self.ryhnewstitle;
    [self doneryhnews:nil];
    [self.navigationController pushViewController:office animated:NO];
    
}

- (IBAction)doneryhnews:(id)sender {
    
    self.ryhnewsview.hidden = YES;
    self.mengbanview.hidden = YES;
    NSString *deviceUUID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
     NSDictionary* parameters=@{@"equipmentCode":deviceUUID};
    [[RHNetworkService instance] POST:@"app/front/payment/appJxAccount/updateBannerRecord" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSLog(@"%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
    }];
}

-(void)huoquryhnews{
    
    
    NSString *deviceUUID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSDictionary* parameters=@{@"equipmentCode":deviceUUID};
    [[RHNetworkService instance] POST:@"app/front/payment/appJxAccount/isPopUp" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            
            if (responseObject[@"popUp"]&&![responseObject[@"popUp"] isKindOfClass:[NSNull class]]) {
                if ([responseObject[@"popUp"] isEqualToString:@"yes"]) {
                    self.ryhnewsview.hidden = NO;
                    self.mengbanview.hidden = NO;
                    if (responseObject[@"logo"]&&![responseObject[@"logo"] isKindOfClass:[NSNull class]]) {
                       [self.ryhimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@common/main/attachment/%@",[RHNetworkService instance].newdoMain,responseObject[@"logo"]]]];
                    }
                    if (responseObject[@"link"]&&![responseObject[@"link"] isKindOfClass:[NSNull class]]) {
                        
                        self.ryhnewslink = responseObject[@"link"];
                    }
                    if (responseObject[@"title"]&&![responseObject[@"title"] isKindOfClass:[NSNull class]]) {
                        
                        self.ryhnewstitle = responseObject[@"title"];
                    }
                    
                }
            }
            
        }
        
        NSLog(@"%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
    }];
}

-(void)stzfpush{
    
    [[RHNetworkService instance] POST:@"front/payment/account/trusteePayAlter" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSString * str = [NSString stringWithFormat:@"%@",responseObject[@"flag"]];
            
            self.dbsxstr = str;
            [RHhelper ShraeHelp].dbsxstr = str;
            
        }
        
        NSLog(@"%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
    }];
    
}
-(void)xmjswitch{
    
    [[RHNetworkService instance] POST:@"app/common/appMain/projectListSwitch" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSString * str = [NSString stringWithFormat:@"%@",responseObject[@"projectListSwitch"]];
            
            
            [RHhelper ShraeHelp].xmjswitch = str;
            [self.tableView reloadData];
        }
        
        NSLog(@"%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
    }];
    
}
-(void)xmjdata{
    
    [[RHNetworkService instance] POST:@"app/common/appMain/getProjectListInfo" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
//            NSString * str = [NSString stringWithFormat:@"%@",responseObject[@"projectListSwitch"]];
//
//
//            [RHhelper ShraeHelp].xmjswitch = str;
//            [self.tableView reloadData];
            
            if (responseObject[@"timeLimit"]&&![responseObject[@"timeLimit"] isKindOfClass:[NSNull class]]) {
                
                
                [RHhelper ShraeHelp].xmjmouth = responseObject[@"timeLimit"];
                
            }
            if (responseObject[@"link"]&&![responseObject[@"link"] isKindOfClass:[NSNull class]]) {
                
                
                [RHhelper ShraeHelp].xmjlink = responseObject[@"link"];
                
            }
            if (responseObject[@"rate"]&&![responseObject[@"rate"] isKindOfClass:[NSNull class]]) {
                
                
                [RHhelper ShraeHelp].xmjlilv = responseObject[@"rate"];
                
            }
            [self.tableView reloadData];
        }
        
        NSLog(@"%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
    }];
    
}
-(void)pushxmj{
    if (![RHUserManager sharedInterface].username) {
        //        [self.investmentButton setTitle:@"请先登录" forState:UIControlStateNormal];
        [RYHViewController Sharedbxtabar].tarbar.hidden = YES;
        NSLog(@"ddddddd");
        RHALoginViewController* controller=[[RHALoginViewController alloc] initWithNibName:@"RHALoginViewController" bundle:nil];
        [self.navigationController pushViewController:controller animated:NO];
        return;
    }
    
     [RYHViewController Sharedbxtabar].tarbar.hidden = YES;
    RHXMJWebViewController *office = [[RHXMJWebViewController alloc] initWithNibName:@"RHXMJWebViewController" bundle:nil];
    office.nametitle = @"项目集";
    office.xmjurl = [NSString stringWithFormat:@"%@%@",[RHNetworkService instance].newdoMain,[RHhelper ShraeHelp].xmjlink];
    [self.navigationController pushViewController:office animated:NO];
}

- (IBAction)hidenmengban:(id)sender {
    self.mengbanview.hidden = YES;
    self.kaihuview.hidden = YES;
    self.navigationController.navigationBar.subviews.firstObject.alpha = 0;
}
- (IBAction)hfkaihu:(id)sender {
    self.mengbanview.hidden = YES;
    self.kaihuview.hidden = YES;
    [RYHViewController Sharedbxtabar].tarbar.hidden = YES;
//    RHRegisterWebViewController* controller1=[[RHRegisterWebViewController alloc]initWithNibName:@"RHRegisterWebViewController" bundle:nil];
//    [self.navigationController pushViewController:controller1 animated:YES];
    if ([self.kaihubtn.titleLabel.text isEqualToString:@"设置交易密码"]) {
        
        RHJXPassWordViewController * controller =[[RHJXPassWordViewController alloc]initWithNibName:@"RHJXPassWordViewController" bundle:nil];
        
        controller.urlstr = @"app/front/payment/appJxAccount/passwordSetJxData";
        [self.navigationController pushViewController:controller animated:NO];
        return;
    }
    RHOpenCountViewController* controller1=[[RHOpenCountViewController alloc]initWithNibName:@"RHOpenCountViewController" bundle:nil];
    [self.navigationController pushViewController:controller1 animated:NO];
}
- (IBAction)guanbihftishi:(id)sender {
    
    [self seeetalterview];
    
}
-(void)gethuifuyuemoth{
    if ([RHUserManager sharedInterface].username.length<2) {
        return;
    }
    
    NSDictionary* parameters=@{@"username":[RHUserManager sharedInterface].username};
    
  //  self.view.userInteractionEnabled = NO;
    [[RHNetworkService instance] POST:@"app/front/payment/appAccount/instantHuifu" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
     //   self.view.userInteractionEnabled = YES;
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            if (responseObject[@"msg"]&&![responseObject[@"msg"] isKindOfClass:[NSNull class]]) {
                [RHhelper ShraeHelp].numstr = [NSString stringWithFormat:@"%@",responseObject[@"msg"]];
                
            }
            if (responseObject[@"money"]&&![responseObject[@"money"] isKindOfClass:[NSNull class]]) {
                [RHhelper ShraeHelp].moneystr = [NSString stringWithFormat:@"%@",responseObject[@"money"]];
                
            }else{
                
                [RHhelper ShraeHelp].moneystr = @"0";
            }
            if (responseObject[@"flag"]&&![responseObject[@"flag"] isKindOfClass:[NSNull class]]) {
                [RHhelper ShraeHelp].flag = [NSString stringWithFormat:@"%@",responseObject[@"flag"]];
                
            }
        }
        //        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSLog(@"%@---",responseObject);
        
        [self huifumoth];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
       // self.view.userInteractionEnabled = YES;
        
        
    }];
}
-(void)gonggao{
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
//    [manager.operationQueue cancelAllOperations];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
     manager.securityPolicy = [[RHNetworkService instance] customSecurityPolicy];
    [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    [manager POST:[NSString stringWithFormat:@"%@app/common/appMain/putAnnouncement",[RHNetworkService instance].newdoMain ] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
       NSString* restult=[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
//        self.gonggaolab.text = dic[@"1"];
//        self.gonggao2.text = dic[@"2"];
//        self.gonggao3.text = dic[@"3"];
//        self.gonggao4.text = dic[@"4"];
//        self.gonggao5.text  =dic[@"5"];
        
        for (int i = 1; i <dic.count +1; i++) {
            
            UILabel * lab = [[UILabel alloc]init];
            lab.frame = CGRectMake(10,i*25+20,self.navgationrightView.frame.size.width-20  , 25);
            lab.font = [UIFont systemFontOfSize:14];
            NSString * str = [NSString stringWithFormat:@"%d",i];
            
            lab.text = dic[str];
            
            [self.navgationrightView addSubview:lab];
        }
        
        NSLog(@"%@",dic[@"1"]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        NSLog(@"%@",error);
    }];
    
        self.navgationrightView.hidden = NO;
     [[UIApplication sharedApplication].keyWindow addSubview:self.mengbanview];
     [[UIApplication sharedApplication].keyWindow addSubview:self.navgationrightView];
    self.mengbanview.hidden = NO;

}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"透明矩.png"] forBarMetrics:UIBarMetricsDefault];
    
    CGFloat minAlphaOffset = - 20;
    CGFloat maxAlphaOffset = 150;
    CGFloat offset = scrollView.contentOffset.y;
    CGFloat alpha = (offset - minAlphaOffset) / (maxAlphaOffset - minAlphaOffset);
    self.navigationController.navigationBar.subviews.firstObject.alpha = alpha;
     NSString *version = [UIDevice currentDevice].systemVersion;
    if ([version doubleValue]>=11) {
    dispatch_async(dispatch_get_main_queue(), ^{
        
  self.navigationController.navigationBar.subviews.firstObject.alpha = alpha;
        
    });
    }
    if (alpha<0.17) {
        [self configTitleWithString:@""];
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"透明矩形.png"] forBarMetrics:UIBarMetricsDefault];

        [self.leftbutton setBackgroundImage:[UIImage imageNamed:@"公告"] forState:UIControlStateNormal];
        [self.rightbutton setBackgroundImage:[UIImage imageNamed:@"客服1"] forState:UIControlStateNormal];
        self.rightbutton.frame=CGRectMake(0, 0, 30, 30);//2
        self.leftbutton.frame=CGRectMake(0, 0, 30, 30);

        
        
    }else{
//        [self rightleftbuttonwhithimagrstring:@"PNG_首页_公告-50" str:@"PNG_客服" action:@selector(gonggao) actions:@selector(getloadzcCustomerService)];
        [self.leftbutton setBackgroundImage:[UIImage imageNamed:@"公告2"] forState:UIControlStateNormal];
         [self.rightbutton setBackgroundImage:[UIImage imageNamed:@"客服2"] forState:UIControlStateNormal];
        self.rightbutton.frame=CGRectMake(0, 0, 30, 30);
        self.leftbutton.frame=CGRectMake(0, 0, 30, 30);
        [self configTitleWithString:@"融益汇"];
    }
    //    self.lab.alpha = alpha;
}
-(void)rightleftbuttonwhithimagrstring:(NSString *)leftimagestring str:(NSString *)rightstr action:(SEL)leftaction actions:(SEL)rightaction{
    
    self.leftbutton=[[UIButton alloc]init];
    [self.leftbutton addTarget:self action:leftaction forControlEvents:UIControlEventTouchUpInside];
    //    [button setTitle:title forState:UIControlStateNormal];
    [self.leftbutton setBackgroundImage:[UIImage imageNamed:leftimagestring] forState:UIControlStateNormal];
    [self.leftbutton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    self.leftbutton.frame=CGRectMake(0, 0, 30, 30);
    self.navigationItem.leftBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:self.leftbutton];
    
    
    
    self.rightbutton=[[UIButton alloc]init];
    [self.rightbutton addTarget:self action:rightaction forControlEvents:UIControlEventTouchUpInside];
    //    [button setTitle:title forState:UIControlStateNormal];
//    [self.leftbutton setBackgroundImage:[UIImage imageNamed:rightstr] forState:UIControlStateNormal];
    [self.rightbutton    setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    self.rightbutton.frame=CGRectMake(0, 0, 30, 50);
    self.navigationItem.rightBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:self.rightbutton];
    

    
    
}

-(void)seeetalterview{
    
    
    UIAlertView* alertView=[[UIAlertView alloc]initWithTitle:@"关闭确认"
                                                     message:@"请确认您的汇付余额已成功转出，再关闭此提示。关闭后将不再提示转出汇付余额。"
                                                    delegate:self
                                           cancelButtonTitle:@"关闭"
                                           otherButtonTitles:@"取消", nil];
    alertView.tag=9900;
    [alertView show];
}



- (IBAction)zhuanchuyue:(id)sender {
    
    
    return;
    //汇付天下官网转出余额教程
    if ([self.hfzybtn.titleLabel.text isEqualToString:@"汇付天下官网转出余额教程"]){
        self.mengbanview.tag = 10111;
        self.zhuanyiview.tag = 10112;
        self.navigationController.navigationBar.subviews.firstObject.alpha = 1;
        RHHFjiaochengViewController * vc = [[RHHFjiaochengViewController alloc]initWithNibName:@"RHHFjiaochengViewController" bundle:nil];
        self.mengbanview.hidden = YES;
        self.zhuanyiview.hidden = YES;
        UIView *subView = [self.view viewWithTag:10111];
        [subView removeFromSuperview];
        UIView *subView1 = [self.view viewWithTag:10112];
        [subView1 removeFromSuperview];
        [RYHViewController Sharedbxtabar].tarbar.hidden = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
        return;
    }
    self.mengbanview.tag = 10111;
    self.zhuanyiview.tag = 10112;
     self.navigationController.navigationBar.subviews.firstObject.alpha = 1;
    RHHFJXViewController * vc = [[RHHFJXViewController alloc]initWithNibName:@"RHHFJXViewController" bundle:nil];
    self.mengbanview.hidden = YES;
    self.zhuanyiview.hidden = YES;
    UIView *subView = [self.view viewWithTag:10111];
    [subView removeFromSuperview];
    UIView *subView1 = [self.view viewWithTag:10112];
    [subView1 removeFromSuperview];
    [RYHViewController Sharedbxtabar].tarbar.hidden = YES;
    [self.navigationController pushViewController:vc animated:NO];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self stzfpush];
    self.footbutton.layer.masksToBounds=YES;
    self.footbutton.layer.cornerRadius=5;
    self.navgationrightView.layer.masksToBounds=YES;
    self.navgationrightView.layer.cornerRadius=10;
 
    self.mengbanview.hidden = YES;
    self.kaihuview.hidden = YES;
    
    
    
   // self.mengbanview2.hidden = YES;
    
    self.zhuanyiview.hidden = YES;
     [[UIApplication sharedApplication].keyWindow addSubview:self.mengbanview];
    [[UIApplication sharedApplication].keyWindow addSubview:self.ryhnewsview];
    self.ryhnewsview.frame =CGRectMake((RHScreeWidth-295)/2,150 , 295, 354);
    self.ryhnewsview.hidden = YES;
    self.mengbanview.frame = CGRectMake(0, CGRectGetMinY(self.mengbanview.frame), [UIScreen mainScreen].bounds.size.width, self.mengbanview.frame.size.height);
    
//    self.newsdatabtn.userInteractionEnabled = NO;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.navigationController.navigationBar.backgroundColor = [UIColor clearColor]; self.navigationController.navigationBar.subviews.firstObject.alpha = 0;
        
    });

    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"透明矩形.png"] forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBarHidden = YES;
    _bx = 2;
    _shouyepanduan = 0;
    _shouyepanduan1 = 0;

    
//    self.navgationrightView.hidden = YES;
    [[RYHViewController Sharedbxtabar] tabBar:(RYHView *)self.view didSelectedIndex:0];
    self.tableView.scrollEnabled = NO;
 
     [self rightleftbuttonwhithimagrstring:@"公告" str:@"客服1" action:@selector(gonggao) actions:@selector(getloadzcCustomerService)];
    _bannersArray = [[NSArray alloc] init];
    _bannerViewsArray = [[NSMutableArray alloc] init];
    
    self.scrview = [[UIScrollView alloc]init];
    self.scrview.frame = CGRectMake(0, -64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-44-69-5+3+3+64);
    if ([UIScreen mainScreen].bounds.size.height >740) {
        self.scrview.frame = CGRectMake(0,-90, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-44-69-5+3+3+64);
    }

    
    //是否显示滚动条
    NSLog(@"%f",[UIScreen mainScreen].bounds.size.height);
    self.scrview .showsHorizontalScrollIndicator =NO ;
    
    //回弹效果
    
    self.scrview.bounces = YES;
    
    //设置整页翻动
    
    
    self.scrview .pagingEnabled = NO;
    
    //设置偏移量
    
    //scorlview.contentOffset = CGPointMake(scorlview.frame.size.width, 0);
    
    
    
    //设置能否滚动
    self.scrview .scrollEnabled = YES;
    self.scrview.backgroundColor = [UIColor colorWithHexString:@"efefef"];
    self.scrview.delegate = self;

    
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor=[UIColor clearColor];
 
//    self.newsView.backgroundColor = [UIColor redColor];
//    if ([UIScreen mainScreen].bounds.size.width >321) {
//        self.tableView.frame=CGRectMake(0, CGRectGetMaxY(self.newsView.frame)+30, [UIScreen mainScreen].applicationFrame.size.width, 1000-44-69+10);
//    }
   
//    if ([UIScreen mainScreen].bounds.size.width >321) {
//        self.tableView.frame=CGRectMake(0, CGRectGetMaxY(self.newsView.frame)+5, [UIScreen mainScreen].applicationFrame.size.width, 1000-44-69+10);
//    }
    
   // self.tableView.tableHeaderView=self.tbHeaderView;
   // NSLog(@"%f",CGRectGetMaxY(self.RHcbxview.frame));
    self.tableView.tableHeaderView.hidden = YES;
    
    [self.scrview addSubview:self.tableView];
    
    self.segment1Array=[[NSMutableArray alloc]initWithCapacity:0];
    self.segment2Array=[[NSMutableArray alloc]initWithCapacity:0];
    self.dataArray=[[NSMutableArray alloc]initWithCapacity:0];

//   
 
 
    
//    [timer1 invalidate]
    self.tableView.tableFooterView=self.footView;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refeshMainViewDataWithState:) name:UIApplicationWillEnterForegroundNotification object:nil];
    
//    [self getAppBanner];
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"AppUpdate"]) {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"AppUpdate"];
        //获取本地软件的版本号
        NSString *localVersion = [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        [self onCheckVersion:localVersion];
    }
    self.mainScorllView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 110) animationDuration:3.0];
    [self.view addSubview:self.mainScorllView];
    if ([UIScreen mainScreen].bounds.size.width <321) {
        self.scrview .contentSize =  CGSizeMake([UIScreen mainScreen].bounds.size.width,675*1.4+10-30+30+25+64+20+6+10+80);
        self.newslab.font = [UIFont systemFontOfSize:11];
    }else{
        self.scrview .contentSize =  CGSizeMake([UIScreen mainScreen].bounds.size.width,675*1.4+10-30+30+25+64+20+46+10+80);
        
    }
    if ([UIScreen mainScreen].bounds.size.height>740) {
        self.scrview .contentSize =  CGSizeMake([UIScreen mainScreen].bounds.size.width,675*1.4+10-30+30+25+64+20+46+10+80+20);
    }
    _shangye = -1;
    [NSTimer scheduledTimerWithTimeInterval:0.0f target:self selector:@selector(delayMethod) userInfo:nil repeats:NO];
  
    [self.view addSubview:self.scrview];
    

    
    
    
    
    
}
-(void)timerFire:(id)sender{
    if (self.keyarr.count<1) {
        return;
    }
//    return;
    
    if (self.a==1) {
        self.a=0;
    }else{
        self.a=1;
    }
    dispatch_group_t group = dispatch_group_create();
    //    dispatch_group_async(group, dispatch_get_global_queue(0,0), ^{
    // 并行执行的线程一
//    NSLog(@"111");
    [UIView animateWithDuration:2.0f animations:^{
        self.newslab.alpha = self.a;
        //        self.lab.te
        self.publicktimelab.alpha = self.a;
        
    }];
    //    });
    //    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
    // 并行执行的线程二
    //        NSLog(@"222");
    
    //    });
    
    if (self.a==0) {
        [self timerFire:nil];
        return;
    }
    //    [UIView animateWithDuration:0.3 delay:0.1 options:0.1 animations:^{
    //
    //        self.lab.alpha = 1;
    //
    //    } completion:nil];
    self.key++;
    
    if (self.key > self.keyarr.count-1) {
        self.key=0;
    }
    //    if (self.a==1) {
//    NSString * stitlestr = self.keyarr[self.key][@"title"];
//    if (stitlestr.length >17) {
//         stitlestr = [stitlestr substringToIndex:18];
//        stitlestr = [NSString stringWithFormat:@"%@...",stitlestr];
//    }
//    
//   
//    
//     NSString * timestr = self.keyarr[self.key][@"publishTime"];
//    NSString * zongstr = [NSString stringWithFormat:@"%@  %@",stitlestr,timestr];
//    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:zongstr];
//    
//    [str addAttribute:NSForegroundColorAttributeName value:[RHUtility colorForHex:@"#bcbcbc"] range:NSMakeRange(zongstr.length-timestr.length,timestr.length)];
    
    
//    lab.attributedText = str;
    
    self.newslab.text =  self.keyarr[self.key][@"title"];
    self.gonggaourlstr = self.keyarr[self.key][@"noticeUrl"];
    self.publicktimelab.text = self.keyarr[self.key][@"publishTime"];
    self.webtitle = self.newslab.text;
    self.newsdatabtn.userInteractionEnabled = YES;
    //    }
    
}
- (IBAction)moregonggao:(id)sender {
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.subviews.firstObject.alpha = 5.00;
    RHOfficeNetAndWeiBoViewController *office = [[RHOfficeNetAndWeiBoViewController alloc] initWithNibName:@"RHOfficeNetAndWeiBoViewController" bundle:nil];
    //            office.NavigationTitle = naviTitle;
//    office.NavigationTitle = self.webtitle;
    office.Type = 3;
    if (([self.moreurlstr rangeOfString:@"https://"].location == NSNotFound)) {
        //            office.urlString = [NSString stringWithFormat:@"http://%@",linkURl];
        //        } else if (([linkURl rangeOfString:@"https://"].location == NSNotFound)) {
        //             office.urlString = [NSString stringWithFormat:@"https://%@",linkURl];
        NSArray * array = [self.moreurlstr componentsSeparatedByString:@"//"];
        
        office.urlString = [NSString stringWithFormat:@"https://%@",array[1]];
    }else{
        office.urlString = self.moreurlstr;
        
    }
    [self.navigationController pushViewController:office animated:YES];
    
}
- (IBAction)didnewsgonggao:(id)sender {
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.subviews.firstObject.alpha = 5.00;
    RHOfficeNetAndWeiBoViewController *office = [[RHOfficeNetAndWeiBoViewController alloc] initWithNibName:@"RHOfficeNetAndWeiBoViewController" bundle:nil];
    
    NSString * stitlestr = self.newslab.text;
    if (stitlestr.length >10) {
        stitlestr = [stitlestr substringToIndex:10];
        stitlestr = [NSString stringWithFormat:@"%@",stitlestr];
    }
                office.NavigationTitle = stitlestr;
    office.Type = 3;
    if (([self.gonggaourlstr rangeOfString:@"https://"].location == NSNotFound)) {
        //            office.urlString = [NSString stringWithFormat:@"http://%@",linkURl];
        //        } else if (([linkURl rangeOfString:@"https://"].location == NSNotFound)) {
        //             office.urlString = [NSString stringWithFormat:@"https://%@",linkURl];
        NSArray * array = [self.gonggaourlstr componentsSeparatedByString:@"//"];
        
        office.urlString = [NSString stringWithFormat:@"https://%@",array[1]];
    }else{
        office.urlString = self.gonggaourlstr;
        
    }
    [self.navigationController pushViewController:office animated:NO];
    
    
    
}

-(void)getnewsryhgw{
//    self.newsdatabtn.userInteractionEnabled = NO;
    [[RHNetworkService instance] POST:@"app/common/appMain/appActivityListNew" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            self.keyarr = responseObject[@"notices"];
            self.collectionArr = responseObject[@"bannerList"];
            self.moreurlstr = responseObject[@"noticesList"];
            
            self.leijimoney.text = responseObject[@"investMoney"];
            self.yizhuanmoney.text = responseObject[@"alreadyMoney"];
//            self.newslab.text = self.keyarr[0][@"title"];
            NSString * stitlestr = self.keyarr[0][@"title"];
            if (stitlestr.length >17) {
                stitlestr = [stitlestr substringToIndex:18];
                stitlestr = [NSString stringWithFormat:@"%@...",stitlestr];
            }
            
//            NSString * zongstr = [NSString stringWithFormat:@"%@ %@",stitlestr,self.keyarr[0][@"publishTime"]];
//            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:zongstr];
//            NSString * timestr = self.keyarr[0][@"publishTime"];
//            [str addAttribute:NSForegroundColorAttributeName value:[RHUtility colorForHex:@"#bcbcbc"] range:NSMakeRange(zongstr.length-timestr.length,timestr.length)];
//            
//            self.newslab.attributedText = str;
//            
//            
//            self.gonggaourlstr = self.keyarr[0][@"noticeUrl"];
            self.newslab.text =  self.keyarr[0][@"title"];
            self.gonggaourlstr = self.keyarr[0][@"noticeUrl"];
            self.publicktimelab.text = self.keyarr[0][@"publishTime"];
//            self.webtitle = self.newslab.text;
            [self.tableView reloadData];
            
            [self.mycollection reloadData];
            
            }
            
//        NSLog(@"%@",self.keyarr);
        
        
        
        
        //
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [RHUtility showTextWithText:@"网络异常,请重试"];
        
        
    }];
}
-(NSArray *)xmjarray{
    
    if (!_xmjarray) {
        _xmjarray = [NSArray array];
    }
    return _xmjarray;
}
-(NSMutableArray *)keyarr{
    
    if (!_keyarr) {
        _keyarr = [NSMutableArray array];
    }
    return _keyarr;
}
-(NSMutableArray *)webtitlearray{
    
    if (!_webtitlearray) {
        _webtitlearray = [NSMutableArray array];
    }
    return _webtitlearray;
}
-(NSMutableArray *)collectionArr{
    
    if (!_collectionArr) {
        _collectionArr = [NSMutableArray array];
    }
    return _collectionArr;
}
- (void)customUserInformationWith:(ZCLibInitInfo*)initInfo{
    // 用户手机号码
    //    initInfo.phone        = @"Your phone";
    
    // 用户昵称
    initInfo.nickName     = [RHUserManager sharedInterface].username;
}
- (void)setZCLibInitInfoParam:(ZCLibInitInfo *)initInfo{
    // 获取AppKey
    initInfo.appKey = @"75bdfe3a9f9c4b8a846e9edc282c92b4";
    //    initInfo.appKey = @"23a063ddadb1485a9a59f391b46bcb8b";
//    initInfo.skillSetId = _groupIdTF.text;
//    initInfo.skillSetName = _groupNameTF.text;
//    initInfo.receptionistId = _aidTF.text;
//    initInfo.robotId = _robotIdTF.text;
//    initInfo.tranReceptionistFlag = _aidTurn;
//    initInfo.scopeTime = [_historyScopeTF.text intValue];
//    initInfo.titleType = titleType;
//    initInfo.customTitle = _titleCustomTF.text;
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    
}
-(void)getloadzcCustomerService{
    
    ZCLibInitInfo *initInfo = [ZCLibInitInfo new];
    // Appkey    *必填*
    //initInfo.appKey  = @"75bdfe3a9f9c4b8a846e9edc282c92b4";//appKey;
    initInfo.nickName     = [RHUserManager sharedInterface].username;
    //自定义用户参数
        [self customUserInformationWith:initInfo];
    [self setZCLibInitInfoParam:initInfo];
    ZCKitInfo *uiInfo=[ZCKitInfo new];
   // uiInfo.info=initInfo;
        uiInfo.isOpenEvaluation = YES;
     [[ZCLibClient getZCLibClient] setLibInitInfo:initInfo];
    // 自定义UI
    //    [self customerUI:uiInfo];
    
    
    // 之定义设置参数
    //    [self customerParameter:uiInfo];
    
    
    // 未读消息
    //    [self customUnReadNumber:uiInfo];
    
    
    // 测试模式
    //    [ZCSobot setShowDebug:YES];
    
    
    // 自动提醒消息
    //    if ([_configModel.autoNotification intValue] == 1) {
    //        [[ZCLibClient getZCLibClient] setAutoNotification:YES];
    //    }else{
    //        [[ZCLibClient getZCLibClient] setAutoNotification:NO];
    //    }
    
    
    // 启动
    [ZCSobot startZCChatView:uiInfo with:self target:nil pageBlock:^(ZCUIChatController *object, ZCPageBlockType type) {
        // 点击返回
        if(type==ZCPageBlockGoBack){
            NSLog(@"点击了关闭按钮");
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                //                            [self.navigationController setNavigationBarHidden:NO];
                [RYHViewController Sharedbxtabar].tarbar.hidden = NO;
                [[RYHViewController Sharedbxtabar].tabBar setHidden:YES];
                if ([UIScreen mainScreen].bounds.size.height >740) {
                [RYHViewController Sharedbxtabar].tarbar.frame = CGRectMake(self.tabBarController.tabBar.frame.origin.x, [RYHViewController Sharedbxtabar].tabBar.frame.origin.y, [RYHViewController Sharedbxtabar].tabBar.frame.size.width, self.tabBarController.tabBar.frame.size.height+35);
                }
            });
        }
        
        // 页面UI初始化完成，可以获取UIView，自定义UI
        if(type==ZCPageBlockLoadFinish){
            [RYHViewController Sharedbxtabar].tarbar.hidden = YES;
            //            object.navigationController.interactivePopGestureRecognizer.delegate = object;
            // banner 返回按钮
            [object.backButton setTitle:@"关闭" forState:UIControlStateNormal];
            
            
        }
    } messageLinkClick:nil];
}
-(void)loginryh{
//     if (![RHUserManager sharedInterface].username) {
//    RHALoginViewController * con = [[RHALoginViewController alloc]initWithNibName:@"RHALoginViewController" bundle:nil];
//
//
//    [RYHViewController Sharedbxtabar].tarbar.hidden = YES;
//    [self.navigationController pushViewController:con animated:NO];
//     }
}



-(void)RHwycbx{
    
//    [UIView animateWithDuration:10 animations:^{
//                self.rhcdbxlab.frame= CGRectMake(-[UIScreen mainScreen].applicationFrame.size.width*4, 108, [UIScreen mainScreen].applicationFrame.size.width*4, 10);
//               // self.aview.backgroundColor = [UIColor greenColor];
//                ;
//            } completion:^(BOOL finished) {
//        
////                [UIView animateWithDuration:5 animations:^{
////                   // self.rhcdbxlab.backgroundColor = [UIColor grayColor];
////                    self.rhcdbxlab.frame=CGRectMake(0, 0, 200, 200);
////                }];
//                self.rhcdbxlab.frame=CGRectMake([UIScreen mainScreen].applicationFrame.size.width*4, 108, [UIScreen mainScreen].applicationFrame.size.width*4, 10);
//                
//            }];
}
-(void)delayMethod{
    [_RHcbxview scrollToPage:1];
}
#pragma mark  ----------顶部轮播图
//-(void)setAndAddScrollView
//{
//    [self.bannerViewsArray removeAllObjects];
//    for (int i = 0; i < self.bannersArray.count; i ++ ) {
//        UIImageView *tempLabel = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.mainScorllView.frame.size.width, self.mainScorllView.frame.size.height)];
//        tempLabel.userInteractionEnabled = YES;
//        NSDictionary *dic = _bannersArray[i];
//        //            NSLog(@"============%@",dic);
//        RHNetworkService *netService = [RHNetworkService instance];
//        NSString *urlString = [NSString stringWithFormat:@"%@%@%@",[netService doMain],@"common/main/attachment/",dic[@"bg"]];
//        [tempLabel sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"NewBanner"]];
//        [self.bannerViewsArray addObject:tempLabel];
//    }
//    if (_bannerViewsArray.count == self.bannersArray.count) {
//        [self.mainScorllView openThePageControllAndIsOpenImageDetails:NO andTheDetails:nil andState:4] ;
//        self.mainScorllView.totalPagesCount = ^NSInteger(void){
//            return self.bannerViewsArray.count;
//        };
//        self.mainScorllView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
//            NSLog(@"==========%d",pageIndex);
//            return _bannerViewsArray[pageIndex];
//        };
//        self.mainScorllView.TapActionBlock = ^(NSInteger pageIndex){
//            NSLog(@"点击了第%ld个",(long)pageIndex);
//            
//           // [self goForBannerDetailViewControllerWithIndex:pageIndex];
//        };
////        [self.mainScorllView.animationTimer resumeTimerAfterTimeInterval:3.0];
////        //开启定时器
////        [self.mainScorllView.animationTimer setFireDate:[NSDate distantPast]];
//    }
//    
//}


- (void)onCheckVersion:(NSString *)currentVersion {
    NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/lookup?id=977505438"];
    NSLog(@"%@",currentVersion);
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
                NSDictionary* results ;
                NSArray * arr = [responseDict objectForKey:@"results"];
                if (arr.count> 0) {
                    results = [[responseDict objectForKey:@"results"] objectAtIndex:0];
                }
                //NSDictionary * results = responseDict[@"results"];
                if (results.count >0) {
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
    if (actionSheet.tag == 8901) {
        
        
        if (buttonIndex==0) {
            [RYHViewController Sharedbxtabar].tarbar.hidden = YES;
            RHDBSJViewController * vc = [[RHDBSJViewController alloc]initWithNibName:@"RHDBSJViewController" bundle:nil];
            //        vc.str = @"cbx";
            [self.navigationController pushViewController:vc animated:NO];
        }
        return;
    }
    
    if (actionSheet.tag==9900) {
        NSLog(@"111");
         if (buttonIndex == 0){
        NSDictionary* parameters=@{@"username":[RHUserManager sharedInterface].username};
         [RHhelper ShraeHelp].moneystr = @"0";
        self.view.userInteractionEnabled = YES;
             self.mengbanview.hidden = YES;
             self.zhuanyiview.hidden = YES;
        [[RHNetworkService instance] POST:@"app/front/payment/appAccount/saveHuifuAvlTag" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
           
            //        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            NSLog(@"%@---",responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            ;
            //self.view.userInteractionEnabled = YES;
            
            
        }];
        
         }
        return;
    }
    
    if (buttonIndex == 0){
        //打开iTunes  方法一
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/rong-yi-hui/id977505438?mt=8"]];
    }
}



-(void)mainbanner{
//    self.view.userInteractionEnabled = NO;
//    self.bannertitleArray = [NSMutableArray array];
//    self.didbannerarray = [NSMutableArray array];
//    self.bannerlogoArray = [NSMutableArray array];
    NSMutableArray * array = [NSMutableArray array];
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    [manager.operationQueue cancelAllOperations];
    
    [manager setSecurityPolicy:[[RHNetworkService instance] customSecurityPolicy]];
    [manager POST:[NSString stringWithFormat:@"%@app/common/appMain/appBannerList",[RHNetworkService instance].newdoMain ] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        for (NSDictionary * dic in responseObject) {
            NSString * buttonstr = [NSString stringWithFormat:@"%@",dic[@"buttonIs"]];
            NSString * inviteCodeIsstr = [NSString stringWithFormat:@"%@",dic[@"inviteCodeIs"]];
            NSString * shareLinkIdstr = [NSString stringWithFormat:@"%@",dic[@"shareLinkId"]];
            NSDictionary * diction = @{@"buttonIs":buttonstr,@"inviteCodeIs":inviteCodeIsstr,@"shareLinkId":shareLinkIdstr};
            [self.ShareArray addObject:diction];
            [array addObject:[NSString stringWithFormat:@"%@common/main/attachment/%@",[RHNetworkService instance].newdoMain,dic[@"bg"]]];
            [self.bannerlogoArray addObject:dic[@"logo"]];
            
            NSString * titlestr = [NSString stringWithFormat:@"%@",dic[@"title"]];
            [self.webtitlearray addObject:titlestr];
            //[self.bannertitleArray addObject:dic[@"tilte"]];
                        NSString * str = dic[@"link"];
                        if (str.length < 2) {
                                [self.didbannerarray addObject:@"1"];
            
                        }else{
            
                                [self.didbannerarray addObject:dic[@"link"]];
              }
            
        }
        PageView *pageView = [[PageView alloc] initWithFrame:CGRectMake(0, 0,  CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight(_headerScrollView.frame))];
        
        if ([UIScreen mainScreen].bounds.size.width >321) {
            pageView.frame =CGRectMake(0, 0,  CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight(_headerScrollView.frame)+90+10);
        }else{
            
            pageView.frame =CGRectMake(0, 0,  CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight(_headerScrollView.frame)+40);
        }
        
        //是否是网络图片
        pageView.isWebImage = YES;
        //存放图片数组
          pageView.imageArray = array;
        
        //停留时间
        pageView.duration = 3;
        
        pageView.delegate = self;
        
        [self.scrview addSubview:pageView];
        if ([UIScreen mainScreen].bounds.size.width <321) {
            self.newscollectionview.frame=CGRectMake(10, CGRectGetMaxY(_headerScrollView.frame)+40, [UIScreen mainScreen].applicationFrame.size.width-20,135);
        }else{
            self.newscollectionview.frame=CGRectMake(10, CGRectGetMaxY(_headerScrollView.frame)+90, [UIScreen mainScreen].applicationFrame.size.width-20,135);
        }
        //    self.newsView.frame=CGRectMake(0, CGRectGetMaxY(_headerScrollView.frame)+90, [UIScreen mainScreen].applicationFrame.size.width,39);
        [self.scrview addSubview:self.newscollectionview];
         self.tableView.frame=CGRectMake(0, CGRectGetMaxY(self.newscollectionview.frame)+5, [UIScreen mainScreen].applicationFrame.size.width, 1000-44-69+10+500);
        self.mycollection.showsHorizontalScrollIndicator = NO;
        self.mycollection.showsVerticalScrollIndicator = NO;
        //    self.collectionview.backgroundColor = [UIColor redColor];
        self.mycollection.bounces = NO;
        self.mycollection.delegate = self;
        self.mycollection.dataSource = self;
        self.colleclayout.itemSize = CGSizeMake((RHScreeWidth-40)/4, 80);
        [self.mycollection registerNib:[UINib nibWithNibName:@"RHProjectCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"collcellid1"];
        self.colleclayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.colleclayout.minimumLineSpacing = 6;
        self.collectionimage.layer.masksToBounds=YES;
        self.collectionimage.layer.cornerRadius=10;
       // self.view.userInteractionEnabled = YES;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
    }];

    
}

-(NSMutableArray *)bannerlogoArray{
    
    if (!_bannerlogoArray) {
        _bannerlogoArray = [NSMutableArray array];
    }
    return _bannerlogoArray;
}
-(NSMutableArray *)ShareArray{
    
    if (!_ShareArray) {
        _ShareArray = [NSMutableArray array];
    }
    return _ShareArray;
}
-(NSMutableArray *)bannertitleArray{
    
    if (!_bannertitleArray) {
        _bannertitleArray = [NSMutableArray array];
    }
    return _bannertitleArray;
}
-(NSMutableArray *)didbannerarray{
    
    if (!_didbannerarray) {
        _didbannerarray = [NSMutableArray array];
    }
    return _didbannerarray;
}



- (void)didSelectPageViewWithNumber:(NSInteger)selectNumber
{    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.subviews.firstObject.alpha = 5.00;
    [RYHViewController Sharedbxtabar].tarbar.hidden = YES;
    NSString *linkURl = self.didbannerarray[selectNumber];
    NSString *logoUrl = self.bannerlogoArray[selectNumber];
    NSString *naviTitle =self.didbannerarray[selectNumber];
    
    NSString * buttonstr = self.ShareArray[selectNumber][@"buttonIs"];
    NSString * inviteCodeIsstr = self.ShareArray[selectNumber][@"inviteCodeIs"];
    NSString * shareLinkIdstr = self.ShareArray[selectNumber][@"shareLinkId"];
    NSString * wentitle = self.webtitlearray[selectNumber];
    NSLog(@"=============%@",linkURl);
    //NSLog(@"=============%@",logoUrl);
    NSLog(@"=============%@",naviTitle);
    
    
    if (linkURl.length > 2) {
        
        if ([buttonstr isEqualToString:@"true"]) {
            RHRNewShareWebViewController *office = [[RHRNewShareWebViewController alloc] initWithNibName:@"RHRNewShareWebViewController" bundle:nil];
            office.NavigationTitle = naviTitle;
            office.Type = 3;
            office.pinjie = inviteCodeIsstr;
            office.shareid = shareLinkIdstr;
            if (([linkURl rangeOfString:@"https://"].location == NSNotFound)) {
                //            office.urlString = [NSString stringWithFormat:@"http://%@",linkURl];
                //        } else if (([linkURl rangeOfString:@"https://"].location == NSNotFound)) {
                //             office.urlString = [NSString stringWithFormat:@"https://%@",linkURl];
                NSArray * array = [linkURl componentsSeparatedByString:@"//"];
                
                office.urlString = [NSString stringWithFormat:@"https://%@",array[1]];
            } else{
                
                
                office.urlString =linkURl;
            }
            [self.navigationController pushViewController:office animated:NO];
        }else{
        RHOfficeNetAndWeiBoViewController *office = [[RHOfficeNetAndWeiBoViewController alloc] initWithNibName:@"RHOfficeNetAndWeiBoViewController" bundle:nil];
        office.NavigationTitle = wentitle;
//        office.Type = 3;
        if (([linkURl rangeOfString:@"https://"].location == NSNotFound)) {
            //            office.urlString = [NSString stringWithFormat:@"http://%@",linkURl];
            //        } else if (([linkURl rangeOfString:@"https://"].location == NSNotFound)) {
            //             office.urlString = [NSString stringWithFormat:@"https://%@",linkURl];
            NSArray * array = [linkURl componentsSeparatedByString:@"//"];
            
            office.urlString = [NSString stringWithFormat:@"https://%@",array[1]];
        } else{
            
            
            office.urlString =linkURl;
        }
        [self.navigationController pushViewController:office animated:NO];
        }
    }else if (logoUrl.length > 0 ) {

    }

    
    
}

-(void)huifumoth{
    
    return;
    if ([[RHhelper ShraeHelp].moneystr doubleValue]>0) {
        //   self.navigationController.navigationBar.subviews.firstObject.alpha = 1;
        self.zhuanyiview.hidden = NO;
        self.mengbanview.hidden = NO;
        //  [[UIApplication sharedApplication].keyWindow addSubview:self.mengban2];
        [[UIApplication sharedApplication].keyWindow addSubview:self.zhuanyiview];
        if ([UIScreen mainScreen].bounds.size.width>376) {
            self.zhuanyiview.frame = CGRectMake(40, CGRectGetMinY(self.kaihuview.frame), [UIScreen mainScreen].bounds.size.width-80, 309);
            
        }else if ([UIScreen mainScreen].bounds.size.width>321&&[UIScreen mainScreen].bounds.size.width<376){
            self.zhuanyiview.frame = CGRectMake(40, CGRectGetMinY(self.kaihuview.frame), [UIScreen mainScreen].bounds.size.width-80, 268);
        }else{
            self.zhuanyiview.frame = CGRectMake(20, CGRectGetMinY(self.kaihuview.frame), [UIScreen mainScreen].bounds.size.width-40, 245);
        }
        self.zhuanyiview.hidden = NO;
        self.mengbanview.hidden = NO;
        self.guanbihfbtn.hidden = YES;
    }
    if ([[RHhelper ShraeHelp].flag isEqualToString:@"0"]&&[[RHhelper ShraeHelp].moneystr doubleValue]>0) {
        //        return;
        //self.navigationController.navigationBar.subviews.firstObject.alpha = 1;
        self.hfzylab.text = @"融益汇已完成江西银行资金系统的升级。由于您未及时在融益汇转出原有余额，请到汇付天下官网进行原有账户余额转出操作。\n 转出后将激活江西银行存管账户";
        
        [self.hfzybtn setTitle:@"汇付天下官网转出余额教程" forState:UIControlStateNormal ];
        
        [[UIApplication sharedApplication].keyWindow addSubview:self.zhuanyiview];
        if ([UIScreen mainScreen].bounds.size.width>376) {
            self.zhuanyiview.frame = CGRectMake(40, CGRectGetMinY(self.kaihuview.frame), [UIScreen mainScreen].bounds.size.width-80, 309);
            
        }else if ([UIScreen mainScreen].bounds.size.width>321&&[UIScreen mainScreen].bounds.size.width<376){
            self.zhuanyiview.frame = CGRectMake(40, CGRectGetMinY(self.kaihuview.frame), [UIScreen mainScreen].bounds.size.width-80, 268);
        }else{
            self.zhuanyiview.frame = CGRectMake(20, CGRectGetMinY(self.kaihuview.frame), [UIScreen mainScreen].bounds.size.width-40, 245);
            
            
        }
        self.zhuanyiview.hidden = NO;
        self.mengbanview.hidden = NO;
        self.guanbihfbtn.hidden = NO;
    }
    
    
}

- (void)viewWillAppear:(BOOL)animated {
//    [self stzfpush];
    [self xmjlist];
    
    [self gethuifuyuemoth];
    [self xmjswitch];
    [self xmjdata];
    [self huoquryhnews];
    self.navigationController.navigationBar.subviews.firstObject.alpha = 0;
   
   
    [self scrollViewDidScroll:self.scrview];
    self.timers = [NSTimer scheduledTimerWithTimeInterval:6.0f
                                                   target:self
                                                 selector:@selector(timerFire:)
                                                 userInfo:nil
                                                  repeats:YES];
    [self.timers fire];
    
    [self getmyjxpassword];
    

    [segment1Array removeAllObjects];
//    [dataArray removeAllObjects];
    [super viewWillAppear:animated];
    [RYHViewController Sharedbxtabar].tarbar.hidden = NO;
    
    [self getnewpeoplegetproject];
//    [[RYHViewController Sharedbxtabar] tabBar:(RYHView *)self.view didSelectedIndex:0];
    [self.tableView reloadData];
    
   // [self refeshMainViewDataWithState:0];
    
    [self mainbanner];
    //[self segment1Post];
    [self segment1Post];
    [self newpeopledata];
    [self getnewsryhgw];
 
}





- (void)refeshMainViewDataWithState:(int) state {

}

#pragma mark-network
- (void)getSegmentnum1 {
    
   
    NSDictionary* parameters=@{@"_search":@"true",@"rows":@"1000",@"page":@"1",@"filters":@"{\"groupOp\":\"AND\",\"rules\":[{\"field\":\"percent\",\"op\":\"lt\",\"data\":100}]}"};
    

}

- (void)getSegmentnum2 {
   // _shouyepanduan1++;
    
    
    
    NSDictionary* parameters=@{@"_search":@"true",@"rows":@"1000",@"page":@"1",@"filters":@"{\"groupOp\":\"AND\",\"rules\":[{\"field\":\"percent\",\"op\":\"lt\",\"data\":100}]}"};

}
-(void)panduan1{
    
    if (_shangye&&_zhuxue) {
        [self panduan];
    }
    
}
-(void)panduan{
    

    
}

-(void)xmjlist{
    NSDictionary* parameters=@{@"_search":@"false",@"rows":@"10",@"page":@"1",@"sidx":@"",@"sord":@""};
    [[RHNetworkService instance] POST:@"app/common/appMain/projectListDataForApp" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
          
            self.xmjarray = responseObject[@"rows"];
            
            [self.tableView reloadData];
        }
        
        
        //
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [RHUtility showTextWithText:@"网络异常,请重试"];
        
        
    }];
    
    
}
- (void)segment1Post {
//    int arrayCount=[[NSNumber numberWithInteger:[segment1Array count]] intValue];
//    NSString* page=[NSString stringWithFormat:@"%@",[NSNumber numberWithInt:(arrayCount/10+1)]];
    NSDictionary* parameters=@{@"_search":@"true",@"rows":@"10",@"page":@"1",@"sidx":@"",@"sord":@"",@"filters":@"{\"groupOp\":\"AND\",\"rules\":[]}"};
    
 
    
    
    
    type = @"0";
     [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[RHNetworkService instance] POST:@"app/common/appMain/projectListAllData" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {


        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSArray* array=[responseObject objectForKey:@"rows"];
            if ([array isKindOfClass:[NSArray class]]) {
                for (NSDictionary* dic in array) {
                    if ([dic objectForKey:@"cell"]&&!([[dic objectForKey:@"cell"] isKindOfClass:[NSNull class]])) {
                        [self.segment1Array addObject:[dic objectForKey:@"cell"]];
                       // NSLog(@"-----1111-----%@",dic[@"id"]);
                    }
                }
            }
            
            NSString* records=[responseObject objectForKey:@"records"];
            if (records&&[records intValue]<10) {
                //已经到底了
            }
            if ([type isEqualToString:@"0"]) {
//                [self.dataArray removeAllObjects];
//                [self.dataArray addObjectsFromArray:self.segment1Array];
                self.dataArray = self.segment1Array;
                [self.tableView reloadData];
                //self.progressBox.hidden = YES;
                self.tableView.userInteractionEnabled = YES;
                //[RHUtility showTextWithText:@"正在努力加载页面"];
                //[MBProgressHUD hideHUDForView:self.view animated:YES];
//                self.segmentView.segmentView1.userInteractionEnabled = YES;
//                self.segmentView.segmentView2.userInteractionEnabled = YES;
//                self.segmentView.segmentLabel4.userInteractionEnabled = YES;
//                self.segmentView.segmentLabel3.userInteractionEnabled = YES;
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

            }
                    }
        
        
        //
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [RHUtility showTextWithText:@"网络异常,请重试"];
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
    //self.progressBox.hidden = YES;

}

- (void)segment2Post {
    
    int arrayCount=[[NSNumber numberWithInteger:[segment2Array count]] intValue];
    NSString* page=[NSString stringWithFormat:@"%@",[NSNumber numberWithInt:(arrayCount/10+1)]];
    NSDictionary* parameters=@{@"_search":@"true",@"rows":@"10",@"page":@"1",@"sidx":@"",@"sord":@"",@"filters":@"{\"groupOp\":\"AND\",\"rules\":[]}"};
 
}

#pragma mark-RHSegmentDelegate

- (void)didSelectInvestment {
    
    RHProjectListViewController* controller=[[RHProjectListViewController alloc]initWithNibName:@"RHProjectListViewController" bundle:nil];
    [RHhelper ShraeHelp].type=@"0";
    
    [[RYHViewController Sharedbxtabar]tabBar:nil didSelectedIndex:1];
    UIButton *btn = [[UIButton alloc]init];
    btn.tag = 1;
    [[RYHView Shareview] btnClick:btn];
//    [self.navigationController pushViewController:controller animated:YES];
}
- (void)didSelectInvestment1 {
    
    RHProjectListViewController* controller=[[RHProjectListViewController alloc]initWithNibName:@"RHProjectListViewController" bundle:nil];
    [RHhelper ShraeHelp].type=@"1";
    
    [[RYHViewController Sharedbxtabar]tabBar:nil didSelectedIndex:1];
    UIButton *btn = [[UIButton alloc]init];
    btn.tag = 1;
    [[RYHView Shareview] btnClick:btn];
    //    [self.navigationController pushViewController:controller animated:YES];
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
- (void)toubiao:(NSDictionary *)dic newpeople:(BOOL)res myxmj:(BOOL)xmjres{
    //NSLog(@"----------");
   // NSString* session=[[NSUserDefaults standardUserDefaults] objectForKey:@"RHSESSION"];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.subviews.firstObject.alpha = 5.00;
    
    
    if (![RHUserManager sharedInterface].username) {
//        [self.investmentButton setTitle:@"请先登录" forState:UIControlStateNormal];
        [RYHViewController Sharedbxtabar].tarbar.hidden = YES;
        NSLog(@"ddddddd");
        RHALoginViewController* controller=[[RHALoginViewController alloc] initWithNibName:@"RHALoginViewController" bundle:nil];
        [self.navigationController pushViewController:controller animated:NO];
    }else{
        if (![RHUserManager sharedInterface].custId) {
//            [self.investmentButton setTitle:@"请先开户" forState:UIControlStateNormal];
            self.mengbanview.hidden = NO;
            self.kaihuview.hidden = NO;
            [[UIApplication sharedApplication].keyWindow addSubview:self.mengbanview];
            [[UIApplication sharedApplication].keyWindow addSubview:self.kaihuview];
            NSLog(@"kkkkkkk");
            if ([UIScreen mainScreen].bounds.size.width>376) {
                self.kaihuview.frame = CGRectMake(40, CGRectGetMinY(self.kaihuview.frame), [UIScreen mainScreen].bounds.size.width-80, 310);
            }else{
                self.kaihuview.frame = CGRectMake(40, CGRectGetMinY(self.kaihuview.frame), [UIScreen mainScreen].bounds.size.width-80, 245);
            }
            
        }else{
            
            NSString* session1=[[NSUserDefaults standardUserDefaults] objectForKey:@"RHUSERpwd"];
            if ([session1 isEqualToString:@"yes"]) {
                self.passwordbool = @"yes";
            }
            if (![self.passwordbool isEqualToString:@"yes"]) {
                
                [self.kaihubtn setTitle:@"设置交易密码" forState:UIControlStateNormal];
                self.bankpdlab.text = @"资金更安全，请先设置交易密码再进行投资／提现";
                self.mengbanview.hidden = NO;
                self.kaihuview.hidden = NO;
                [[UIApplication sharedApplication].keyWindow addSubview:self.mengbanview];
                 [[UIApplication sharedApplication].keyWindow addSubview:self.mengban2];
                [[UIApplication sharedApplication].keyWindow addSubview:self.kaihuview];
                if ([UIScreen mainScreen].bounds.size.width>376) {
                    self.kaihuview.frame = CGRectMake(40, CGRectGetMinY(self.kaihuview.frame), [UIScreen mainScreen].bounds.size.width-80, 310);
                }else{
                    
                    self.kaihuview.frame = CGRectMake(40, CGRectGetMinY(self.kaihuview.frame), [UIScreen mainScreen].bounds.size.width-80, 245);
//                    [[UIApplication sharedApplication].keyWindow addSubview:self.mengbanview2];
//                    self.mengbanview2 = [[UIView alloc]initWithFrame:CGRectMake(40, -100, [UIScreen mainScreen].bounds.size.width-80, 500)];
//                    self.mengbanview2.backgroundColor = [UIColor blackColor];
//                    [self.view addSubview:self.mengbanview2];
                }
                return;
            }
            
            if (res==YES) {
                if (self.newpeoplebool == YES) {
                    
                    
                    
                    RHInvestmentViewController* contoller=[[RHInvestmentViewController alloc]initWithNibName:@"RHInvestmentViewController" bundle:nil];
                    NSString * str = dic[@"available"];
                    int a = [str intValue];
                    if ([[dic objectForKey:@"everyoneEndAmount"] isKindOfClass:[NSNull class]]) {
                        //                    self.danbaolab.text=@"单人限投5万元";
                        contoller.everyoneEndAmountstr =@"10000";
                    }else{
                        //                    self.danbaolab.text=[NSString stringWithFormat:@"单人限投%@",[dic objectForKey:@"singleEndAmount"]];
                        contoller.everyoneEndAmountstr =  [dic objectForKey:@"everyoneEndAmount"];
                    }
                    contoller.projectFund= a;
                    contoller.dataDic=dic;
                    contoller.newpeople = YES;
                    //            if (self.panduan == 10) {
                    // contoller.panduan = 10;
                    //            }
                    NSString * str1 =  dic[@"investorRate"];
                    //contoller.lilv =str1;
                    [self.navigationController pushViewController:contoller animated:NO];
                }else{
                    
                    [RHUtility showTextWithText:@"您已投资过，请看其余项目。"];
                    
                }
                
            }else{
                
                if ([[RHhelper ShraeHelp].dbsxstr isEqualToString:@"1"]) {
                    UIAlertView* alertView=[[UIAlertView alloc]initWithTitle:@"提示"
                                                                     message:@"您有待办事项未处理完毕，请尽快处理。"
                                                                    delegate:self
                                                           cancelButtonTitle:@"确定"
                                                           otherButtonTitles:@"取消", nil];
                    alertView.tag=8901;
                    [alertView show];
                    
                    return;
                }
                
                
                if (xmjres==YES) {
                    
                    RHInvestmentViewController* contoller=[[RHInvestmentViewController alloc]initWithNibName:@"RHInvestmentViewController" bundle:nil];
                    
                    
                   
                        
                    contoller.xmjres = @"xmj" ;
                    
                    NSString * str = dic[@"cell"][@"remainMoney"];
                    
                    int a = [str intValue];
                    contoller.projectFund= a;
                    contoller.dataDic=dic[@"cell"];
                    //            if (self.panduan == 10) {
                    // contoller.panduan = 10;
                    //            }
                    NSString * str1 =  dic[@"investorRate"];
                    //contoller.lilv =str1;
                    [self.navigationController pushViewController:contoller animated:NO];
                    
                    return;
                    
                }
                
                
            RHInvestmentViewController* contoller=[[RHInvestmentViewController alloc]initWithNibName:@"RHInvestmentViewController" bundle:nil];
                
                
                NSString * xmjstr;
                if (dic[@"isProjectList"]&&![dic[@"isProjectList"] isKindOfClass:[NSNull class]]) {
                    xmjstr = [NSString stringWithFormat:@"%@",dic[@"isProjectList"]];
                }
                 if ([xmjstr isEqualToString:@"yes"]) {
                     
                     contoller.xmjres = @"xmj" ;
                 }
            NSString * str = dic[@"available"];
               
            int a = [str intValue];
            contoller.projectFund= a;
            contoller.dataDic=dic;
//            if (self.panduan == 10) {
               // contoller.panduan = 10;
//            }
           NSString * str1 =  dic[@"investorRate"];
            //contoller.lilv =str1;
            [self.navigationController pushViewController:contoller animated:NO];
            }
        }
    }
    
    
    
    
}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    
//    return 50;
//}
#pragma mark-TableViewDelegate
//-(NSArray *)tableViewAtIndexes:(NSIndexSet *)indexes{
//    
//    return @[@"1111",@"2222"];
//}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * headerview = [[UIView alloc]init];
    
    headerview.frame = CGRectMake(0, 0, RHScreeWidth, 45);
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(10, 3, RHScreeWidth-20, 40)];
    [btn setTitle:@"查看更多项目" forState:UIControlStateNormal];
    [btn setTitleColor:[RHUtility colorForHex:@"#09AEB0"]forState:UIControlStateNormal];
//    [btn]
    btn.tag = section;
    btn.titleLabel.font = [UIFont systemFontOfSize: 13.0];
    self.type = [NSString stringWithFormat:@"%ld",section];
     if (self.newpeopleress == YES) {
         
      if ([self.projectLocal isEqualToString:@"LFSA"]) {
           if (section==1) {
             [btn addTarget:self action:@selector(pushProjectList:) forControlEvents:UIControlEventTouchUpInside];
           }else if(section==2){
             [btn addTarget:self action:@selector(didSelectInvestment1) forControlEvents:UIControlEventTouchUpInside];
             
            }
         }else{
             if (section==1) {
                 [btn addTarget:self action:@selector(didSelectInvestment1) forControlEvents:UIControlEventTouchUpInside];
             }else if(section==2){
                 [btn addTarget:self action:@selector(pushProjectList:) forControlEvents:UIControlEventTouchUpInside];
                 
             }
         }
     }else{
         
         if ([self.projectLocal isEqualToString:@"LFSA"]) {
            if (section==0) {
               [btn addTarget:self action:@selector(pushProjectList:) forControlEvents:UIControlEventTouchUpInside];
             }else{
                [btn addTarget:self action:@selector(didSelectInvestment1) forControlEvents:UIControlEventTouchUpInside];
        
            }
         }else{
             if (section==0) {
                 [btn addTarget:self action:@selector(didSelectInvestment1) forControlEvents:UIControlEventTouchUpInside];
             }else if(section==1){
                 [btn addTarget:self action:@selector(pushProjectList:) forControlEvents:UIControlEventTouchUpInside];
                 
             }
         }
     }
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = [UIBezierPath bezierPathWithRoundedRect:btn.bounds byRoundingCorners: UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii: (CGSize){8.0f, 8.0f}].CGPath;
    btn.layer.masksToBounds = YES;
    btn.layer.mask = maskLayer;
    
    btn.backgroundColor =[UIColor whiteColor] ;
    [headerview addSubview:btn];
    return headerview;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * headerview = [[UIView alloc]init];
    headerview.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 42);
//    self.tableView.tableHeaderView = self.tbHeaderView;
    UILabel * newpersonlab = [[UILabel alloc]init];
     UILabel * balcklab = [[UILabel alloc]init];
    newpersonlab.frame = CGRectMake(RHScreeWidth/2-50,10, 100, 30);
    balcklab.frame = CGRectMake(10,5, RHScreeWidth-20, 42);
    balcklab.backgroundColor = [UIColor whiteColor];
    newpersonlab.textAlignment = NSTextAlignmentCenter;
    [headerview addSubview:balcklab];
    [headerview addSubview:newpersonlab];
    newpersonlab.font =[UIFont systemFontOfSize: 16.0];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = [UIBezierPath bezierPathWithRoundedRect:balcklab.bounds byRoundingCorners: UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii: (CGSize){8.0f, 8.0f}].CGPath;
    balcklab.layer.masksToBounds = YES;
    balcklab.layer.mask = maskLayer;
    
  
    UIImageView * imageview = [[UIImageView alloc]init];
    imageview.frame = CGRectMake(RHScreeWidth/2-70, 24, 30, 2);
    UIImageView * imageview1 = [[UIImageView alloc]init];
    imageview1.frame = CGRectMake(RHScreeWidth/2+40, 24, 30, 2);
    imageview.image = [UIImage imageNamed:@"标题左侧线"];
    imageview1.image = [UIImage imageNamed:@"标题右侧线"];
    [headerview addSubview:imageview];
    [headerview addSubview:imageview1];
    
    UILabel * downlab = [[UILabel alloc]init];
    downlab.frame = CGRectMake(20,41,RHScreeWidth-40,1);
    downlab.backgroundColor = [RHUtility colorForHex:@"#cccccc"];
    [headerview addSubview:downlab];
    
    newpersonlab.textColor = [RHUtility colorForHex:@"#09AEB0"];
    if (section ==0) {
        newpersonlab.text = @"项目集合";
    }else{
        newpersonlab.text = @"散标专区";
    }
   
    
    if (self.newpeopleress == YES) {
        
        if (section ==1) {
            newpersonlab.text = @"项目集合";
        }else if(section==2){
            newpersonlab.text = @"散标专区";
        }else{
            newpersonlab.text = @"新手专区";
        }
    
    
    }else{
        if ([self.projectLocal isEqualToString:@"LFSA"]) {
            if (section ==0) {
                newpersonlab.text = @"项目集合";
            }else{
                newpersonlab.text = @"散标专区";
            }
        }else{
            if (section ==0) {
                newpersonlab.text = @"散标专区";
            }else{
                newpersonlab.text = @"项目集合";
            }
        }
        
        
    }
    return headerview;
    
    
//    return nil;

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //分组数 也就是section数
    if (self.dataArray.count>0&&self.xmjarray.count>0) {
        if (self.newpeopleress == YES) {
            return 3;
        }else{
            
            return 2;
        }
    }else{
        return 0;
    }
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (self.newpeopleress == YES) {
        if (section==0) {
            return 0;
        }
    }
    
    return 45;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 42;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (dataArray.count<3) {
        return 125;
    }
    if (indexPath.row==1) {
        return 125;
    }
    if (indexPath.row==0) {
        return 125;
    }
    return 125;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
//    self.scrview .contentSize =  CGSizeMake([UIScreen mainScreen].bounds.size.width,675*1.4+10-30+30+25+64+20+46);
    
    if (self.newpeopleress == YES) {
        if (section==0) {
            return 1;
        }else if (section==2){
            
            return 2;
        }else{
            
            return 2;
        }
    }else{
        if (self.dataArray.count>0&&self.xmjarray.count>0) {
            return 2;
        }
        return 0;
        
        
    }
    
    if (dataArray.count<3) {
        return 3;
    }
    return 3;
    
        if (section == 0) {
            if (self.newdic.count > 2) {
                 return 5;
            }else{
               return 5;
            }
        }
         if (dataArray.count>4) {
             return 4;
         }
         return dataArray.count;
//     }else{
//         if ([UIScreen mainScreen].bounds.size.height > 670) {
//             self.scrview .contentSize =  CGSizeMake([UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height*1.1+140-30-35+30+25);
//         }else if ([UIScreen mainScreen].bounds.size.height > 570 && [UIScreen mainScreen].bounds.size.height< 670){
//             self.scrview .contentSize =  CGSizeMake([UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height*1.4+10-30-35+7+30+25);
//             
//         }else{
//             self.scrview .contentSize =  CGSizeMake([UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height*1.4+120-35+20+10);
//         }
//         
//         if ([UIScreen mainScreen].bounds.size.height < 481){
//             
//             
//             self.scrview.contentSize =  CGSizeMake([UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height*1.4+120-35+150-20);
//         }
         if (dataArray.count>4) {
             return 5;
         }
         return dataArray.count;
//     }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    
   // if ([UIScreen mainScreen].bounds.size.height >570) {
   
    NSDictionary* dataDic;
    if (self.newpeopleress == YES) {
        
        if (indexPath.section==0) {
            dataDic = self.newdic;
        }else if (indexPath.section==1){
             if ([self.projectLocal isEqualToString:@"LFSA"]) {
            dataDic = [self.xmjarray objectAtIndex:indexPath.row];
             }else{
                  dataDic = [self.dataArray objectAtIndex:indexPath.row];
             }
            
        }else{
            if ([self.projectLocal isEqualToString:@"LFSA"]) {
                 dataDic = [self.dataArray objectAtIndex:indexPath.row];
            }else{
                dataDic = [self.xmjarray objectAtIndex:indexPath.row];
            }
            
            
        }
        
        static NSString *CellIdentifier = @"CellIdentifier";
        RHMainViewCell *cell = (RHMainViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"RHMainViewCell" owner:nil options:nil] objectAtIndex:0];
        }
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
        cell.lilv  = string;
        
        
        if (indexPath.section==0) {
             [cell updateCell:dataDic];
            cell.myblock =^{
                [self toubiao:dataDic newpeople:YES myxmj:NO];
            };
        }else if (indexPath.section==1){
            
            if ([self.projectLocal isEqualToString:@"LFSA"]) {
                [cell updatexmjCell:dataDic[@"cell"]];
                cell.myblock =^{
                    [self toubiao:dataDic newpeople:NO myxmj:YES];
                };
            }else{
                [cell updateCell:dataDic];
                cell.myblock =^{
                    [self toubiao:dataDic newpeople:NO myxmj:NO];
                };
            }
            
            
            
        }else{
            
            if ([self.projectLocal isEqualToString:@"SALF"]) {
                [cell updatexmjCell:dataDic[@"cell"]];
                cell.myblock =^{
                    [self toubiao:dataDic newpeople:NO myxmj:YES];
                };
            }else{
                [cell updateCell:dataDic];
                cell.myblock =^{
                    [self toubiao:dataDic newpeople:NO myxmj:NO];
                };
            }
            
//             [cell updateCell:dataDic];
//            cell.myblock =^{
//                [self toubiao:dataDic newpeople:NO myxmj:NO];
//            };
        }
        
       
        
        
        return cell;
        
    }else{
        NSDictionary* dataDic;
//        if (indexPath.section==0) {
//            dataDic = [self.xmjarray objectAtIndex:indexPath.row];
//
//
//        }else{
//             dataDic = [self.dataArray objectAtIndex:indexPath.row];
//
//        }
        
        if (indexPath.section==0){
            if ([self.projectLocal isEqualToString:@"LFSA"]) {
                dataDic = [self.xmjarray objectAtIndex:indexPath.row];
            }else{
                dataDic = [self.dataArray objectAtIndex:indexPath.row];
            }
            
        }else{
            if ([self.projectLocal isEqualToString:@"LFSA"]) {
                dataDic = [self.dataArray objectAtIndex:indexPath.row];
            }else{
                dataDic = [self.xmjarray objectAtIndex:indexPath.row];
            }
            
            
        }
        
        static NSString *CellIdentifier = @"CellIdentifier";
        RHMainViewCell *cell = (RHMainViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"RHMainViewCell" owner:nil options:nil] objectAtIndex:0];
        }
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
        cell.lilv  = string;
       
        
//         if (indexPath.section==0){
//
//            [cell updatexmjCell:dataDic[@"cell"]];
//             cell.myblock =^{
//                 [self toubiao:dataDic newpeople:NO myxmj:YES];
//             };
//        }else{
//            [cell updateCell:dataDic];
//            cell.myblock =^{
//                [self toubiao:dataDic newpeople:NO myxmj:NO];
//            };
//        }
     
        if (indexPath.section==0){
            
            if ([self.projectLocal isEqualToString:@"LFSA"]) {
                [cell updatexmjCell:dataDic[@"cell"]];
                cell.myblock =^{
                    [self toubiao:dataDic newpeople:NO myxmj:YES];
                };
            }else{
                [cell updateCell:dataDic];
                cell.myblock =^{
                    [self toubiao:dataDic newpeople:NO myxmj:NO];
                };
            }
            
            
            
        }else{
            
            if ([self.projectLocal isEqualToString:@"SALF"]) {
                [cell updatexmjCell:dataDic[@"cell"]];
                cell.myblock =^{
                    [self toubiao:dataDic newpeople:NO myxmj:YES];
                };
            }else{
                [cell updateCell:dataDic];
                cell.myblock =^{
                    [self toubiao:dataDic newpeople:NO myxmj:NO];
                };
            }
            
            //             [cell updateCell:dataDic];
            //            cell.myblock =^{
            //                [self toubiao:dataDic newpeople:NO myxmj:NO];
            //            };
        }
        
        return cell;
        
    }
    
 
    
    
    
        static NSString *CellIdentifier = @"CellIdentifier";
        RHMainViewCell *cell = (RHMainViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"RHMainViewCell" owner:nil options:nil] objectAtIndex:0];
            
            
        }
//        cell.xiangouimage.hidden = YES;
    
        return cell;
    
    
    
    if (indexPath.row==1) {
        RHMainTableViewCell * cell =  [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier1"];
        if (cell ==nil) {
            cell =[[[NSBundle mainBundle] loadNibNamed:@"RHMainTableViewCell" owner:nil options:nil] objectAtIndex:0];
        }
        cell.nav = self.navigationController;
        [cell updateCell:self.collectionArr];
        return cell;
    }else{
        
        if (self.newpeopleress == YES&&indexPath.row==0) {
            static NSString *CellIdentifier = @"rhmaincell";
            RHNewMainCell * cell = (RHNewMainCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"RHNewMainCell" owner:nil options:nil] objectAtIndex:0];
                
            }
            [cell updataNewPeopleCell:self.newdic];
            return cell;
            
        }else{
            
            if (indexPath.row==0&&[[RHhelper ShraeHelp].xmjswitch isEqualToString:@"ON"]) {
                RHXMJTableViewCell * cell = (RHXMJTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"xmjcell"];
                if (cell == nil) {
                    cell = [[[NSBundle mainBundle] loadNibNamed:@"RHXMJTableViewCell" owner:nil options:nil] objectAtIndex:0];
                    
                }
                [cell.didbtn addTarget:self action:@selector(pushxmj) forControlEvents:UIControlEventTouchUpInside];
                cell.lilvlab.text = [RHhelper ShraeHelp].xmjlilv;
                cell.mouthlab.text = [RHhelper ShraeHelp].xmjmouth;
//                [cell updataNewPeopleCell:self.newdic];
                return cell;
            }
            
            static NSString *CellIdentifier = @"CellIdentifier";
            RHMainViewCell *cell = (RHMainViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"RHMainViewCell" owner:nil options:nil] objectAtIndex:0];
            }
            long a=0;
            if (!self.newpeopleress == YES){
                if (indexPath.row==0) {
                    a=indexPath.row;
                }else{
                    a = indexPath.row-1;
                }
            }else{
                
                a = indexPath.row-2;
            }
            
            NSDictionary* dataDic=[self.dataArray objectAtIndex:a];
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
            cell.lilv  = string;
            cell.myblock =^{
                [self toubiao:dataDic newpeople:NO myxmj:NO];
            };
            [cell updateCell:dataDic];
          
            
            return cell;

        }
    }
    

    
    
    //-----------------------
    
     if (self.newpeopleress == YES) {
    
         
         
    static NSString *CellIdentifier = @"CellIdentifier";
    RHMainViewCell *cell = (RHMainViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
         
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"RHMainViewCell" owner:nil options:nil] objectAtIndex:0];
    }
//    cell.myblock =^{
//        [self toubiao:[self.dataArray objectAtIndex:indexPath.row]];
//    };
         
        if (indexPath.section ==0 ) {
            cell.res = YES;
            cell.customView.backgroundColor = [UIColor whiteColor];
            NSString  * string = [NSString stringWithFormat:@"%@",self.newdic[@"investorRate"]];
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
            
            cell.newpeopleimage.hidden = NO;
            cell.lilv  = string;
            cell.myblock =^{
                [self toubiao:self.newdic newpeople:YES myxmj:NO] ;
            };
            [cell updateCell:self.newdic];
            cell.xiangouimage.hidden = YES;
        }else{
        
       
    NSDictionary* dataDic=[self.dataArray objectAtIndex:indexPath.row];
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
    cell.lilv  = string;
            cell.myblock =^{
                cell.myblock =^{
                    [self toubiao:dataDic newpeople:NO myxmj:NO];
                };
            };
    [cell updateCell:dataDic];
    }
         
    return cell;
     }else{
         
         static NSString *CellIdentifier = @"CellIdentifier";
         RHMainViewCell *cell = (RHMainViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
         if (cell == nil) {
             cell = [[[NSBundle mainBundle] loadNibNamed:@"RHMainViewCell" owner:nil options:nil] objectAtIndex:0];
         }
    
         NSDictionary* dataDic=[self.dataArray objectAtIndex:indexPath.row];
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
         cell.lilv  = string;
         cell.myblock =^{
             cell.myblock =^{
                 [self toubiao:dataDic newpeople:NO myxmj:NO];
             };
         };
         [cell updateCell:dataDic];
     
    
       return cell;
         
     }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.subviews.firstObject.alpha = 5.00;
//    NSArray * allkearray = [self.newdic allKeys];
   // if ([UIScreen mainScreen].bounds.size.height>580) {
    
    NSDictionary* Dic;
    NSDictionary* dataDic;
    if (self.newpeopleress == YES) {
        
        if (indexPath.section==0) {
//            dataDic = self.newdic;
            
            RHNEWpeopleViewController * controller = [[RHNEWpeopleViewController alloc]initWithNibName:@"RHNEWpeopleViewController" bundle:nil];
            //            NSDictionary* dataDic=[self.segment1Array objectAtIndex:indexPath.row];
            //            controller.newpeopletype = YES;
            //
            //
            if (self.newpeoplebool == NO) {
                controller.judge = @"ketou";
            }
            controller.dataDic=self.newdic;
            controller.getType=type;
           
            NSString * projectStatus;
            if (![[self.newdic objectForKey:@"percent"] isKindOfClass:[NSNull class]]) {
                projectStatus=[self.newdic objectForKey:@"projectStatus"] ;
                
            }
            if ([projectStatus isEqualToString:@"finished"]) {
                
                controller.zhaungtaistr =  @"还款完毕";
                
            }else if ([projectStatus isEqualToString:@"repayment_normal"]||[projectStatus isEqualToString:@"repayment_abnormal"]){
                
                controller.zhaungtaistr =@"还款中";
                
            }else if ([projectStatus isEqualToString:@"loans"]||[projectStatus isEqualToString:@"loans_audit"]){
                
                controller.zhaungtaistr =@"项目审核";
                
            }else if ([projectStatus isEqualToString:@"full"]){
                
                controller.zhaungtaistr =@"已满标";
                
            }else if ([projectStatus isEqualToString:@"publishedWaiting"]){
                
                controller.zhaungtaistr =@"稍后出借";
                
            }
            [self.navigationController pushViewController:controller animated:NO];
            return;
            
        }else if (indexPath.section==1){
            
            if ([self.projectLocal isEqualToString:@"LFSA"]) {
                Dic = [self.xmjarray objectAtIndex:indexPath.row];
                dataDic = [self.xmjarray objectAtIndex:indexPath.row];
                
                RHXMJProjectViewController * xmjcontroller = [[RHXMJProjectViewController alloc]initWithNibName:@"RHXMJProjectViewController" bundle:nil];
                
                
                //            xmjcontroller.lilv = string;
                xmjcontroller.datadic=dataDic;
                NSString * projectStatus;
                if (![[Dic objectForKey:@"percent"] isKindOfClass:[NSNull class]]) {
                    projectStatus=[Dic objectForKey:@"projectStatus"] ;
                    
                }
                if ([projectStatus isEqualToString:@"finished"]) {
                    
                    xmjcontroller.zhuangtaistr =  @"还款完毕";
                    
                }else if ([projectStatus isEqualToString:@"repayment_normal"]||[projectStatus isEqualToString:@"repayment_abnormal"]){
                    
                    xmjcontroller.zhuangtaistr =@"还款中";
                    
                }else if ([projectStatus isEqualToString:@"loans"]||[projectStatus isEqualToString:@"loans_audit"]){
                    
                    xmjcontroller.zhuangtaistr =@"项目审核";
                    
                }else if ([projectStatus isEqualToString:@"full"]){
                    
                    xmjcontroller.zhuangtaistr =@"已满标";
                    
                }else if ([projectStatus isEqualToString:@"publishedWaiting"]){
                    
                    xmjcontroller.zhuangtaistr =@"稍后出借";
                    
                }
                [RYHViewController Sharedbxtabar].tarbar.hidden = YES;
                
                [self.navigationController pushViewController:xmjcontroller animated:NO];
            }else{
                
                Dic = [self.dataArray objectAtIndex:indexPath.row];
                dataDic =  [self.segment1Array objectAtIndex:indexPath.row];
                RHProjectdetailthreeViewController * controller = [[RHProjectdetailthreeViewController alloc]initWithNibName:@"RHProjectdetailthreeViewController" bundle:nil];
                
                //        RHXMJProjectViewController * xmjcontroller = [[RHXMJProjectViewController alloc]initWithNibName:@"RHXMJProjectViewController" bundle:nil];
                
                
                
                
                
                //            NSString * xmjstr;
                //            if (dataDic[@"isProjectList"]&&![dataDic[@"isProjectList"] isKindOfClass:[NSNull class]]) {
                //                xmjstr = [NSString stringWithFormat:@"%@",dataDic[@"isProjectList"]];
                //            }
                //
                
                
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
                controller.getType=@"0";
                
                //controller.view.frame = CGRectMake(0, 0, self.view.frame.size.width, 700);
                //controller.view.backgroundColor = [UIColor orangeColor];
                NSString * projectStatus;
                if (![[Dic objectForKey:@"percent"] isKindOfClass:[NSNull class]]) {
                    projectStatus=[Dic objectForKey:@"projectStatus"] ;
                    
                }
                if ([projectStatus isEqualToString:@"finished"]) {
                    
                    controller.zhaungtaistr =  @"还款完毕";
                    
                }else if ([projectStatus isEqualToString:@"repayment_normal"]||[projectStatus isEqualToString:@"repayment_abnormal"]){
                    
                    controller.zhaungtaistr =@"还款中";
                    
                }else if ([projectStatus isEqualToString:@"loans"]||[projectStatus isEqualToString:@"loans_audit"]){
                    
                    controller.zhaungtaistr =@"项目审核";
                    
                }else if ([projectStatus isEqualToString:@"full"]){
                    
                    controller.zhaungtaistr =@"已满标";
                    
                }else if ([projectStatus isEqualToString:@"publishedWaiting"]){
                    
                    controller.zhaungtaistr =@"稍后出借";
                    
                }
                
                [self.navigationController pushViewController:controller animated:NO];
            }
            
           
            
        }else{
            
            if ([self.projectLocal isEqualToString:@"SALF"]) {
                Dic = [self.xmjarray objectAtIndex:indexPath.row];
                dataDic = [self.xmjarray objectAtIndex:indexPath.row];
                
                RHXMJProjectViewController * xmjcontroller = [[RHXMJProjectViewController alloc]initWithNibName:@"RHXMJProjectViewController" bundle:nil];
                
                
                //            xmjcontroller.lilv = string;
                xmjcontroller.datadic=dataDic;
                NSString * projectStatus;
                if (![[Dic objectForKey:@"percent"] isKindOfClass:[NSNull class]]) {
                    projectStatus=[Dic objectForKey:@"projectStatus"] ;
                    
                }
                if ([projectStatus isEqualToString:@"finished"]) {
                    
                    xmjcontroller.zhuangtaistr =  @"还款完毕";
                    
                }else if ([projectStatus isEqualToString:@"repayment_normal"]||[projectStatus isEqualToString:@"repayment_abnormal"]){
                    
                    xmjcontroller.zhuangtaistr =@"还款中";
                    
                }else if ([projectStatus isEqualToString:@"loans"]||[projectStatus isEqualToString:@"loans_audit"]){
                    
                    xmjcontroller.zhuangtaistr =@"项目审核";
                    
                }else if ([projectStatus isEqualToString:@"full"]){
                    
                    xmjcontroller.zhuangtaistr =@"已满标";
                    
                }else if ([projectStatus isEqualToString:@"publishedWaiting"]){
                    
                    xmjcontroller.zhuangtaistr =@"稍后出借";
                    
                }
                [RYHViewController Sharedbxtabar].tarbar.hidden = YES;
                
                [self.navigationController pushViewController:xmjcontroller animated:NO];
            }else{
                
                Dic = [self.dataArray objectAtIndex:indexPath.row];
                dataDic =  [self.segment1Array objectAtIndex:indexPath.row];
                RHProjectdetailthreeViewController * controller = [[RHProjectdetailthreeViewController alloc]initWithNibName:@"RHProjectdetailthreeViewController" bundle:nil];
                
                //        RHXMJProjectViewController * xmjcontroller = [[RHXMJProjectViewController alloc]initWithNibName:@"RHXMJProjectViewController" bundle:nil];
                
                
                
                
                
                //            NSString * xmjstr;
                //            if (dataDic[@"isProjectList"]&&![dataDic[@"isProjectList"] isKindOfClass:[NSNull class]]) {
                //                xmjstr = [NSString stringWithFormat:@"%@",dataDic[@"isProjectList"]];
                //            }
                //
                
                
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
                controller.getType=@"0";
                
                //controller.view.frame = CGRectMake(0, 0, self.view.frame.size.width, 700);
                //controller.view.backgroundColor = [UIColor orangeColor];
                NSString * projectStatus;
                if (![[Dic objectForKey:@"percent"] isKindOfClass:[NSNull class]]) {
                    projectStatus=[Dic objectForKey:@"projectStatus"] ;
                    
                }
                if ([projectStatus isEqualToString:@"finished"]) {
                    
                    controller.zhaungtaistr =  @"还款完毕";
                    
                }else if ([projectStatus isEqualToString:@"repayment_normal"]||[projectStatus isEqualToString:@"repayment_abnormal"]){
                    
                    controller.zhaungtaistr =@"还款中";
                    
                }else if ([projectStatus isEqualToString:@"loans"]||[projectStatus isEqualToString:@"loans_audit"]){
                    
                    controller.zhaungtaistr =@"项目审核";
                    
                }else if ([projectStatus isEqualToString:@"full"]){
                    
                    controller.zhaungtaistr =@"已满标";
                    
                }else if ([projectStatus isEqualToString:@"publishedWaiting"]){
                    
                    controller.zhaungtaistr =@"稍后出借";
                    
                }
                
                [self.navigationController pushViewController:controller animated:NO];
            }
            
            
            
            
         
        }
        
        
        
            return;
        
        
        
    }else{
        
        
        if (indexPath.section==0){
            
            if ([self.projectLocal isEqualToString:@"LFSA"]) {
                Dic = [self.xmjarray objectAtIndex:indexPath.row];
                dataDic = [self.xmjarray objectAtIndex:indexPath.row];
                
                RHXMJProjectViewController * xmjcontroller = [[RHXMJProjectViewController alloc]initWithNibName:@"RHXMJProjectViewController" bundle:nil];
                
                
                //            xmjcontroller.lilv = string;
                xmjcontroller.datadic=dataDic;
                NSString * projectStatus;
                if (![[Dic objectForKey:@"percent"] isKindOfClass:[NSNull class]]) {
                    projectStatus=[Dic objectForKey:@"projectStatus"] ;
                    
                }
                if ([projectStatus isEqualToString:@"finished"]) {
                    
                    xmjcontroller.zhuangtaistr =  @"还款完毕";
                    
                }else if ([projectStatus isEqualToString:@"repayment_normal"]||[projectStatus isEqualToString:@"repayment_abnormal"]){
                    
                    xmjcontroller.zhuangtaistr =@"还款中";
                    
                }else if ([projectStatus isEqualToString:@"loans"]||[projectStatus isEqualToString:@"loans_audit"]){
                    
                    xmjcontroller.zhuangtaistr =@"项目审核";
                    
                }else if ([projectStatus isEqualToString:@"full"]){
                    
                    xmjcontroller.zhuangtaistr =@"已满标";
                    
                }else if ([projectStatus isEqualToString:@"publishedWaiting"]){
                    
                    xmjcontroller.zhuangtaistr =@"稍后出借";
                    
                }
                [RYHViewController Sharedbxtabar].tarbar.hidden = YES;
                
                [self.navigationController pushViewController:xmjcontroller animated:NO];
            }else{
                
                
                
                
                
                Dic = [self.dataArray objectAtIndex:indexPath.row];
                dataDic =  [self.segment1Array objectAtIndex:indexPath.row];
                RHProjectdetailthreeViewController * controller = [[RHProjectdetailthreeViewController alloc]initWithNibName:@"RHProjectdetailthreeViewController" bundle:nil];
                
                //        RHXMJProjectViewController * xmjcontroller = [[RHXMJProjectViewController alloc]initWithNibName:@"RHXMJProjectViewController" bundle:nil];
                
                
                
                
                
                //            NSString * xmjstr;
                //            if (dataDic[@"isProjectList"]&&![dataDic[@"isProjectList"] isKindOfClass:[NSNull class]]) {
                //                xmjstr = [NSString stringWithFormat:@"%@",dataDic[@"isProjectList"]];
                //            }
                //
                
                
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
                controller.getType=@"0";
                
                //controller.view.frame = CGRectMake(0, 0, self.view.frame.size.width, 700);
                //controller.view.backgroundColor = [UIColor orangeColor];
                NSString * projectStatus;
                if (![[Dic objectForKey:@"percent"] isKindOfClass:[NSNull class]]) {
                    projectStatus=[Dic objectForKey:@"projectStatus"] ;
                    
                }
                if ([projectStatus isEqualToString:@"finished"]) {
                    
                    controller.zhaungtaistr =  @"还款完毕";
                    
                }else if ([projectStatus isEqualToString:@"repayment_normal"]||[projectStatus isEqualToString:@"repayment_abnormal"]){
                    
                    controller.zhaungtaistr =@"还款中";
                    
                }else if ([projectStatus isEqualToString:@"loans"]||[projectStatus isEqualToString:@"loans_audit"]){
                    
                    controller.zhaungtaistr =@"项目审核";
                    
                }else if ([projectStatus isEqualToString:@"full"]){
                    
                    controller.zhaungtaistr =@"已满标";
                    
                }else if ([projectStatus isEqualToString:@"publishedWaiting"]){
                    
                    controller.zhaungtaistr =@"稍后出借";
                    
                }
                
                [self.navigationController pushViewController:controller animated:NO];
            }
            
            
            
            
//            Dic = [self.xmjarray objectAtIndex:indexPath.row];
//            dataDic = [self.xmjarray objectAtIndex:indexPath.row];
//
//            RHXMJProjectViewController * xmjcontroller = [[RHXMJProjectViewController alloc]initWithNibName:@"RHXMJProjectViewController" bundle:nil];
//
//
//            //            xmjcontroller.lilv = string;
//            xmjcontroller.datadic=dataDic;
//            NSString * projectStatus;
//            if (![[Dic objectForKey:@"cell"] isKindOfClass:[NSNull class]]) {
//
//
//                projectStatus=[Dic objectForKey:@"cell"][@"projectStatus"] ;
//
//            }
//            if ([projectStatus isEqualToString:@"finished"]) {
//
//                xmjcontroller.zhuangtaistr =  @"还款完毕";
//
//            }else if ([projectStatus isEqualToString:@"repayment_normal"]||[projectStatus isEqualToString:@"repayment_abnormal"]){
//
//                xmjcontroller.zhuangtaistr =@"还款中";
//
//            }else if ([projectStatus isEqualToString:@"loans"]||[projectStatus isEqualToString:@"loans_audit"]){
//
//                xmjcontroller.zhuangtaistr =@"项目审核";
//
//            }else if ([projectStatus isEqualToString:@"full"]){
//
//                xmjcontroller.zhuangtaistr =@"已满标";
//
//            }else if ([projectStatus isEqualToString:@"publishedWaiting"]){
//
//                xmjcontroller.zhuangtaistr =@"稍后出借";
//
//            }
//            [RYHViewController Sharedbxtabar].tarbar.hidden = YES;
//
//            [self.navigationController pushViewController:xmjcontroller animated:NO];
            
        }else{
            
            
            
            
            if ([self.projectLocal isEqualToString:@"SALF"]) {
                Dic = [self.xmjarray objectAtIndex:indexPath.row];
                dataDic = [self.xmjarray objectAtIndex:indexPath.row];
                
                RHXMJProjectViewController * xmjcontroller = [[RHXMJProjectViewController alloc]initWithNibName:@"RHXMJProjectViewController" bundle:nil];
                
                
                //            xmjcontroller.lilv = string;
                xmjcontroller.datadic=dataDic;
                NSString * projectStatus;
                if (![[Dic objectForKey:@"percent"] isKindOfClass:[NSNull class]]) {
                    projectStatus=[Dic objectForKey:@"projectStatus"] ;
                    
                }
                if ([projectStatus isEqualToString:@"finished"]) {
                    
                    xmjcontroller.zhuangtaistr =  @"还款完毕";
                    
                }else if ([projectStatus isEqualToString:@"repayment_normal"]||[projectStatus isEqualToString:@"repayment_abnormal"]){
                    
                    xmjcontroller.zhuangtaistr =@"还款中";
                    
                }else if ([projectStatus isEqualToString:@"loans"]||[projectStatus isEqualToString:@"loans_audit"]){
                    
                    xmjcontroller.zhuangtaistr =@"项目审核";
                    
                }else if ([projectStatus isEqualToString:@"full"]){
                    
                    xmjcontroller.zhuangtaistr =@"已满标";
                    
                }else if ([projectStatus isEqualToString:@"publishedWaiting"]){
                    
                    xmjcontroller.zhuangtaistr =@"稍后出借";
                    
                }
                [RYHViewController Sharedbxtabar].tarbar.hidden = YES;
                
                [self.navigationController pushViewController:xmjcontroller animated:NO];
            }else{
                
                Dic = [self.dataArray objectAtIndex:indexPath.row];
                dataDic =  [self.segment1Array objectAtIndex:indexPath.row];
                RHProjectdetailthreeViewController * controller = [[RHProjectdetailthreeViewController alloc]initWithNibName:@"RHProjectdetailthreeViewController" bundle:nil];
                
             
                
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
                controller.getType=@"0";
                
                //controller.view.frame = CGRectMake(0, 0, self.view.frame.size.width, 700);
                //controller.view.backgroundColor = [UIColor orangeColor];
                NSString * projectStatus;
                if (![[Dic objectForKey:@"percent"] isKindOfClass:[NSNull class]]) {
                    projectStatus=[Dic objectForKey:@"projectStatus"] ;
                    
                }
                if ([projectStatus isEqualToString:@"finished"]) {
                    
                    controller.zhaungtaistr =  @"还款完毕";
                    
                }else if ([projectStatus isEqualToString:@"repayment_normal"]||[projectStatus isEqualToString:@"repayment_abnormal"]){
                    
                    controller.zhaungtaistr =@"还款中";
                    
                }else if ([projectStatus isEqualToString:@"loans"]||[projectStatus isEqualToString:@"loans_audit"]){
                    
                    controller.zhaungtaistr =@"项目审核";
                    
                }else if ([projectStatus isEqualToString:@"full"]){
                    
                    controller.zhaungtaistr =@"已满标";
                    
                }else if ([projectStatus isEqualToString:@"publishedWaiting"]){
                    
                    controller.zhaungtaistr =@"稍后出借";
                    
                }
                
                [self.navigationController pushViewController:controller animated:NO];
            }
            
            
//            Dic = [self.dataArray objectAtIndex:indexPath.row];
//            dataDic =  [self.segment1Array objectAtIndex:indexPath.row];
//            RHProjectdetailthreeViewController * controller = [[RHProjectdetailthreeViewController alloc]initWithNibName:@"RHProjectdetailthreeViewController" bundle:nil];
//
//
//
//
//            NSString  * string = [NSString stringWithFormat:@"%@",dataDic[@"investorRate"]];
//            //dataDic[@"investorRate"] = (id)string
//            if (string.length > 5) {
//                NSArray *array = [string componentsSeparatedByString:@"."];
//                string = array.lastObject;
//                string =  [string substringToIndex:2];
//
//                int a = [string intValue];
//
//                int b  = a /10;
//
//                int c = a - b * 10;
//
//                if (c > 5) {
//                    b= b+1;
//
//                    string = [NSString stringWithFormat:@"%@.%d",array.firstObject,b];
//                    // [dataDic setValue:string forKey:@"investorRate"];
//                    // dataDic[@"investorRate"] = string;
//                }else{
//
//                    string = [NSString stringWithFormat:@"%@.%d",array.firstObject,b];
//                    //[dataDic setValue:string forKey:@"investorRate"];
//
//                }
//            }
//
//
//            controller.lilv = string;
//
//            controller.dataDic=dataDic;
//            controller.getType=type;
//            controller.getType=@"0";
//            //controller.view.frame = CGRectMake(0, 0, self.view.frame.size.width, 700);
//            //controller.view.backgroundColor = [UIColor orangeColor];
//            NSString * projectStatus;
//            if (![[Dic objectForKey:@"percent"] isKindOfClass:[NSNull class]]) {
//                projectStatus=[Dic objectForKey:@"projectStatus"] ;
//
//            }
//            if ([projectStatus isEqualToString:@"finished"]) {
//
//                controller.zhaungtaistr =  @"还款完毕";
//
//            }else if ([projectStatus isEqualToString:@"repayment_normal"]||[projectStatus isEqualToString:@"repayment_abnormal"]){
//
//                controller.zhaungtaistr =@"还款中";
//
//            }else if ([projectStatus isEqualToString:@"loans"]||[projectStatus isEqualToString:@"loans_audit"]){
//
//                controller.zhaungtaistr =@"项目审核";
//
//            }else if ([projectStatus isEqualToString:@"full"]){
//
//                controller.zhaungtaistr =@"已满标";
//
//            }else if ([projectStatus isEqualToString:@"publishedWaiting"]){
//
//                controller.zhaungtaistr =@"稍后出借";
//
//            }
//
//            [self.navigationController pushViewController:controller animated:NO];
        }
        
        
        
        return;
        
        
    }
    
    
    
    
    
    if (indexPath.row==0&&[[RHhelper ShraeHelp].xmjswitch isEqualToString:@"ON"]) {
        
        [self pushxmj];
        return;
    }
    
    
    
    
    
    
    
    if (self.newdic.count<2) {
        long a=0;
        
            if (indexPath.row==0) {
                a=indexPath.row;
            }else{
                a = indexPath.row-1;
            }
        if (self.dataArray.count<1) {
            return;
        }
        NSDictionary* Dic=[self.dataArray objectAtIndex:a];
        RHProjectdetailthreeViewController * controller = [[RHProjectdetailthreeViewController alloc]initWithNibName:@"RHProjectdetailthreeViewController" bundle:nil];
        
        RHXMJProjectViewController * xmjcontroller = [[RHXMJProjectViewController alloc]initWithNibName:@"RHXMJProjectViewController" bundle:nil];
        
       
        
        NSDictionary* dataDic=[self.segment1Array objectAtIndex:a];
        
        NSString * xmjstr;
        if (dataDic[@"isProjectList"]&&![dataDic[@"isProjectList"] isKindOfClass:[NSNull class]]) {
            xmjstr = [NSString stringWithFormat:@"%@",dataDic[@"isProjectList"]];
        }
        
        
        
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
        
        if ([xmjstr isEqualToString:@"yes"]) {
            
            xmjcontroller.lilv = string;
            xmjcontroller.datadic=dataDic;
            NSString * projectStatus;
            if (![[Dic objectForKey:@"percent"] isKindOfClass:[NSNull class]]) {
                projectStatus=[Dic objectForKey:@"projectStatus"] ;
                
            }
            if ([projectStatus isEqualToString:@"finished"]) {
                
                xmjcontroller.zhuangtaistr =  @"还款完毕";
                
            }else if ([projectStatus isEqualToString:@"repayment_normal"]||[projectStatus isEqualToString:@"repayment_abnormal"]){
                
                xmjcontroller.zhuangtaistr =@"还款中";
                
            }else if ([projectStatus isEqualToString:@"loans"]||[projectStatus isEqualToString:@"loans_audit"]){
                
                xmjcontroller.zhuangtaistr =@"项目审核";
                
            }else if ([projectStatus isEqualToString:@"full"]){
                
                xmjcontroller.zhuangtaistr =@"已满标";
                
            }else if ([projectStatus isEqualToString:@"publishedWaiting"]){
                
                xmjcontroller.zhuangtaistr =@"稍后出借";
                
            }
            [RYHViewController Sharedbxtabar].tarbar.hidden = YES;
            
            [self.navigationController pushViewController:xmjcontroller animated:NO];
            return;
            
        }else{
            controller.lilv = string;
            
            controller.dataDic=dataDic;
            controller.getType=type;
            
            //controller.view.frame = CGRectMake(0, 0, self.view.frame.size.width, 700);
            //controller.view.backgroundColor = [UIColor orangeColor];
            NSString * projectStatus;
            if (![[Dic objectForKey:@"percent"] isKindOfClass:[NSNull class]]) {
                projectStatus=[Dic objectForKey:@"projectStatus"] ;
                
            }
            if ([projectStatus isEqualToString:@"finished"]) {
                
                controller.zhaungtaistr =  @"还款完毕";
                
            }else if ([projectStatus isEqualToString:@"repayment_normal"]||[projectStatus isEqualToString:@"repayment_abnormal"]){
                
                controller.zhaungtaistr =@"还款中";
                
            }else if ([projectStatus isEqualToString:@"loans"]||[projectStatus isEqualToString:@"loans_audit"]){
                
                controller.zhaungtaistr =@"项目审核";
                
            }else if ([projectStatus isEqualToString:@"full"]){
                
                controller.zhaungtaistr =@"已满标";
                
            }else if ([projectStatus isEqualToString:@"publishedWaiting"]){
                
                controller.zhaungtaistr =@"稍后出借";
                
            }
            
            [self.navigationController pushViewController:controller animated:NO];
            return;
        }
        
        
    }else{
        
   
    
    
    if (indexPath.row == 0) {
        

        
            RHNEWpeopleViewController * controller = [[RHNEWpeopleViewController alloc]initWithNibName:@"RHNEWpeopleViewController" bundle:nil];
//            NSDictionary* dataDic=[self.segment1Array objectAtIndex:indexPath.row];
//            controller.newpeopletype = YES;
//            
//
        if (self.newpeoplebool == NO) {
            controller.judge = @"ketou";
        }
            controller.dataDic=self.newdic;
            controller.getType=type;
//            controller.newpeopletype =YES;
//            controller.postnewpeopletype = self.newpeoplebool;
//            //controller.view.frame = CGRectMake(0, 0, self.view.frame.size.width, 700);
//            //controller.view.backgroundColor = [UIColor orangeColor];
        NSString * projectStatus;
        if (![[self.newdic objectForKey:@"percent"] isKindOfClass:[NSNull class]]) {
            projectStatus=[self.newdic objectForKey:@"projectStatus"] ;
            
        }
        if ([projectStatus isEqualToString:@"finished"]) {
            
            controller.zhaungtaistr =  @"还款完毕";
            
        }else if ([projectStatus isEqualToString:@"repayment_normal"]||[projectStatus isEqualToString:@"repayment_abnormal"]){
            
            controller.zhaungtaistr =@"还款中";
            
        }else if ([projectStatus isEqualToString:@"loans"]||[projectStatus isEqualToString:@"loans_audit"]){
            
            controller.zhaungtaistr =@"项目审核";
            
        }else if ([projectStatus isEqualToString:@"full"]){
            
            controller.zhaungtaistr =@"已满标";
            
        }else if ([projectStatus isEqualToString:@"publishedWaiting"]){
            
            controller.zhaungtaistr =@"稍后出借";
            
        }
            [self.navigationController pushViewController:controller animated:NO];
//        }else{
//
//            [RHUtility showTextWithText:@"您已投资过，请看其余项目。"];
//        }
        
    }else{
        
        RHProjectdetailthreeViewController * controller = [[RHProjectdetailthreeViewController alloc]initWithNibName:@"RHProjectdetailthreeViewController" bundle:nil];
        long a=0;
        
        a = indexPath.row-2;
        NSDictionary* Dic=[self.dataArray objectAtIndex:a];
        NSDictionary* dataDic=[self.segment1Array objectAtIndex:a];
        
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
        
        //controller.view.frame = CGRectMake(0, 0, self.view.frame.size.width, 700);
        //controller.view.backgroundColor = [UIColor orangeColor];
        NSString * projectStatus;
        if (![[Dic objectForKey:@"percent"] isKindOfClass:[NSNull class]]) {
            projectStatus=[Dic objectForKey:@"projectStatus"] ;
           
        }
        if ([projectStatus isEqualToString:@"finished"]) {
            
            controller.zhaungtaistr =  @"还款完毕";
            
        }else if ([projectStatus isEqualToString:@"repayment_normal"]||[projectStatus isEqualToString:@"repayment_abnormal"]){
            
            controller.zhaungtaistr =@"还款中";
            
        }else if ([projectStatus isEqualToString:@"loans"]||[projectStatus isEqualToString:@"loans_audit"]){
            
            controller.zhaungtaistr =@"项目审核";
            
        }else if ([projectStatus isEqualToString:@"full"]){
            
            controller.zhaungtaistr =@"已满标";
            
        }else if ([projectStatus isEqualToString:@"publishedWaiting"]){
            
            controller.zhaungtaistr =@"稍后出借";
            
        }
        
        [self.navigationController pushViewController:controller animated:NO];
        
        
    }
        
        
    }

}

#pragma mark-Push
- (IBAction)pushUserCenter:(id)sender {
    [[[RHTabbarManager sharedInterface] selectTabbarUser] popToRootViewControllerAnimated:NO];
}

- (IBAction)pushMore:(id)sender {
    [[[RHTabbarManager sharedInterface] selectTabbarMore] popToRootViewControllerAnimated:NO];
}

- (IBAction)pushProjectList:(id)sender {
    
    //ddddd
    [self didSelectInvestment];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.subviews.firstObject.alpha = 5.00;
    self.mengbanview.hidden = YES;
    self.zhuanyiview.hidden = YES;
    [self removeScrollView];
    for (UIView *subView in [UIApplication sharedApplication].keyWindow.subviews) {
        if (subView.tag == 1000) {
            [subView removeFromSuperview];
        }
    }
    //关闭定时器
    [self.mainScorllView.animationTimer setFireDate:[NSDate distantFuture]];
    [self.mainScorllView.animationTimer pauseTimer];
    [self.timers invalidate];
    self.navgationrightView.hidden = YES;
    [super viewWillDisappear:animated];
}
- (IBAction)testbutton:(id)sender {
    
//    NSString * str = @"https://123.57.133.7/front/payment/account/queryBalance";
//    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    //manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    [manager.operationQueue cancelAllOperations];
    
//    [manager POST:str parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@",responseObject);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"-----");
//    }];
    NSLog(@"666666644343563645757");
//    

}

-(void)removeScrollView {
    [self.mySCrorllView.timer invalidate];
    self.mySCrorllView.timer = nil;
    if (self.mySCrorllView) {
        [self.mySCrorllView removeFromSuperview];
    }
    self.mySCrorllView = nil;
}





- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark PagedFlowView Delegate
- (CGSize)sizeForPageInFlowView:(PagedFlowView *)flowView;{
    CGFloat with = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = self.RHcbxview.frame.size.height;
    
    int a = with/3;
    int b = height -10 ;
//    return CGSizeMake(with/3, height-10);
    return CGSizeMake(a, b);
}

- (void)flowView:(PagedFlowView *)flowView didScrollToPageAtIndex:(NSInteger)index {
    
//    _wddbxindex = index;
    // NSLog(@"Scrolled to page # %ld", (long)index);
}

- (void)flowView:(PagedFlowView *)flowView didTapPageAtIndex:(NSInteger)index{
    NSLog(@"Tapped on page # %ld", (long)index);
    NSLog(@"%ld",(long)flowView.tag);
}

////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark PagedFlowView Datasource
//返回显示View的个数
- (NSInteger)numberOfPagesInFlowView:(PagedFlowView *)flowView{
    return [imageArray count];
}

//返回给某列使用的View
- (UIView *)flowView:(PagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    //    if (index > 5) {
    //        return nil;
    //    }
    
    CGFloat with = [UIScreen mainScreen].bounds.size.width;
   // CGFloat height = self.RHcbxview.frame.size.height;
    
    if (with > 410) {
        UIView * dbxview = [[UIView alloc]init];
        dbxview.backgroundColor = [UIColor whiteColor];
        UIImageView *imageView = [[UIImageView alloc]init];;
        if (!imageView) {
            imageView = [[UIImageView alloc] init];
            imageView.layer.cornerRadius = 6;
            imageView.layer.masksToBounds = YES;
        }
        imageView.image = [UIImage imageNamed:[imageArray objectAtIndex:index]];
        
        [dbxview addSubview:imageView];
        imageView.frame = CGRectMake(42, 5, 50, 50);
        // imageView.backgroundColor = [UIColor orangeColor];
        UILabel * lab = [[UILabel alloc]init];
        
        lab.text = titleArray[index];
        lab.frame = CGRectMake(10, 60, 120, 35);
        lab.textAlignment = NSTextAlignmentCenter;
        // lab.font = [UIFont fontWithName:@"STHeiti-Medium.ttc" size:17];
        lab.font = [UIFont boldSystemFontOfSize:23];
        
        [dbxview addSubview:lab];
        UILabel * lab1 = [[UILabel alloc]init];
        lab1.frame = CGRectMake(20, 98, 100, 20);
        lab1.text = baozhengArray[index];
        lab1.font = [UIFont boldSystemFontOfSize:13.0];
        lab1.textAlignment = NSTextAlignmentCenter;
        [dbxview addSubview:lab1];
        
        UILabel * lab2 = [[UILabel alloc]init];
        
        lab2.text = @"0";
        lab2.font = [UIFont boldSystemFontOfSize:43];
        lab2.frame =CGRectMake(20, 115, 100, 35);
        lab2.textAlignment = NSTextAlignmentCenter;
        [dbxview addSubview:lab2];
        
        
        UILabel * lab3 = [[UILabel alloc]init];
        
        lab3.text = @"可投";
        lab3.frame = CGRectMake(20, 160, 100, 12);
        
        lab3.font = [UIFont fontWithName:@"Arial" size:11.0];
        lab3.textAlignment = NSTextAlignmentCenter;
        [dbxview addSubview:lab3];
        
        
        lab1.textColor = [RHUtility colorForHex:@"bdbdbe"];
        lab3.textColor = [RHUtility colorForHex:@"bdbdbe"];
        if ([lab.text isEqualToString:@"益商贷"]) {
            lab2.textColor = [RHUtility colorForHex:@"44bbc1"];
        }else if ([lab.text isEqualToString:@"益学贷"]){
            lab2.textColor = [RHUtility colorForHex:@"f8ce5f"];
        }else if ([lab.text isEqualToString:@"益房贷"]){
            lab2.textColor = [RHUtility colorForHex:@"d4b689"];
        }else if ([lab.text isEqualToString:@"益车贷"]){
            lab2.textColor = [RHUtility colorForHex:@"75bbeb"];
        }else{
            lab2.textColor = [RHUtility colorForHex:@"f58cb8"];
        }
        return dbxview;
    }else if (with > 360&&with < 410){
        
        
        UIView * dbxview = [[UIView alloc]init];
        dbxview.backgroundColor = [UIColor whiteColor];
        UIImageView *imageView = [[UIImageView alloc]init];;
        if (!imageView) {
            imageView = [[UIImageView alloc] init];
            imageView.layer.cornerRadius = 6;
            imageView.layer.masksToBounds = YES;
        }
        imageView.image = [UIImage imageNamed:[imageArray objectAtIndex:index]];
        
        [dbxview addSubview:imageView];
        imageView.frame = CGRectMake(37, 5, 50, 50);
        // imageView.backgroundColor = [UIColor orangeColor];
        UILabel * lab = [[UILabel alloc]init];
        
        lab.text = titleArray[index];
        lab.frame = CGRectMake(10, 60, 100, 35);
        lab.textAlignment = NSTextAlignmentCenter;
        // lab.font = [UIFont fontWithName:@"STHeiti-Medium.ttc" size:17];
        lab.font = [UIFont boldSystemFontOfSize:23];
        
        [dbxview addSubview:lab];
        UILabel * lab1 = [[UILabel alloc]init];
        lab1.frame = CGRectMake(20, 98, 80, 20);
        lab1.text = baozhengArray[index];
        lab1.font = [UIFont boldSystemFontOfSize:13.0];
        lab1.textAlignment = NSTextAlignmentCenter;
        [dbxview addSubview:lab1];
        
        UILabel * lab2 = [[UILabel alloc]init];
        
        lab2.text = @"0";
        lab2.font = [UIFont boldSystemFontOfSize:43];
        lab2.frame =CGRectMake(20, 115, 80, 35);
        lab2.textAlignment = NSTextAlignmentCenter;
        [dbxview addSubview:lab2];
        
        
        UILabel * lab3 = [[UILabel alloc]init];
        
        lab3.text = @"可投";
        lab3.frame = CGRectMake(20, 160,80, 12);
        
        lab3.font = [UIFont boldSystemFontOfSize:11.0];
        lab3.textAlignment = NSTextAlignmentCenter;
        [dbxview addSubview:lab3];
        lab1.textColor = [RHUtility colorForHex:@"bdbdbe"];
        lab3.textColor = [RHUtility colorForHex:@"bdbdbe"];
        if ([lab.text isEqualToString:@"益商贷"]) {
            lab2.textColor = [RHUtility colorForHex:@"44bbc1"];
        }else if ([lab.text isEqualToString:@"益学贷"]){
            lab2.textColor = [RHUtility colorForHex:@"f8ce5f"];
        }else if ([lab.text isEqualToString:@"益房贷"]){
            lab2.textColor = [RHUtility colorForHex:@"d4b689"];
        }else if ([lab.text isEqualToString:@"益车贷"]){
            lab2.textColor = [RHUtility colorForHex:@"75bbeb"];
        }else{
            lab2.textColor = [RHUtility colorForHex:@"f58cb8"];
        }
        return dbxview;
        
        
    }else if (with <330){
        
        UIView * dbxview = [[UIView alloc]init];
        dbxview.backgroundColor = [UIColor whiteColor];
        UIImageView *imageView = [[UIImageView alloc]init];;
        if (!imageView) {
            imageView = [[UIImageView alloc] init];
            imageView.layer.cornerRadius = 6;
            imageView.layer.masksToBounds = YES;
        }
        imageView.image = [UIImage imageNamed:[imageArray objectAtIndex:index]];
        
        [dbxview addSubview:imageView];
        imageView.frame = CGRectMake(35, 10, 30, 30);
        // imageView.backgroundColor = [UIColor orangeColor];
        self.rhbxblab = [[UILabel alloc]init];
        
        self.rhbxblab.text = titleArray[index];
        self.rhbxblab.frame = CGRectMake(10, 45, 80, 30);
        self.rhbxblab.textAlignment = NSTextAlignmentCenter;
        // lab.font = [UIFont fontWithName:@"STHeiti-Medium.ttc" size:17];
        self.rhbxblab.font = [UIFont boldSystemFontOfSize:18];
        
        [dbxview addSubview:self.rhbxblab];
        UILabel * lab1 = [[UILabel alloc]init];
        lab1.frame = CGRectMake(20, 75, 60, 20);
        lab1.text = baozhengArray[index];
        lab1.font = [UIFont boldSystemFontOfSize:10.0];
        lab1.textAlignment = NSTextAlignmentCenter;
        [dbxview addSubview:lab1];
        
        UILabel * lab2 = [[UILabel alloc]init];
        
        lab2.text = @"0";
        lab2.font = [UIFont boldSystemFontOfSize:30];
        lab2.frame =CGRectMake(20, 96, 60, 25);
        lab2.textAlignment = NSTextAlignmentCenter;
        [dbxview addSubview:lab2];
        
        
        UILabel * lab3 = [[UILabel alloc]init];
        
        lab3.text = @"可投";
        lab3.frame = CGRectMake(20, 128, 60, 12);
        
        lab3.font = [UIFont fontWithName:@"Arial" size:10.0];
        lab3.textAlignment = NSTextAlignmentCenter;
        lab1.textColor = [RHUtility colorForHex:@"bdbdbe"];
        lab3.textColor = [RHUtility colorForHex:@"bdbdbe"];
        [dbxview addSubview:lab3];
        
        if ([self.rhbxblab.text isEqualToString:@"益商贷"]) {
            lab2.textColor = [RHUtility colorForHex:@"44bbc1"];
        }else if ([self.rhbxblab.text isEqualToString:@"益学贷"]){
            lab2.textColor = [RHUtility colorForHex:@"f8ce5f"];
        }else if ([self.rhbxblab.text isEqualToString:@"益房贷"]){
            lab2.textColor = [RHUtility colorForHex:@"d4b689"];
        }else if ([self.rhbxblab.text isEqualToString:@"益车贷"]){
            lab2.textColor = [RHUtility colorForHex:@"75bbeb"];
        }else{
            lab2.textColor = [RHUtility colorForHex:@"f58cb8"];
        }
        //dbxview.tag = _bx++;
        
       
        return dbxview;
        
        
        
        
        
        
        
        
        
    }else{
        return nil;
    }
    
//    UIView * dbxview = [[UIView alloc]init];
//    dbxview.backgroundColor = [UIColor whiteColor];
//    UIImageView *imageView = [[UIImageView alloc]init];;
//    if (!imageView) {
//        imageView = [[UIImageView alloc] init];
//        imageView.layer.cornerRadius = 6;
//        imageView.layer.masksToBounds = YES;
//    }
//    imageView.image = [UIImage imageNamed:[imageArray objectAtIndex:index]];
//    
//    [dbxview addSubview:imageView];
//    imageView.frame = CGRectMake(30, 0, 40, 40);
//    // imageView.backgroundColor = [UIColor orangeColor];
//    UILabel * lab = [[UILabel alloc]init];
//    
//    lab.text = titleArray[index];
//    lab.frame = CGRectMake(10, 45, 80, 30);
//    lab.textAlignment = NSTextAlignmentCenter;
//    // lab.font = [UIFont fontWithName:@"STHeiti-Medium.ttc" size:17];
//    lab.font = [UIFont boldSystemFontOfSize:20];
//    
//    [dbxview addSubview:lab];
//    UILabel * lab1 = [[UILabel alloc]init];
//    lab1.frame = CGRectMake(20, 78, 60, 20);
//    lab1.text = baozhengArray[index];
//    lab1.font = [UIFont fontWithName:@"Arial" size:10.0];
//    lab1.textAlignment = NSTextAlignmentCenter;
//    [dbxview addSubview:lab1];
//    
//    UILabel * lab2 = [[UILabel alloc]init];
//    
//    lab2.text = @"0";
//    lab2.font = [UIFont boldSystemFontOfSize:40];
//    lab2.frame =CGRectMake(20, 101, 60, 35);
//    lab2.textAlignment = NSTextAlignmentCenter;
//    [dbxview addSubview:lab2];
//    
//    
//    UILabel * lab3 = [[UILabel alloc]init];
//    
//    lab3.text = @"可投";
//    lab3.frame = CGRectMake(20, 138, 60, 12);
//    
//    lab3.font = [UIFont fontWithName:@"Arial" size:10.0];
//    lab3.textAlignment = NSTextAlignmentCenter;
//    [dbxview addSubview:lab3];
//    return dbxview;
    
}


- (IBAction)hidennavigtaionright:(id)sender {
    self.navgationrightView.hidden = YES;
    
    self.mengbanview.hidden = YES;
}


-(void)newpeopledata{
    
    //[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[RHNetworkService instance] POST:@"app/common/appMain/isXinshou" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            NSString * str = [NSString stringWithFormat:@"%@",responseObject[@"msg"]];
            if ([str isEqualToString:@"1"]) {
                [self getNewPeopleProject];
            }else{
                
                 self.newpeopleress = NO;
            }
          
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
        DLog(@"%@",[[NSString alloc] initWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
    
    [[RHNetworkService instance] POST:@"app/common/appMain/getProjectLocal" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            // NSLog(@"%@",responseObject);
            
            self.projectLocal = responseObject[@"projectLocal"];
            [self.tableView reloadData];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
        DLog(@"%@",[[NSString alloc] initWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
    
    
}

-(void)getNewPeopleProject{
    [[RHNetworkService instance] POST:@"app/common/appMain/noviceData" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            // NSLog(@"%@",responseObject);
            
            self.newdic = responseObject[@"rows"][0][@"cell"];
            self.newpeopleress = YES;
            
            if ([UIScreen mainScreen].bounds.size.width <321) {
                self.scrview .contentSize =  CGSizeMake([UIScreen mainScreen].bounds.size.width,675*1.4+10-30+30+25+64+20+6+10+80+180);
                self.newslab.font = [UIFont systemFontOfSize:11];
            }else{
                self.scrview .contentSize =  CGSizeMake([UIScreen mainScreen].bounds.size.width,675*1.4+10-30+30+25+64+20+46+10+80+180);
                
            }
            if ([UIScreen mainScreen].bounds.size.height>740) {
                self.scrview .contentSize =  CGSizeMake([UIScreen mainScreen].bounds.size.width,675*1.4+10-30+30+25+64+20+46+10+80+20+180);
            }
            
            [self.tableView reloadData];
            // NSLog(@"%@",self.newdic);
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
        DLog(@"%@",[[NSString alloc] initWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
    
    
   
    
}
-(NSDictionary *)newdic{
    
    if (!_newdic) {
        _newdic = [NSMutableDictionary dictionary];
    }
    
    return _newdic;
}
-(void)getnewpeoplegetproject{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];//请求
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    [manager.operationQueue cancelAllOperations];
    manager.securityPolicy = [[RHNetworkService instance] customSecurityPolicy];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"text/html",@"text/plain"]];
    [manager POST:[NSString stringWithFormat:@"%@app/common/appMain/noviceIsNull",[RHNetworkService instance].newdoMain ] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString * str = [NSString stringWithFormat:@"%@",responseObject];
        
        if ([str isEqualToString:@"0"]) {
            self.newpeoplebool = NO;
            
        }else{
            self.newpeoplebool = YES;
            
        }
        
//        [self.tableView reloadData];
       NSLog(@"%@--",responseObject);
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
         DLog(@"%@",[[NSString alloc] initWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
        NSLog(@"%@---",error);
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    }];
    
//    [[RHNetworkService instance] POST:@"app/common/appMain/noviceIsNull" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        
//        NSLog(@"%@--",responseObject);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        ;
//        
//        
//        NSLog(@"%@",error);
//    }];
    
    
}




-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    //    return 21;
    return self.collectionArr.count;
}




-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    RHProjectCollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"collcellid1" forIndexPath:indexPath];
    //    cell.backgroundColor = [UIColor redColor];
    //    cell.backgroundColor = [UIColor whiteColor];
    //    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    //    [cell update:self.dataArray[indexPath.row]];
    
    [cell.imageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@common/main/attachment/%@",[RHNetworkService instance].newdoMain,self.collectionArr[indexPath.row][@"bg"]]]];
    
    cell.titlelab.text = [NSString stringWithFormat:@"%@",self.collectionArr[indexPath.row][@"title"]];
    return cell;
    
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [RYHViewController Sharedbxtabar].tarbar.hidden = YES;
//    [self.nav.navigationBar setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsDefault];
//    self.nav.navigationBar.subviews.firstObject.alpha = 5.00;
    NSString *linkURl = self.collectionArr[indexPath.row][@"link"];
    //    NSString *logoUrl = self.array[indexPath.row][@""];
    //    NSString *naviTitle =self.array[indexPath.row][@""];
    
    NSString * buttonstr = self.collectionArr[indexPath.row][@"buttonIs"];;
    NSString * inviteCodeIsstr = self.collectionArr[indexPath.row][@"inviteCodeIs"];
    NSString * shareLinkIdstr = self.collectionArr[indexPath.row][@"shareLinkId"];
    
    if (linkURl.length > 2) {
        
        if ([buttonstr isEqualToString:@"true"]) {
            RHRNewShareWebViewController *office = [[RHRNewShareWebViewController alloc] initWithNibName:@"RHRNewShareWebViewController" bundle:nil];
            //            office.NavigationTitle = naviTitle;
            office.Type = 3;
            office.pinjie = inviteCodeIsstr;
            office.shareid = shareLinkIdstr;
            if (([linkURl rangeOfString:@"https://"].location == NSNotFound)) {
                //            office.urlString = [NSString stringWithFormat:@"http://%@",linkURl];
                //        } else if (([linkURl rangeOfString:@"https://"].location == NSNotFound)) {
                //             office.urlString = [NSString stringWithFormat:@"https://%@",linkURl];
                NSArray * array = [linkURl componentsSeparatedByString:@"//"];
                
                office.urlString = [NSString stringWithFormat:@"https://%@",array[1]];
            } else{
                
                
                office.urlString =linkURl;
            }
            [self.navigationController pushViewController:office animated:YES];
        }else{
            RHOfficeNetAndWeiBoViewController *office = [[RHOfficeNetAndWeiBoViewController alloc] initWithNibName:@"RHOfficeNetAndWeiBoViewController" bundle:nil];
            //            office.NavigationTitle = naviTitle;
            if (self.collectionArr[indexPath.row][@"title"] &&![self.collectionArr[indexPath.row][@"title"] isKindOfClass:[NSNull class]]) {
                office.NavigationTitle = self.collectionArr[indexPath.row][@"title"];
            }
            
            if (([linkURl rangeOfString:@"https://"].location == NSNotFound)) {
                //            office.urlString = [NSString stringWithFormat:@"http://%@",linkURl];
                //        } else if (([linkURl rangeOfString:@"https://"].location == NSNotFound)) {
                //             office.urlString = [NSString stringWithFormat:@"https://%@",linkURl];
                NSArray * array = [linkURl componentsSeparatedByString:@"//"];
                
                office.urlString = [NSString stringWithFormat:@"https://%@",array[1]];
            } else{
                
                
                office.urlString =linkURl;
            }
            [self.navigationController pushViewController:office animated:YES];
        }
    }else{
        
        [RYHViewController Sharedbxtabar].tarbar.hidden = NO;
    }
    
    NSLog(@"111");
}


@end
