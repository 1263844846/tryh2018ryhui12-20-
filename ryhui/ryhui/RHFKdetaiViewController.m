//
//  RHFKdetaiViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 16/4/11.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import "RHFKdetaiViewController.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "AITableFooterVew.h"
#import "RHDetailJLTableViewCell.h"
#import "RHALoginViewController.h"
#import "RHJsqViewController.h"
#import "RHInvestmentViewController.h"
#import "MBProgressHUD.h"
#import "RHDetailseconddetailViewController.h"
@interface RHFKdetaiViewController ()<UITableViewDataSource,UITableViewDelegate>{
    int available;
    CGRect tempRect;
    int page;
    AITableFooterVew *footerView;
    BOOL isSegment2Click;
    RHDetailJLTableViewCell* cell;
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property(nonatomic,strong)NSMutableArray * array;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property (weak, nonatomic) IBOutlet UILabel *cooperatesInfo;

@property (weak, nonatomic) IBOutlet UIView *dengluview;

@property (weak, nonatomic) IBOutlet UIView *loginview;
@property (weak, nonatomic) IBOutlet UIView *touziview;
@property (weak, nonatomic) IBOutlet UIView *studentview;
@property (weak, nonatomic) IBOutlet UILabel *xfdhzf;
@property(nonatomic,assign)int ress;
@property (weak, nonatomic) IBOutlet UILabel *ziliaolab;
@property (weak, nonatomic) IBOutlet UILabel *hidenlab;
@end

@implementation RHFKdetaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.xiaofeires) {
        self.xfdhzf.text = @"风控方式";
    }
    if ([self.oldnew isEqualToString:@"old"]) {
        self.xfdhzf.text = @"合作方简介";
    }
    self.ress = 1;
    self.studentview.hidden = YES;
    // Do any additional setup after loading the view from its nib.
    self.array = [NSMutableArray array];
    self.dataArray = [NSMutableArray array];
    
//    if (self.tableView.hidden == NO) {
//        NSLog(@"cbxcbxbcbxbcbxbcbbxbxbcbxbcbbc");
//    }
    self.loginview.hidden = YES;
    if ([self.type isEqualToString:@"0"]) {
        self.tableView.hidden = YES;
        self.touziview.hidden = YES;
        [self getdata];

    }else{
        
        NSString *pass =  [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@Gesture",[RHUserManager sharedInterface].username]];;
        
        if (pass.length <1) {
            self.loginview.hidden = NO;
            //        self.controller3.tableView.hidden = YES;
           // [self loginryh];
//            return;
        }
        footerView = [[AITableFooterVew alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width,50.0)];
        [footerView.footerButton addTarget:self action:@selector(showMoreInfomationForApp:) forControlEvents:UIControlEventTouchUpInside];
        [footerView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        self.tableView.tableFooterView = footerView;
        footerView.hidden = YES;
        self.tableView.delegate = self;
        self.tableView.dataSource =self;
       // page = 3;
        [self projectInvestmentList];
    }
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushmybenxi)];
    self.cooperatesInfo.userInteractionEnabled = YES;
    [self.cooperatesInfo addGestureRecognizer:tap];
    
    
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    page ++;
    [self projectInvestmentList];
    footerView.hidden = NO;
    [footerView.activityIndicatorView startAnimating];
}
- (void)showMoreInfomationForApp:(UIButton *)btn {
    page ++;
    [self projectInvestmentList];
    footerView.hidden = NO;
    [footerView.activityIndicatorView startAnimating];
}
-(void)projectInvestmentList
{
    //[self.dataArray removeAllObjects];
    
    //    for (NSDictionary * diccc in self.dataArray) {
    //        for (NSDictionary * dicc in <#collection#>) {
    //            <#statements#>
    //        }
    //    }
    
//    [UIColor]
    
    if (self.ress==2) {
        [self.dataArray removeAllObjects];
       
    }
    
    NSDictionary* parameters=@{@"projectId":self.projectid,@"_search":@"true",@"rows":@"10",@"page":[NSString stringWithFormat:@"%d",page],@"sidx":@"investTime",@"sord":@"desc",@"filters":@"{\"groupOp\":\"AND\",\"rules\":[]}"};
    [[RHNetworkService instance] POST:@"app/common/appDetails/appProjectInvestmentList" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"---responseObjectresponseObject----------%@",[responseObject objectForKey:@"rows"]);
        
        //        DLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSArray* array=[responseObject objectForKey:@"rows"];
             self.ress++;
            if ([array isKindOfClass:[NSArray class]]) {
                
                if (array.count == 0) {
                    [footerView.activityIndicatorView stopAnimating];
                    [footerView.activityIndicatorView removeFromSuperview];
                    footerView.hidden = NO;
                    footerView.footerButton.enabled = NO;
                } else {
                    
                    
                    for (NSDictionary* dic in array) {
                        if ([dic objectForKey:@"cell"]&&!([[dic objectForKey:@"cell"] isKindOfClass:[NSNull class]])) {
                            [self.dataArray addObject:[dic objectForKey:@"cell"]];
                        }
                    }
                }
            }
            [self.tableView reloadData];
            
            NSString* records=[responseObject objectForKey:@"records"];
            if (records&&[records intValue]<10) {
                //已经到底了
                [footerView.activityIndicatorView stopAnimating];
                [footerView.activityIndicatorView removeFromSuperview];
                footerView.hidden = NO;
                footerView.footerButton.enabled = NO;
            }
            
            if (self.dataArray.count < 10) {
                [footerView removeFromSuperview];
            }
            if (isSegment2Click) {
                isSegment2Click = NO;
                if (self.dataArray.count > 0) {
                    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
                }
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //        DLog(@"%@",error);
        [RHUtility showTextWithText:@"请求失败"];
    }];
    //     NSSet * sett = [NSSet setWithArray:self.dataArray];
    //    [self.dataArray removeAllObjects];
    //    NSArray * aaa = [sett allObjects];
    //    self.dataArray = [NSMutableArray arrayWithArray:aaa];
//    [self.tableView reloadData];
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}
-(void)getdata{
    
    NSDictionary* parameters=@{@"id":self.projectid};
    
    [[RHNetworkService instance] POST:@"app/common/appDetails/appProjectDetailData" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        DLog(@"%@",responseObject);
         [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            if (self.studentres) {
                if ([responseObject isKindOfClass:[NSDictionary class]]) {
                    
                    if (responseObject[@"project"]&&responseObject[@"project"][@"partnerInfo"]) {
                        
                        self.studentview.hidden = NO;
                        self.cooperatesInfo.text = [NSString stringWithFormat:@"%@",responseObject[@"project"][@"partnerInfo"]];
                        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                        return ;
                        
                    }
                    
                    
                }
            }
            
                        NSArray* insuranceImages=[responseObject objectForKey:@"insuranceImages"];
                        NSLog(@"=-=-=-=-=-=-=%@=--=-=-=-=-=",insuranceImages);
                        if (insuranceImages.count > 0) {
            
                            for (NSDictionary* insuranceDic in insuranceImages) {
                                int index=[[NSNumber numberWithInteger:[insuranceImages indexOfObject:insuranceDic]] intValue];
            
                                UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(index*(45+10),4, 45, 45)];
                                imageView.userInteractionEnabled=YES;
                                [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@common/main/attachment/%@",[RHNetworkService instance].newdoMain,[insuranceDic objectForKey:@"filepath"]]]];
            
                                UIButton* button=[UIButton buttonWithType:UIButtonTypeCustom];
                                button.frame=imageView.bounds;
                                button.tag = index;
                                [button addTarget:self action:@selector(touch1:) forControlEvents:UIControlEventTouchUpInside];
                                [imageView addSubview:button];
                                [self.array addObject:[NSString stringWithFormat:@"%@common/main/attachment/%@",[RHNetworkService instance].newdoMain,[insuranceDic objectForKey:@"filepath"]]];
                                [self.scrollView addSubview:imageView];
                            }
            
                        }
            if (!responseObject[@"project"][@"riskSuggestion"]|| ![responseObject[@"project"][@"riskSuggestion"] isKindOfClass:[NSNull class]]) {
                
                self.cooperatesInfo.text = responseObject[@"project"][@"riskSuggestion"];
            }
             if ([self.oldnew isEqualToString:@"old"]) {
                 if (!responseObject[@"cooperatesInfo"]|| ![responseObject[@"cooperatesInfo"] isKindOfClass:[NSNull class]]) {
                self.cooperatesInfo.text = responseObject[@"cooperatesInfo"];
                }
           }
                        self.scrollView.contentSize=CGSizeMake([insuranceImages count]*55,53);
            //
            //            NSDictionary* projectDic=[responseObject objectForKey:@"project"];
            //            NSString *detailString = [NSString stringWithFormat:@"%@",[projectDic objectForKey:@"projectInfo"]];
            //
            //            CGRect rect1=self.projectDetail.frame;
            //
            //            NSLog(@"---------------%@",detailString);
            //
            //            if (detailString && detailString.length > 0 && ![detailString isKindOfClass:[NSNull class]] && detailString != nil && ![detailString isEqualToString:@"<null>"]) {
            //                self.projectDetail.text = detailString;
            //                rect1.size.height=[detailString sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(self.projectDetail.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping].height+5;
            //            }
            //            self.projectDetail.frame=rect1;
            //
            //            self.projectImageLabel.frame=CGRectMake(self.projectImageLabel.frame.origin.x, self.projectDetail.frame.origin.y+self.projectDetail.frame.size.height+5, self.projectImageLabel.frame.size.width, self.projectImageLabel.frame.size.height);
            //            self.projectScrollView.frame=CGRectMake(self.projectScrollView.frame.origin.x, self.projectImageLabel.frame.origin.y+self.projectImageLabel.frame.size.height+5, self.projectScrollView.frame.size.width, self.projectScrollView.frame.size.height);
            //
            //            self.projectImageLabel1.frame=CGRectMake(self.projectImageLabel1.frame.origin.x, self.projectScrollView.frame.origin.y+self.projectScrollView.frame.size.height+5, self.projectImageLabel1.frame.size.width, self.projectImageLabel1.frame.size.height);
            //            self.insuranceScrollView.frame=CGRectMake(self.insuranceScrollView.frame.origin.x, self.projectImageLabel1.frame.origin.y+self.projectImageLabel1.frame.size.height+5, self.insuranceScrollView.frame.size.width, self.insuranceScrollView.frame.size.height);
            //            self.scrollView.contentSize=CGSizeMake(self.scrollView.frame.size.width, self.insuranceScrollView.frame.origin.y+self.insuranceScrollView.frame.size.height+10);
            
            
            
         
        }
        
        if (self.array.count<1) {
            self.ziliaolab.hidden = YES;
            self.hidenlab.hidden = YES;
        }
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [RHUtility showTextWithText:@"请求失败"];
    }];

    
}

-(void)touch1:(id)sender
{
    UIButton* button=sender;
    
    int count = (int)self.array.count;
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        // 替换为中等尺寸图片
        NSString *url = self.array[i];
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString:url]; // 图片路径
        //        photo.srcImageView = self.view.subviews[i]; // 来源于哪个UIImageView
        [photos addObject:photo];
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = button.tag; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    if (self.dataArray.count > 0) {
    //        NSDictionary* getDataDic =[self.dataArray objectAtIndex:indexPath.row];
    //        [cell updateCell:getDataDic];
    //    }
    //    [cell systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return 61;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    NSSet * set = [NSSet setWithArray:self.dataArray];
//    [self.dataArray removeAllObjects];
//    NSArray * aa = [set allObjects];
//    self.dataArray = [NSMutableArray arrayWithArray:aa];
//    
//    NSMutableArray * array = [NSMutableArray array];
//    
//    
//    for (NSDictionary * dicc in self.dataArray) {
//        
//        //[array addObject:@1];
//        if (dicc[@"freezeId"]) {
//            [array addObject:dicc[@"freezeId"] ];
//        }
//        
//    }
//    NSArray * arrr = [array sortedArrayUsingSelector:@selector(compare:)];
//    
//    //NSMutableDictionary * dic = [NSMutableDictionary dictionary];
//    
//    NSMutableArray * dataarray = [NSMutableArray array];
//    
//    for (int i = 0 ; i < arrr.count; i ++) {
//        for (int j = 0 ; j < arrr.count; j ++) {
//            
//            if ([arrr[array.count-i-1] isEqualToString:self.dataArray[j][@"freezeId"]] ) {
//                
//                [dataarray addObject:self.dataArray[j]];
//                
//            }
//            
//        }
//    }
//    
//    
//    [self.dataArray removeAllObjects];
//    
//    self.dataArray = dataarray;
    
    
    //    for (NSDictionary * diccc in self.dataArray) {
    //
    //    }
    
    //    NSMutableArray * array = [NSMutableArray array];
    //    for (NSDictionary * dic in self.dataArray) {
    //
    //        [array addObject:dic[@"freezeId"]];
    //    }
    
    
    
    // [self.tableView reloadData];
    return self.dataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //[self.tableView reloadData];
    static NSString *CellIdentifier = @"jlCellIdentifier";
    
    cell = (RHDetailJLTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"RHDetailJLTableViewCell" owner:nil options:nil] objectAtIndex:0];
    }
    if (self.dataArray.count > 0) {
        NSDictionary* getDataDic =[self.dataArray objectAtIndex:indexPath.row];
        [cell updateCell:getDataDic];
        //        NSLog(@"1-----%f",cell.priceLabel.frame.origin.x);
       // CGFloat a = self.touzijinerlable.frame.origin.x;
        //        NSLog(@"2------%f",a);
        //        NSLog(@"%f",self.touzijinerlable.frame.size.width);
        //        CGRect rect = cell.priceLabel.frame;
        //CGFloat b = cell.nameLabel.frame.origin.y;
        //        CGFloat w = rect.size.width;
        //        CGFloat h = rect.size.height;
        //        cell.priceLabel.frame = CGRectMake(a, b, 95, h);
        //
        //        NSLog(@"3------%f",cell.priceLabel.frame.origin.x);
        //        CGFloat b = self.touzijinerlable.frame.origin.x;
        //        NSLog(@"%f",cell.nameLabel.frame.origin.x) ;
        //        NSLog(@"%f",a);
       // cell.priceLabel.hidden = YES;
       // UILabel *lab= [[UILabel alloc]initWithFrame:CGRectMake(a+10, b, 95, 21)];
        
//        lab.text = cell.priceLabel.text;
//        lab.font = [UIFont fontWithName:cell.priceLabel.text size:13];
        //[cell addSubview:lab];
    }
    
    
    
    
    return cell;
}


-(NSDictionary *)datadic{
    if (!_datadic) {
        _datadic = [NSDictionary dictionary];
    }
    return _datadic;
}
- (IBAction)toubiao:(id)sender {
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
            //            self.kaihuView.hidden = NO;
            //            self.mengbanview.hidden = NO;
            
        }else{
            RHInvestmentViewController* contoller=[[RHInvestmentViewController alloc]initWithNibName:@"RHInvestmentViewController" bundle:nil];
            NSString * str = self.datadic[@"available"];
            int a = [str intValue];
            contoller.projectFund= a;
            contoller.dataDic=self.datadic;
            //            if (self.panduan == 10) {
            // contoller.panduan = 10;
            //            }
            NSString * str1 =  self.datadic[@"investorRate"];
            //contoller.lilv =str1;
            [self.nav pushViewController:contoller animated:YES];
            
            
        }
    }

}

-(void)pushmybenxi{
    
    
   
    
}
- (IBAction)jsq:(id)sender {
    RHJsqViewController * vc = [[RHJsqViewController alloc]initWithNibName:@"RHJsqViewController" bundle:nil];
    vc.nianStr = self.nhstr;
    
    vc.mouthStr = self.mouthstr;
    [self.nav pushViewController:vc animated:YES];
    NSLog(@"jsq");
}
- (IBAction)push:(id)sender {
    NSLog(@"-------------------------------");
    RHDetailseconddetailViewController *vc =[[RHDetailseconddetailViewController alloc]initWithNibName:@"RHDetailseconddetailViewController" bundle:nil];
if ([self.oldnew isEqualToString:@"old"]) {
     vc.namestr = @"合作方简介";
}else{
     vc.namestr = @"风控信息";
}
   
    vc.deatial = self.cooperatesInfo.text;
    self.myblock();
    [self.nav pushViewController:vc animated:YES];
}

- (IBAction)loginryh:(id)sender {
}

@end
