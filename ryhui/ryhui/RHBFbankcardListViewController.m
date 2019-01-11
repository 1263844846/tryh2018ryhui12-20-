//
//  RHBFbankcardListViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 2018/1/18.
//  Copyright © 2018年 stefan. All rights reserved.
//

#import "RHBFbankcardListViewController.h"
#import "RHBFbankcardCell.h"
#import "RHBFAddbankcardViewController.h"
#import "RHBFLastTableViewCell.h"
@interface RHBFbankcardListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property(nonatomic,copy)NSString * ress;
@property(nonatomic,assign)CGFloat indexpass;

@property(nonatomic,strong)UIButton * rightbtn;
@property(nonatomic,copy)NSString * bankcardstr;

@property(nonatomic,assign)CGFloat resindex;
@end

@implementation RHBFbankcardListViewController

-(NSArray *)array{
    
    if (!_array) {
        _array = [NSArray array];
    }
    return _array;
}
- (void)viewDidLoad {
self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    [super viewDidLoad];
    self.tableview.dataSource =self;
    self.tableview.delegate = self;
    //self.tableview.cellSeparateStyle = UITableViewCellSeparateStyleNone;
    
    [self configBackButton];
    [self configTitleWithString:@"请选择银行卡"];
    
    self.rightbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.rightbtn addTarget:self action:@selector(xuanze) forControlEvents:UIControlEventTouchUpInside];
    [self.rightbtn setTitle:@"编辑" forState:UIControlStateNormal];
    
    //    UIImage * image = [UIImage imageNamed:@"back.png"];
    
   // [button setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    self.rightbtn.frame=CGRectMake(0, 0, 30, 50);
    
    [self.rightbtn setTitleColor:[UIColor colorWithRed:32.0f/255.0f green:32.0f/255.0f blue:32.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    // button.backgroundColor = [UIColor colorWithHexString:@"44bbc1"];
    self.navigationItem.rightBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:self.rightbtn];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.ress = @"hidden";
    //
    self.indexpass = -1;
}

-(void)xuanze{
    
    if ([self.rightbtn.titleLabel.text isEqualToString:@"编辑"]) {
        self.ress = @"1";
        [self.tableview reloadData];
        [self.rightbtn setTitle:@"取消" forState:UIControlStateNormal];
    }else{
        self.ress = @"hidden";
        [self.tableview reloadData];
        [self.rightbtn setTitle:@"编辑" forState:UIControlStateNormal];
    }
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count+1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Base style for Rectangle 3
    
  
    if (indexPath.row==self.array.count) {
        static NSString *CellIdentifier = @"RHBFLastTableViewCell";
        
        RHBFLastTableViewCell *cell = (RHBFLastTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"RHBFLastTableViewCell" owner:nil options:nil] objectAtIndex:0];
        }
        
        
//        NSDictionary* dataDic=[self.array objectAtIndex:indexPath.row];
//        
//        cell.ress = self.ress;
//        cell.selectionStyle =UITableViewCellSelectionStyleNone;
//        
//        
//        [cell updatemydata:dataDic];
        return cell;
        
    }else{
    
            static NSString *CellIdentifier = @"bfbankcell";
            
            RHBFbankcardCell *cell = (RHBFbankcardCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"RHBFbankcardCell" owner:nil options:nil] objectAtIndex:0];
            }
    
    
        NSDictionary* dataDic=[self.array objectAtIndex:indexPath.row];
        cell.xuanzhongimage.hidden = YES;
        cell.ress = self.ress;
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
       
        if (indexPath.row==self.indexpass) {
            if ([cell.ress isEqualToString:@"1"]) {
                if (self.resindex==10) {
                    cell.removeimage.image = [UIImage imageNamed:@"kuang1"];
                }else{
                    cell.removeimage.image = [UIImage imageNamed:@"kuang"];
                }
                
            }else{
                
                cell.xuanzhongimage.hidden = NO;
            }
        }
    
    [cell updatemydata:dataDic];
    return cell;
            
            
    
    }
       
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
   if (indexPath.row==self.array.count) {
       
       RHBFAddbankcardViewController * vc =[[RHBFAddbankcardViewController alloc]initWithNibName:@"RHBFAddbankcardViewController" bundle:nil];
       
       [self.navigationController pushViewController:vc animated:YES];
   }else{
       
       // NSDictionary* dataDic=[self.array objectAtIndex:indexPath.row];
       
       self.bankcardstr = self.array[indexPath.row][2];
       
       self.indexpass = indexPath.row;
       if (self.resindex==10) {
           self.resindex =1;
       }else{
           self.resindex =10;
       }
       
       [self.tableview reloadData];
   }
    
    
}

- (IBAction)removebankcard:(id)sender {
    NSDictionary* parameters=@{@"cardNo":self.bankcardstr};
    
    [[RHNetworkService instance] POST:@"front/payment/baofoo/unBindCard" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        DLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //  NSLog(@"%@",error);
        DLog(@"%@",[[NSString alloc] initWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
        
    }];
    
}

@end
