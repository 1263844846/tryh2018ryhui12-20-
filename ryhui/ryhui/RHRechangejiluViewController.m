//
//  RHRechangejiluViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 16/2/22.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import "RHRechangejiluViewController.h"
#import "RHJLTableViewCell.h"
#import "MBProgressHUD.h"
@interface RHRechangejiluViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *sbxlab;
@property (weak, nonatomic) IBOutlet UILabel *cbxlab;
@property(nonatomic,strong)NSMutableDictionary * datadic;

@property(nonatomic,strong)NSMutableArray *keyAyyay;
@property (weak, nonatomic) IBOutlet UIView *heardView;
@property(nonatomic,strong)UILabel * moneylab;
@end

@implementation RHRechangejiluViewController

-(NSMutableDictionary *)datadic{
    
    if (!_datadic) {
        _datadic = [NSMutableDictionary dictionary];
    }
    
    return _datadic;
    
}
- (void)viewDidLoad {
    self.tableView.separatorStyle = NO;
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configTitleWithString:@"充值记录"];
    [self configBackButton];
    
    self.view.backgroundColor = [RHUtility colorForHex:@"#e4e6e6"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    self.view.backgroundColor = [UIColor clearColor];
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    UILabel * lab = [[UILabel alloc]init];
    lab.frame = CGRectMake(100, 20, width-200, 50);
    lab.textAlignment = NSTextAlignmentCenter;
    lab.text = @"累计充值(元)";
    [self.heardView addSubview:lab];
    
    
    
    self.moneylab = [[UILabel alloc]init];
    self.moneylab.frame = CGRectMake(50, CGRectGetMaxY(lab.frame), width-100, 70);
    self.moneylab.text = @"0";
    self.moneylab.textAlignment = NSTextAlignmentCenter;
    [self.heardView addSubview:self.moneylab];
    self.moneylab.textColor = [RHUtility colorForHex:@"#44bbc1"];
    
     [self.moneylab setFont:[UIFont systemFontOfSize:30]];
    
    
    [self getuserChangeRecord];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //分组数 也就是section数
    NSArray * array = [self.datadic allKeys];
//     self.keyAyyay = array;
//    if (array.count==0) {
//        CGRect myrect = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y-100, self.tableView.frame.size.width, self.tableView.frame.size.height);
//        
//        [self showNoDataWithFrame:myrect insertView:self.tableView];
//    }else{
//        [self hiddenNoData];
//    }
    
    return self.keyAyyay.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSString * str = self.keyAyyay[section];
    NSArray * arr =self.datadic[str];
    
//    if (self.keyAyyay.count==0) {
//        CGRect myrect = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y-100, self.tableView.frame.size.width, self.tableView.frame.size.height);
//        
//        [self showNoDataWithFrame:myrect insertView:self.tableView];
//    }else{
//        [self hiddenNoData];
//    }
    return arr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * inderstr = @"rhjlcell";
    
    RHJLTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:inderstr];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"RHJLTableViewCell" owner:nil options:nil] objectAtIndex:0];
    }
    NSString * key = self.keyAyyay[indexPath.section];
    [cell updatacell:self.datadic[key][indexPath.row]];
//     cell.backgroundColor = [UIColor clearColor];
//     [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 74;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    UIView * headerview = [[UIView alloc]init];
    headerview.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30);
    UILabel * newpersonlab = [[UILabel alloc]init];
    newpersonlab.frame = CGRectMake(20,0, 100, 30);
    //    newpersonlab.backgroundColor = [UIColor redColor];
    [headerview addSubview:newpersonlab];
    newpersonlab.font =[UIFont systemFontOfSize: 16.0];
    
    headerview.backgroundColor = [RHUtility colorForHex:@"#E4E6E6"];
    newpersonlab.text = self.keyAyyay[section];
    
    return headerview;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)getuserChangeRecord{
     [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
    [[RHNetworkService instance] POST:@"app/common/user/appOperationRecord/rechrageRecords" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            if (![responseObject[@"sumRecharge"] isKindOfClass:[NSNull class]]) {
                self.moneylab.text = [NSString stringWithFormat:@"%@",responseObject[@"sumRecharge"]];
            }
            
            NSArray * array =[responseObject[@"map"] allKeys];
            array = [array sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM"];
                if (obj1 == [NSNull null]) {
                    obj1 = @"0000-00";
                }
                if (obj2 == [NSNull null]) {
                    obj2 = @"0000-00";
                }
                NSDate *date1 = [formatter dateFromString:obj1];
                NSDate *date2 = [formatter dateFromString:obj2];
                NSComparisonResult result = [date1 compare:date2];
                return result == NSOrderedAscending;
            }];
            self.keyAyyay = array;
            for (NSString * str  in array) {
                NSArray * arra = responseObject[@"map"][str];
                
                [self.datadic setObject:arra forKey:str];
            }
            [self.tableView reloadData];
            [MBProgressHUD hideAllHUDsForView:self.tableView animated:YES];
//            NSArray * array = [self.datadic allKeys];
            //     self.keyAyyay = array;
            if (self.datadic.count==0) {
                CGRect myrect = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y-100, self.tableView.frame.size.width, self.tableView.frame.size.height);
                
                [self showNoDataWithFrame:myrect insertView:self.tableView];
            }else{
                [self hiddenNoData];
            }
            
        }
        
        NSLog(@"%@",responseObject);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
         [MBProgressHUD hideAllHUDsForView:self.tableView animated:YES];
        CGRect myrect = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y-100, self.tableView.frame.size.width, self.tableView.frame.size.height);
        
        [self showNoDataWithFrame:myrect insertView:self.tableView];
    }];
    
    
    
}

@end
