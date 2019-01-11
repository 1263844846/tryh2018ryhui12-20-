//
//  RHNEWpeopleViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 16/11/3.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import "RHNEWpeopleViewController.h"
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

#import "RHOpenCountViewController.h"
#import "RHJXPassWordViewController.h"

@interface RHNEWpeopleViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *mengbanview;
@property (weak, nonatomic) IBOutlet UIView *kaihuview;

@property (weak, nonatomic) IBOutlet UIButton *touzibtn;
@property (weak, nonatomic) IBOutlet UIImageView *jsqimage;
@property (weak, nonatomic) IBOutlet UIScrollView *mainscrollview;
@property (strong, nonatomic) IBOutlet UIView *secondview;
@property (weak, nonatomic) IBOutlet UIView *sgment2;
@property (weak, nonatomic) IBOutlet UIView *sgment1;


@property (weak, nonatomic) IBOutlet UILabel *namelab;
@property (weak, nonatomic) IBOutlet UILabel *danbaolab;
@property (weak, nonatomic) IBOutlet UILabel *qitoulab;
@property (weak, nonatomic) IBOutlet UILabel *huankuanfangshi;
@property (weak, nonatomic) IBOutlet UILabel *jixifangshi;
@property (weak, nonatomic) IBOutlet UILabel *shouyi;
@property (weak, nonatomic) IBOutlet UILabel *qixian;
@property (weak, nonatomic) IBOutlet UILabel *keyou;
@property (weak, nonatomic) IBOutlet UILabel *zonge;
@property (weak, nonatomic) IBOutlet UILabel *firstlab;
@property (weak, nonatomic) IBOutlet UILabel *secondlab;
@property (weak, nonatomic) IBOutlet UILabel *jindu;
@property (weak, nonatomic) IBOutlet UIButton *khbtn;

@property (weak, nonatomic) IBOutlet UILabel *kaihulab;

@property(nonatomic,strong)RHDetaisecondViewController* controller1;
@property(nonatomic,strong)RHFKdetaiViewController*controller2;
@property(nonatomic,strong)RHFKdetaiViewController*controller3;
@property(nonatomic,strong)RHSegmentContentView* segmentContentView;
@property(nonatomic,strong)RHXFDViewController * controller4;
@property(nonatomic,strong)RYHStudentDetailViewController* controller5;
@property(nonatomic,strong)NSMutableArray* viewControllers;
@property(nonatomic,copy)NSString * passwordbool;
@end

@implementation RHNEWpeopleViewController

-(void)getmyjxpassword{
    
    [[RHNetworkService instance] POST:@"app/front/payment/appJxAccount/isSetPassword" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"----===============-1111---%@",responseObject);
        self.passwordbool = [NSString stringWithFormat:@"%@",responseObject[@"setPwd"]];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
        DLog(@"%@",[[NSString alloc] initWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
        
    }];
    
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.touzibtn.hidden = NO;
    self.jsqimage.hidden = NO;
}
-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.mengbanview.hidden = YES;
    self.kaihuview.hidden = YES;
    self.touzibtn.hidden = YES;
    self.jsqimage.hidden = YES;
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self getmyjxpassword];
    [self getnewpeoplegetproject];
    [DQViewController Sharedbxtabar].tarbar.hidden = YES;
    [self configBackButton];
    if (self.zhaungtaistr) {
        [self.touzibtn setTitle:self.zhaungtaistr forState:UIControlStateNormal] ;
        self.touzibtn.userInteractionEnabled = NO;
        self.touzibtn.backgroundColor = [RHUtility colorForHex:@"#bdbdbe"];
    }
    
    self.mengbanview.hidden = YES;
    self.kaihuview.hidden = YES;
    self.secondview.hidden = YES;
    self.sgment2.hidden = YES;
    [self configTitleWithString:@"项目详情"];
//     [self mygetdata];
    [[UIApplication sharedApplication].keyWindow addSubview:self.touzibtn];
    [[UIApplication sharedApplication].keyWindow addSubview:self.jsqimage];
   

    if([UIScreen mainScreen].bounds.size.width >325){
        self.mainscrollview.contentSize = CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), ([UIScreen mainScreen].bounds.size.height-69-30)*2 );
    }else{
        self.mainscrollview.contentSize = CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), ([UIScreen mainScreen].bounds.size.height-69-30)*2);
    }
    self.mainscrollview.delegate = self;
    if ([UIScreen mainScreen].bounds.size.width <380 &&[UIScreen mainScreen].bounds.size.width >325) {
        self.secondview.frame = CGRectMake(0, CGRectGetMaxY(self.jsqimage.frame)-10, self.mainscrollview.frame.size.width, [UIScreen mainScreen].bounds.size.height-69-30);
        self.jsqimage.frame = CGRectMake(self.jsqimage.frame.origin.x, self.jsqimage.frame.origin.y+70, self.jsqimage.frame.size.width, self.jsqimage.frame.size.height);
        self.touzibtn.frame = CGRectMake(self.touzibtn.frame.origin.x, self.touzibtn.frame.origin.y+70, self.touzibtn.frame.size.width, self.touzibtn.frame.size.height);
        
    }else if([UIScreen mainScreen].bounds.size.width <325){
        // NSLog(@"%f",[UIScreen mainScreen].bounds.size.width);
        self.secondview.frame = CGRectMake(0, CGRectGetMaxY(self.jsqimage.frame)-110, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-69-30+100);
       self.touzibtn.frame = CGRectMake(self.touzibtn.frame.origin.x, self.jsqimage.frame.origin.y, self.touzibtn.frame.size.width-40, self.touzibtn.frame.size.height);
    }else{
        self.secondview.frame = CGRectMake(0, CGRectGetMaxY(self.jsqimage.frame)+60, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-69-30);
        
        self.jsqimage.frame = CGRectMake(self.jsqimage.frame.origin.x, self.jsqimage.frame.origin.y+130, self.jsqimage.frame.size.width, self.jsqimage.frame.size.height);
        self.touzibtn.frame = CGRectMake(self.touzibtn.frame.origin.x, self.touzibtn.frame.origin.y+130, self.touzibtn.frame.size.width+20, self.touzibtn.frame.size.height);
    }
    if ([UIScreen mainScreen].bounds.size.height>810) {
        self.secondview.frame = CGRectMake(0, CGRectGetMaxY(self.jsqimage.frame)+3+30+10, self.mainscrollview.frame.size.width, [UIScreen mainScreen].bounds.size.height-69-30);
        self.jsqimage.frame = CGRectMake(self.jsqimage.frame.origin.x, self.jsqimage.frame.origin.y+130, self.jsqimage.frame.size.width, self.jsqimage.frame.size.height);
        self.touzibtn.frame = CGRectMake(self.touzibtn.frame.origin.x, self.touzibtn.frame.origin.y+130, self.touzibtn.frame.size.width+10, self.touzibtn.frame.size.height);
   //     self.hidenbtnview.frame = CGRectMake(0, self.touzibtn.frame.origin.y-5, [UIScreen mainScreen].bounds.size.width, self.toubiaobtn.frame.size.height+10+10+5);
    }
    
    [self.mainscrollview addSubview:self.secondview];
    self.mainscrollview.bounces = NO;
    self.mainscrollview.alwaysBounceHorizontal = NO;
    self.mainscrollview.alwaysBounceVertical = NO;
    self.mainscrollview.showsHorizontalScrollIndicator = NO;
    self.mainscrollview.showsHorizontalScrollIndicator = NO;
    self.mainscrollview.pagingEnabled = YES;
    
    [self setupWithDic:self.dataDic];
    
    _viewControllers = [NSMutableArray array];
    self.segmentContentView = [[RHSegmentContentView alloc] initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].applicationFrame.size.height-50-30-self.navigationController.navigationBar.frame.size.height)];
    //    DLog(@"%f----%f",[UIScreen mainScreen].applicationFrame.size.height-50-40-self.navigationController.navigationBar.frame.size.height,self.navigationController.navigationBar.frame.size.height);
    [_segmentContentView setDelegate:self];
    [self.secondview addSubview:_segmentContentView];
   
    [self getsegmentviewcontrol];
    UITapGestureRecognizer * aimagetap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushjsq)];
    self.jsqimage.userInteractionEnabled = YES;
    [self.jsqimage addGestureRecognizer:aimagetap];
}
//-(void)mygetdata{
//    NSDictionary* parameters=@{@"id":self.projectId};
//    [[RHNetworkService instance] POST:@"app/common/appDetails/appNoviceDetailPage" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        if ([responseObject isKindOfClass:[NSDictionary class]]) {
//            
//            // NSLog(@"%@",responseObject);
//            
////            [self setDataDic:responseObject];
//            
//            
//        }
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        ;
//    }];
//    
//}
-(void)pushjsq{
    self.touzibtn.hidden = YES;
    self.jsqimage.hidden = YES;
    RHJsqViewController * vc = [[RHJsqViewController alloc]initWithNibName:@"RHJsqViewController" bundle:nil];
    vc.nianStr = self.shouyi.text;
    vc.projectid = self.projectId;
    vc.mouthStr = self.qixian.text;
    vc.monery = self.zonge.text;
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // NSLog(@"%f",scrollView.contentOffset.y);
    
    if ([UIScreen mainScreen].bounds.size.height >570) {
        
        if (scrollView.contentOffset.y > 480) {
            if (_controller1.sess == YES) {
                [_controller1.newscrool setContentOffset:CGPointMake(0, 2) animated:NO];
            }
            self.secondview.hidden=NO;
//            _controller1.datadic = self.dataDic;
//            _controller2.datadic = self.dataDic;
//            _controller1.nhstr = self.shouyilab.text;
            
//            _controller1.mouthstr = self.qixianlab.text;
        }else{
            self.secondview.hidden = YES;
        }
        // NSLog(@"jieshu");
    }else{
        
        if (scrollView.contentOffset.y > 380) {
            self.secondview.hidden=NO;
//            _controller1.datadic = self.dataDic;
//            _controller2.datadic = self.dataDic;
            if (_controller1.sess == YES) {
                [_controller1.newscrool setContentOffset:CGPointMake(0, 1) animated:NO];
            }
        }else{
            self.secondview.hidden = YES;
            if (_controller1.sess == YES) {
                [_controller1.newscrool setContentOffset:CGPointMake(0, 1) animated:NO];
            }
        }
        
    }
}

-(void)setupWithDic:(NSDictionary*)dic{
    if ([[dic objectForKey:@"id"] isKindOfClass:[NSNull class]]) {
        self.projectId=@"";
    }else{
        self.projectId=[dic objectForKey:@"id"];
    }
//    [self mygetdata];
    if ([[dic objectForKey:@"name"] isKindOfClass:[NSNull class]]) {
        self.namelab.text=@"";
    }else{
        self.namelab.text=[dic objectForKey:@"name"];
    }
    if ([[dic objectForKey:@"investorRate"] isKindOfClass:[NSNull class]]) {
        self.shouyi.text=@"";
    }else{
        _lilv=[[dic objectForKey:@"investorRate"] stringValue];
        self.shouyi.text = [NSString stringWithFormat:@"%@%%",_lilv];
    }
    
    
    
    if ([[dic objectForKey:@"limitTime"] isKindOfClass:[NSNull class]]) {
        self.qixian.text=@"";
    }else{
        if (self.panduan == 10) {
            if ([[dic objectForKey:@"monthOrDay"] isKindOfClass:[NSNull class]]) {
                NSString * str =[dic objectForKey:@"limitTime"];
                self.qixian.text= [NSString stringWithFormat:@"%@个月",str];
            }else{
                NSString * str =[dic objectForKey:@"limitTime"];
                self.qixian.text= [NSString stringWithFormat:@"%@%@",str,dic[@"monthOrDay"]];
            }
            
            
        }else{
            //            NSString * str =[dic objectForKey:@"limitTime"] ;
            //            self.qixianlab.text= [NSString stringWithFormat:@"%@个月",str];
            if ([[dic objectForKey:@"monthOrDay"] isKindOfClass:[NSNull class]]) {
                NSString * str =[dic objectForKey:@"limitTime"];
                self.qixian.text= [NSString stringWithFormat:@"%@个月",str];
            }else{
                NSString * str =[dic objectForKey:@"limitTime"];
                self.qixian.text= [NSString stringWithFormat:@"%@%@",str,dic[@"monthOrDay"]];
            }
            
        }
    }
//    if ([[dic objectForKey:@"limitTime"] isKindOfClass:[NSNull class]]) {
//        self.qixian.text=@"";
//    }else{
//        if (self.panduan == 10) {
//            NSString * str =[dic objectForKey:@"limitTime"];
//            self.qixian.text= [NSString stringWithFormat:@"%@个月",str];
//            
//        }else{
//            NSString * str =[dic objectForKey:@"limitTime"] ;
//            self.qixian.text= [NSString stringWithFormat:@"%@个月",str];
//        }
//    }
    
    if (self.panduan ==10) {
        NSString * moneyy =[dic objectForKey:@"projectFund"];
        NSArray *array = [moneyy componentsSeparatedByString:@","];
        NSString * stringmoney = @"";
        for (NSString * str  in array) {
            stringmoney = [NSString stringWithFormat:@"%@%@",stringmoney,str];
        }
        
        float mo = [stringmoney floatValue];
        self.zonge.text = [NSString stringWithFormat:@"%.2f万",mo/10000.0];
    }else{
        
            
            NSString * str = [[dic objectForKey:@"projectFund"] stringByReplacingOccurrencesOfString:@"," withString:@""];
            NSLog(@"%f",[str floatValue]);
            
            self.zonge.text = [NSString stringWithFormat:@"%.2f万",([str floatValue]/10000.0)];
            
        
            
        
    }
    
    if ([[dic objectForKey:@"insuranceName"] isKindOfClass:[NSNull class]]) {
        self.danbaolab.text=@"";
    }else{
        self.danbaolab.text=[dic objectForKey:@"insuranceName"];
    }
    if ([[dic objectForKey:@"paymentName"] isKindOfClass:[NSNull class]]) {
        self.huankuanfangshi.text=@"";
    }else{
        self.huankuanfangshi.text=[dic objectForKey:@"paymentName"];
    }
    CGFloat a = [[dic objectForKey:@"percent"] intValue]/100.0;
    
//    [self.progressView setProgress:a];
    
    
    NSString * srtr = [dic objectForKey:@"available"];
    self.keyou.text = [NSString stringWithFormat:@"%@",srtr];
    // self.ketouLab.text = @"99999999";
    
    CGFloat percent=0;
    if (![[dic objectForKey:@"percent"] isKindOfClass:[NSNull class]]) {
        percent=[[dic objectForKey:@"percent"] floatValue]/100.0;
        //        self.button.userInteractionEnabled = YES;
    }
//    self.firstlab.frame = CGRectMake(CGRectGetMinX(self.firstlab.frame), CGRectGetMinY(self.firstlab.frame), self.firstlab.frame.size.width*([UIScreen mainScreen].bounds.size.width/375.00), 3);
    self.secondlab.frame = CGRectMake(CGRectGetMinX(self.secondlab.frame), CGRectGetMinY(self.secondlab.frame), percent * self.firstlab.frame.size.width, 3);
 
    NSLog(@"%f",self.firstlab.frame.size.width);
    NSLog(@"%f",self.secondlab.frame.size.width);
//    self.secondlab.hidden = YES;
//    [self.firstview addSubview:self.mylab];
    if (percent >=1) {
        self.secondlab.hidden = NO;
//        self.mylab.hidden = YES;
    }
    self.jindu.text = [NSString stringWithFormat:@"%.2f%%",percent*100];
    //    self.jindu.text =@"11";
    
    if ([[dic objectForKey:@"everyoneEndAmount"] isKindOfClass:[NSNull class]]) {
        self.danbaolab.text=@"单人限投1万元";
    }else{
        NSString * monstr = [dic objectForKey:@"everyoneEndAmount"];
//        NSString * str = @"null";
//        if ([monstr isEqualToString:str]) {
//            self.danbaolab.text=@"单人限投1万元";
//        }else{
        
        int a = [monstr intValue];
        if (a<10) {
            a=10000;
        }
        self.danbaolab.text=[NSString stringWithFormat:@"单人限投%d万元",a/10000];
//        }
    }
}

-(void)getsegmentviewcontrol{
    
    if ([self.dataDic[@"product"]isEqualToString:@"6"] ) {
        self.controller4=[[RHXFDViewController alloc]initWithNibName:@"RHXFDViewController" bundle:nil];
        _controller4.projectid = self.projectId;
        _controller4.nav = self.navigationController;
        [_viewControllers addObject:_controller4];
        _controller4.myblock = ^(){
//            [self secondblock];
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
            
            self.controller1=[[RHDetaisecondViewController alloc]initWithNibName:@"RHDetaisecondViewController" bundle:nil];
            _controller1.projectid = self.projectId;
            _controller1.nav = self.navigationController;
//            self.controller1.jietitle.text = @"出借限额(每人限投一次)";
            _controller1.newpeo = YES;
            
            _controller1.myblock = ^(){
//                [self secondblock];
            };
            _controller1.scroolblock = ^(){
                
                _controller1.sess = NO;
                [UIView animateWithDuration:5.0f animations:^{
                    [self.mainscrollview setContentOffset:CGPointMake(0, 0) animated:YES];
                    
                } completion:^(BOOL finished) {
                    //                    [self.maiscorleview setContentOffset:CGPointMake(0, 0) animated:YES];
                    _controller1.sess = YES;
                }];
            };
            [_viewControllers addObject:_controller1];
        }
    }
    
    self.controller3=[[RHFKdetaiViewController alloc]initWithNibName:@"RHFKdetaiViewController" bundle:nil];
    [_viewControllers addObject:_controller3];
    _controller3.projectid = self.projectId;
    [_segmentContentView setViews:_viewControllers];
    

    
}

- (void)segmentContentView:(RHSegmentContentView *)segmentContentView selectPage:(NSUInteger)page{
    
    
    if (page ==1) {
        if (![RHUserManager sharedInterface].username.length) {
            self.controller3.view.hidden = YES;
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"登录后才可查看投标记录,请先登录" delegate:self cancelButtonTitle:@"登录" otherButtonTitles:@"取消", nil];
            alert.tag=5565;
            [alert show];
        }
        [self segentsecondbtn:nil];
    }else  {
        
        [self segntthreebtn:nil];
    }
    //    [self didSelectSegmentAtIndex:page];
}

-(IBAction)segentsecondbtn:(id)sender {
//    self.controller2.tableView.hidden = YES;
    self.sgment1.hidden = YES;
   
    self.sgment2.hidden = NO;
   
    
    [self didSelectSegmentAtIndex:1];
    
    
}

-(IBAction)segntthreebtn:(id)sender {
//    self.controller2.tableView.hidden = YES;
    self.sgment2.hidden = YES;
   
    self.sgment1.hidden = NO;
    [self didSelectSegmentAtIndex:0];
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
    
    if (buttonIndex==0) {
        if (alertView.tag==5565) {
            
            [[RHTabbarManager sharedInterface] cleanTabbar];
            [[RHTabbarManager  sharedInterface] selectALogin];
            
            
        }
    }else{
        
        //        self.controller2.tableView.hidden = YES;
        //        self.segmentView1.hidden = YES;
        //        self.segmentView3.hidden = YES;
        //        self.segmentView2.hidden = NO;
        //        [self didSelectSegmentAtIndex:1];
        
    }
}

- (void)didSelectSegmentAtIndex:(int)index{
    
    
    [_segmentContentView setSelectPage:index];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
    
    // Dispose of any resources that can be recreated.
}
- (IBAction)touzi:(id)sender {
    if (![RHUserManager sharedInterface].username) {
        //        [self.investmentButton setTitle:@"请先登录" forState:UIControlStateNormal];
        
        NSLog(@"ddddddd");
        RHALoginViewController* controller=[[RHALoginViewController alloc] initWithNibName:@"RHALoginViewController" bundle:nil];
        [self.navigationController pushViewController:controller animated:YES];
        return;
    }
    
    if (![RHUserManager sharedInterface].custId) {
        //            [self.investmentButton setTitle:@"请先开户" forState:UIControlStateNormal];
        NSLog(@"kkkkkkk");
        //            self.maiscorleview.backgroundColor = ;
        self.kaihuview.hidden = NO;
        self.mengbanview.hidden = NO;
        self.touzibtn.hidden = NO;
        self.jsqimage.hidden = NO;
      //  self.hidenbtnview.hidden= NO;
        [[UIApplication sharedApplication].keyWindow addSubview:self.mengbanview ];
        [[UIApplication sharedApplication].keyWindow addSubview:self.kaihuview];
        
        if ([UIScreen mainScreen].bounds.size.width>376) {
            self.kaihuview.frame = CGRectMake(40, CGRectGetMinY(self.kaihuview.frame), [UIScreen mainScreen].bounds.size.width-80, 310);
        }else{
            self.kaihuview.frame = CGRectMake(40, CGRectGetMinY(self.kaihuview.frame), [UIScreen mainScreen].bounds.size.width-80, 245);
        }
        return;
        
    }
        
    if (![self.passwordbool isEqualToString:@"yes"]) {
            
            [self.khbtn setTitle:@"设置交易密码" forState:UIControlStateNormal];
            // self.passwordlab.text = @"资金更安全，请先设置交易密码在进行出借／提现";
            self.kaihuview.hidden = NO;
            self.mengbanview.hidden = NO;
            self.touzibtn.hidden = NO;
            self.jsqimage.hidden = NO;
            [[UIApplication sharedApplication].keyWindow addSubview:self.mengbanview ];
            [[UIApplication sharedApplication].keyWindow addSubview:self.kaihuview];
            if ([UIScreen mainScreen].bounds.size.width>376) {
                self.kaihuview.frame = CGRectMake(40, CGRectGetMinY(self.kaihuview.frame), [UIScreen mainScreen].bounds.size.width-80, 310);
            }else{
                self.kaihuview.frame = CGRectMake(40, CGRectGetMinY(self.kaihuview.frame), [UIScreen mainScreen].bounds.size.width-80, 245);
            }
        self.kaihulab.text = @"资金更安全，请先设置交易密码在进行出借／提现";
            return;
        }
    
    if ([self.judge isEqualToString:@"ketou"]) {
        [RHUtility showTextWithText:@"您已出借过，请看其余项目。"];
        return;
    }
    
    RHInvestmentViewController* contoller=[[RHInvestmentViewController alloc]initWithNibName:@"RHInvestmentViewController" bundle:nil];
    NSString * str = self.dataDic[@"available"];
    int a = [str intValue];
    contoller.projectFund= a;
    contoller.dataDic=self.dataDic;
    contoller.newpeople = YES;
    if ([[self.dataDic objectForKey:@"everyoneEndAmount"] isKindOfClass:[NSNull class]]) {
         contoller.everyoneEndAmountstr = @"10000";
    }else{
        
        if ([[self.dataDic objectForKey:@"everyoneEndAmount"] isEqualToString:@"null"]) {
            contoller.everyoneEndAmountstr = @"10000";
        }else{
        contoller.everyoneEndAmountstr =[NSString stringWithFormat:@"%@",[self.dataDic objectForKey:@"everyoneEndAmount"]];
        }
    }
    //            if (self.panduan == 10) {
    // contoller.panduan = 10;
    //            }
//    NSString * str1 =  dic[@"investorRate"];
    //contoller.lilv =str1;
    [self.navigationController pushViewController:contoller animated:YES];
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
            self.judge = @"ketou";
            
        }else{
            self.judge = @"";
            
        }
        
        //        [self.tableView reloadData];
        NSLog(@"%@--",responseObject);
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        NSLog(@"%@---",error);
        
        
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

- (IBAction)kaihu:(id)sender {
    
    self.touzibtn.hidden = YES;
    self.jsqimage.hidden = YES;
   // self.hidenbtnview.hidden= YES;
    
    
    if ([self.khbtn.titleLabel.text isEqualToString:@"设置交易密码"]) {
        
        RHJXPassWordViewController * controller =[[RHJXPassWordViewController alloc]initWithNibName:@"RHJXPassWordViewController" bundle:nil];
        self.kaihuview.hidden = YES;
        self.mengbanview.hidden = YES;
        controller.urlstr = @"app/front/payment/appJxAccount/passwordSetJxData";
        [self.navigationController pushViewController:controller animated:YES];
        return;
    }
    
    RHOpenCountViewController* controller1=[[RHOpenCountViewController alloc]initWithNibName:@"RHOpenCountViewController" bundle:nil];
    self.kaihuview.hidden = YES;
    self.mengbanview.hidden = YES;
    [self.navigationController pushViewController:controller1 animated:YES];
    
    
}
- (IBAction)quxiaokaihu:(id)sender {
    
    self.kaihuview.hidden = YES;
    self.mengbanview.hidden = YES;
}

@end
