//
//  RHXMJXQViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 2018/6/21.
//  Copyright © 2018年 stefan. All rights reserved.
//

#import "RHXMJXQViewController.h"

#import "RHXMJXQTableViewCell.h"

#import "RHProjectdetailthreeViewController.h"

@interface RHXMJXQViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (weak, nonatomic) IBOutlet UIView *myview;
@property(nonatomic,strong)NSArray * array;

@property(nonatomic,copy)NSString *xmjid;
@end

@implementation RHXMJXQViewController

-(NSArray *)array{
    
    if (!_array) {
        _array = [NSArray array];
        
    }
    return _array;
    
}
-(void)getdata{
     NSDictionary *parameters = @{@"projectListId":self.projectid};
    [[RHNetworkService instance] POST:@"app/common/appProjectList/projectListDetailsForApp" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
           
            if (responseObject[@"projects"]) {
                self.array = responseObject[@"projects"];
                
                if (responseObject[@"projectListId"]) {
                    self.xmjid = responseObject[@"projectListId"];
                }
//                self.xmjid =
                [self.tableview reloadData];
            }
            
            
            // [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [RHUtility showTextWithText:@"请求失败"];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self configBackButton];
    [self configTitleWithString:@"项目集合详情"];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self getdata];
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"xmjcell";
    
  RHXMJXQTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"RHXMJXQTableViewCell" owner:nil options:nil] objectAtIndex:0];
    }
    
    if (indexPath.row%2==0) {
        cell.backgroundColor = [UIColor whiteColor];
    }else{
        cell.backgroundColor = [RHUtility colorForHex:@"#EEEEEE"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell updatemydata:self.array[indexPath.row]];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 60;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.array.count;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSMutableDictionary* dic=[self.array objectAtIndex:indexPath.row];
    
    
    NSDictionary* parameters=@{@"id":[NSString stringWithFormat:@"%@",dic[@"projectId"]]};
    
    [[RHNetworkService instance] POST:@"app/common/appDetails/appProjectDetailData" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSDictionary * dataDic = responseObject[@"project"];
        
        RHProjectdetailthreeViewController* controller=[[RHProjectdetailthreeViewController alloc]initWithNibName:@"RHProjectdetailthreeViewController" bundle:nil];
        controller.zzimage.hidden = YES;
        controller.zzlasttimelab.hidden = YES;
        controller.zzlasttimeminlab.hidden = YES;
        controller.zztimelogoiamge.hidden = YES;
        controller.xmjid = self.xmjid;
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
        controller.panduan = 10;
        controller.lilv = string;
        controller.dataDic=dataDic;
        controller.getType=@"0";
        NSString * projectStatus;
        if (![[dataDic objectForKey:@"percent"] isKindOfClass:[NSNull class]]) {
            projectStatus=[dataDic objectForKey:@"projectStatus"] ;
            
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
        
//        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:NO];
//        self.hidesBottomBarWhenPushed = NO;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
  
    
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
//    [DQViewController Sharedbxtabar].tabBar.hidden = YES;
//    [DQViewController Sharedbxtabar].tarbar.hidden = YES;
    
    
//    self.myview.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-80);
//    self.hidesBottomBarWhenPushed = YES;
    
}
-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [DQViewController Sharedbxtabar].tabBar.hidden = YES;
//    self.hidesBottomBarWhenPushed = NO;
//    [DQViewController Sharedbxtabar].tarbar.hidden = YES;
    
}
@end
