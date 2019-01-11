//
//  RHWitdrawJLViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 16/8/24.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import "RHWitdrawJLViewController.h"
#import "RHJLTableViewCell.h"
#import "MBProgressHUD.h"
@interface RHWitdrawJLViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableDictionary * dataDic;
@property(nonatomic,strong)NSMutableDictionary * dataDic1;
@property (weak, nonatomic) IBOutlet UILabel *monlab;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSMutableArray * array;
@property(nonatomic,strong)NSArray * array1;
@end

@implementation RHWitdrawJLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    [self getdata];
    
    [self configBackButton];
    [self configTitleWithString:@"提现记录"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
     self.tableView.separatorStyle = NO;
    self.array = [NSMutableArray array];
    self.array1 = [NSArray array];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getdata{
     [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
    [[RHNetworkService instance] POST:@"app/common/user/appOperationRecord/cashRecords" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            if ([responseObject[@"msg"] isEqualToString:@"success"]) {
                
                if (!responseObject[@"sumCash"]||![responseObject[@"sumCash"]isKindOfClass:[NSNull class]]) {
                    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
                    [numberFormatter setPositiveFormat:@"###,##0.00;"];
                    NSString * money = responseObject[@"sumCash"];
                    NSString *formattedNumberString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble: [money doubleValue] ]];
                    
                    self.monlab.text = formattedNumberString;
                }
                if (responseObject[@"map"]&&[responseObject[@"map"] isKindOfClass:[NSDictionary class]]) {
                    self.dataDic = responseObject[@"map"];
                    
                    [self getdring];
                    [self.tableView reloadData];
                    [MBProgressHUD hideAllHUDsForView:self.tableView animated:YES];
                }
                
                
            }
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
        
        
        
    }];
    
}

- (NSMutableDictionary *)dataDic{
    
    if (!_dataDic) {
        _dataDic = [NSMutableDictionary dictionary];
    }
    return _dataDic;
    
}
- (NSMutableDictionary *)dataDic1{
    
    if (!_dataDic1) {
        _dataDic1 = [NSMutableDictionary dictionary];
    }
    return _dataDic1;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //分组数 也就是section数
    self.array1 = [self.dataDic1 allKeys];
    // self.keyArray = array;
    if (self.array1.count==0) {
        CGRect myrect = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y-100, self.tableView.frame.size.width, self.tableView.frame.size.height);
        
        [self showNoDataWithFrame:myrect insertView:self.tableView];
    }else{
        [self hiddenNoData];
    }
    
    return self.array1.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
//    NSArray * array = [self.dataDic1 allKeys];
    
    NSArray * patharray = self.dataDic1[self.array[section]];
    return patharray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * inderstr = @"rhjlcell";
    
    RHJLTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:inderstr];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"RHJLTableViewCell" owner:nil options:nil] objectAtIndex:0];
    }
//    NSArray * key = self.dataDic[indexPath.section];
    
    NSArray * arry = self.dataDic1[self.array[indexPath.section]];
    [cell updatacell:arry[indexPath.row]];
    cell.lab.text = @"提现";
    cell.imagelab.backgroundColor = [RHUtility colorForHex:@"#32CD32"];
    cell.imagelab.text = @"支";
    cell.moneylab.textColor = [RHUtility colorForHex:@"#32CD32"];
//     cell.backgroundColor = [UIColor clearColor];
    [self.tableView setSeparatorColor:[UIColor clearColor]];
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
    newpersonlab.text = self.array[section];
    
    return headerview;
}

-(void)getdring{
    
    self.array =[NSMutableArray arrayWithArray:[self.dataDic allKeys]];
    
    self.array = (NSMutableArray *)[self.array sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
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
    for (int i = 0; i< self.array.count; i++) {
        
        [self.dataDic1 setObject:self.dataDic[self.array[i]] forKey:self.array[i]];
        
    }

    [self.tableView reloadData];
}

@end
