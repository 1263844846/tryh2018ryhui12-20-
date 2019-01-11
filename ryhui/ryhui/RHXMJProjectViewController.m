//
//  RHXMJProjectViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 2018/6/20.
//  Copyright © 2018年 stefan. All rights reserved.
//

#import "RHXMJProjectViewController.h"
#import "RHXMJXQViewController.h"
#import "RHInvestmentViewController.h"
#import "RHJsqViewController.h"
#import "RHALoginViewController.h"
#import "RHXYWebviewViewController.h"
#import "RHOfficeNetAndWeiBoViewController.h"
#import "RHALoginViewController.h"
#import "RHJXPassWordViewController.h"
#import "RHOpenCountViewController.h"

#import "RHDBSJViewController.h"
#import "RHhelper.h"
@interface RHXMJProjectViewController ()
@property (weak, nonatomic) IBOutlet UILabel *moneylab;
@property (weak, nonatomic) IBOutlet UILabel *jindunumberlab;
@property (weak, nonatomic) IBOutlet UILabel *jundulab;
@property (weak, nonatomic) IBOutlet UILabel *lilvlab;

@property (weak, nonatomic) IBOutlet UILabel *qixianlab;

@property (weak, nonatomic) IBOutlet UILabel *zongelab;

@property (weak, nonatomic) IBOutlet UILabel *jixilab;
@property (weak, nonatomic) IBOutlet UILabel *xieyiframe;
@property (weak, nonatomic) IBOutlet UILabel *firstjundulab;


@property(nonatomic,copy)NSString *firstid;
@property(nonatomic,copy)NSString * cpurl;
@property (weak, nonatomic) IBOutlet UIView *mengbanview;
@property (weak, nonatomic) IBOutlet UIView *kaihuview;
@property (weak, nonatomic) IBOutlet UILabel *kaihulab;

@property (weak, nonatomic) IBOutlet UIButton *kaihubtn;
@property(nonatomic,copy)NSString *passwordbool;

@property (weak, nonatomic) IBOutlet UIButton *chujiebtn;
@property (weak, nonatomic) IBOutlet UILabel *shengyuhiden;

@property(nonatomic,copy)NSString *jsqlv;



@property (weak, nonatomic) IBOutlet UIView *smallview;
@property (weak, nonatomic) IBOutlet UIButton *smallchujiebtn;
@property (weak, nonatomic) IBOutlet UILabel *smallmoney;
@property (weak, nonatomic) IBOutlet UILabel *smalljindulab;

@property (weak, nonatomic) IBOutlet UILabel *smallsecondlab;
@property (weak, nonatomic) IBOutlet UILabel *smalllilvlab;
@property (weak, nonatomic) IBOutlet UILabel *smallqixianlab;
@property (weak, nonatomic) IBOutlet UILabel *smallzongelab;
@property (weak, nonatomic) IBOutlet UILabel *smallfirstlab;

@end

@implementation RHXMJProjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self getxieyi];
    if ([self.listres isEqualToString:@"0"]) {
         [self updata:self.datadic];
    }else{
    
    [self updata:self.datadic[@"cell"]];
    }
    [self configBackButton];
    [self getmyjxpassword];
    
    self.kaihuview.hidden = YES;
    self.mengbanview.hidden = YES;
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    
    
    if (RHScreeWidth >321) {
        self.smallview.hidden = YES;
    }
    
}

- (NSString *)positiveFormat:(NSString *)text{
    
    if(!text || [text floatValue] == 0){
        
        self.chujiebtn.userInteractionEnabled = NO;
        self.chujiebtn.backgroundColor = [RHUtility colorForHex:@"#bdbdbe"];
        [self.chujiebtn setTitle:self.zhuangtaistr forState:UIControlStateNormal] ;
        self.smallchujiebtn.backgroundColor = [RHUtility colorForHex:@"#bdbdbe"];
        [self.smallchujiebtn setTitle:self.zhuangtaistr forState:UIControlStateNormal] ;
//        self.toubiaobtn.userInteractionEnabled = NO;
//        self.toubiaobtn.backgroundColor = [RHUtility colorForHex:@"#bdbdbe"];
        
        return @"0.00";
    }else{
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setPositiveFormat:@"###,##0.00;"];
        
        NSString * str =[numberFormatter stringFromNumber:[NSNumber numberWithDouble:[text doubleValue]]];
        return str;
        
//        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
//        [numberFormatter setPositiveFormat:@"###,##0.00;"];
//        NSString * money = responseObject[@"sumCash"];
//        NSString *formattedNumberString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble: [money doubleValue] ]];
//
//        self.monlab.text = formattedNumberString;
        
    }
    return @"";
}
-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
     self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
     [DQViewController Sharedbxtabar].tabBar.hidden = YES;
    
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
-(void)updata:(NSDictionary *)dic{
    
    CGFloat percent=0;
    if (dic[@"percent"]&&![[dic objectForKey:@"percent"] isKindOfClass:[NSNull class]]) {
        percent=[[dic objectForKey:@"percent"] floatValue]/100.0;
       
        self.jundulab.frame = CGRectMake(self.jundulab.frame.origin.x, self.jundulab.frame.origin.y, self.firstjundulab.frame.size.width*percent, 2);
        self.jindunumberlab.text =[NSString stringWithFormat:@"%@%%",dic[@"percent"]];
        self.smallsecondlab.frame = CGRectMake(self.smallsecondlab.frame.origin.x, self.smallsecondlab.frame.origin.y, self.smallfirstlab.frame.size.width*percent, 2);
        self.smalljindulab.text =[NSString stringWithFormat:@"%@%%",dic[@"percent"]];
    }
    if (dic[@"remainMoney"]&&![[dic objectForKey:@"remainMoney"] isKindOfClass:[NSNull class]]) {
        
        self.moneylab.text = [NSString stringWithFormat:@"%@",dic[@"remainMoney"]];
        
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setPositiveFormat:@"###,##0.00;"];
        NSString * money = dic[@"remainMoney"];
        NSString *formattedNumberString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble: [money doubleValue] ]];
        
//        self.monlab.text = formattedNumberString;
//        NSString * str =
        
        
        self.moneylab.text = [self positiveFormat:self.moneylab.text];;
        self.smallmoney.text = [self positiveFormat:self.moneylab.text];;
    }
    
    
    if (dic[@"period"]&&![[dic objectForKey:@"period"] isKindOfClass:[NSNull class]]) {
        
        self.qixianlab.text = [NSString stringWithFormat:@"%@个月",dic[@"period"]];
         self.smallqixianlab.text = [NSString stringWithFormat:@"%@个月",dic[@"period"]];
    }
    if (dic[@"name"]&&![[dic objectForKey:@"name"] isKindOfClass:[NSNull class]]) {
        
        [self configTitleWithString:dic[@"name"]];
    }
    if (dic[@"id"]&&![[dic objectForKey:@"id"] isKindOfClass:[NSNull class]]) {
        
        self.projectId = [NSString stringWithFormat:@"%@",dic[@"id"]];
        
       
    }
    if (dic[@"totalMoney"]&&![[dic objectForKey:@"totalMoney"] isKindOfClass:[NSNull class]]) {

        NSString * fund = [NSString stringWithFormat:@"%@",dic[@"totalMoney"]];
        
        CGFloat fundfloat = [fund floatValue];
        self.zongelab.text = [NSString stringWithFormat:@"%.2f万",fundfloat/10000.00 ];
        self.smallzongelab.text = [NSString stringWithFormat:@"%.2f万",fundfloat/10000.00 ];
    }
    if (dic[@"totalMoney"]&&![[dic objectForKey:@"totalMoney"] isKindOfClass:[NSNull class]]) {
        
        NSString * fund = [NSString stringWithFormat:@"%@",dic[@"totalMoney"]];
        
        CGFloat fundfloat = [fund floatValue];
        self.zongelab.text = [NSString stringWithFormat:@"%.2f万",fundfloat/10000.00 ];
         self.smallzongelab.text = [NSString stringWithFormat:@"%.2f万",fundfloat/10000.00 ];
    }
    
    if ([self.chujiebtn.titleLabel.text isEqualToString:@"稍后出借"]) {
        self.moneylab.text = @"新额度发布中";
        self.moneylab.font = [UIFont systemFontOfSize:18];
        self.shengyuhiden.hidden = YES;
    }
    
    self.lilvlab.text = [NSString stringWithFormat:@"%@%%",dic[@"rate"]];
    self.smalllilvlab.text = [NSString stringWithFormat:@"%@%%",dic[@"rate"]];
    
     self.jsqlv = [NSString stringWithFormat:@"%@%%",dic[@"rate"]];
}
-(void)myupdata:(NSDictionary *)dic{
    
    CGFloat percent=0;
    if (dic[@"percent"]&&![[dic objectForKey:@"percent"] isKindOfClass:[NSNull class]]) {
        percent=[[dic objectForKey:@"percent"] floatValue]/100.0;
        
        self.jundulab.frame = CGRectMake(self.jundulab.frame.origin.x, self.jundulab.frame.origin.y, self.firstjundulab.frame.size.width*percent, 2);
        self.jindunumberlab.text =[NSString stringWithFormat:@"%@%%",dic[@"percent"]];
    }
    if (dic[@"remainMoney"]&&![[dic objectForKey:@"remainMoney"] isKindOfClass:[NSNull class]]) {
        
        self.moneylab.text = [NSString stringWithFormat:@"%@",dic[@"remainMoney"]];
    }
    if (dic[@"period"]&&![[dic objectForKey:@"period"] isKindOfClass:[NSNull class]]) {
        
        self.qixianlab.text = [NSString stringWithFormat:@"%@个月",dic[@"period"]];
    }
    if (dic[@"name"]&&![[dic objectForKey:@"name"] isKindOfClass:[NSNull class]]) {
        
        [self configTitleWithString:dic[@"name"]];
    }
    if (dic[@"id"]&&![[dic objectForKey:@"id"] isKindOfClass:[NSNull class]]) {
        
        self.projectId = [NSString stringWithFormat:@"%@",dic[@"id"]];
    }
    if (dic[@"totalMoney"]&&![[dic objectForKey:@"totalMoney"] isKindOfClass:[NSNull class]]) {
        
        NSString * fund = [NSString stringWithFormat:@"%@",dic[@"totalMoney"]];
        
        CGFloat fundfloat = [fund floatValue];
        self.zongelab.text = [NSString stringWithFormat:@"%.2f万",fundfloat/10000.00 ];
    }
    if (dic[@"totalMoney"]&&![[dic objectForKey:@"totalMoney"] isKindOfClass:[NSNull class]]) {
        
        NSString * fund = [NSString stringWithFormat:@"%@",dic[@"totalMoney"]];
        
        CGFloat fundfloat = [fund floatValue];
        self.zongelab.text = [NSString stringWithFormat:@"%.2f万",fundfloat/10000.00 ];
    }
    
    
    self.lilvlab.text = [NSString stringWithFormat:@"%@%%",dic[@"rate"]];
   
}
- (IBAction)chuanpinshuoming:(id)sender {
    RHOfficeNetAndWeiBoViewController *office = [[RHOfficeNetAndWeiBoViewController alloc] initWithNibName:@"RHOfficeNetAndWeiBoViewController" bundle:nil];
    office.NavigationTitle = @"项目集合产品说明";
    office.urlString = [NSString stringWithFormat:@"%@%@",[RHNetworkService instance].newdoMain,self.cpurl];
    
    [self.navigationController pushViewController:office animated:YES];
}
- (IBAction)xiangmujixiangqing:(id)sender {
    RHXMJXQViewController * vc = [[RHXMJXQViewController alloc]initWithNibName:@"RHXMJXQViewController" bundle:nil];
    
    self.hidesBottomBarWhenPushed = YES;
    
    vc.projectid = self.projectId;
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

- (IBAction)lijikaitong:(id)sender {
    
    if ([self.kaihubtn.titleLabel.text isEqualToString:@"设置交易密码"]) {
        
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
- (IBAction)quxiao:(id)sender {
    self.kaihuview.hidden = YES;
    self.mengbanview.hidden = YES;
    
}

-(void)getxieyi{
    
    [[RHNetworkService instance] POST:@"common/main/getProticelName" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        DLog(@"%@",responseObject);
        // [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        if ([responseObject isKindOfClass:[NSArray class]]) {
            
            NSArray * array = responseObject;
             int testxieyi = 0;
            for (int i = 0; i<array.count; i++) {
                UIButton * btn = [[UIButton alloc]init];
                [btn setTitle:[NSString stringWithFormat:@"《%@》",array[i]] forState:UIControlStateNormal];
                //                    btn.backgroundColor=[UIColor redColor];
                btn.titleLabel.font = [UIFont systemFontOfSize:13];
               
                btn.titleLabel.lineBreakMode = 0 ;
               
                //                        btn.frame = CGRectMake(26,i+30, 200, 20);
                
                
                if (RHScreeWidth<321) {
                    if (i%2==0) {
                        btn.frame = CGRectMake(CGRectGetMinX(self.xieyiframe.frame),CGRectGetMaxY(self.xieyiframe.frame)+5+testxieyi-100, (RHScreeWidth-75)/2, 20);
                        
                    }else{
                        
                        btn.frame = CGRectMake(CGRectGetMinX(self.xieyiframe.frame)+(RHScreeWidth-75)/2,CGRectGetMaxY(self.xieyiframe.frame)+5+testxieyi-100, (RHScreeWidth-75)/2, 20);
                        testxieyi = testxieyi+20;
                    }
                }else{
                if (i%2==0) {
                   btn.frame = CGRectMake(CGRectGetMinX(self.xieyiframe.frame),CGRectGetMaxY(self.xieyiframe.frame)+5+testxieyi, (RHScreeWidth-75)/2, 20);
                   
                }else{
                    
                    btn.frame = CGRectMake(CGRectGetMinX(self.xieyiframe.frame)+(RHScreeWidth-75)/2,CGRectGetMaxY(self.xieyiframe.frame)+5+testxieyi, (RHScreeWidth-75)/2, 20);
                    testxieyi = testxieyi+20;
                }
                }
                //                        if (str.length>10) {
                //                            btn.frame = CGRectMake(8,i+30, 360, 20);
                //                        }else{
                //                            btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                //                        }
//                [btn addTarget:self action:@selector(didxieyi:) forControlEvents:UIControlEventTouchUpInside];
                [btn setTitleColor:[RHUtility colorForHex:@"44bbc1"] forState:UIControlStateNormal];
                btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                [btn addTarget:self action:@selector(didxieyi:) forControlEvents:UIControlEventTouchUpInside];
                [self.view addSubview:btn];
            }
            
           
            // [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [RHUtility showTextWithText:@"请求失败"];
    }];
    
    [[RHNetworkService instance] POST:@"common/projectList/getProjectMsgUrl" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        DLog(@"%@",responseObject);
        // [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
          
            self.cpurl= responseObject[@"url"];
            
            // [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [RHUtility showTextWithText:@"请求失败"];
    }];
    
}

-(void)didxieyi:(UIButton *)btn{
    if ([btn.titleLabel.text isEqualToString:@"《借款协议范本》"]  ) {
        
        if (![RHUserManager sharedInterface].username) {
            RHALoginViewController* controller=[[RHALoginViewController alloc] initWithNibName:@"RHALoginViewController" bundle:nil];
            [self.navigationController pushViewController:controller animated:YES];
            return;
        }
    }
    
    RHXYWebviewViewController * controller = [[RHXYWebviewViewController alloc]initWithNibName:@"RHXYWebviewViewController" bundle:nil];
    
    NSString * str = btn.titleLabel.text;
    
    NSString *stringWithoutQuotation = [str
                                        stringByReplacingOccurrencesOfString:@"《" withString:@""];
    str =  [stringWithoutQuotation stringByReplacingOccurrencesOfString:@"》" withString:@""];
    controller.namestr = str;
    controller.projectid = self.firstid;
    
    [self.navigationController pushViewController:controller animated:YES];
    NSLog(@"%@",btn.titleLabel.text);
}

- (IBAction)chujie:(id)sender {
    
    if (![RHUserManager sharedInterface].username) {
        //        [self.investmentButton setTitle:@"请先登录" forState:UIControlStateNormal];
        
        NSLog(@"ddddddd");
        RHALoginViewController* controller=[[RHALoginViewController alloc] initWithNibName:@"RHALoginViewController" bundle:nil];
        [self.navigationController pushViewController:controller animated:YES];
        return;
    }
    
    
    if(![RHUserManager sharedInterface].custId) {
        
        self.kaihuview.hidden = NO;
        self.mengbanview.hidden = NO;
      
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
        self.kaihuview.hidden = NO;
        self.mengbanview.hidden = NO;
        
        [[UIApplication sharedApplication].keyWindow addSubview:self.mengbanview ];
        [[UIApplication sharedApplication].keyWindow addSubview:self.kaihuview];
        [self.kaihubtn setTitle:@"设置交易密码" forState:UIControlStateNormal];
        // self.passwordlab.text = @"资金更安全，请先设置交易密码在进行投资／提现";
        self.mengbanview.hidden = NO;
        self.kaihuview.hidden = NO;
        
        
        [[UIApplication sharedApplication].keyWindow addSubview:self.mengbanview ];
        [[UIApplication sharedApplication].keyWindow addSubview:self.kaihuview];
        if ([UIScreen mainScreen].bounds.size.width>376) {
            self.kaihuview.frame = CGRectMake(40, CGRectGetMinY(self.kaihuview.frame), [UIScreen mainScreen].bounds.size.width-80, 310);
        }else{
            self.kaihuview.frame = CGRectMake(40, CGRectGetMinY(self.kaihuview.frame), [UIScreen mainScreen].bounds.size.width-80, 245);
        }
        self.kaihulab.text = @"资金更安全，请先设置交易密码再进行出借／提现";
        return;
    }
    
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
    
    RHInvestmentViewController * vc = [[RHInvestmentViewController alloc]initWithNibName:@"RHInvestmentViewController" bundle:nil];
    
    vc.xmjres = @"xmj";
    NSString * str ;
    
    if ([self.listres isEqualToString:@"0"]) {
       vc.dataDic=self.datadic;
        str = self.datadic[@"remainMoney"];
    }else{
        
       vc.dataDic=self.datadic[@"cell"];
        str = self.datadic[@"cell"][@"remainMoney"];
    }
    int a = [str intValue];
    vc.projectFund= a;
    vc.xmjfirst = self.firstid;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 8901) {
        
        
        if (buttonIndex==0) {
            [DQViewController Sharedbxtabar].tarbar.hidden = YES;
            RHDBSJViewController * vc = [[RHDBSJViewController alloc]initWithNibName:@"RHDBSJViewController" bundle:nil];
            //        vc.str = @"cbx";
            [self.navigationController pushViewController:vc animated:NO];
        }
        return;
    }
}

- (IBAction)syjsq:(id)sender {
    
    RHJsqViewController * vc = [[RHJsqViewController alloc]initWithNibName:@"RHJsqViewController" bundle:nil];
    vc.nianStr = self.jsqlv;
    vc.projectid = self.firstid;
    vc.mouthStr = self.qixianlab.text;
    vc.monery = self.zongelab.text;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)getimagemy{
    NSDictionary* parameters=@{@"projectListId":self.projectId};
    
    [[RHNetworkService instance] POST:@"app/common/appProjectList/getProjectListInfoForApp" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        DLog(@"%@",responseObject);
        
        CGFloat percent=0;
        if (responseObject[@"percent"]&&![[responseObject objectForKey:@"percent"] isKindOfClass:[NSNull class]]) {
            percent=[[responseObject objectForKey:@"percent"] floatValue]/100.0;
            
            self.jundulab.frame = CGRectMake(self.jundulab.frame.origin.x, self.jundulab.frame.origin.y, self.firstjundulab.frame.size.width*percent, 2);
            self.jindunumberlab.text =[NSString stringWithFormat:@"%@%%",responseObject[@"percent"]];
        }
       
        if (responseObject[@"remainMoney"]&&![[responseObject objectForKey:@"remainMoney"] isKindOfClass:[NSNull class]]) {
            if ([responseObject[@"projectListStatus"] isEqualToString:@"publishedWaiting"]) {
                self.moneylab.text =@"新额度发布中";
            }else{
                self.moneylab.text = [self positiveFormat:[NSString stringWithFormat:@"%@",responseObject[@"remainMoney"]]];
            }
            
            
        }
        if (responseObject[@"firstProjectId"]&&![[responseObject objectForKey:@"firstProjectId"] isKindOfClass:[NSNull class]]) {
            
            self.firstid = [NSString stringWithFormat:@"%@",responseObject[@"firstProjectId"]];
        }
        NSLog(@"%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //[RHUtility showTextWithText:@"请求失败"];
    }];
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getimagemy];
    
    
}

@end
