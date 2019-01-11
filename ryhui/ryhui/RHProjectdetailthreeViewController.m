//
//  RHProjectdetailthreeViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 16/3/3.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import "RHProjectdetailthreeViewController.h"
#import "CircleProgressView.h"
#import "AppDelegate.h"
#import "DQViewController.h"
#import "RHALoginViewController.h"
#import "RHmainModel.h"
#import "RHRegisterWebViewController.h"
#import "RHInvestmentViewController.h"
#import "RHDetaisecondViewController.h"
#import "RHFKdetaiViewController.h"
#import "RHJsqViewController.h"
#import "RHXFDViewController.h"
#import "RYHStudentDetailViewController.h"
#import "RHXFDZRViewController.h"
#import "RHJXPassWordViewController.h"
#import "RHOpenCountViewController.h"
#import "RHhelper.h"
#import "RHPLViewController.h"
#import "RHDKGLViewController.h"
#import "RHDBSJViewController.h"

@interface RHProjectdetailthreeViewController ()<UIScrollViewDelegate>

@property(nonatomic,strong)NSMutableArray* array1;
@property(nonatomic,strong)NSMutableArray* array2;

@property (nonatomic,strong)NSMutableArray* dataArray;

@property(nonatomic,strong)RHDetaisecondViewController* controller1;
@property(nonatomic,strong)RHFKdetaiViewController*controller2;
@property(nonatomic,strong)RHFKdetaiViewController*controller3;
@property(nonatomic,strong)RHSegmentContentView* segmentContentView;
@property(nonatomic,strong)RHXFDViewController * controller4;
@property(nonatomic,strong)RYHStudentDetailViewController* controller5;
@property(nonatomic,strong)RHXFDZRViewController * controller8;
@property(nonatomic,strong)RHPLViewController * controller9;
@property(nonatomic,strong)RHDKGLViewController * controller10;
@property(nonatomic,strong)NSMutableArray* viewControllers;
@property (weak, nonatomic) IBOutlet UIView *segmentView1;
@property (weak, nonatomic) IBOutlet UIView *segmentView2;
@property (weak, nonatomic) IBOutlet UIView *segmentView3;

@property (weak, nonatomic) IBOutlet UIScrollView *maiscorleview;
@property (strong, nonatomic) IBOutlet UIView *secondView;


@property(nonatomic,strong)CircleProgressView* progressView;
@property (weak, nonatomic) IBOutlet UIImageView *logomyimage;

@property (weak, nonatomic) IBOutlet UIView *kaihuView;
@property (weak, nonatomic) IBOutlet UIImageView *jsqimage;

@property (weak, nonatomic) IBOutlet UIButton *toubiaobtn;



@property (weak, nonatomic) IBOutlet UIView *prossview;
@property (weak, nonatomic) IBOutlet UILabel *shouyilab;
@property (weak, nonatomic) IBOutlet UILabel *qixianlab;
@property (weak, nonatomic) IBOutlet UILabel *ketoulab;
@property (weak, nonatomic) IBOutlet UILabel *zongelab;
@property (weak, nonatomic) IBOutlet UILabel *prodectnamelab;
@property (weak, nonatomic) IBOutlet UILabel *dabaolab;
@property (weak, nonatomic) IBOutlet UILabel *huankuanfangshi;
@property (weak, nonatomic) IBOutlet UILabel *jixifangshilab;
@property (weak, nonatomic) IBOutlet UILabel *qitoulab;

@property (weak, nonatomic) IBOutlet UIImageView *danbaologo;
@property (weak, nonatomic) IBOutlet UIView *mengbanview;
@property(nonatomic,assign)BOOL ressss;
@property (weak, nonatomic) IBOutlet UILabel *firstlab;
@property (weak, nonatomic) IBOutlet UILabel *secondlab;

@property (weak, nonatomic) IBOutlet UILabel *jindu;
@property (weak, nonatomic) IBOutlet UIView *firstview;


@property(strong,nonatomic)UILabel * mylab;
@property(strong,nonatomic)UIView * hidenbtnview;
@property(nonatomic,copy)NSString * passwordbool;
@property (weak, nonatomic) IBOutlet UIButton *kaihubtn;
@property (weak, nonatomic) IBOutlet UILabel *kaihulab;
@property(nonatomic,strong)NSTimer * timer;
@property(nonatomic,assign)int inttimer;
@property (weak, nonatomic) IBOutlet UILabel *danbaonewlab;
@property (weak, nonatomic) IBOutlet UIImageView *danbaonewiamge;
@property(nonatomic,copy)NSString *oldnew;

@property (strong, nonatomic) IBOutlet UIView *newsecondview;

@property (weak, nonatomic) IBOutlet UIView *newsegement1;
@property (weak, nonatomic) IBOutlet UIView *newsegement2;
@property (weak, nonatomic) IBOutlet UIView *newsegement3;
@property (weak, nonatomic) IBOutlet UIView *newsegement4;
@property(nonatomic,copy)NSString *dbsxstr;

@property(nonatomic,copy)NSString *dkglstr;

@end

@implementation RHProjectdetailthreeViewController
-(void)stzfpush{
    
    [[RHNetworkService instance] POST:@"front/payment/account/trusteePayAlter" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSString * str = [NSString stringWithFormat:@"%@",responseObject[@"flag"]];
            
            self.dbsxstr = str;
            
            
        }
        
        NSLog(@"%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
    }];
    
}

-(void)setdkgl{
//    if ([self.dataDic[@"product"]isEqualToString:@"9"] || [self.dataDic[@"product"]isEqualToString:@"10"]|| [self.dataDic[@"product"]isEqualToString:@"11"] || [self.dataDic[@"product"]isEqualToString:@"12"]  ){
//        [self.maiscorleview addSubview:self.newsecondview];
//        self.newsegement1.hidden = NO;
//        self.newsegement2.hidden = YES;
//        self.newsegement3.hidden = YES;
//        self.newsegement4.hidden = YES;
//    }else{
//        [self.maiscorleview addSubview:self.secondView];
//    }
//    return;
    NSString * proid;
    if ([[self.dataDic objectForKey:@"id"] isKindOfClass:[NSNull class]]) {
        proid=@"";
    }else{
        proid=[self.dataDic objectForKey:@"id"];
        
    }
    NSDictionary* parameters=@{@"projectId":proid};
    
    [[RHNetworkService instance] POST:@"common/main/getLoanAfterData" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            if (responseObject[@"publishData"]&& ![responseObject[@"publishData"] isKindOfClass:[NSNull class]] ) {
                if ([responseObject[@"publishData"] isEqualToString:@"yes"]) {
                    
                    if ([self.dataDic[@"product"]isEqualToString:@"9"] || [self.dataDic[@"product"]isEqualToString:@"10"]|| [self.dataDic[@"product"]isEqualToString:@"11"] || [self.dataDic[@"product"]isEqualToString:@"12"]  ){
                        [self.maiscorleview addSubview:self.newsecondview];
                        self.newsegement1.hidden = NO;
                        self.newsegement2.hidden = YES;
                        self.newsegement3.hidden = YES;
                        self.newsegement4.hidden = YES;
                        [self.newsecondview addSubview:_segmentContentView];
                        [self plsecondview];
                        self.jixifangshilab.text = @"放款当日计息";
                        self.dkglstr = @"1";
                        
                    }else{
                        [self.maiscorleview addSubview:self.secondView];
                        
                        [self.secondView addSubview:_segmentContentView];
                        self.danbaonewlab.text = @"合作机构";
                        [self getsegmentviewcontrol];
                        self.oldnew = @"old";
                        
                    }
                }else{
                    [self.maiscorleview addSubview:self.secondView];
                    self.newsecondview.hidden = YES;
                    [self.secondView addSubview:_segmentContentView];
                    self.danbaonewlab.text = @"合作机构";
                    [self getsegmentviewcontrol];
                    self.oldnew = @"old";
                }
            }
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self.maiscorleview addSubview:self.secondView];
        [self.secondView addSubview:_segmentContentView];
        self.danbaonewlab.text = @"合作机构";
        [self getsegmentviewcontrol];
        self.oldnew = @"old";
        
    }];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [DQViewController Sharedbxtabar].tarbar.hidden = YES;
    [super viewWillAppear:animated];
    self.toubiaobtn.hidden = NO;
    self.jsqimage.hidden = NO;
    self.hidenbtnview.hidden= NO;
    [self getmyjxpassword];
     [self getimagemy];
}


- (void)viewDidLoad {
  
    
//     self.hidesBottomBarWhenPushed = NO;
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    
    NSString *timestr = [self timeFormatted:100000];
    
    [self stzfpush];
    [super viewDidLoad];
//    self.jindu.text = @"";
//    self.toubiaobtn.frame = CGRectMake(, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
    self.hidenbtnview = [[UIView alloc]init];
    self.hidenbtnview.backgroundColor = [UIColor whiteColor];
    [self.maiscorleview addSubview:self.hidenbtnview];
    [[UIApplication sharedApplication].keyWindow addSubview:self.hidenbtnview];
    [[UIApplication sharedApplication].keyWindow addSubview:self.toubiaobtn];
    [[UIApplication sharedApplication].keyWindow addSubview:self.jsqimage];
    
    NSLog(@"%f---%f",[UIScreen mainScreen].bounds.size.height,[UIScreen mainScreen].bounds.size.width);
    
    if([UIScreen mainScreen].bounds.size.width >325){
         self.maiscorleview.contentSize = CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), ([UIScreen mainScreen].bounds.size.height-69-30)*2 );
    }else{
    self.maiscorleview.contentSize = CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), ([UIScreen mainScreen].bounds.size.height-69-30)*2);
    }
    self.maiscorleview.delegate = self;
    
    if ([RHhelper ShraeHelp].myinsert==11) {
        [RHhelper ShraeHelp].myinsert = 0;
        if ([UIScreen mainScreen].bounds.size.width <380 &&[UIScreen mainScreen].bounds.size.width >325) {
            self.secondView.frame = CGRectMake(0, CGRectGetMaxY(self.jsqimage.frame)+3-50-20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-69-30);
            self.newsecondview.frame = CGRectMake(0, CGRectGetMaxY(self.jsqimage.frame)+3-50-20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-69-30);
            self.jsqimage.frame = CGRectMake(self.jsqimage.frame.origin.x, self.jsqimage.frame.origin.y+70, self.jsqimage.frame.size.width, self.jsqimage.frame.size.height);
            self.toubiaobtn.frame = CGRectMake(self.toubiaobtn.frame.origin.x, self.toubiaobtn.frame.origin.y+70, self.toubiaobtn.frame.size.width+10, self.toubiaobtn.frame.size.height);
            self.hidenbtnview.frame = CGRectMake(0, self.toubiaobtn.frame.origin.y-5, [UIScreen mainScreen].bounds.size.width, self.toubiaobtn.frame.size.height+10+5);
            
        }else if([UIScreen mainScreen].bounds.size.width <325){
            // NSLog(@"%f",[UIScreen mainScreen].bounds.size.width);
            self.secondView.frame = CGRectMake(0, CGRectGetMaxY(self.jsqimage.frame)-100-30-30, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-69-30+100);
            self.newsecondview.frame = CGRectMake(0, CGRectGetMaxY(self.jsqimage.frame)-100-30-30, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-69-30+100);
            self.jsqimage.frame = CGRectMake(self.jsqimage.frame.origin.x, self.jsqimage.frame.origin.y-10-10, self.jsqimage.frame.size.width, self.jsqimage.frame.size.height);
            self.toubiaobtn.frame = CGRectMake(self.toubiaobtn.frame.origin.x, self.jsqimage.frame.origin.y, self.toubiaobtn.frame.size.width-45, self.toubiaobtn.frame.size.height);
            self.hidenbtnview.frame = CGRectMake(0, self.toubiaobtn.frame.origin.y-10, [UIScreen mainScreen].bounds.size.width, self.toubiaobtn.frame.size.height+10);
            
        }else{
            self.secondView.frame = CGRectMake(0, CGRectGetMaxY(self.jsqimage.frame)+70-50-20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-69-30);
            self.newsecondview.frame = CGRectMake(0, CGRectGetMaxY(self.jsqimage.frame)+70-50-20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-69-30);
            self.jsqimage.frame = CGRectMake(self.jsqimage.frame.origin.x, self.jsqimage.frame.origin.y+130, self.jsqimage.frame.size.width, self.jsqimage.frame.size.height);
            self.toubiaobtn.frame = CGRectMake(self.toubiaobtn.frame.origin.x, self.toubiaobtn.frame.origin.y+130, self.toubiaobtn.frame.size.width+10, self.toubiaobtn.frame.size.height);
            self.hidenbtnview.frame = CGRectMake(0, self.toubiaobtn.frame.origin.y-5, [UIScreen mainScreen].bounds.size.width, self.toubiaobtn.frame.size.height+10+10+5);
        }
        if ([UIScreen mainScreen].bounds.size.height>810) {
            self.secondView.frame = CGRectMake(0, CGRectGetMaxY(self.jsqimage.frame)+3+30+50+10-20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-69-30-50-10);
            self.newsecondview.frame = CGRectMake(0, CGRectGetMaxY(self.jsqimage.frame)+3+30+50+10-20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-69-30-50-10);
            self.jsqimage.frame = CGRectMake(self.jsqimage.frame.origin.x, self.jsqimage.frame.origin.y+130, self.jsqimage.frame.size.width, self.jsqimage.frame.size.height);
            self.toubiaobtn.frame = CGRectMake(self.toubiaobtn.frame.origin.x, self.toubiaobtn.frame.origin.y+130, self.toubiaobtn.frame.size.width+10, self.toubiaobtn.frame.size.height);
            self.hidenbtnview.frame = CGRectMake(0, self.toubiaobtn.frame.origin.y-5, [UIScreen mainScreen].bounds.size.width, self.toubiaobtn.frame.size.height+10+10+5);
        }
        
    }else{
    if ([UIScreen mainScreen].bounds.size.width <380 &&[UIScreen mainScreen].bounds.size.width >325) {
        self.secondView.frame = CGRectMake(0, CGRectGetMaxY(self.jsqimage.frame)+3-18, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-69-30);
        self.newsecondview.frame = CGRectMake(0, CGRectGetMaxY(self.jsqimage.frame)+3-18, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-69-30);
        self.jsqimage.frame = CGRectMake(self.jsqimage.frame.origin.x, self.jsqimage.frame.origin.y+70, self.jsqimage.frame.size.width, self.jsqimage.frame.size.height);
        self.toubiaobtn.frame = CGRectMake(self.toubiaobtn.frame.origin.x, self.toubiaobtn.frame.origin.y+70, self.toubiaobtn.frame.size.width+10, self.toubiaobtn.frame.size.height);
        self.hidenbtnview.frame = CGRectMake(0, self.toubiaobtn.frame.origin.y-5, [UIScreen mainScreen].bounds.size.width, self.toubiaobtn.frame.size.height+10+5);
        
    }else if([UIScreen mainScreen].bounds.size.width <325){
       // NSLog(@"%f",[UIScreen mainScreen].bounds.size.width);
         self.secondView.frame = CGRectMake(0, CGRectGetMaxY(self.jsqimage.frame)-100-18, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-69-30+100);
        self.newsecondview.frame = CGRectMake(0, CGRectGetMaxY(self.jsqimage.frame)-100-18, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-69-30+100);
        self.jsqimage.frame = CGRectMake(self.jsqimage.frame.origin.x, self.jsqimage.frame.origin.y-10-10, self.jsqimage.frame.size.width, self.jsqimage.frame.size.height);
        self.toubiaobtn.frame = CGRectMake(self.toubiaobtn.frame.origin.x, self.jsqimage.frame.origin.y, self.toubiaobtn.frame.size.width-45, self.toubiaobtn.frame.size.height);
        self.hidenbtnview.frame = CGRectMake(0, self.toubiaobtn.frame.origin.y-10, [UIScreen mainScreen].bounds.size.width, self.toubiaobtn.frame.size.height+10);
    }else{
         self.secondView.frame = CGRectMake(0, CGRectGetMaxY(self.jsqimage.frame)+70-18, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-69-30);
        self.newsecondview.frame = CGRectMake(0, CGRectGetMaxY(self.jsqimage.frame)+70-18, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-69-30);
        self.jsqimage.frame = CGRectMake(self.jsqimage.frame.origin.x, self.jsqimage.frame.origin.y+130, self.jsqimage.frame.size.width, self.jsqimage.frame.size.height);
        self.toubiaobtn.frame = CGRectMake(self.toubiaobtn.frame.origin.x, self.toubiaobtn.frame.origin.y+130, self.toubiaobtn.frame.size.width+10, self.toubiaobtn.frame.size.height);
        self.hidenbtnview.frame = CGRectMake(0, self.toubiaobtn.frame.origin.y-5, [UIScreen mainScreen].bounds.size.width, self.toubiaobtn.frame.size.height+10+10+5);
    }
        if ([UIScreen mainScreen].bounds.size.height>810) {
            self.secondView.frame = CGRectMake(0, CGRectGetMaxY(self.jsqimage.frame)+3+30-20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-69-30);
            self.newsecondview.frame = CGRectMake(0, CGRectGetMaxY(self.jsqimage.frame)+3+30-20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-69-30);
            self.jsqimage.frame = CGRectMake(self.jsqimage.frame.origin.x, self.jsqimage.frame.origin.y+130, self.jsqimage.frame.size.width, self.jsqimage.frame.size.height);
            self.toubiaobtn.frame = CGRectMake(self.toubiaobtn.frame.origin.x, self.toubiaobtn.frame.origin.y+130, self.toubiaobtn.frame.size.width+10, self.toubiaobtn.frame.size.height);
            self.hidenbtnview.frame = CGRectMake(0, self.toubiaobtn.frame.origin.y-5, [UIScreen mainScreen].bounds.size.width, self.toubiaobtn.frame.size.height+10+10+5);
        }
        
    }
    if ([UIScreen mainScreen].bounds.size.height < 481){
        
        self.secondView.frame = CGRectMake(0, CGRectGetMaxY(self.jsqimage.frame)-190, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-69-30);
         self.newsecondview.frame = CGRectMake(0, CGRectGetMaxY(self.jsqimage.frame)-190, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-69-30);
    }
   
    
    UITapGestureRecognizer * aimagetap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushjsq)];
    self.jsqimage.userInteractionEnabled = YES;
    [self.jsqimage addGestureRecognizer:aimagetap];
    
    [self setdkgl];
   
    self.segmentView2.hidden = YES;
    self.segmentView3.hidden = YES;
    self.maiscorleview.bounces = NO;
    self.maiscorleview.alwaysBounceHorizontal = NO;
    self.maiscorleview.alwaysBounceVertical = NO;
    self.maiscorleview.showsHorizontalScrollIndicator = NO;
    self.maiscorleview.showsHorizontalScrollIndicator = NO;
    self.maiscorleview.pagingEnabled = YES;
    self.secondView.hidden = YES;
    self.newsecondview.hidden = YES;
    if ([self.getType isEqualToString:@"0"]) {
        self.zzimage.hidden = YES;
        self.zzlasttimelab.hidden = YES;
        self.zzlasttimeminlab.hidden = YES;
        self.zztimelogoiamge.hidden = YES;
    }
    
   
    [RHmainModel ShareRHmainModel].tabbarstr = @"cbx";
    self.view.backgroundColor = [UIColor whiteColor];
    [DQViewController Sharedbxtabar].tarbar.hidden = YES;
    [self configBackButton];
    [self configTitleWithString:@"项目详情"];
    [self creat];
    if ([RHUserManager sharedInterface].username) {
                [self.toubiaobtn setTitle:@"立即出借" forState:UIControlStateNormal];
            }else{
               // [self.toubiaobtn setTitle:@"马上登录" forState:UIControlStateNormal];
            }
    [self setupWithDic:self.dataDic];
    
    
    
    self.kaihuView.hidden = YES;
    self.mengbanview.hidden = YES;
    
    
    self.segmentContentView = [[RHSegmentContentView alloc] initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].applicationFrame.size.height-50-30-self.navigationController.navigationBar.frame.size.height)];
    
    [_segmentContentView setDelegate:self];
   
    
  //  _segmentContentView.backgroundColor = [UIColor grayColor];

    
     _viewControllers = [NSMutableArray array];
    
    
//    if ([self.dataDic[@"product"]isEqualToString:@"9"] || [self.dataDic[@"product"]isEqualToString:@"10"]|| [self.dataDic[@"product"]isEqualToString:@"11"] || [self.dataDic[@"product"]isEqualToString:@"12"]  ){
//         [self.newsecondview addSubview:_segmentContentView];
//        [self plsecondview];
//        self.jixifangshilab.text = @"放款当日计息";
//
//    }else{
//         [self.secondView addSubview:_segmentContentView];
//        self.danbaonewlab.text = @"合作机构";
//         [self getsegmentviewcontrol];
//        self.oldnew = @"old";
//    }
    
   
    
    if (self.zhaungtaistr) {
        [self.toubiaobtn setTitle:self.zhaungtaistr forState:UIControlStateNormal] ;
        self.toubiaobtn.userInteractionEnabled = NO;
        self.toubiaobtn.backgroundColor = [RHUtility colorForHex:@"#bdbdbe"];
    }
    
    if ([UIScreen mainScreen].bounds.size.height < 481){
        
        self.toubiaobtn.frame = CGRectMake(80, 435, 180, 40);
        self.jsqimage.frame = CGRectMake(20, 435, 40, 40);
    }
    
    
//    self.maiscorleview.backgroundColor = [RHUtility colorForHex:@"#efefef"];
    
}

-(void)plsecondview{
    
    self.controller9=[[RHPLViewController alloc]initWithNibName:@"RHPLViewController" bundle:nil];
    _controller9.projectid = self.projectId;
    _controller9.myblock = ^{
        
        [self secondblock];
    };
    _controller9.nav = self.navigationController;
    
//    _controller1.nav = self.navigationController;
//    _controller1.myblock = ^(){
//        [self secondblock];
//    };
//    _controller1.scroolblock = ^(){
//        //                self.secondView.hidden = YES;
//        _controller1.sess = NO;
//        [UIView animateWithDuration:5.0f animations:^{
//            [self.maiscorleview setContentOffset:CGPointMake(0, 0) animated:YES];
//
//        } completion:^(BOOL finished) {
//            //                    [self.maiscorleview setContentOffset:CGPointMake(0, 0) animated:YES];
//            _controller1.sess = YES;
//        }];
//    };
    [_viewControllers addObject:_controller9];

self.controller2=[[RHFKdetaiViewController alloc]initWithNibName:@"RHFKdetaiViewController" bundle:nil];
[_viewControllers addObject:_controller2];
_controller2.projectid = self.projectId;
_controller2.nav = self.navigationController;
NSString * tesstr = [NSString stringWithFormat:@"%@",self.dataDic[@"studentLoan"]];
if ([tesstr  isEqualToString:@"1"]) {
    
    _controller2.studentres = YES;
}
if (self.dataDic[@"studentName"]&&![self.dataDic[@"studentName"] isKindOfClass:[NSNull class]]) {
    _controller2.studentres = YES;
}

if ([self.dataDic[@"product"]isEqualToString:@"6"] ) {
    
    _controller2.xiaofeires = YES;
}
_controller2.myblock = ^{
    [self secondblock];
};
//     /_controller2.tableView.hidden = YES;
_controller2.type = @"0";
    self.controller10 = [[RHDKGLViewController alloc]initWithNibName:@"RHDKGLViewController" bundle:nil];
    self.controller10.projectid = self.projectId;
    [_viewControllers addObject:_controller10 ];
self.controller3=[[RHFKdetaiViewController alloc]initWithNibName:@"RHFKdetaiViewController" bundle:nil];
[_viewControllers addObject:_controller3];
_controller3.projectid = self.projectId;
    
    
[_segmentContentView setViews:_viewControllers];
    

}

- (void)configBackButton
{
    UIButton* button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    //    UIImage * image = [UIImage imageNamed:@"back.png"];
    
    [button setImage:[UIImage imageNamed:@"icon_back.png"] forState:UIControlStateNormal];
    button.frame=CGRectMake(0, 0, 25, 40);
    
    // button.backgroundColor = [UIColor colorWithHexString:@"44bbc1"];
    self.navigationItem.leftBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:button];
}
-(void)back
{
    self.toubiaobtn.hidden = YES;
    self.jsqimage.hidden = YES;
    self.hidenbtnview.hidden= YES;
    if ([[RHmainModel ShareRHmainModel].tabbarstr isEqualToString:@"cbx"]) {
        //[DQViewController Sharedbxtabar].tarbar.hidden = NO;
    }
    
    if ([self.shouyexunhuan isEqualToString:@"qiangge"]) {
        NSArray * array = self.navigationController.viewControllers;
        for (UIViewController * contr in array) {
            if ([contr isKindOfClass:[RHMainViewController class] ]) {
                
                [RHmainModel ShareRHmainModel].maintest = @"qiangge";
                
                [self.navigationController popToViewController:contr animated:YES];
                return;
            }
        }
        
    }
    if (self.myinsertres == 10) {
        self.myblock();
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)pushjsq{
    self.toubiaobtn.hidden = YES;
    self.jsqimage.hidden = YES;
    self.hidenbtnview.hidden= YES;
    RHJsqViewController * vc = [[RHJsqViewController alloc]initWithNibName:@"RHJsqViewController" bundle:nil];
    vc.nianStr = self.shouyilab.text;
    vc.projectid = self.projectId;
    vc.mouthStr = self.qixianlab.text;
    vc.monery = self.zongelab.text;
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)getsegmentviewcontrol{
    if ([self.dataDic[@"product"]isEqualToString:@"8"] ) {
        
        self.controller8 = [[RHXFDZRViewController alloc]initWithNibName:@"RHXFDZRViewController" bundle:nil];
        _controller8.scroolblock = ^(){
            //                self.secondView.hidden = YES;
            _controller8.sess = NO;
            [UIView animateWithDuration:5.0f animations:^{
                [self.maiscorleview setContentOffset:CGPointMake(0, 0) animated:YES];
                
            } completion:^(BOOL finished) {
                //                    [self.maiscorleview setContentOffset:CGPointMake(0, 0) animated:YES];
                _controller8.sess = YES;
            }];
        };
        _controller8.projectid = self.projectId;
        _controller8.nav = self.navigationController;
        [_viewControllers addObject:_controller8];
        
    }else{
    
    if ([self.dataDic[@"product"]isEqualToString:@"6"] ) {
         self.controller4=[[RHXFDViewController alloc]initWithNibName:@"RHXFDViewController" bundle:nil];
        _controller4.projectid = self.projectId;
        _controller4.nav = self.navigationController;
        [_viewControllers addObject:_controller4];
        _controller4.myblock = ^(){
            [self secondblock];
        };
        _controller4.scroolblock = ^(){
            //                self.secondView.hidden = YES;
            _controller4.sess = NO;
            [UIView animateWithDuration:5.0f animations:^{
                [self.maiscorleview setContentOffset:CGPointMake(0, 0) animated:YES];
                
            } completion:^(BOOL finished) {
                //                    [self.maiscorleview setContentOffset:CGPointMake(0, 0) animated:YES];
                _controller4.sess = YES;
            }];
        };
    }else{
        NSString * tesstr = [NSString stringWithFormat:@"%@",self.dataDic[@"studentLoan"]];
        if ([tesstr  isEqualToString:@"1"]||self.dataDic[@"studentName"]) {
            self.controller5 = [[RYHStudentDetailViewController alloc]initWithNibName:@"RYHStudentDetailViewController" bundle:nil];
            _controller5.projectid = self.projectId;
            _controller5.nav = self.navigationController;
            [_viewControllers addObject:_controller5];
//            _controller5.myblock = ^(){
//                [self secondblock];
//            };
        }else{
        
            
            if ([self.dataDic[@"product"]isEqualToString:@"9"] || [self.dataDic[@"product"]isEqualToString:@"10"]|| [self.dataDic[@"product"]isEqualToString:@"11"] || [self.dataDic[@"product"]isEqualToString:@"12"]  ){
                self.controller9=[[RHPLViewController alloc]initWithNibName:@"RHPLViewController" bundle:nil];
                _controller9.projectid = self.projectId;
                _controller9.myblock = ^{
                    
                    [self secondblock];
                };
                _controller9.nav = self.navigationController;
                [_viewControllers addObject:_controller9];
                
            }else{
            
                    self.controller1=[[RHDetaisecondViewController alloc]initWithNibName:@"RHDetaisecondViewController" bundle:nil];
                    _controller1.projectid = self.projectId;
                     _controller1.nav = self.navigationController;
                     _controller1.myblock = ^(){
                        [self secondblock];
                         };
                       _controller1.scroolblock = ^(){
//                self.secondView.hidden = YES;
                        _controller1.sess = NO;
                          [UIView animateWithDuration:5.0f animations:^{
                          [self.maiscorleview setContentOffset:CGPointMake(0, 0) animated:YES];
                    
                          } completion:^(BOOL finished) {
//                    [self.maiscorleview setContentOffset:CGPointMake(0, 0) animated:YES];
                            _controller1.sess = YES;
                         }];
                               };
                       [_viewControllers addObject:_controller1];
        }
            
        }
    }
    }
    self.controller2=[[RHFKdetaiViewController alloc]initWithNibName:@"RHFKdetaiViewController" bundle:nil];
    
    [_viewControllers addObject:_controller2];
    _controller2.oldnew = @"old";
    _controller2.projectid = self.projectId;
    _controller2.nav = self.navigationController;
    NSString * tesstr = [NSString stringWithFormat:@"%@",self.dataDic[@"studentLoan"]];
    if ([tesstr  isEqualToString:@"1"]) {
        
        _controller2.studentres = YES;
    }
    if (self.dataDic[@"studentName"]&&![self.dataDic[@"studentName"] isKindOfClass:[NSNull class]]) {
        _controller2.studentres = YES;
    }
    
    if ([self.dataDic[@"product"]isEqualToString:@"6"] ) {
        
        _controller2.xiaofeires = YES;
    }
    _controller2.myblock = ^{
        [self secondblock];
    };
//     /_controller2.tableView.hidden = YES;
    _controller2.type = @"0";
    self.controller3=[[RHFKdetaiViewController alloc]initWithNibName:@"RHFKdetaiViewController" bundle:nil];
    [_viewControllers addObject:_controller3];
    _controller3.projectid = self.projectId;
    _controller3.oldnew = @"old";
    [_segmentContentView setViews:_viewControllers];
    
    //[self segmentContentView:_segmentContentView selectPage:0];
    //[self getdata];
    
}
- (void)didSelectSegmentAtIndex:(int)index
{
//    [self getSegmentnum1];
//    [self getSegmentnum2];
//    RHDetaisecondViewController* controller=[_viewControllers objectAtIndex:index];
   // [controller.tableView setContentOffset:CGPointMake(0,0) animated:YES];
//    if (index ==2) {
//        NSString *pass =  [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@Gesture",[RHUserManager sharedInterface].username]];;
//        
//        if (pass.length <1) {
//            [self segentsecondbtn:nil];
//            //        self.controller3.tableView.hidden = YES;
//            [self loginryh];
//            
//            return;
//        }
//    }
    
    [_segmentContentView setSelectPage:index];
    
}
- (void)segmentContentView:(RHSegmentContentView *)segmentContentView selectPage:(NSUInteger)page{
    
    if ([self.dataDic[@"product"]isEqualToString:@"9"] || [self.dataDic[@"product"]isEqualToString:@"10"] || [self.dataDic[@"product"]isEqualToString:@"11"] || [self.dataDic[@"product"]isEqualToString:@"12"]  ){
        
         if (![self.dkglstr isEqualToString:@"1"]) {
             
             
             if (page ==1) {
                 
                 [self segentsecondbtn:nil];
             }else if (page ==2){
                 
                 [self segntthreebtn:nil];
             }else{
                 [self segntonebtn:nil];
             }
             
         }else{
             
             
        
        if (page ==1) {
            
            [self segentsecondbtn:nil];
        }else if (page ==3){
            
            [self segntthreebtn:nil];
        }else if(page ==2){
            
            [self daikuan:nil];
        }else{
            [self segntonebtn:nil];
        }
       }
    }else{
       if (page ==1) {
        
           [self segentsecondbtn:nil];
        }else if (page ==2){
       
           [self segntthreebtn:nil];
        }else{
           [self segntonebtn:nil];
    }
   }
//    [self didSelectSegmentAtIndex:page];
}
-(void)getdata{
    if ([[self.dataDic objectForKey:@"id"] isKindOfClass:[NSNull class]]) {
        self.projectId=@"";
    }else{
        self.projectId=[self.dataDic objectForKey:@"id"];
        
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
   // NSLog(@"%f",scrollView.contentOffset.y);
    
    if ([UIScreen mainScreen].bounds.size.height >570) {
    
    if (scrollView.contentOffset.y > 480) {
        
        self.secondView.hidden=NO;
        self.newsecondview.hidden=NO;
        _controller1.datadic = self.dataDic;
        _controller2.datadic = self.dataDic;
        _controller1.nhstr = self.shouyilab.text;
        
        _controller1.mouthstr = self.qixianlab.text;
        if (_controller1.sess == YES) {
            [_controller1.newscrool setContentOffset:CGPointMake(0, 1) animated:NO];
        }
        if (_controller4.sess == YES) {
            [_controller4.scrollview setContentOffset:CGPointMake(0, 2) animated:NO];
        }
        if (_controller8.sess == YES) {
            [_controller8.scrollview setContentOffset:CGPointMake(0, 2) animated:NO];
        }
    }else{
        self.secondView.hidden = YES;
        self.newsecondview.hidden = YES;
    }
   // NSLog(@"jieshu");
    }else{
        
        if (scrollView.contentOffset.y > 380) {
            self.secondView.hidden=NO;
            self.newsecondview.hidden = NO;
            if (_controller1.sess == YES) {
                [_controller1.newscrool setContentOffset:CGPointMake(0, 1) animated:NO];
            }
            if (_controller4.sess == YES) {
                [_controller4.scrollview setContentOffset:CGPointMake(0, 2) animated:NO];
            }
            if (_controller8.sess == YES) {
                [_controller8.scrollview setContentOffset:CGPointMake(0, 2) animated:NO];
            }
            _controller1.datadic = self.dataDic;
            _controller2.datadic = self.dataDic;
        }else{
            self.secondView.hidden = YES;
            self.newsecondview.hidden = YES;
        }
        if ([UIScreen mainScreen].bounds.size.height < 481){
            
            if (scrollView.contentOffset.y > 280) {
                self.secondView.hidden=NO;
                self.newsecondview.hidden = NO;
                if (_controller1.sess == YES) {
                    [_controller1.newscrool setContentOffset:CGPointMake(0, 1) animated:NO];
                }
                if (_controller4.sess == YES) {
                    [_controller4.scrollview setContentOffset:CGPointMake(0, 2) animated:NO];
                }
                if (_controller8.sess == YES) {
                    [_controller8.scrollview setContentOffset:CGPointMake(0, 2) animated:NO];
                }
                _controller1.datadic = self.dataDic;
                _controller2.datadic = self.dataDic;
            }else{
                self.secondView.hidden = YES;
                self.newsecondview.hidden = YES;
            }
        }
        
        
    }
}


-(void)setupWithDic:(NSDictionary*)dic{
     if ([self.dataDic[@"product"]isEqualToString:@"9"] || [self.dataDic[@"product"]isEqualToString:@"10"]|| [self.dataDic[@"product"]isEqualToString:@"11"]|| [self.dataDic[@"product"]isEqualToString:@"12"]   ){
     }else{
         self.danbaonewlab.text = @"合作机构";
     }
    
    if ([[dic objectForKey:@"id"] isKindOfClass:[NSNull class]]) {
        self.projectId=@"";
    }else{
        self.projectId=[dic objectForKey:@"id"];
//        [self getimagemy];
    }
    if ([[dic objectForKey:@"name"] isKindOfClass:[NSNull class]]) {
        self.prodectnamelab.text=@"";
    }else{
        self.prodectnamelab.text=[dic objectForKey:@"name"];
    }
    if ([[dic objectForKey:@"investorRate"] isKindOfClass:[NSNull class]]) {
        self.shouyilab.text=@"";
    }else{
        _lilv=[[dic objectForKey:@"investorRate"] stringValue];
        self.shouyilab.text = [NSString stringWithFormat:@"%@%%",_lilv];
    }
    if ([[dic objectForKey:@"limitTime"] isKindOfClass:[NSNull class]]) {
        self.qixianlab.text=@"";
    }else{
        if (self.panduan == 10) {
            if ([[dic objectForKey:@"monthOrDay"] isKindOfClass:[NSNull class]]||![dic objectForKey:@"monthOrDay"]) {
                NSString * str =[dic objectForKey:@"limitTime"];
                
                self.qixianlab.text= [NSString stringWithFormat:@"%@个月",str];
            }else{
                NSString * str1 =[dic objectForKey:@"monthOrDay"];
                 NSString * str =[dic objectForKey:@"limitTime"];
                if ([str1 isEqualToString:@"day"]) {
                    str1 = @"天";
                     self.qixianlab.text= [NSString stringWithFormat:@"%@%@",str,str1];
                }else{
//                    str1 = @"个月";
                    self.qixianlab.text= [NSString stringWithFormat:@"%@%@",str,str1];

                }
                
               
            }
            
            
        }else{
//            NSString * str =[dic objectForKey:@"limitTime"] ;
//            self.qixianlab.text= [NSString stringWithFormat:@"%@个月",str];
            if ([[dic objectForKey:@"monthOrDay"] isKindOfClass:[NSNull class]]||![dic objectForKey:@"monthOrDay"]) {
                NSString * str =[dic objectForKey:@"limitTime"];
                self.qixianlab.text= [NSString stringWithFormat:@"%@个月",str];
            }else{
                NSString * str =[dic objectForKey:@"limitTime"];
                NSString * str1 =[dic objectForKey:@"monthOrDay"];
//                NSString * str =[dic objectForKey:@"limitTime"];
                if ([str1 isEqualToString:@"day"]) {
                    str1 = @"天";
                    self.qixianlab.text= [NSString stringWithFormat:@"%@%@",str,str1];
                }else{
                    
                    self.qixianlab.text= [NSString stringWithFormat:@"%@%@",str,str1];
                    
                }
            }
            
        }
    }
    
    if (self.panduan ==10) {
        NSString * moneyy =[dic objectForKey:@"projectFund"];
        NSArray *array = [moneyy componentsSeparatedByString:@","];
        NSString * stringmoney = @"";
        for (NSString * str  in array) {
            stringmoney = [NSString stringWithFormat:@"%@%@",stringmoney,str];
        }
        
        float mo = [stringmoney floatValue];
        self.zongelab.text = [NSString stringWithFormat:@"%.2f万",mo/10000.0];
    }else{
        if (self.newpeopletype) {
            
            NSString * str = [[dic objectForKey:@"projectFund"] stringByReplacingOccurrencesOfString:@"," withString:@""];
            NSLog(@"%f",[str floatValue]);
            
            self.zongelab.text = [NSString stringWithFormat:@"%.2f万",([str floatValue]/10000.0)];
                                                                    
        }else{
        
        self.zongelab.text=[NSString stringWithFormat:@"%.2f万",([[dic objectForKey:@"projectFund"] floatValue]/10000.0)];
        }
    }
    
    if ([[dic objectForKey:@"insuranceName"] isKindOfClass:[NSNull class]]) {
        self.dabaolab.text=@"";
    }else{
        if ([self.danbaonewlab.text isEqualToString:@"合作机构"]) {
            self.dabaolab.text=[dic objectForKey:@"insuranceName"];
            self.danbaonewiamge.image = [UIImage imageNamed:@"担保方"];
        }
        
        if (self.dabaolab.text.length>6) {
            self.logomyimage.frame = CGRectMake(self.logomyimage.frame.origin.x+20, self.logomyimage.frame.origin.y, self.logomyimage.frame.size.width, self.logomyimage.frame.size.height);
        }else if (self.dabaolab.text.length==6){
            self.logomyimage.frame = CGRectMake(self.logomyimage.frame.origin.x+27+4, self.logomyimage.frame.origin.y, self.logomyimage.frame.size.width, self.logomyimage.frame.size.height);
        }else if (self.dabaolab.text.length==5){
            self.logomyimage.frame = CGRectMake(self.logomyimage.frame.origin.x+33+4, self.logomyimage.frame.origin.y, self.logomyimage.frame.size.width, self.logomyimage.frame.size.height);
        }else if (self.dabaolab.text.length==4){
            self.logomyimage.frame = CGRectMake(self.logomyimage.frame.origin.x+50+4, self.logomyimage.frame.origin.y, self.logomyimage.frame.size.width, self.logomyimage.frame.size.height);
        }else if (self.dabaolab.text.length==3){
            self.logomyimage.frame = CGRectMake(self.logomyimage.frame.origin.x+45, self.logomyimage.frame.origin.y, self.logomyimage.frame.size.width, self.logomyimage.frame.size.height);
        }
        
    }
    if ([[dic objectForKey:@"paymentName"] isKindOfClass:[NSNull class]]) {
        self.huankuanfangshi.text=@"";
    }else{
        self.huankuanfangshi.text=[dic objectForKey:@"paymentName"];
    }
    CGFloat a = [[dic objectForKey:@"percent"] intValue]/100.0;
    
    [self.progressView setProgress:a];
    
    if (![[dic objectForKey:@"available"] isKindOfClass:[NSNull class]]) {

    NSString * srtr = [dic objectForKey:@"available"];
    self.ketoulab.text = [NSString stringWithFormat:@"%@",srtr];
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:@"###,##0.00;"];
    NSString *formattedNumberString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble: [self.ketoulab.text doubleValue] ]];
    
    //        self.moneylab.backgroundColor = [UIColor redColor];
    //        self.moneylab.frame = CGRectMake(CGRectGetMinX(self.moneylab.frame)-20, CGRectGetMinY(self.moneylab.frame), self.moneylab.frame.size.width+60, self.moneylab.frame.size.height);
    self.ketoulab.text = formattedNumberString;
    }
    //        self.moneylab.textColor = [RHUtility colorForHex:@"#44bbc1"];
   
    // self.ketouLab.text = @"99999999";
    
    CGFloat percent=0;
    if (![[dic objectForKey:@"percent"] isKindOfClass:[NSNull class]]) {
        percent=[[dic objectForKey:@"percent"] floatValue]/100.0;
//        self.button.userInteractionEnabled = YES;
    }
    self.firstlab.frame = CGRectMake(CGRectGetMinX(self.firstlab.frame), CGRectGetMinY(self.firstlab.frame), self.firstlab.frame.size.width*([UIScreen mainScreen].bounds.size.width/375.00), 3);
   self.secondlab.frame = CGRectMake(CGRectGetMinX(self.firstlab.frame), CGRectGetMinY(self.secondlab.frame), percent * self.firstlab.frame.size.width, 3);
//    self.secondlab.frame.size.width =  percent * self.firstlab.frame.size.width;
    NSLog(@"%f",self.secondlab.frame.size.width);
    NSLog(@"%f",self.firstlab.frame.size.width);
    
    self.mylab = [[UILabel alloc]init];
    
    self.mylab.frame = CGRectMake(CGRectGetMinX(self.secondlab.frame), CGRectGetMinY(self.secondlab.frame), percent * self.firstlab.frame.size.width, 3);
    self.mylab.backgroundColor = [RHUtility colorForHex:@"#44bbc1"];
    
    self.secondlab.hidden = YES;
    [self.firstview addSubview:self.mylab];
    if (percent >=1) {
        self.secondlab.hidden = NO;
        self.mylab.hidden = YES;
    }
    self.jindu.text = [NSString stringWithFormat:@"%.2f%%",percent*100];
//    self.jindu.text =@"11";
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//-(void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    dispatch_async(dispatch_get_main_queue(), ^{
//       // UIView * aview = [[UIView alloc]init];
//        self.view.frame =  CGRectMake(0, 69-5, self
//                                      .view.frame.size.width, self.view.frame.size.height+50);
//       // [self.view addSubview:aview];
//    });
//}

-(void)creat{
    
    //pubNews/76782f6d-f85a-41e7-af4f-fd41ea0736d9.png
    //pubNews/banner/a7d5b0d0-fa85-4344-9aef-c654e55b0c31.jpg
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    height = height- 69-44;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
   
    CGFloat w = width/4.0;
    NSString * str = [NSString stringWithFormat:@"%.1f",w];
    int ww = [str floatValue];
    //NSLog(@"%f",ww);
    int www = ww-20;
    if (ww < 85) {
        www = 40;
        //self.progressView.str = @"cbx";
    }
    
    self.progressView = [[CircleProgressView alloc]
                         initWithFrame:CGRectMake(0, 0,60, 60)
                         withCenter:CGPointMake(60/ 2.0, 60/ 2.0)
                         Radius:55.0 / 2.0
                         lineWidth:6];
    self.progressView.backgroundColor = [UIColor clearColor];
    [self.prossview addSubview:_progressView];
    self.progressView.str = @"cbx";
     [self.progressView setProgress:0.5];
    
//    UIButton * btn  = [[UIButton alloc]init];
//    btn.frame = CGRectMake(80, [UIScreen mainScreen].bounds.size.height-20-69-20+4, [UIScreen mainScreen].bounds.size.width-40-60, 35);
//    [self.view addSubview:btn];
//    if ([RHUserManager sharedInterface].username) {
//        [btn setTitle:@"立即投标" forState:UIControlStateNormal];
//    }else{
//        [btn setTitle:@"马上登录" forState:UIControlStateNormal];
//    }
//    btn.backgroundColor = [RHUtility colorForHex:@"#44bbc1"];
//    [btn addTarget:self action:@selector(toubiao:) forControlEvents:UIControlEventTouchUpInside];
//    UIImageView * jsqimage = [[UIImageView alloc]init];
//    jsqimage.frame = CGRectMake(20, [UIScreen mainScreen].bounds.size.height-20-69-20+4, 35, 35);
//    
//    jsqimage.backgroundColor = [RHUtility colorForHex:@"#44bbc1"];
//    jsqimage.image = [UIImage imageNamed:@"jsq"];
//    [self.view addSubview:jsqimage];
    
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)toubiao:(UIButton *)sender {
    self.toubiaobtn.hidden = YES;
    self.jsqimage.hidden = YES;
    self.hidenbtnview.hidden= YES;
    if (![RHUserManager sharedInterface].username) {
        //        [self.investmentButton setTitle:@"请先登录" forState:UIControlStateNormal];
        
        NSLog(@"ddddddd");
        RHALoginViewController* controller=[[RHALoginViewController alloc] initWithNibName:@"RHALoginViewController" bundle:nil];
        [self.navigationController pushViewController:controller animated:YES];
    }else{
        if (![RHUserManager sharedInterface].custId) {
            //            [self.investmentButton setTitle:@"请先开户" forState:UIControlStateNormal];
            NSLog(@"kkkkkkk");
//            self.maiscorleview.backgroundColor = ;
            self.kaihuView.hidden = NO;
            self.mengbanview.hidden = NO;
            self.toubiaobtn.hidden = NO;
            self.jsqimage.hidden = NO;
            self.hidenbtnview.hidden= NO;
            [[UIApplication sharedApplication].keyWindow addSubview:self.mengbanview ];
            [[UIApplication sharedApplication].keyWindow addSubview:self.kaihuView];
            
            if ([UIScreen mainScreen].bounds.size.width>376) {
                self.kaihuView.frame = CGRectMake(40, CGRectGetMinY(self.kaihuView.frame), [UIScreen mainScreen].bounds.size.width-80, 310);
            }else{
                self.kaihuView.frame = CGRectMake(40, CGRectGetMinY(self.kaihuView.frame), [UIScreen mainScreen].bounds.size.width-80, 245);
            }
            
            
        }else{
            
            if (![self.passwordbool isEqualToString:@"yes"]) {
                
                [self.kaihubtn setTitle:@"设置交易密码" forState:UIControlStateNormal];
               // self.passwordlab.text = @"资金更安全，请先设置交易密码在进行投资／提现";
                self.mengbanview.hidden = NO;
                self.kaihuView.hidden = NO;
                self.toubiaobtn.hidden = NO;
                self.jsqimage.hidden = NO;
                self.hidenbtnview.hidden= NO;
                [[UIApplication sharedApplication].keyWindow addSubview:self.mengbanview ];
                [[UIApplication sharedApplication].keyWindow addSubview:self.kaihuView];
                if ([UIScreen mainScreen].bounds.size.width>376) {
                    self.kaihuView.frame = CGRectMake(40, CGRectGetMinY(self.kaihuView.frame), [UIScreen mainScreen].bounds.size.width-80, 310);
                }else{
                    self.kaihuView.frame = CGRectMake(40, CGRectGetMinY(self.kaihuView.frame), [UIScreen mainScreen].bounds.size.width-80, 245);
                }
                self.kaihulab.text = @"资金更安全，请先设置交易密码再进行出借／提现";
                return;
            }
            
            if ([self.dbsxstr isEqualToString:@"1"]) {
                UIAlertView* alertView=[[UIAlertView alloc]initWithTitle:@"提示"
                                                                 message:@"您有待办事项未处理完毕，请尽快处理。"
                                                                delegate:self
                                                       cancelButtonTitle:@"确定"
                                                       otherButtonTitles:@"取消", nil];
                alertView.tag=8901;
                [alertView show];
                
                return;
            }
            RHInvestmentViewController* contoller=[[RHInvestmentViewController alloc]initWithNibName:@"RHInvestmentViewController" bundle:nil];
            NSString * str = self.dataDic[@"available"];
            int a = [str intValue];
            contoller.projectFund= a;
            contoller.dataDic=self.dataDic;
            contoller.xmjid = self.xmjid;
            //            if (self.panduan == 10) {
            // contoller.panduan = 10;
            //            }
            NSString * str1 =  self.dataDic[@"investorRate"];
            if (self.newpeopletype) {
                
                if (self.postnewpeopletype) {
                    
                    contoller.newpeople = self.postnewpeopletype;
                    
                }else{
                    self.toubiaobtn.hidden = NO;
                    self.jsqimage.hidden = NO;
                    self.hidenbtnview.hidden= NO;
                    [RHUtility showTextWithText:@"您已出借过，请看其余项目。"];
                    return;
                }
                
            }
               
                
                
                //contoller.lilv =str1;
                [self.navigationController pushViewController:contoller animated:YES];
                
           
            
            
            
           
        }
    }
    
//    if ([sender.titleLabel.text isEqualToString:@"立即投标"]) {
//        NSLog(@"cbxcbxcbxcbx");
//        [self gentt];
//    }else{
//        RHALoginViewController * vc = [[RHALoginViewController alloc]initWithNibName:@"RHALoginViewController" bundle:nil];
//        [self.navigationController pushViewController:vc animated:YES];
//        
//         NSLog(@"2222222222cbx22222222");
//    }
    
   
}

//-(void)gentt{
//    
//    AFHTTPRequestOperationManager* manager=[AFHTTPRequestOperationManager manager];
//    manager.responseSerializer=[[AFCompoundResponseSerializer alloc]init];
//    NSString* session=[[NSUserDefaults standardUserDefaults] objectForKey:@"RHSESSION"];
//    NSLog(@"------------------%@",session);
//    
//    if (session&&[session length]>0) {
//        [manager.requestSerializer setValue:session forHTTPHeaderField:@"cookie"];
//    }
//    [manager POST:[NSString stringWithFormat:@"%@front/payment/account/queryAccountFinishedBonuses",[RHNetworkService instance].doMain] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        //        DLog(@"result==%@ <<<",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
//        if ([responseObject isKindOfClass:[NSData class]]) {
//            
//            NSDictionary* dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//            
//            NSLog(@"------------------%@",dic);
//            
//            NSString* amount=[dic objectForKey:@"money"];
//            if (amount&&[amount length]>0) {
//                //                RHGetGiftViewController* controller=[[RHGetGiftViewController alloc]initWithNibName:@"RHGetGiftViewController" bundle:nil];
//                //                controller.amount=amount;
//                //                [self.navigationController pushViewController:controller animated:NO];
//                //                self.giftView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) + 64);
//                //                self.giftMoneyLabel.text = [NSString stringWithFormat:@"%d元投资现金已放入账户",[amount intValue]];
//                //                [self setTheAttributeString:self.giftMoneyLabel.text];
//                //                [[[UIApplication sharedApplication].delegate window] addSubview:self.giftView];
//                self.view.userInteractionEnabled = NO;
//                
//                
//                NSNumber* lowest = [dic objectForKey:@"lowestMoney"];
//                if (lowest) {
//                    if ([lowest integerValue] == 0) {
//                        //     self.giftNoticeLabel.text = @"快去充值投资吧～";
//                    } else {
//                        //     self.giftNoticeLabel.text = [NSString stringWithFormat:@" 首次投资%@元以上立得返利现金哦！快去充值投资吧～",lowest];
//                    }
//                } else {
//                    // self.giftNoticeLabel.text = @"快去充值投资吧～";
//                }
//                //  [self performSelector:@selector(closeButtonClicked:) withObject:nil afterDelay:15.0];
//            }
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        //        DLog(@"%@",[[NSString alloc] initWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
//    }];
//    
//}

- (IBAction)kaitonghuifu:(id)sender {
    self.toubiaobtn.hidden = YES;
    self.jsqimage.hidden = YES;
    self.hidenbtnview.hidden= YES;
    
    
    if ([self.kaihubtn.titleLabel.text isEqualToString:@"设置交易密码"]) {
        
        RHJXPassWordViewController * controller =[[RHJXPassWordViewController alloc]initWithNibName:@"RHJXPassWordViewController" bundle:nil];
        self.kaihuView.hidden = YES;
        self.mengbanview.hidden = YES;
        controller.urlstr = @"app/front/payment/appJxAccount/passwordSetJxData";
        [self.navigationController pushViewController:controller animated:YES];
        return;
    }
    
    RHOpenCountViewController* controller1=[[RHOpenCountViewController alloc]initWithNibName:@"RHOpenCountViewController" bundle:nil];
    self.kaihuView.hidden = YES;
    self.mengbanview.hidden = YES;
    [self.navigationController pushViewController:controller1 animated:YES];
    
//    RHRegisterWebViewController* controller1=[[RHRegisterWebViewController alloc]initWithNibName:@"RHRegisterWebViewController" bundle:nil];
//    [self.navigationController pushViewController:controller1 animated:YES];
    
}
- (IBAction)yicangkaitong:(id)sender {
    self.kaihuView.hidden = YES;
    self.mengbanview.hidden = YES;
}
- (IBAction)segntonebtn:(id)sender {
    
    self.segmentView2.hidden = YES;
    self.segmentView3.hidden = YES;
    self.segmentView1.hidden = NO;
   // NSLog(@"cbxcbx");
    self.newsegement1.hidden = NO;
    self.newsegement2.hidden = YES;
    self.newsegement3.hidden = YES;
    self.newsegement4.hidden = YES;
    [self didSelectSegmentAtIndex:0];
}

- (IBAction)segentsecondbtn:(id)sender {
    self.controller2.tableView.hidden = YES;
    self.segmentView1.hidden = YES;
    self.segmentView3.hidden = YES;
    self.segmentView2.hidden = NO;
    self.newsegement1.hidden = YES;
    self.newsegement2.hidden = NO;
    self.newsegement3.hidden = YES;
    self.newsegement4.hidden = YES;
    [self didSelectSegmentAtIndex:1];
     self.newsegement2.hidden = NO;
}
- (IBAction)segntthreebtn:(id)sender {
    
    if (self.ressss) {
        return;
    }
    
    self.ressss=YES;
    
    
    if (![self.dkglstr isEqualToString:@"1"]) {
        if ([RHUserManager sharedInterface].username&&[[RHUserManager sharedInterface].username length]>0) {
            if (self.segmentView2.hidden) {
                self.segmentView1.hidden = YES;
                self.segmentView2.hidden = YES;
                self.segmentView3.hidden = NO;
                [self didSelectSegmentAtIndex:2];
                
                //            [self didSelectSegmentAtIndex:2];
                self.ressss=NO;
                
            }else{
                self.segmentView1.hidden = YES;
                self.segmentView2.hidden = YES;
                self.segmentView3.hidden = NO;
                [self didSelectSegmentAtIndex:2];
                self.ressss=NO;
            }
        } else {
            self.segmentView1.hidden = YES;
            self.segmentView2.hidden = YES;
            self.segmentView3.hidden = NO;
            [self didSelectSegmentAtIndex:2];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"登录后才可查看出借记录,请先登录" delegate:self cancelButtonTitle:@"登录" otherButtonTitles:@"取消", nil];
            alert.tag=5565;
            [alert show];
            
            //        [self didSelectSegmentAtIndex:2];
        }
        return;
    }
    
  if ([self.dataDic[@"product"]isEqualToString:@"9"] || [self.dataDic[@"product"]isEqualToString:@"10"]|| [self.dataDic[@"product"]isEqualToString:@"11"] || [self.dataDic[@"product"]isEqualToString:@"12"]  ){
      
      
      
      
      if ([RHUserManager sharedInterface].username&&[[RHUserManager sharedInterface].username length]>0) {
          if (self.segmentView2.hidden) {
              
              self.newsegement1.hidden = YES;
              self.newsegement2.hidden = YES;
              self.newsegement3.hidden = YES;
              self.newsegement4.hidden = NO;
              [self didSelectSegmentAtIndex:3];
              
              
              self.ressss=NO;
              
          }else{
              self.newsegement1.hidden = YES;
              self.newsegement2.hidden = YES;
              self.newsegement3.hidden = YES;
              self.newsegement4.hidden = NO;
              [self didSelectSegmentAtIndex:3];
              self.ressss=NO;
          }
      } else {
          
          [self didSelectSegmentAtIndex:3];
          UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"登录后才可查看出借记录,请先登录" delegate:self cancelButtonTitle:@"登录" otherButtonTitles:@"取消", nil];
          alert.tag=5565;
          [alert show];
          
          //        [self didSelectSegmentAtIndex:2];
      }
      
  }else{
    
    if ([RHUserManager sharedInterface].username&&[[RHUserManager sharedInterface].username length]>0) {
        if (self.segmentView2.hidden) {
            self.segmentView1.hidden = YES;
                self.segmentView2.hidden = YES;
                self.segmentView3.hidden = NO;
                [self didSelectSegmentAtIndex:2];
            
//            [self didSelectSegmentAtIndex:2];
           self.ressss=NO;
            
        }else{
            self.segmentView1.hidden = YES;
            self.segmentView2.hidden = YES;
            self.segmentView3.hidden = NO;
            [self didSelectSegmentAtIndex:2];
            self.ressss=NO;
        }
    } else {
        self.segmentView1.hidden = YES;
        self.segmentView2.hidden = YES;
        self.segmentView3.hidden = NO;
         [self didSelectSegmentAtIndex:2];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"登录后才可查看出借记录,请先登录" delegate:self cancelButtonTitle:@"登录" otherButtonTitles:@"取消", nil];
        alert.tag=5565;
        [alert show];
        
//        [self didSelectSegmentAtIndex:2];
    }
  }
    
//    NSString *pass =  [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@Gesture",[RHUserManager sharedInterface].username]];;
//    
//    if (pass.length <1) {
////        self.controller3.tableView.hidden = YES;
//        
//        if (!self.ressss) {
//            [self loginryh];
////                    return;
//        }
//       
//    }
//    
//    self.segmentView1.hidden = YES;
//    self.segmentView2.hidden = YES;
//    self.segmentView3.hidden = NO;
//    [self didSelectSegmentAtIndex:2];
}

-(void)loginryh{
    UIAlertView* alertView=[[UIAlertView alloc]initWithTitle:@""
                                                     message:@"登录后才可查看投标记录，请先登录"
                                                    delegate:self
                                           cancelButtonTitle:@"登录"
                                           otherButtonTitles:@"取消", nil];
    alertView.tag=5565;
   // if (!self.ressss) {
        [alertView show];

    //}
    
    
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 8901) {
        
        
        if (buttonIndex==0) {
            [DQViewController Sharedbxtabar].tarbar.hidden = YES;
            RHDBSJViewController * vc = [[RHDBSJViewController alloc]initWithNibName:@"RHDBSJViewController" bundle:nil];
            //        vc.str = @"cbx";
            [self.navigationController pushViewController:vc animated:NO];
        }else{
            
            self.toubiaobtn.hidden = NO;
            self.jsqimage.hidden = NO;
//            self.hidenbtnview.hidden= YES;
        }
        return;
    }
    
    if (buttonIndex==0) {
        if (alertView.tag==5565) {
            
            [[RHTabbarManager sharedInterface] cleanTabbar];
            [[RHTabbarManager  sharedInterface] selectALogin];
            
            self.ressss = NO;
        }
    }else{
        self.ressss = NO;
//        self.controller2.tableView.hidden = YES;
//        self.segmentView1.hidden = YES;
//        self.segmentView3.hidden = YES;
//        self.segmentView2.hidden = NO;
//        [self didSelectSegmentAtIndex:1];
        
    }
}

-(void)secondblock{
    self.toubiaobtn.hidden = YES;
    self.jsqimage.hidden = YES;
    self.hidenbtnview.hidden= YES;
}
-(void)viewDidDisappear:(BOOL)animated{
//    self.toubiaobtn.hidden = YES;
    [super viewDidDisappear:animated];
    self.toubiaobtn.hidden = YES;
    self.jsqimage.hidden = YES;
    self.hidenbtnview.hidden= YES;
}

-(void)getimagemy{
    NSDictionary* parameters=@{@"id":self.projectId};
    
    [[RHNetworkService instance] POST:@"app/common/appDetails/appProjectDetailData" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        DLog(@"%@",responseObject);
        
//
        CGFloat percent=0;
        if (![[responseObject[@"project"] objectForKey:@"percent"] isKindOfClass:[NSNull class]]) {
            percent=[[responseObject[@"project"] objectForKey:@"percent"] floatValue]/100.0;
            self.secondlab.frame = CGRectMake(CGRectGetMinX(self.firstlab.frame), CGRectGetMinY(self.secondlab.frame), percent * self.firstlab.frame.size.width, 3);
            //        self.button.userInteractionEnabled = YES;
            self.jindu.text = [NSString stringWithFormat:@"%.2f%%",percent*100];
        }
        if (![[responseObject[@"project"] objectForKey:@"available"] isKindOfClass:[NSNull class]]) {
            
            NSString * srtr = [responseObject[@"project"] objectForKey:@"available"];
            self.ketoulab.text = [NSString stringWithFormat:@"%@",srtr];
            NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
            [numberFormatter setPositiveFormat:@"###,##0.00;"];
            NSString *formattedNumberString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble: [self.ketoulab.text doubleValue] ]];
            
            //        self.moneylab.backgroundColor = [UIColor redColor];
            //        self.moneylab.frame = CGRectMake(CGRectGetMinX(self.moneylab.frame)-20, CGRectGetMinY(self.moneylab.frame), self.moneylab.frame.size.width+60, self.moneylab.frame.size.height);
            self.ketoulab.text = formattedNumberString;
        }
        
        if ([self.danbaonewlab.text isEqualToString:@"合作机构"]) {
            [self.logomyimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@common/main/attachment/%@",[RHNetworkService instance].newdoMain,responseObject[@"project"][@"logo"]]]];
        }else{
        
        if (responseObject[@"remain"]) {
            self.inttimer = [responseObject[@"remain"] intValue];
            if (self.inttimer>0) {
               if (self.zhaungtaistr.length<1) {
                self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(settimermytime) userInfo:nil repeats:YES];
               }else{
                   self.dabaolab.text = @"已满标";
               }
            }else{
                if (self.zhaungtaistr.length<1) {
                    self.dabaolab.text = @"00天00时00分00秒";
                }else{
                     self.dabaolab.text = @"已满标";
                }
                
            }
            
        }else{
            
            self.dabaolab.text = @"已满标";
        }
        
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //[RHUtility showTextWithText:@"请求失败"];
    }];
    

    
}

-(void)settimermytime{
    
    self.dabaolab.text = [self timeFormatted:self.inttimer];
    
    self.inttimer --;
}

- (NSString *)timeFormatted:(int)totalSeconds
{
    
   
    int days = totalSeconds /86400;
    int hours = (totalSeconds % 86400)/3600;
    int seconds = totalSeconds % 60;
    int minutes = ((totalSeconds % 86400)%3600)/60;
    
    
    return [NSString stringWithFormat:@"%02d天%02d时%02d分%02d秒",days,hours, minutes, seconds];
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [self.timer invalidate];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    
}

- (IBAction)daikuan:(id)sender {
    
    self.newsegement1.hidden = YES;
    self.newsegement2.hidden = YES;
    self.newsegement3.hidden = NO;
    self.newsegement4.hidden = YES;
    [self didSelectSegmentAtIndex:2];
}


@end
