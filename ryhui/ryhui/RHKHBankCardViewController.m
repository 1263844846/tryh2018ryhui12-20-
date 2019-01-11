//
//  RHKHBankCardViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 17/8/16.
//  Copyright © 2017年 stefan. All rights reserved.
//

#import "RHKHBankCardViewController.h"
#import "AGAlertListView.h"
#import "RHBankLXTableViewCell.h"
#import "RHLHKWebViewController.h"

@interface RHKHBankCardViewController ()<AGAlertListDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)AGAlertListView *v;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property(nonatomic,strong)NSMutableArray * addressArray;
@property(nonatomic,strong)NSMutableArray * cityArray;
@property (weak, nonatomic) IBOutlet UIView *myview;

@property(nonatomic,strong)NSMutableArray * codeingarray;
@property(nonatomic,copy)NSString *codeing;
@property (weak, nonatomic) IBOutlet UILabel *shengfenlab;
@property (weak, nonatomic) IBOutlet UILabel *citylab;
@property (weak, nonatomic) IBOutlet UITextField *sousuotf;
@property(nonatomic,strong)NSMutableArray * lianhangarray;
@property(nonatomic,strong)NSIndexPath * inde;

@property (weak, nonatomic) IBOutlet UILabel *chaxunlab;

@property (weak, nonatomic) IBOutlet UIView *threeview;




@end

@implementation RHKHBankCardViewController
-(NSMutableArray *)cityArray{
    
    if (!_cityArray) {
        _cityArray = [NSMutableArray array];
    }
    
    return _cityArray;
    
}
-(NSMutableArray *)lianhangarray{
    
    if (!_lianhangarray) {
        _lianhangarray = [NSMutableArray array];
    }
    
    return _lianhangarray;
    
}
-(NSMutableArray *)codeingarray{
    
    if (!_codeingarray) {
        _codeingarray = [NSMutableArray array];
    }
    
    return _codeingarray;
    
}
-(NSMutableArray *)addressArray{
    
    if (!_addressArray) {
        _addressArray = [NSMutableArray array];
    }
    return _addressArray;
}

-(void)didbackdae{
    NSString * str = self.lianhangarray[self.inde.row][@"bankName"];
    NSString * str1 = self.lianhangarray[self.inde.row][@"lineNum"];
    self.bankblock(str,str1);
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.codeing = @"";
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.myview.hidden = YES;
    self.threeview.hidden = YES;
   // [self getaddress];
    
    NSDictionary *attributes = @{NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *netString = [[NSMutableAttributedString alloc] initWithString:self.chaxunlab.text];
    
    [netString addAttributes:attributes range:NSMakeRange(4,5)];
    [netString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(4,5)];
    
    self.chaxunlab.attributedText = netString;
    
    
    [self configBackButton];
    [self configTitleWithString:@"联行卡号查询"];

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.view];
    [self.sousuotf resignFirstResponder];
   // [self.yanzhengmatf resignFirstResponder];
    //    self.bankcardtf
    if (CGRectContainsPoint(self.chaxunlab.frame, touchPoint)) {
        
        RHLHKWebViewController * vc = [[RHLHKWebViewController alloc]initWithNibName:@"RHLHKWebViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}

-(void)getaddress{
    [self.cityArray removeAllObjects];
    if (self.addressArray.count>10) {
        self.v = [[AGAlertListView alloc] initWithOptions:self.addressArray];
        self.v.delegate = self;
        [self.view addSubview:self.v];
        return;
    }
    
    [[RHNetworkService instance] POST:@"app/back/archives/appArchives/appProvinces" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSArray class]]) {
            
        //    self.addressArray = responseObject;
            
            for (NSDictionary * dic  in responseObject) {
                [self.addressArray addObject:dic[@"name"]];
                [self.codeingarray addObject:dic[@"code"]];
            }
            self.v = [[AGAlertListView alloc] initWithOptions:self.addressArray];
            self.v.delegate = self;
            [self.view addSubview:self.v];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)ag_selectWithIndes:(NSInteger)index option:(NSString *)option{
    NSLog(@"%ld ------- %@",index,option);
}


- (void)ag_selectWithListView:(AGAlertListView *)listView indes:(NSInteger)index option:(NSString *)option{
    NSLog(@"%ld ------- %@",index,option);
    
    self.codeing = self.codeingarray[index];
    
    if (self.cityArray.count>0) {
        self.citylab.text = self.cityArray[index];
        return;
    }
    self.shengfenlab.text = self.addressArray[index];
    
    
    
    
}
- (IBAction)shengfen:(id)sender {
    
    [self getaddress];
}

- (IBAction)citybtn:(id)sender {
    
    
    [self.cityArray removeAllObjects];
    [self.sousuotf resignFirstResponder];
    if ([self.shengfenlab.text isEqualToString:@"请选择省份"]) {
        [RHUtility showTextWithText:@"请选择省份"];
        return;
    }
      NSDictionary * parameters = @{@"parentId":self.codeing};
    [[RHNetworkService instance] POST:@"app/back/archives/appArchives/appCitiesOrDistrict" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSArray class]]) {
            
            for (NSDictionary * dic  in responseObject) {
                [self.cityArray addObject:dic[@"name"]];
                //[self.codeingarray addObject:dic[@"code"]];
            }
            self.v = [[AGAlertListView alloc] initWithOptions:self.cityArray];
            self.v.delegate = self;
            [self.view addSubview:self.v];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
    }];
}
- (IBAction)sousuobtn:(id)sender {
    [self.sousuotf resignFirstResponder];
    NSDictionary* parameters=@{@"bankCode":self.sousuotf.text,@"province":self.shengfenlab.text,@"city":self.citylab.text};
    [[RHNetworkService instance] POST:@"app/front/payment/appBankCascade/getBank" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSLog(@"----===============-1111---%@",responseObject);
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            self.lianhangarray = responseObject[@"resultData"];
            if (self.lianhangarray.count>0) {
                self.myview.hidden = NO;
                
                [self.tableview reloadData];
                UIButton*rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,40,20)];
                //  [rightButton setImage:[UIImage imageNamed:@"gengduo.png"]forState:UIControlStateNormal];
                [rightButton addTarget:self action:@selector(didbackdae)forControlEvents:UIControlEventTouchUpInside];
                [rightButton setTitle:@"确定" forState: UIControlStateNormal];
                
                [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
                self.navigationItem.rightBarButtonItem = rightItem;
            }else{
                self.threeview.hidden = NO;
                
                UIButton*rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,40,20)];
                //  [rightButton setImage:[UIImage imageNamed:@"gengduo.png"]forState:UIControlStateNormal];
                [rightButton addTarget:self action:@selector(didbackdae1)forControlEvents:UIControlEventTouchUpInside];
                [rightButton setTitle:@"" forState: UIControlStateNormal];
                
                [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
                self.navigationItem.rightBarButtonItem = rightItem;
            }
            
        }
        
        //  [self guanbitishi:nil];
        // [self.nav pushViewController:controller animated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
        DLog(@"%@",[[NSString alloc] initWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
        
        //self.mengban.hidden = NO;
        // self.shibaiview.hidden = NO;
        self.threeview.hidden = NO;
    }];

    
}
-(void)didbackdae1{
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    
    return self.lianhangarray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 130;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RHBankLXTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"banklhcell"];
    
    if (!cell) {
        
        cell = [[[NSBundle mainBundle]loadNibNamed:@"RHBankLXTableViewCell" owner:nil options:nil] lastObject];
    }
   // [cell updata:self.Array[indexPath.row][@"cell"]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    cell.bankname.text = [NSString stringWithFormat:@"%@",self.lianhangarray[indexPath.row][@"bankName"]];
     cell.bankcardnum.text = [NSString stringWithFormat:@"【%@】",self.lianhangarray[indexPath.row][@"lineNum"]];
    cell.addresslab.text = [NSString stringWithFormat:@"%@",self.lianhangarray[indexPath.row][@"address"]];
    cell.image.image = [UIImage imageNamed:@"appryhui_yinghang.png"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.inde) {
        RHBankLXTableViewCell * cell1 = [tableView cellForRowAtIndexPath:self.inde];
        cell1.image.image = [UIImage imageNamed:@"appryhui_yinghang.png"];
    }
    
    RHBankLXTableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    
    cell.image.image = [UIImage imageNamed:@"BKG_BankSelected"];
    self.inde  =indexPath;
}
- (IBAction)chongxinsousuo:(id)sender {
    
    self.myview.hidden = YES;
    self.threeview.hidden = YES;
}

@end
