//
//  RHJPTableViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 16/4/15.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import "RHJPTableViewController.h"
#import "RHJPTableViewCell.h"
#import "RHADressViewController.h"
#import "RHMainTableViewCell.h"
@interface RHJPTableViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSMutableArray * dataArray;

@end

@implementation RHJPTableViewController

-(NSMutableArray *)dataArray{
    
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.tableView setSeparatorColor:[UIColor clearColor]];
//    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [self getmygift];
//    self.title = @"我的奖品";
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self getnavagationbutton];
}

-(void)getnavagationbutton{
    
    UILabel* titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 30)];
    titleLabel.font=[UIFont boldSystemFontOfSize:20];
    titleLabel.textAlignment=NSTextAlignmentCenter;
    titleLabel.textColor= [RHUtility colorForHex:@"#4abac0"];
    titleLabel.backgroundColor=[UIColor clearColor];
    titleLabel.text=@"我的奖品";
    self.navigationItem.titleView = titleLabel;
    
    UIButton*rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,60,30)];
    //[rightButton setImage:[UIImage imageNamed:@"shezhipng.png"]forState:UIControlStateNormal];
    [rightButton setTitle:@"收货地址" forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [rightButton setTitleColor:[RHUtility colorForHex:@"#4abac0"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(getuser)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    
    //    [btn setTitle:@""];
    //
    //
    //    [btn setTintColor:[RHUtility colorForHex:@"#44bbc1"]];
    //btn.image = [UIImage imageNamed:@"gengduo"];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    //[self getBindCard];
    
    
    UIButton*leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,15,15)];
    [leftButton setImage:[UIImage imageNamed:@"icon_back.png"]forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(goback)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
}
-(void)goback{
    
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [DQViewController Sharedbxtabar].tarbar.hidden = YES;
}
-(void)getuser{
    
    RHADressViewController * vc  =[[RHADressViewController alloc]initWithNibName:@"RHADressViewController" bundle:nil];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    RHJPTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rhjpcell"];
//    
//    if (cell ==nil) {
//        cell =[[[NSBundle mainBundle] loadNibNamed:@"RHJPTableViewCell" owner:nil options:nil] objectAtIndex:0];
//    }
//    // Configure the cell...
//    
//    [cell updata:self.dataArray[indexPath.row][@"cell"]];
//     [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
////    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
//    self.tableView.separatorStyle = NO;
    
    RHMainTableViewCell * cell =  [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier1"];
    if (cell ==nil) {
                cell =[[[NSBundle mainBundle] loadNibNamed:@"RHMainTableViewCell" owner:nil options:nil] objectAtIndex:0];
            }
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)getmygift{
    
    NSDictionary* parameters=@{@"_search":@"true",@"rows":@"10",@"page":@"1",@"sidx":@"createTime",@"sord":@"desc",@"filters":@"{\"groupOp\":\"AND\",\"rules\":[]}"};
    
     [[RHNetworkService instance] POST:@"app/front/payment/appMyAwards/appMyAwardsDetailList" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
         self.dataArray = responseObject[@"rows"];
         
         NSLog(@"%@-------",responseObject);
         [self.tableView reloadData];
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
     }];
}

@end
