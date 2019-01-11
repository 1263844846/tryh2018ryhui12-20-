//
//  RHXMJxqjhViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 2018/6/22.
//  Copyright © 2018年 stefan. All rights reserved.
//

#import "RHXMJxqjhViewController.h"

#import "RHMyinverstmentXMJTableViewCell.h"

@interface RHXMJxqjhViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UILabel *monerylab;
@property (weak, nonatomic) IBOutlet UILabel *namelab;

@property(nonatomic,strong)NSArray * array;
@end

@implementation RHXMJxqjhViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self configTitleWithString:@"归属项目集详情"];
    [self configBackButton];
    
    [self getdata];
    self.tableview.delegate =self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
}
-(NSArray *)array{
    
    if (!_array) {
        _array = [NSArray array];
        
    }
    return _array;
    
}
-(void)getdata{
    NSDictionary *parameters = @{@"projectId":self.projectid};
    [[RHNetworkService instance] POST:@"app/front/payment/appProjectListArchives/myInvestProjectListForApp" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            
            self.namelab.text = [NSString stringWithFormat:@"%@",responseObject[@"projectListName"]];
            
            self.monerylab.text = [NSString stringWithFormat:@"%@元",responseObject[@"projectListTotal"]];
            
            self.array = responseObject[@"containProject"];
            
            [self.tableview reloadData];
            // [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [RHUtility showTextWithText:@"请求失败"];
    }];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"rhmyinsertxmj";
    
    RHMyinverstmentXMJTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"RHMyinverstmentXMJTableViewCell" owner:nil options:nil] objectAtIndex:0];
    }
    
    if (indexPath.row%2==0) {
        cell.backgroundColor = [UIColor whiteColor];
    }else{
        cell.backgroundColor = [RHUtility colorForHex:@"#EEEEEE"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary * dic = self.array[indexPath.row];
    
    cell.namelab.text = [NSString stringWithFormat:@"%@",dic[@"projectName"]];
   
   
    if (dic[@"investMoney"] && ![dic[@"investMoney"] isKindOfClass:[NSNull class]]) {
         cell.monerylab.text = [NSString stringWithFormat:@"%@",dic[@"investMoney"]];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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

@end
