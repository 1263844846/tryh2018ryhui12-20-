//
//  RHADressViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 16/6/2.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import "RHADressViewController.h"
#import "RHCityTableViewCell.h"

@interface RHADressViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *provincetable;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *telephonenumber;
@property (weak, nonatomic) IBOutlet UILabel *province;
@property (weak, nonatomic) IBOutlet UILabel *citylab;
@property (weak, nonatomic) IBOutlet UILabel *addresslab;
@property (weak, nonatomic) IBOutlet UITextField *usernametx;
@property (weak, nonatomic) IBOutlet UITextField *phonetx;
@property (weak, nonatomic) IBOutlet UITextField *addresstx;



@property(nonatomic,strong)NSMutableArray * provinceArray;
@property (weak, nonatomic) IBOutlet UILabel *countylab;
@property (weak, nonatomic) IBOutlet UITableView *citytableview;
@property(nonatomic,copy)NSString * codestring;
@property(nonatomic,copy)NSString * citycodestring;
@property(nonatomic,copy)NSString * countrycodestring;
@property(nonatomic,strong)NSMutableArray * cityArray;


@property (weak, nonatomic) IBOutlet UITableView *countrytableview;
@property(nonatomic,strong)NSMutableArray * countryArray;


@property(nonatomic,assign)BOOL * res;
@property(nonatomic,assign)BOOL * cityres;
@property(nonatomic,assign)BOOL * countryres;


@property (weak, nonatomic) IBOutlet UIButton *shengfen;

@property (weak, nonatomic) IBOutlet UIButton *chengshi;
@property (weak, nonatomic) IBOutlet UIButton *quxian;

@end

@implementation RHADressViewController

-(NSMutableArray *)provinceArray{
    
    if (!_provinceArray) {
        _provinceArray = [NSMutableArray array];
    }
    
    return _provinceArray;
}

-(NSMutableArray *)cityArray{
    
    if (!_cityArray) {
        _cityArray = [NSMutableArray array];
    }
    
    return _cityArray;
    
}

-(NSMutableArray *)countryArray{
    
    if (!_countryArray) {
        _countryArray = [NSMutableArray array];
    }
    return _countryArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self configBackButton];
    [self configTitleWithString:@"收货地址"];
    [self getmyadressdata];
    self.provincetable.hidden = YES;
    
    self.provincetable.dataSource = self;
    self.provincetable.delegate  = self ;
    self.provincetable.separatorStyle = NO;
    
    
    self.citytableview.hidden = YES;
    self.citytableview.dataSource = self;
    self.citytableview.delegate  = self ;
    self.citytableview.separatorStyle = NO;
    
    
    
    self.countrytableview.hidden = YES;
    self.countrytableview.dataSource = self;
    self.countrytableview.delegate  = self ;
    self.countrytableview.separatorStyle = NO;
    
    
    self.addresstx.delegate = self;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField;{
    
    if ([UIScreen mainScreen].bounds.size.width < 321) {
        self.view.frame = CGRectMake(0, -75, [UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.height);
    }else if ([UIScreen mainScreen].bounds.size.width > 321&&[UIScreen mainScreen].bounds.size.width < 376){
        
        self.view.frame = CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.height);
    }
    
    NSLog(@"cbx");
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([UIScreen mainScreen].bounds.size.width < 321) {
        self.view.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.height);
    }else if ([UIScreen mainScreen].bounds.size.width > 321&&[UIScreen mainScreen].bounds.size.width < 376){
        
        self.view.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.height);
    }
    [self.usernametx resignFirstResponder];
    [self.phonetx resignFirstResponder];
    [self.addresstx resignFirstResponder];
//    [self.InvitationCodeTF resignFirstResponder];
    //    [self.textField resignFirstResponder];
}

-(void)getmyadressdata{
    
    
     [[RHNetworkService instance] POST:@"app/front/payment/appMyAwards/appUserInfo" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
         
         if ([responseObject isKindOfClass:[NSDictionary class]]) {
             
             if (!responseObject[@"username"] ||! [responseObject[@"username"] isKindOfClass:[NSNull class]]) {
                 self.usernametx.text = [NSString stringWithFormat:@"%@",responseObject[@"username"]];
             }
             
              if (!responseObject[@"telephone"] ||! [responseObject[@"telephone"] isKindOfClass:[NSNull class]]) {
             self.phonetx.text = [NSString stringWithFormat:@"%@",responseObject[@"telephone"]];
              }
             
             if (!responseObject[@"province"] ||! [responseObject[@"province"] isKindOfClass:[NSNull class]]) {
                 self.province.text = [NSString stringWithFormat:@"%@",responseObject[@"province"]];
             }
             if (!responseObject[@"city"] ||![responseObject[@"city"] isKindOfClass:[NSNull class]]) {
                 self.citylab.text = [NSString stringWithFormat:@"%@",responseObject[@"city"]];
             }
             if (![responseObject[@"address"] isKindOfClass:[NSNull class]]) {
                  self.addresstx.text = [NSString stringWithFormat:@"%@",responseObject[@"address"]];
             }
             if (!responseObject[@"country"] || ![responseObject[@"country"] isKindOfClass:[NSNull class]]) {
                 self.countylab.text = [NSString stringWithFormat:@"%@",responseObject[@"country"]];
                 self.countrycodestring =  [NSString stringWithFormat:@"%@",responseObject[@"countryCode"]];
             }
             if (!responseObject[@"cityCode"] ||! [responseObject[@"cityCode"] isKindOfClass:[NSNull class]]) {
                 self.citycodestring = [NSString stringWithFormat:@"%@",responseObject[@"cityCode"]];
             }
             if (!responseObject[@"proviceCode"] ||! [responseObject[@"proviceCode"] isKindOfClass:[NSNull class]]) {
                 self.codestring = [NSString stringWithFormat:@"%@",responseObject[@"proviceCode"]];
             }
             
             
             
            
             
             
             
         }
         NSLog(@"----%@",responseObject);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         ;
     }];
    
    
}

- (IBAction)taskprovince:(id)sender {
    
//    _citylab.text = @"请选择城市";
//    _countylab.text = @"请选择区县";
    if (self.res) {
        
        [self.shengfen setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
        [self.chengshi setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
        [self.quxian setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
        self.provincetable.hidden = YES;
        self.countrytableview.hidden = YES;
        self.citytableview.hidden = YES;
        self.res = NO;
        _citylab.text = @"请选择城市";
        _countylab.text = @"请选择区县";
        return;
    }
    
    
     [self.shengfen setImage:[UIImage imageNamed:@"sjt"] forState:UIControlStateNormal];
    self.provincetable.hidden = NO;
    self.countrytableview.hidden = YES;
    self.citytableview.hidden = YES;
//    self.provincetable.hidden = YES;
    
//    [self.cityArray removeAllObjects];
//    [self.countryArray removeAllObjects];
    self.citylab.text = @"";
    self.countylab.text = @"";
    self.citycodestring= @"";
    //111
    [[RHNetworkService instance] POST:@"app/back/archives/appArchives/appProvinces" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSArray class]]) {
        
         self.provinceArray = responseObject;
            [self.provincetable reloadData];
            self.res = YES;
            _citylab.text = @"请选择城市";
            _countylab.text = @"请选择区县";
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
    }];
    
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    
    if (tableView==self.provincetable) {
        return self.provinceArray.count;
    }
    if (tableView == self.citytableview) {
        return self.cityArray.count;
    }else if (tableView ==self.countrytableview){
        
        return self.countryArray.count;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 43;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    if (tableView==self.provincetable) {
        RHCityTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"citycell"];
        
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"RHCityTableViewCell" owner:nil options:nil] objectAtIndex:0];
            
        }
        cell.citylab.text = [NSString stringWithFormat:@"%@",self.provinceArray[indexPath.row][@"name"]];
        
        return cell;
    }else if(tableView ==self.citytableview){
        RHCityTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"citycell"];
        
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"RHCityTableViewCell" owner:nil options:nil] objectAtIndex:0];
            
        }
        cell.citylab.text = [NSString stringWithFormat:@"%@",self.cityArray[indexPath.row][@"name"]];
        
        return cell;
    }else if(tableView ==self.countrytableview){
        
        RHCityTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"citycell"];
        
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"RHCityTableViewCell" owner:nil options:nil] objectAtIndex:0];
            
        }
        cell.citylab.text = [NSString stringWithFormat:@"%@",self.countryArray[indexPath.row][@"name"]];
        
        return cell;
        
    }
   
    
    
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (tableView== self.provincetable){
        
        self.province.text = [NSString stringWithFormat:@"%@",self.provinceArray[indexPath.row][@"name"]];
        self.codestring = [NSString stringWithFormat:@"%@",self.provinceArray[indexPath.row][@"code"]];
        self.provincetable.hidden = YES;
    }else if(tableView ==self.citytableview){
        
        self.citylab.text = [NSString stringWithFormat:@"%@",self.cityArray[indexPath.row][@"name"]];
        self.citycodestring = [NSString stringWithFormat:@"%@",self.cityArray[indexPath.row][@"code"]];
        self.citytableview.hidden = YES;
        
    }else if (tableView ==self.countrytableview){
        
        self.countylab.text = [NSString stringWithFormat:@"%@",self.countryArray[indexPath.row][@"name"]];
        self.countrycodestring = [NSString stringWithFormat:@"%@",self.countryArray[indexPath.row][@"code"]];
        self.countrytableview.hidden = YES;
    }
    [self.shengfen setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
    [self.chengshi setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
    [self.quxian setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
    
    
}



- (IBAction)preservationbtn:(id)sender {
    
    if (_usernametx.text.length<1) {
        [RHUtility showTextWithText:@"收件人不能为空"];
        return;
    }
    if (_phonetx.text.length<1) {
        [RHUtility showTextWithText:@"手机号不能为空"];
        return;
    }else{
        
        if (_phonetx.text.length!=11) {
            
            [RHUtility showTextWithText:@"手机号不合法"];
            return;
        }
        
    }
    
    
    if (_province.text.length<1) {
        [RHUtility showTextWithText:@"省份不能为空"];
        return;
    }
    if (_citylab.text.length<1||[_citylab.text isEqualToString:@"请选择城市"]) {
        [RHUtility showTextWithText:@"城市不能为空"];
        return;
    }
    if (_countylab.text.length<1||[_countylab.text isEqualToString:@"请选择区县"]) {
        [RHUtility showTextWithText:@"区县不能为空"];
        return;
    }
    if (_addresstx.text.length<1) {
        [RHUtility showTextWithText:@"地址不能为空"];
        return;
    }
    self.provincetable.hidden = YES;
    self.citytableview.hidden = YES;
    self.countrytableview.hidden = YES;
    
    
    NSDictionary *parameters = @{@"province":self.codestring,@"city":self.citycodestring,@"country":[NSString stringWithFormat:@"%@",self.countrycodestring ],@"address":[NSString stringWithFormat:@"%@",self.addresstx.text],@"username":self.usernametx.text,@"telephone":self.phonetx.text};
    [[RHNetworkService instance] POST:@"app/front/payment/appMyAwards/appSaveUserAddress" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject[@"msg"] isEqualToString:@"success"]) {
            
             [RHUtility showTextWithText:@"保存成功"];
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [RHUtility showTextWithText:@"保存失败，请重试"];
    }];
}
- (IBAction)getcitybtn:(id)sender {
    //222
//    _countylab.text = @"请选择区县";
    if (self.cityres) {
        
        [self.shengfen setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
        [self.chengshi setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
        [self.quxian setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
        self.provincetable.hidden = YES;
        self.countrytableview.hidden = YES;
        self.citytableview.hidden = YES;
        self.cityres = NO;
        _countylab.text = @"请选择区县";
        return;
    }
    
    [self.chengshi setImage:[UIImage imageNamed:@"sjt"] forState:UIControlStateNormal];
    NSDictionary * parameters = @{@"parentId":self.codestring};
    self.citytableview.hidden = NO;
    self.countrytableview.hidden = YES;
//    self.citytableview.hidden = YES;
    self.provincetable.hidden = YES;
    
   self.countylab.text = @"";
    [[RHNetworkService instance] POST:@"app/back/archives/appArchives/appCities" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSArray class]]) {
            
            self.cityArray = responseObject;
            [self.citytableview reloadData];
            
            self.cityres = YES;
            _countylab.text = @"请选择区县";
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
    }];
//    _countylab.text = @"请选择区县";
    
}
- (IBAction)getcountybtn:(id)sender {
    
    //333
    
    if (self.countryres) {
        
        [self.shengfen setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
        [self.chengshi setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
        [self.quxian setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
        self.provincetable.hidden = YES;
        self.countrytableview.hidden = YES;
        self.citytableview.hidden = YES;
        self.countryres = NO;
        return;
    }
    
    [self.quxian setImage:[UIImage imageNamed:@"sjt"] forState:UIControlStateNormal];
    NSDictionary * parameters = @{@"parentId":self.citycodestring};
    self.countrytableview.hidden = NO;
    self.citytableview.hidden = YES;
    self.provincetable.hidden = YES;
    [[RHNetworkService instance] POST:@"app/back/archives/appArchives/appCities" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSArray class]]) {
            
            //            self.provinceArray = responseObject;
            //            [self.provincetable reloadData];
            
            self.countryArray = responseObject;
            
            [self.countrytableview reloadData];
            
            self.countryres = YES;
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
    }];
    
}

- (IBAction)myshengfen:(id)sender {
    [self taskprovince:nil];
    
}


- (IBAction)myquxian:(id)sender {
    [self getcountybtn:nil];
    
}
- (IBAction)mychengshi:(id)sender {
    [self getcitybtn:nil];
}

@end
