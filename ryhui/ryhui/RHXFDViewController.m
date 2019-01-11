//
//  RHXFDViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 16/9/1.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import "RHXFDViewController.h"
#import "RHXFDTableViewCell.h"
#import "RHDetailseconddetailViewController.h"
@interface RHXFDViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *benxi;
@property (weak, nonatomic) IBOutlet UILabel *yongtu;
@property (weak, nonatomic) IBOutlet UILabel *zhuanrangname;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property (weak, nonatomic) IBOutlet UILabel *benxilab;
@property (weak, nonatomic) IBOutlet UILabel *zhaiquan;
@property (weak, nonatomic) IBOutlet UILabel *yongtulab;

@property (weak, nonatomic) IBOutlet UILabel *xian;
@property (weak, nonatomic) IBOutlet UIView *labview;

@end


@implementation RHXFDViewController
-(NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.sess = YES;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    NSDictionary* parameters=@{@"id":self.projectid};
    
    
    [[RHNetworkService instance] POST:@"app/common/appDetails/appProjectDetailData" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        DLog(@"%@",responseObject);
       // [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            
            
            [self setupdata:responseObject];
           // [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [RHUtility showTextWithText:@"请求失败"];
    }];// Do any additional setup after loading the view from its nib.
    
    self.scrollview.delegate =self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setupdata:(NSDictionary * )dic{
    
    if (!dic[@"loanName"]|| ![dic[@"loanName"] isKindOfClass:[NSNull class]]) {
        
            NSString *str = [NSString stringWithFormat:@"%@",dic[@"loanName"]];
            
//            NSString * laststr = [str substringFromIndex:str.length - 1];
            NSString * firststr = [str substringToIndex:1];
           
        
//        self.zhuanrangname.text = [NSString stringWithFormat:@"%@***",firststr];
        
        
        if ([dic[@"project"][@"realLoanObjType"] isEqualToString:@"LoanCompanyArchives"]) {
            NSString *str = [NSString stringWithFormat:@"%@",dic[@"loanName"]];
            
            NSString * laststr = [str substringFromIndex:str.length - 1];
            NSString * firststr = [str substringToIndex:1];
            self.zhuanrangname.text = [NSString stringWithFormat:@"%@******%@",firststr,laststr];
        }else{
            NSString *str = [NSString stringWithFormat:@"%@",dic[@"loanName"]];
            
            NSString * laststr = [str substringFromIndex:str.length - 1];
            NSString * firststr = [str substringToIndex:1];
            self.zhuanrangname.text = [NSString stringWithFormat:@"%@**",firststr];
        }
        
    }
//    if (!dic[@"project"][@"loanInfo"]|| ![dic[@"project"][@"loanInfo"] isKindOfClass:[NSNull class]]) {
//        self.loanInfo.text = dic[@"project"][@"loanInfo"];
//    }
    if (!dic[@"project"][@"fundPurpose"]|| ![dic[@"project"][@"fundPurpose"] isKindOfClass:[NSNull class]]) {
        self.yongtu.text = dic[@"project"][@"fundPurpose"];
    }
    if (!dic[@"project"][@"riskSuggestion"]|| ![dic[@"project"][@"riskSuggestion"] isKindOfClass:[NSNull class]]) {
        self.benxi.text = dic[@"project"][@"riskSuggestion"];
    }
//
    self.dataArray = dic[@"creditor"];
    [self.tableView reloadData];
    
    
    CGSize size = [self.yongtu sizeThatFits:CGSizeMake(self.yongtu.frame.size.width, MAXFLOAT)];
    self.yongtu.frame = CGRectMake(self.yongtu.frame.origin.x, CGRectGetMaxY(self.yongtulab.frame)+5, self.yongtu.frame.size.width,      size.height);
    
    self.benxilab.frame = CGRectMake(self.benxilab.frame.origin.x, CGRectGetMaxY(self.yongtu.frame)+10, self.benxilab.frame.size.width, self.benxilab.frame.size.height);
    CGSize size1 = [self.benxi sizeThatFits:CGSizeMake(self.benxi.frame.size.width, MAXFLOAT)];
    self.benxi.frame = CGRectMake(self.benxilab.frame.origin.x, CGRectGetMaxY(self.benxilab.frame)+5, self.benxi.frame.size.width,      size1.height);
    
    self.zhaiquan.frame = CGRectMake(self.zhaiquan.frame.origin.x, CGRectGetMaxY(self.benxi.frame)+10, self.zhaiquan.frame.size.width, self.zhaiquan.frame.size.height);
    
    self.xian.frame =CGRectMake(self.xian.frame.origin.x, CGRectGetMaxY(self.zhaiquan.frame), self.xian.frame.size.width, self.xian.frame.size.height);
    self.labview.frame = CGRectMake(self.labview.frame.origin.x, CGRectGetMaxY(self.xian.frame)+1, self.labview.frame.size.width, self.labview.frame.size.height);
    
    self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, CGRectGetMaxY(self.labview.frame), self.tableView.frame.size.width, self.tableView.frame.size.height);
    self.scrollview.contentSize=CGSizeMake([UIScreen mainScreen].bounds.size.width,CGRectGetMaxY(self.tableView.frame)+180);
    if ([UIScreen mainScreen].bounds.size.width <321) {
        self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, CGRectGetMaxY(self.labview.frame), self.tableView.frame.size.width, self.tableView.frame.size.height+100);
        self.scrollview.contentSize=CGSizeMake([UIScreen mainScreen].bounds.size.width,CGRectGetMaxY(self.tableView.frame)+260+50);
    }
    NSLog(@"%f",[UIScreen mainScreen].bounds.size.height);
    self.scrollview.bounces = NO;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView ==self.tableView) {
        return;
    }
    if (scrollView == self.scrollview) {
        NSLog(@"======");
        if (scrollView.contentOffset.y <1) {
            NSLog(@"---");
                    self.scroolblock();
        }
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    if (self.dataArray.count > 0) {
    //        NSDictionary* getDataDic =[self.dataArray objectAtIndex:indexPath.row];
    //        [cell updateCell:getDataDic];
    //    }
    //    [cell systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return 51;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.dataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //[self.tableView reloadData];
    
    
    static NSString *CellIdentifier = @"xfCellIdentifier";
    
    RHXFDTableViewCell *cell = (RHXFDTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"RHXFDTableViewCell" owner:nil options:nil] objectAtIndex:0];
    }
    
     NSDictionary* getDataDic =[self.dataArray objectAtIndex:indexPath.row];
    
    [cell updata:getDataDic withnum:indexPath.row+1];
    return cell;
}


-(void)pushmybenxi{
    
    
    RHDetailseconddetailViewController *vc =[[RHDetailseconddetailViewController alloc]initWithNibName:@"RHDetailseconddetailViewController" bundle:nil];
    vc.namestr = @"风控信息";
//    vc.deatial = self.riskSuggestion.text;
    
    [self.nav pushViewController:vc animated:YES];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)jiekuanyongtu:(id)sender {
    RHDetailseconddetailViewController *vc =[[RHDetailseconddetailViewController alloc]initWithNibName:@"RHDetailseconddetailViewController" bundle:nil];
    vc.namestr = @"借款用途";
    vc.deatial = self.yongtu.text;
    self.myblock();
    [self.nav pushViewController:vc animated:YES];
}
- (IBAction)benxi:(id)sender {
    RHDetailseconddetailViewController *vc =[[RHDetailseconddetailViewController alloc]initWithNibName:@"RHDetailseconddetailViewController" bundle:nil];
    vc.namestr = @"本息保障";
    vc.deatial = self.benxi.text;
    self.myblock();
    [self.nav pushViewController:vc animated:YES];
}

@end
