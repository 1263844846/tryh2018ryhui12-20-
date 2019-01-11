//
//  RHBFAddbankcardViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 2018/1/24.
//  Copyright © 2018年 stefan. All rights reserved.
//

#import "RHBFAddbankcardViewController.h"
#import "RHBFBKTableViewCell.h"
@interface RHBFAddbankcardViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *hidenview;
@property (weak, nonatomic) IBOutlet UITextField *bankcardtf;
@property (weak, nonatomic) IBOutlet UITextField *phonenumtf;
@property (weak, nonatomic) IBOutlet UILabel *bankxinxilab;
@property(nonatomic,strong)NSArray * array;
@property (weak, nonatomic) IBOutlet UILabel *zhichilab;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UILabel *bankxinxi2;
@property (weak, nonatomic) IBOutlet UILabel *bankxinxi1;

@property(nonatomic,copy)NSString * suoluestr;
@end

@implementation RHBFAddbankcardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.bankcardtf.clearButtonMode = UITextFieldViewModeAlways;
    self.tableview.dataSource =self;
    self.tableview.delegate = self;
     self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.hidenview.hidden = YES;
    
    self.bankcardtf.inputAccessoryView = [self addToolbar:self.bankcardtf];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSArray *)array{
    
    if (!_array) {
        _array = [NSArray array];
    }
    return _array;
}

- (IBAction)getbankcardlist:(id)sender {
    [[RHNetworkService instance] POST:@"front/payment/baofoo/getAllBaofooBankInfo" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        DLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            if (responseObject[@"allBanks"]) {
                self.array = responseObject[@"allBanks"];
                self.hidenview.hidden = NO;
                [self.tableview reloadData];
                self.zhichilab.text = [NSString stringWithFormat:@"      支持银行及限额  ( 共计%lu家 ）",(unsigned long)self.array.count];
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //  NSLog(@"%@",error);
        DLog(@"%@",[[NSString alloc] initWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
        
    }];
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"BKTableViewCell";
    
    RHBFBKTableViewCell *cell = (RHBFBKTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"RHBFBKTableViewCell" owner:nil options:nil] objectAtIndex:0];
    }
    NSArray * array =[self.array objectAtIndex:indexPath.row];
    
   // cell.ress = self.ress;
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    [cell.banklogo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@common/main/attachment/%@",[RHNetworkService instance].newdoMain,array[0]]]];
    
   // [cell updatemydata:dataDic];
    cell.banknamelab.text = [NSString stringWithFormat:@"%@",array[1]];
    cell.bankxiaelab.text = [NSString stringWithFormat:@"限额：单笔%@万，单日累计%@万",array[2],array[3]];
    return cell;
    
    
    
    
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSArray * array =[self.array objectAtIndex:indexPath.row];
    self.bankxinxilab.text = @"";
    
    self.bankxinxi1.text = [NSString stringWithFormat:@"%@",array[1]];
    self.bankxinxi2.text = [NSString stringWithFormat:@"限额：单笔%@万，单日累计%@万",array[2],array[3]];
    self.hidenview.hidden = YES;
    
}
- (UIToolbar *)addToolbar:(UITextField *)tf
{
    
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame),35)];
    //    toolbar.tintColor = [UIColor blueColor];
    //    toolbar.backgroundColor = [UIColor clearColor];
    UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(nextTextField)];
    UIBarButtonItem *prevButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(prevTextField)];
    //    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 50, 3,40, 30)];
    [button setTitle:@"完成"forState:UIControlStateNormal];
    //   button.titleLabel
    if (tf == self.bankcardtf) {
       [button addTarget:self action:@selector(textFieldDone) forControlEvents:UIControlEventTouchUpInside];
    }else{
    [button addTarget:self action:@selector(textFieldDone1) forControlEvents:UIControlEventTouchUpInside];
    }
    [button setTitleColor:[RHUtility colorForHex:@"#44BBC1"] forState:UIControlStateNormal];
    // UIBarButtonItem *rectItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    UIBarButtonItem *flexibleitem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemFlexibleSpace) target:self action:nil];
    NSArray *items = @[flexibleitem,flexibleitem,item];
    [toolbar setItems:items animated:YES];
    //    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(textFieldDone)];
    //    toolbar.items = @[bar];
    //[toolbar :rectItem];
    return toolbar;
}
-(void)textFieldDone{
    [self getthisbankcarknews];
    [self.bankcardtf resignFirstResponder];
    [self.phonenumtf resignFirstResponder];
}
-(void)textFieldDone1{
    
    [self.bankcardtf resignFirstResponder];
    [self.phonenumtf resignFirstResponder];
}
-(void)getthisbankcarknews{
    
    NSDictionary* parameters=@{@"cardNo":self.bankcardtf.text};
    
    
    [[RHNetworkService instance] POST:@"front/payment/baofoo/getBankInfoByCardNo" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        DLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            if ([responseObject[@"bankcode"] isKindOfClass:[NSNull class]]||[responseObject[@"bankcode"] isEqualToString:@"null"]) {
                self.bankxinxilab.text = @"未找到所属银行，请手动选择";
            }else{
                
                self.bankxinxilab.text = responseObject[@"bankcode"];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //  NSLog(@"%@",error);
        DLog(@"%@",[[NSString alloc] initWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
        
    }];
    
    
}
- (IBAction)addbankcard:(id)sender {
    
    NSDictionary* parameters=@{@"cardNo":self.bankcardtf.text,@"telephone":self.phonenumtf.text,@"payCode":self.bankxinxilab.text};
    
    [[RHNetworkService instance] POST:@"front/payment/baofoo/bindCard" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        DLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            if ([responseObject[@"msg"] isEqualToString:@"success"]) {
                [RHUtility showTextWithText:@"绑卡成功"];
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //  NSLog(@"%@",error);
        DLog(@"%@",[[NSString alloc] initWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
        
    }];
    
}


@end
