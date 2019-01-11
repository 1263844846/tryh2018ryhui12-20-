//
//  RHBngkCardDetailViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 16/4/18.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import "RHsmallMybankViewController.h"
#import "RHBANKTableViewCell.h"
#import "MBProgressHUD.h"
#import "RHBankwebviewViewController.h"

@interface RHsmallMybankViewController ()<UITableViewDataSource,UITableViewDelegate>
// 没绑定快捷 但是绑定提现银行卡
@property (weak, nonatomic) IBOutlet UIView *threeView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *secondview;
@property (strong, nonatomic) IBOutlet UIView *firstview;
@property (weak, nonatomic) IBOutlet UILabel *chongzhikalab1;
@property (weak, nonatomic) IBOutlet UILabel *tixiankalab1;
@property (weak, nonatomic) IBOutlet UILabel *threelab;
@property (weak, nonatomic) IBOutlet UILabel *threelab2;
@property (weak, nonatomic) IBOutlet UILabel *threelab3;
@property (weak, nonatomic) IBOutlet UILabel *threelab4;

//提现卡数组
@property(strong,nonatomic)NSMutableArray * cardArray;
@property (weak, nonatomic) IBOutlet UIView *hidenview;


//image
@property (weak, nonatomic) IBOutlet UIImageView *czimage;

@property (weak, nonatomic) IBOutlet UIImageView *tximage;

@property(nonatomic,copy)NSString * str;

@end

@implementation RHsmallMybankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //    if([UIScreen mainScreen].bounds.size.width < 321){
    //        self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, self.tableView.frame.size.width, 190);
    //    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self configBackButton];
    [self configTitleWithString:@"我的银行卡"];
    //    [self setcolor:self.threelab];
    //    [self setcolor:self.threelab2];
    //    [self setcolor:self.threelab3];
    //    [self setcolor:self.threelab4];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self getcarddata];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.cardArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 120;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    RHBANKTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"rhbankcell"];
    
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"RHBANKTableViewCell" owner:nil options:nil].lastObject;
    }
    
    [cell updatacell:self.cardArray[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [cell.RemoveButton addTarget:self action:@selector(removebankcard:) forControlEvents:UIControlEventTouchUpInside];
    cell.RemoveButton.tag = 1314+indexPath.row;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSLog(@"mtcjy5chs3c");
}

- (void)getcarddata{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[RHNetworkService instance] POST:@"app/front/payment/appAccount/appMyCashData" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            
            if (responseObject[@"qpCard"] == nil || [responseObject[@"qpCard"] isKindOfClass:[NSNull class]]) {
                ;
                if (responseObject[@"defaultCardId"]==nil || [responseObject[@"defaultCardId"] isKindOfClass:[NSNull class]]) {
                    self.hidenview.hidden = YES;
                    self.secondview.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
                    [self.view addSubview:self.secondview];
                }else{
                    
                    self.cardArray = responseObject[@"cards"];
                    
                    [self.tableView reloadData];
                }
                
                NSLog(@"%@",responseObject);
                
            }else{
                self.hidenview.hidden = YES;
                self.firstview.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.threeView.frame.size.height);
                
                NSString *  str = responseObject[@"qpCard"][1];
                NSString * laststr = [str substringFromIndex:str.length - 4];
                NSString * firststr = [str substringToIndex:4];
                
                self.chongzhikalab1.text = [NSString stringWithFormat:@"  %@  ****  %@  ",firststr,laststr];
                
                
                str = responseObject[@"qpCard"][1];
                laststr = [str substringFromIndex:str.length - 4];
                firststr = [str substringToIndex:4];
                self.tixiankalab1.text = [NSString stringWithFormat:@"  %@  ****  %@  ",firststr,laststr];
                
                // NSString * str = [NSString stringWithFormat:@"%@assets/img/bankicon/%@",[RHNetworkService instance].newdoMain,responseObject[@"qpCard"][0]];
                [self.czimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@assets/img/bankicon/%@.jpg",[RHNetworkService instance].newdoMain,responseObject[@"qpCard"][0]]]];
                [self.tximage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@assets/img/bankicon/%@.jpg",[RHNetworkService instance].newdoMain,responseObject[@"qpCard"][0]]]];
                [self.view addSubview:self.firstview];
                
            }
        }
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSLog(@"%@---",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
        
        
    }];
    
}



- (NSMutableArray *)cardArray{
    
    if (!_cardArray) {
        _cardArray = [NSMutableArray array];
    }
    return _cardArray;
    
}
- (IBAction)bankcard:(id)sender {
    
    RHBankwebviewViewController * vc = [[RHBankwebviewViewController  alloc]initWithNibName:@"RHBankwebviewViewController" bundle:nil];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)removebankcard:(UIButton *)sender{
    
    NSInteger pass = sender.tag-1314.0;
    NSLog(@"修改我的银行卡");
    
    UIAlertView* alertView=[[UIAlertView alloc]initWithTitle:nil
                                                     message:@"您确定要删除吗？"
                                                    delegate:self
                                           cancelButtonTitle:@"确定"
                                           otherButtonTitles:@"取消", nil];
    alertView.tag=9911;
    [alertView show];
    
    self.str = self.cardArray[pass][1];
    
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        if (alertView.tag==9911) {
            NSDictionary * parment = @{@"card":self.str};
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            [[RHNetworkService instance] POST:@"app/common/user/appUser/deleteCard" parameters:parment success:^(AFHTTPRequestOperation *operation, id responseObject) {
                //[MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                NSString *str = responseObject[@"RespDesc"];
                NSLog(@"%@",str);
                
                if ([str isEqualToString:@"默认取现卡不允许删除"]) {
                    UIAlertView* ertView=[[UIAlertView alloc]initWithTitle:nil
                                                                   message:@"默认取现卡不允许删除"
                                                                  delegate:self
                                                         cancelButtonTitle:@"关闭"
                                                         otherButtonTitles: nil];
                    [ertView show];
                }else{
                    [RHUtility showTextWithText:str];
                }
                [self getcarddata];
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                
                //                [RHUtility showTextWithText:responseObject[@"RespDesc"]];
                
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                ;
            }];
        }else{
            
        }
    }
}

-(void)setcolor:(UILabel *)lab{
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:lab.text];
    
    [str addAttribute:NSForegroundColorAttributeName value:[RHUtility colorForHex:@"#44bbc1"] range:NSMakeRange(lab.text.length-13,12)];
    //    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-BoldItalicMT" size:30.0] range:NSMakeRange(0, 5)];
    //    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:30.0] range:NSMakeRange(6, 12)];
    //    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Courier-BoldOblique" size:30.0] range:NSMakeRange(19, 6)];
    //    attrLabel.attributedText = str;
    //    return str;
    
    lab.attributedText = str;
}

@end
