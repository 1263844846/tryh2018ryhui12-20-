//
//  RHDBSJViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 2018/5/17.
//  Copyright © 2018年 stefan. All rights reserved.
//

#import "RHDBSJViewController.h"
#import "RHSTZFTableViewCell.h"
#import "RHWSQViewController.h"
#import "RHJXPassWordViewController.h"
#import "RHJXHKSQViewController.h"
#import "RHSTZFWebViewController.h"
#import "RHMainViewController.h"
#import "RHhelper.h"
#import "MBProgressHUD.h"

@interface RHDBSJViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *passwordbtn;
@property (weak, nonatomic) IBOutlet UIButton *jiaofeibtn;
@property (weak, nonatomic) IBOutlet UIButton *huankuanbtn;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property(nonatomic,strong)NSArray * array;
@property(nonatomic,copy)NSString * passwordbool;

@property (weak, nonatomic) IBOutlet UIView *secondview;
@property (weak, nonatomic) IBOutlet UIView *threeview;

@end

@implementation RHDBSJViewController
-(void)sqmyswitch{
    
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[RHNetworkService instance] POST:@"front/payment/reformAccountJx/authSwitch" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        DLog(@"%@",responseObject)
         [MBProgressHUD hideAllHUDsForView:self.view animated:YES];;
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            if(responseObject[@"checkSwitch"]&& ![responseObject[@"checkSwitch"] isKindOfClass:[NSNull class]]){
                if (![responseObject[@"checkSwitch"] isEqualToString:@"ON"]) {
                    self.secondview.hidden = YES;
                    
                    self.threeview.frame =CGRectMake(0, 140, self.threeview.frame.size.width, self.threeview.frame.size.height);
                     [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                }
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //  NSLog(@"%@",error);
        DLog(@"%@",[[NSString alloc] initWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
         [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
    
}
-(void)goback{
    
    UIButton* button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(mygoback) forControlEvents:UIControlEventTouchUpInside];
    //    UIImage * image = [UIImage imageNamed:@"back.png"];
    
    [button setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    button.frame=CGRectMake(0, 0, 30, 50);
    
    // button.backgroundColor = [UIColor colorWithHexString:@"44bbc1"];
    self.navigationItem.leftBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:button];
}
-(void)mygoback{
    
    
}

-(NSArray *)array{
    if (!_array) {
        _array = [NSArray array];
    }
    return _array;
    
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
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self configTitleWithString:@"待办事项"];
  
    [self sqmyswitch];
   
    [self goback];
    self.passwordbtn.layer.masksToBounds = YES;
    self.passwordbtn.layer.cornerRadius = 5;
    self.huankuanbtn.layer.masksToBounds = YES;
    self.huankuanbtn.layer.cornerRadius = 5;
    self.jiaofeibtn.layer.masksToBounds = YES;
    self.jiaofeibtn.layer.cornerRadius = 5;
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
}

-(void)getstzfdata{
    
    NSDictionary* parameters=@{@"_search":@"flase",@"rows":@"1000",@"page":@"1",@"sidx":@"isTrustee,trusteePayDate",@"sord":@"asc,desc",@"pager":@"project_grid_pager"};
    [[RHNetworkService instance] POST:@"front/payment/account/trusteePayJxProjectList" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
         if ([responseObject isKindOfClass:[NSDictionary class]]) {
             self.array = responseObject[@"rows"];
             
             if (self.array.count<1) {
                 self.threeview.hidden = YES;
             }
             [self.tableview reloadData];
             
         }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"%@",[[NSString alloc] initWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
    }];
    
}
-(void)gethuankuanshouquan{
    [[RHNetworkService instance] POST:@"app/front/payment/appReformAccountJx/userRepayAuthState" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
           
            if ([responseObject[@"repayState"] isEqualToString:@"yes"]) {
              
              
                [self.jiaofeibtn setTitle:@"已授权" forState:UIControlStateNormal];
                
                self.jiaofeibtn.backgroundColor = [RHUtility colorForHex:@"7C7C7C"];
                
              
            }else{
               
                [self.jiaofeibtn setTitle:@"去授权" forState:UIControlStateNormal];
                [self.jiaofeibtn addTarget:self action:@selector(huankuansq) forControlEvents:UIControlEventTouchUpInside];
                
                
            }
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"%@",[[NSString alloc] initWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
    }];
    [[RHNetworkService instance] POST:@"app/front/payment/appJxAccount/isSetPassword" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"----===============-1111---%@",responseObject);
//        self.passwordbool = [NSString stringWithFormat:@"%@",responseObject[@"setPwd"]];
        if (![responseObject[@"setPwd"] isEqualToString:@"yes"]) {
             [self.passwordbtn setTitle:@"去设置" forState:UIControlStateNormal];
            [self.passwordbtn addTarget:self action:@selector(passwordsq) forControlEvents:UIControlEventTouchUpInside];
            
        }else{
             [self.passwordbtn setTitle:@"已设置" forState:UIControlStateNormal];
            self.passwordbtn.backgroundColor = [RHUtility colorForHex:@"7C7C7C"];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
        DLog(@"%@",[[NSString alloc] initWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
        
    }];
    [[RHNetworkService instance] POST:@"app/front/payment/appReformAccountJx/appUserPaymentAuthState" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
//
            if ([responseObject[@"paymentState"] isEqualToString:@"yes"]) {
//
                [self.huankuanbtn setTitle:@"已授权" forState:UIControlStateNormal];
                self.huankuanbtn.backgroundColor = [RHUtility colorForHex:@"7C7C7C"];
                
               

            }else{

                
                [self.huankuanbtn setTitle:@"去授权" forState:UIControlStateNormal];
                [self.huankuanbtn addTarget:self action:@selector(jiaofeisq) forControlEvents:UIControlEventTouchUpInside];
            }

        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //  NSLog(@"%@",error);
        DLog(@"%@",[[NSString alloc] initWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
        
    }];
    
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 162;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.array.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"stzfCellIdentifier";
    
    RHSTZFTableViewCell *cell = (RHSTZFTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"RHSTZFTableViewCell" owner:nil options:nil] objectAtIndex:0];
    }
       [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    NSDictionary * dic = self.array[indexPath.row][@"cell"];
    if (dic[@"name"]&&![dic[@"name"] isKindOfClass:[NSNull class]]) {
        cell.namelab.text = dic[@"name"];
    }
    if (dic[@"projectFund"]&&![dic[@"projectFund"] isKindOfClass:[NSNull class]]) {
        cell.moneylab.text = [NSString stringWithFormat:@"%@",dic[@"projectFund"]];
    }
    if (dic[@"limitTime"]&&![dic[@"limitTime"] isKindOfClass:[NSNull class]]) {
        cell.qixianlab.text = dic[@"limitTime"];
        
    }
    if (dic[@"isTrustee"]&&![dic[@"isTrustee"] isKindOfClass:[NSNull class]]) {

        NSString * str = [NSString stringWithFormat:@"%@",dic[@"isTrustee"]];
        if ([str isEqualToString:@"1"]) {
            if (dic[@"trusteePayDate"]&&![dic[@"trusteePayDate"] isKindOfClass:[NSNull class]]) {
                cell.sqtimelab.text = [NSString stringWithFormat:@"%@",dic[@"trusteePayDate"]];
            }
            cell.sqbtn.backgroundColor = [RHUtility colorForHex:@"7C7C7C"];
            [cell.sqbtn setTitle:@"已授权" forState:UIControlStateNormal];
        }else{

            cell.myblock=^{
                
                NSString * stri = [NSString stringWithFormat:@"%@",dic[@"id"]];
                [self sqzfsq:stri];
            };
//            [cell.sqbtn addTarget:self action:@selector(sqzfsq) forControlEvents:UIControlEventTouchUpInside];
        }
        
        
    }else{
        
        cell.myblock=^{
            
            NSString * stri = [NSString stringWithFormat:@"%@",dic[@"id"]];
            [self sqzfsq:stri];
        };
    }
    
    
    
   
    return cell;
    
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}
-(void)passwordsq{
    
    RHJXPassWordViewController * controller =[[RHJXPassWordViewController alloc]initWithNibName:@"RHJXPassWordViewController" bundle:nil];
    
    controller.urlstr = @"app/front/payment/appJxAccount/passwordSetJxData";
//    [DQViewController Sharedbxtabar].tarbar.hidden = YES;
//    self.mengbanview.hidden = YES;
//    self.kaihuview.hidden = YES;
    [self.navigationController pushViewController:controller animated:YES];
}
-(void)jiaofeisq{
    if (![self.passwordbool isEqualToString:@"yes"]) {
        
        [RHUtility showTextWithText:@"请先设置交易密码"];
        return ;
    }
    RHWSQViewController * vc = [[RHWSQViewController alloc]initWithNibName:@"RHWSQViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)huankuansq{
    
    if (![self.passwordbool isEqualToString:@"yes"]) {
        
        [RHUtility showTextWithText:@"请先设置交易密码"];
        return ;
    }
    
    RHJXHKSQViewController * vc = [[RHJXHKSQViewController alloc]initWithNibName:@"RHJXHKSQViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)sqzfsq:(NSString*)projectid{
    
    if (![self.passwordbool isEqualToString:@"yes"]) {
        
        [RHUtility showTextWithText:@"请先设置交易密码"];
        return ;
    }
    RHSTZFWebViewController * vc = [[RHSTZFWebViewController alloc]initWithNibName:@"RHSTZFWebViewController" bundle:nil];
    vc.projectid = projectid;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getmyjxpassword];
     [self gethuankuanshouquan];
    [self daibanshixiang];
      [self getstzfdata];
}

-(void)daibanshixiang{
    
    [[RHNetworkService instance] POST:@"front/payment/account/trusteePayAlter" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
         if ([responseObject isKindOfClass:[NSDictionary class]]) {
             NSString * str = [NSString stringWithFormat:@"%@",responseObject[@"flag"]];
             
             if ([str isEqualToString:@"1"]) {
                
             }else{
                 
                 [RHhelper ShraeHelp].dbsxstr= @"0";
                 UIAlertView* alertView=[[UIAlertView alloc]initWithTitle:@"通知"
                                                                  message:@"待办事项已完成即将跳转"
                                                                 delegate:self
                                                        cancelButtonTitle:@"确定"
                                                        otherButtonTitles:nil, nil];
                 alertView.tag=8999;
                 [alertView show];
                 
                 
                 
             }
             
         }
        
        NSLog(@"%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
    }];
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        RHMainViewController *controller = [[RHMainViewController alloc]initWithNibName:@"RHMainViewController" bundle:nil];
        [RHhelper ShraeHelp].dbsxstr = @"0";
        //    [nav pushViewController:controller animated:YES];
        [[DQViewController Sharedbxtabar]tabBar:(DQview *)controller.view didSelectedIndex:0];
        UIButton *btn = [[UIButton alloc]init];
        btn.tag = 0;
        [[DQview Shareview] btnClick:btn];
        
        [self.navigationController popViewControllerAnimated:NO];
       
    }
}


@end
