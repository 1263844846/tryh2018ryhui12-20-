//
//  RHProjectdetailthreeViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 16/3/3.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import "RHProjectDViewNewpeopleController.h"
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

@interface RHProjectDViewNewpeopleController ()<UIScrollViewDelegate>

//@property(nonatomic,strong)NSMutableArray* array1;
//@property(nonatomic,strong)NSMutableArray* array2;
//
//@property (nonatomic,strong)NSMutableArray* dataArray;
//
//@property(nonatomic,strong)RHDetaisecondViewController* controller1;
//@property(nonatomic,strong)RHFKdetaiViewController*controller2;
//@property(nonatomic,strong)RHFKdetaiViewController*controller3;
//@property(nonatomic,strong)RHSegmentContentView* segmentContentView;
//@property(nonatomic,strong)RHXFDViewController * controller4;
//@property(nonatomic,strong)RYHStudentDetailViewController* controller5;
//@property(nonatomic,strong)NSMutableArray* viewControllers;
//@property (weak, nonatomic) IBOutlet UIView *segmentView1;
//@property (weak, nonatomic) IBOutlet UIView *segmentView2;
//@property (weak, nonatomic) IBOutlet UIView *segmentView3;
//
//@property (weak, nonatomic) IBOutlet UIScrollView *maiscorleview;
//@property (strong, nonatomic) IBOutlet UIView *secondView;
//
//
//@property(nonatomic,strong)CircleProgressView* progressView;
//
//@property (weak, nonatomic) IBOutlet UIView *kaihuView;
//@property (weak, nonatomic) IBOutlet UIImageView *jsqimage;
//
//@property (weak, nonatomic) IBOutlet UIButton *toubiaobtn;
//
//
//
//@property (weak, nonatomic) IBOutlet UIView *prossview;
//@property (weak, nonatomic) IBOutlet UILabel *shouyilab;
//@property (weak, nonatomic) IBOutlet UILabel *qixianlab;
//@property (weak, nonatomic) IBOutlet UILabel *ketoulab;
//@property (weak, nonatomic) IBOutlet UILabel *zongelab;
//@property (weak, nonatomic) IBOutlet UILabel *prodectnamelab;
//@property (weak, nonatomic) IBOutlet UILabel *dabaolab;
//@property (weak, nonatomic) IBOutlet UILabel *huankuanfangshi;
//@property (weak, nonatomic) IBOutlet UILabel *jixifangshilab;
//@property (weak, nonatomic) IBOutlet UILabel *qitoulab;
//
//@property (weak, nonatomic) IBOutlet UIImageView *danbaologo;
//@property (weak, nonatomic) IBOutlet UIView *mengbanview;
//@property(nonatomic,assign)BOOL ressss;
//@property (weak, nonatomic) IBOutlet UILabel *firstlab;
//@property (weak, nonatomic) IBOutlet UILabel *secondlab;
//
//@property (weak, nonatomic) IBOutlet UILabel *jindu;
//@property (weak, nonatomic) IBOutlet UIView *firstview;
//
//
//@property(strong,nonatomic)UILabel * mylab;
@end

@implementation RHProjectDViewNewpeopleController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
//    self.toubiaobtn.hidden = NO;
//    self.jsqimage.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.jindu.text = @"";
    //    self.toubiaobtn.frame = CGRectMake(, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
    /*
    [[UIApplication sharedApplication].keyWindow addSubview:self.toubiaobtn];
    [[UIApplication sharedApplication].keyWindow addSubview:self.jsqimage];
    if([UIScreen mainScreen].bounds.size.width >325){
        self.maiscorleview.contentSize = CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), ([UIScreen mainScreen].bounds.size.height-69-30)*2 );
    }else{
        self.maiscorleview.contentSize = CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), ([UIScreen mainScreen].bounds.size.height-69-30)*2);
    }
    self.maiscorleview.delegate = self;
    if ([UIScreen mainScreen].bounds.size.width <380 &&[UIScreen mainScreen].bounds.size.width >325) {
        self.secondView.frame = CGRectMake(0, CGRectGetMaxY(self.jsqimage.frame)+3, self.maiscorleview.frame.size.width, [UIScreen mainScreen].bounds.size.height-69-30);
        self.jsqimage.frame = CGRectMake(self.jsqimage.frame.origin.x, self.jsqimage.frame.origin.y+70, self.jsqimage.frame.size.width, self.jsqimage.frame.size.height);
        self.toubiaobtn.frame = CGRectMake(self.toubiaobtn.frame.origin.x, self.toubiaobtn.frame.origin.y+70, self.toubiaobtn.frame.size.width+40, self.toubiaobtn.frame.size.height);
        
    }else if([UIScreen mainScreen].bounds.size.width <325){
        // NSLog(@"%f",[UIScreen mainScreen].bounds.size.width);
        self.secondView.frame = CGRectMake(0, CGRectGetMaxY(self.jsqimage.frame)-100, self.maiscorleview.frame.size.width, [UIScreen mainScreen].bounds.size.height-69-30+100);
    }else{
        self.secondView.frame = CGRectMake(0, CGRectGetMaxY(self.jsqimage.frame)+70, self.maiscorleview.frame.size.width, [UIScreen mainScreen].bounds.size.height-69-30);
        
        self.jsqimage.frame = CGRectMake(self.jsqimage.frame.origin.x, self.jsqimage.frame.origin.y+130, self.jsqimage.frame.size.width, self.jsqimage.frame.size.height);
        self.toubiaobtn.frame = CGRectMake(self.toubiaobtn.frame.origin.x, self.toubiaobtn.frame.origin.y+130, self.toubiaobtn.frame.size.width+80, self.toubiaobtn.frame.size.height);
    }
    UITapGestureRecognizer * aimagetap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushjsq)];
    self.jsqimage.userInteractionEnabled = YES;
    [self.jsqimage addGestureRecognizer:aimagetap];
    
    [self.maiscorleview addSubview:self.secondView];
    self.segmentView2.hidden = YES;
    
    self.maiscorleview.bounces = NO;
    self.maiscorleview.alwaysBounceHorizontal = NO;
    self.maiscorleview.alwaysBounceVertical = NO;
    self.maiscorleview.showsHorizontalScrollIndicator = NO;
    self.maiscorleview.showsHorizontalScrollIndicator = NO;
    self.maiscorleview.pagingEnabled = YES;
    self.secondView.hidden = YES;
    
   
    
    
    [RHmainModel ShareRHmainModel].tabbarstr = @"cbx";
    self.view.backgroundColor = [UIColor whiteColor];
    [DQViewController Sharedbxtabar].tarbar.hidden = YES;
    [self configBackButton];
    [self configTitleWithString:@"项目详情"];
   
    if ([RHUserManager sharedInterface].username) {
        [self.toubiaobtn setTitle:@"立即投资" forState:UIControlStateNormal];
    }else{
        // [self.toubiaobtn setTitle:@"马上登录" forState:UIControlStateNormal];
    }
    [self setupWithDic:self.dataDic];
    
    self.kaihuView.layer.masksToBounds=YES;
    self.kaihuView.layer.cornerRadius=9;
    self.kaihuView.hidden = YES;
    self.mengbanview.hidden = YES;
    
    
    self.segmentContentView = [[RHSegmentContentView alloc] initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].applicationFrame.size.height-50-30-self.navigationController.navigationBar.frame.size.height)];
    //    DLog(@"%f----%f",[UIScreen mainScreen].applicationFrame.size.height-50-40-self.navigationController.navigationBar.frame.size.height,self.navigationController.navigationBar.frame.size.height);
    [_segmentContentView setDelegate:self];
    [self.secondView addSubview:_segmentContentView];
    //  _segmentContentView.backgroundColor = [UIColor grayColor];
    
    
    _viewControllers = [NSMutableArray array];
//    [self getsegmentviewcontrol];
    
    if (self.zhaungtaistr) {
        [self.toubiaobtn setTitle:self.zhaungtaistr forState:UIControlStateNormal] ;
        self.toubiaobtn.userInteractionEnabled = NO;
        self.toubiaobtn.backgroundColor = [RHUtility colorForHex:@"#bdbdbe"];
    }
     */
    
}
/*

- (void)configBackButton
{
    UIButton* button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    //    UIImage * image = [UIImage imageNamed:@"back.png"];
    
    [button setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    button.frame=CGRectMake(0, 0, 11, 17);
    
    // button.backgroundColor = [UIColor colorWithHexString:@"44bbc1"];
    self.navigationItem.leftBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:button];
}
-(void)back
{
    self.toubiaobtn.hidden = YES;
    self.jsqimage.hidden = YES;
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
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)pushjsq{
    self.toubiaobtn.hidden = YES;
    self.jsqimage.hidden = YES;
    RHJsqViewController * vc = [[RHJsqViewController alloc]initWithNibName:@"RHJsqViewController" bundle:nil];
    vc.nianStr = self.shouyilab.text;
    vc.projectid = self.projectId;
    vc.mouthStr = self.qixianlab.text;
    vc.monery = self.zongelab.text;
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)getsegmentviewcontrol{
    
    if ([self.dataDic[@"product"]isEqualToString:@"6"] ) {
        self.controller4=[[RHXFDViewController alloc]initWithNibName:@"RHXFDViewController" bundle:nil];
        _controller4.projectid = self.projectId;
        _controller4.nav = self.navigationController;
        [_viewControllers addObject:_controller4];
        _controller4.myblock = ^(){
            [self secondblock];
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
            _controller1.myblock = ^(){
                [self secondblock];
            };
            [_viewControllers addObject:_controller1];
        }
    }
   
    //     /_controller2.tableView.hidden = YES;
    _controller2.type = @"0";
    self.controller3=[[RHFKdetaiViewController alloc]initWithNibName:@"RHFKdetaiViewController" bundle:nil];
    [_viewControllers addObject:_controller3];
    _controller3.projectid = self.projectId;
    [_segmentContentView setViews:_viewControllers];
    
    //[self segmentContentView:_segmentContentView selectPage:0];
    //[self getdata];
    
}
- (void)didSelectSegmentAtIndex:(int)index
{
    
    
    [_segmentContentView setSelectPage:index];
    
}
- (void)segmentContentView:(RHSegmentContentView *)segmentContentView selectPage:(NSUInteger)page{
    
    
    if (page ==1) {
        
        
        [self segntthreebtn:nil];
    }else{
        [self segntonebtn:nil];
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
            _controller1.datadic = self.dataDic;
            _controller2.datadic = self.dataDic;
            _controller1.nhstr = self.shouyilab.text;
            
            _controller1.mouthstr = self.qixianlab.text;
        }else{
            self.secondView.hidden = YES;
        }
        // NSLog(@"jieshu");
    }else{
        
        if (scrollView.contentOffset.y > 380) {
            self.secondView.hidden=NO;
            _controller1.datadic = self.dataDic;
            _controller2.datadic = self.dataDic;
        }else{
            self.secondView.hidden = YES;
        }
        
    }
}


-(void)setupWithDic:(NSDictionary*)dic{
    if ([[dic objectForKey:@"id"] isKindOfClass:[NSNull class]]) {
        self.projectId=@"";
    }else{
        self.projectId=[dic objectForKey:@"id"];
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
            NSString * str =[dic objectForKey:@"limitTime"];
            self.qixianlab.text= [NSString stringWithFormat:@"%@个月",str];
            
        }else{
            NSString * str =[dic objectForKey:@"limitTime"] ;
            self.qixianlab.text= [NSString stringWithFormat:@"%@个月",str];
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
        self.dabaolab.text=[dic objectForKey:@"insuranceName"];
    }
    if ([[dic objectForKey:@"paymentName"] isKindOfClass:[NSNull class]]) {
        self.huankuanfangshi.text=@"";
    }else{
        self.huankuanfangshi.text=[dic objectForKey:@"paymentName"];
    }
    CGFloat a = [[dic objectForKey:@"percent"] intValue]/100.0;
    
    [self.progressView setProgress:a];
    
    
    NSString * srtr = [dic objectForKey:@"available"];
    self.ketoulab.text = [NSString stringWithFormat:@"%@",srtr];
    // self.ketouLab.text = @"99999999";
    
    CGFloat percent=0;
    if (![[dic objectForKey:@"percent"] isKindOfClass:[NSNull class]]) {
        percent=[[dic objectForKey:@"percent"] floatValue]/100.0;
        //        self.button.userInteractionEnabled = YES;
    }
    self.secondlab.frame = CGRectMake(CGRectGetMinX(self.secondlab.frame), CGRectGetMinY(self.secondlab.frame), percent * self.firstlab.frame.size.width, 3);
    //    self.secondlab.frame.size.width =  percent * self.firstlab.frame.size.width;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)toubiao:(UIButton *)sender {
    self.toubiaobtn.hidden = YES;
    self.jsqimage.hidden = YES;
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
            [[UIApplication sharedApplication].keyWindow addSubview:self.mengbanview ];
            [[UIApplication sharedApplication].keyWindow addSubview:self.kaihuView];
            
        }else{
            RHInvestmentViewController* contoller=[[RHInvestmentViewController alloc]initWithNibName:@"RHInvestmentViewController" bundle:nil];
            NSString * str = self.dataDic[@"available"];
            int a = [str intValue];
            contoller.projectFund= a;
            contoller.dataDic=self.dataDic;
            
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
                    [RHUtility showTextWithText:@"您已投资过，请看其余项目。"];
                    return;
                }
                
            }
            
            
            
            //contoller.lilv =str1;
            [self.navigationController pushViewController:contoller animated:YES];
            
            
            
            
            
            
        }
    }
    
    
    
    
}


- (IBAction)kaitonghuifu:(id)sender {
    self.toubiaobtn.hidden = YES;
    self.jsqimage.hidden = YES;
    RHRegisterWebViewController* controller1=[[RHRegisterWebViewController alloc]initWithNibName:@"RHRegisterWebViewController" bundle:nil];
    [self.navigationController pushViewController:controller1 animated:YES];
    self.kaihuView.hidden = YES;
    self.mengbanview.hidden = YES;
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
    [self didSelectSegmentAtIndex:0];
}


- (IBAction)segntthreebtn:(id)sender {
    
    if ([RHUserManager sharedInterface].username&&[[RHUserManager sharedInterface].username length]>0) {
        if (self.segmentView2.hidden) {
            self.segmentView1.hidden = YES;
            self.segmentView2.hidden = YES;
            self.segmentView3.hidden = NO;
            [self didSelectSegmentAtIndex:1];
            
            //            [self didSelectSegmentAtIndex:2];
            
            
        }else{
            self.segmentView1.hidden = YES;
            self.segmentView2.hidden = YES;
            self.segmentView3.hidden = NO;
            [self didSelectSegmentAtIndex:1];
        }
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"登录后才可查看投标记录,请先登录" delegate:self cancelButtonTitle:@"登录" otherButtonTitles:@"取消", nil];
        alert.tag=5565;
        [alert show];
        
        //        [self didSelectSegmentAtIndex:2];
    }
    
    
    
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
    self.ressss=YES;
    if (buttonIndex==0) {
        if (alertView.tag==5565) {
            
            [[RHTabbarManager sharedInterface] cleanTabbar];
            [[RHTabbarManager  sharedInterface] selectALogin];
        }
    }else{
        
        self.controller2.tableView.hidden = YES;
        self.segmentView1.hidden = YES;
        self.segmentView3.hidden = YES;
        self.segmentView2.hidden = NO;
        [self didSelectSegmentAtIndex:1];
        
    }
}

-(void)secondblock{
    self.toubiaobtn.hidden = YES;
    self.jsqimage.hidden = YES;
    
}
-(void)viewDidDisappear:(BOOL)animated{
    //    self.toubiaobtn.hidden = YES;
    [super viewDidDisappear:animated];
    
}
 */
@end
