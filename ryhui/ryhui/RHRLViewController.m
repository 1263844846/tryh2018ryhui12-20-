//
//  RHRLViewController.m
//  极光推送
//
//  Created by 糊涂虫 on 15/12/28.
//  Copyright © 2015年 Light. All rights reserved.
//

#import "RHRLViewController.h"
#import "SZCalendarPicker.h"
#import "RHRLTableViewCell.h"
#import "MBProgressHUD.h"

@interface RHRLViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSMutableArray * cbxArray;
@property(nonatomic,strong)UIView * twoview;
@property(nonatomic,strong)UIScrollView * scollView;
@property(nonatomic,strong)UITableView * tableview;

@property(nonatomic,strong)UILabel * yhlab;
@property(nonatomic,strong)UILabel* yihuilab;

@property(nonatomic,copy)NSString * mouthstr;
@property (nonatomic, nonnull,strong)NSDictionary * datadic;

@property(nonatomic,copy)NSString * daystr;


@property(nonatomic,strong)UILabel * bryhlab;
@property(nonatomic,strong)UILabel * bryihuilab;



@end

@implementation RHRLViewController
//@synthesize selectedYear;

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [RYHViewController Sharedbxtabar].tarbar.hidden = YES;
}
-(NSMutableArray *)cbxArray{
    
    if (!_cbxArray) {
        _cbxArray = [NSMutableArray array];
    }
    return _cbxArray;
    
}
-(void)getdaydata :(NSString * )str{
    
    
    NSDictionary *parameters = @{@"dayDate":self.daystr};
    NSLog(@"%@",parameters);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[RHNetworkService instance] POST:@"app/common/user/appGatheringCalendar/dayGathering" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSArray class]]) {
            
            //            self.datadic = responseObject;
            if (responseObject!=nil) {
                
                self.cbxArray = responseObject;
                [self.tableview reloadData];
                NSLog(@"%@",responseObject);
                
                
            }
            
            
        }
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        
        // NSLog(@"%@",responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSDictionary * dic ;
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
       // [self updatemydata:dic];
    }];
    
    
    NSDictionary *parameters1 = @{@"date":self.daystr};
    
   
    [[RHNetworkService instance] POST:@"app/common/user/appGatheringCalendar/getDayMoneyByDate" parameters:parameters1 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]&&responseObject) {
            
            //            self.datadic = responseObject;
            
            
            self.bryhlab.text = [NSString stringWithFormat:@"%.2f",[responseObject[@"should"] doubleValue]];
            self.bryihuilab.text = [NSString stringWithFormat:@"%.2f",[responseObject[@"already"] doubleValue]];
            
        }
      
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       
    }];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self creattableview];
    [self configBackButton];
    [self configTitleWithString:@"回款计划"];
     self.tableview.separatorStyle = NO;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

-(void)creattableview{
    
    UIImageView * backimage = [[UIImageView alloc]init];
    backimage.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 1) ;
    backimage.backgroundColor = [RHUtility colorForHex:@"#e4e6e6"];
    [self.view addSubview:backimage];
    self.scollView = [[UIScrollView alloc]init];
    
    self.scollView.frame = CGRectMake(0, 1, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-66);
    self.scollView.contentSize=CGSizeMake(self.view.frame.size.width,[UIScreen mainScreen].bounds.size.height+40);
    self.scollView.bounces = NO;
    self.scollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scollView];
    SZCalendarPicker *calendarPicker = [SZCalendarPicker showOnView:self.scollView];
    calendarPicker.today = [NSDate date];
    calendarPicker.date = calendarPicker.today;
    
//    [self configTitleWithString:calendarPicker.myblock];
    NSLog(@"%@",calendarPicker.today);
    
    calendarPicker.dayblock = ^(NSString * str){
        self.daystr = str;
        [self getdaydata:nil];
        
        
    };
    calendarPicker.frame = CGRectMake(0, 0, self.view.frame.size.width, 300);
    calendarPicker.calendarBlock = ^(NSInteger day, NSInteger month, NSInteger year){
        
        
        // NSLog(@"%i-%i-%i", year,month,day);
    };
    [self.scollView addSubview:calendarPicker];
    self.view.backgroundColor = [UIColor whiteColor];
    self.twoview = [[UIView alloc]init];
    self.twoview.frame = CGRectMake(0,CGRectGetMaxY(calendarPicker.frame), calendarPicker.frame.size.width, 135);
    self.twoview.backgroundColor = [UIColor whiteColor];

    [self.scollView addSubview:self.twoview];

    self.bryhlab = [[UILabel alloc]init];
    self.bryhlab.frame = CGRectMake(0, 11, [UIScreen mainScreen].bounds.size.width/2-1, 30);
    self.bryhlab.textAlignment = NSTextAlignmentCenter;
    self.bryhlab.text = @"0.00";
    self.bryhlab.font = [UIFont systemFontOfSize: 24.0];
    self.bryhlab.textColor = [RHUtility colorForHex:@"#44bbc1"];
    [self.twoview addSubview:self.bryhlab];
    self.bryihuilab = [[UILabel alloc]init];
    self.bryihuilab.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2, CGRectGetMinY(self.bryhlab.frame),[UIScreen mainScreen].bounds.size.width/2-1, 30);
    self.bryihuilab.textAlignment = NSTextAlignmentCenter;
    self.bryihuilab.text = @"0.00";
    self.bryihuilab.font = [UIFont systemFontOfSize: 24.0];
    self.bryihuilab.textColor = [RHUtility colorForHex:@"#44bbc1"];

    [self.twoview addSubview:self.bryihuilab];

    UILabel * bryhlab = [[UILabel alloc]init];
    bryhlab.frame = CGRectMake(0, CGRectGetMaxY(self.bryhlab.frame)+5, [UIScreen mainScreen].bounds.size.width/2-1, 14);
    bryhlab.textColor = [RHUtility colorForHex:@"#cccccc"];
    bryhlab.textAlignment = NSTextAlignmentCenter;
    bryhlab.text = @"本日应回(元)";
    bryhlab.font = [UIFont systemFontOfSize: 13.0];
    [self.twoview addSubview:bryhlab];

    UILabel * bryhlab1 = [[UILabel alloc]init];
    bryhlab1.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2, CGRectGetMaxY(self.bryhlab.frame)+5, [UIScreen mainScreen].bounds.size.width/2-1, 15);
    bryhlab1.textColor = [RHUtility colorForHex:@"#cccccc"];
    bryhlab1.textAlignment = NSTextAlignmentCenter;
    bryhlab1.text = @"本日已回(元)";
    bryhlab1.font = [UIFont systemFontOfSize: 13.0];

    [self.twoview addSubview:bryhlab1];

    UILabel * fengelab = [[UILabel alloc]init];
    fengelab.frame = CGRectMake(0, CGRectGetMaxY(bryhlab.frame)+20, [UIScreen mainScreen].bounds.size.width, 1);
    fengelab.backgroundColor = [RHUtility colorForHex:@"#cccccc"];
    [self.twoview addSubview:fengelab];

    UILabel * yhlab = [[UILabel alloc]init];
    yhlab.frame = CGRectMake(0, CGRectGetMaxY(fengelab.frame)+8, [UIScreen mainScreen].bounds.size.width/2-1, 15);
    yhlab.textColor = [RHUtility colorForHex:@"#cccccc"];
    yhlab.textAlignment = NSTextAlignmentCenter;
    yhlab.text = @"本月应回(元)";
    yhlab.font = [UIFont systemFontOfSize: 13.0];

    [self.twoview addSubview:yhlab];

    UIImageView * backimage1 = [[UIImageView alloc]init];
    backimage1.frame = CGRectMake(CGRectGetMaxX(yhlab.frame),CGRectGetMaxY(fengelab.frame)+3 , 1, 42) ;
    backimage1.backgroundColor = [RHUtility colorForHex:@"#cccccc"];
    [self.twoview addSubview:backimage1];

    UILabel * yhlab1 = [[UILabel alloc]init];
    yhlab1.frame = CGRectMake(CGRectGetMaxX(backimage1.frame), CGRectGetMaxY(fengelab.frame)+8, [UIScreen mainScreen].bounds.size.width/2-1, 15);
    yhlab1.textColor = [RHUtility colorForHex:@"#cccccc"];
    yhlab1.textAlignment = NSTextAlignmentCenter;
    yhlab1.text = @"本月已回(元)";
    yhlab1.font = [UIFont systemFontOfSize: 13.0];

    [self.twoview addSubview:yhlab1];

    self.yhlab = [[UILabel alloc]init];
    self.yhlab.frame = CGRectMake(0, CGRectGetMaxY(yhlab.frame), [UIScreen mainScreen].bounds.size.width/2-1, 20);
    self.yhlab.textAlignment = NSTextAlignmentCenter;
    self.yhlab.text = @"0.00";
    self.yhlab.font = [UIFont systemFontOfSize: 18.0];
    self.yhlab.textColor = [UIColor blackColor];

    [self.twoview addSubview:self.yhlab];





    self.yihuilab = [[UILabel alloc]init];
    self.yihuilab.frame = CGRectMake(CGRectGetMaxX(backimage1.frame), CGRectGetMinY(self.yhlab.frame),[UIScreen mainScreen].bounds.size.width/2-1, 20);
    self.yihuilab.textAlignment = NSTextAlignmentCenter;
    self.yihuilab.text = @"0.00";
    self.yihuilab.font = [UIFont systemFontOfSize: 18.0];
    self.yihuilab.textColor = [UIColor blackColor];

    [self.twoview addSubview:self.yihuilab];


    UILabel * fengelab1 = [[UILabel alloc]init];
    fengelab1.frame = CGRectMake(0, 134, [UIScreen mainScreen].bounds.size.width, 1);
    fengelab1.backgroundColor = [RHUtility colorForHex:@"#cccccc"];
    [self.twoview addSubview:fengelab1];
    UILabel * fengelab2 = [[UILabel alloc]init];
    fengelab2.frame = CGRectMake(0, 1, [UIScreen mainScreen].bounds.size.width, 1);
    fengelab2.backgroundColor = [RHUtility colorForHex:@"#cccccc"];
    [self.twoview addSubview:fengelab2];

    if ([UIScreen mainScreen].bounds.size.height < 570) {

        self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.twoview.frame), calendarPicker.frame.size.width, [UIScreen mainScreen].bounds.size.height/10*5-45) style:UITableViewStylePlain];
    }else if([UIScreen mainScreen].bounds.size.height > 670){
        NSLog(@"%f",[UIScreen mainScreen].bounds.size.height);

        self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.twoview.frame), calendarPicker.frame.size.width, [UIScreen mainScreen].bounds.size.height/12*7-20-15-50) style:UITableViewStylePlain];
    }else{
       self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.twoview.frame), calendarPicker.frame.size.width, [UIScreen mainScreen].bounds.size.height/12*7-50) style:UITableViewStylePlain];
    }

    if ([UIScreen mainScreen].bounds.size.height < 481){
        self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.twoview.frame), calendarPicker.frame.size.width, [UIScreen mainScreen].bounds.size.height/12*7-50-30-43) style:UITableViewStylePlain];
    }
    
    
//    self.twoview = [[UIView alloc]init];
//    self.twoview.frame = CGRectMake(0,CGRectGetMaxY(calendarPicker.frame), calendarPicker.frame.size.width, 65);
//    self.twoview.backgroundColor = [RHUtility colorForHex:@"#44bbc1"];
//
//    [self.scollView addSubview:self.twoview];
//    self.yhlab = [[UILabel alloc]init];
//    self.yhlab.frame = CGRectMake(0, 13, [UIScreen mainScreen].bounds.size.width/2-1, 20);
//    self.yhlab.textAlignment = NSTextAlignmentCenter;
//    self.yhlab.text = @"0.00";
//    self.yhlab.font = [UIFont systemFontOfSize: 18.0];
//    self.yhlab.textColor = [UIColor whiteColor];
//
//    [self.twoview addSubview:self.yhlab];
//
//    UILabel * yhlab = [[UILabel alloc]init];
//    yhlab.frame = CGRectMake(0, CGRectGetMaxY(self.yhlab.frame)+5, [UIScreen mainScreen].bounds.size.width/2-1, 15);
//    yhlab.textColor = [UIColor whiteColor];
//    yhlab.textAlignment = NSTextAlignmentCenter;
//    yhlab.text = @"本月应回(元)";
//    yhlab.font = [UIFont systemFontOfSize: 16.0];
//
//    [self.twoview addSubview:yhlab];
//
//    UIImageView * backimage1 = [[UIImageView alloc]init];
//    backimage1.frame = CGRectMake(CGRectGetMaxX(self.yhlab.frame), 5, 1, 55) ;
//    backimage1.backgroundColor = [RHUtility colorForHex:@"#e4e6e6"];
//    [self.twoview addSubview:backimage1];
//
//    self.yihuilab = [[UILabel alloc]init];
//    self.yihuilab.frame = CGRectMake(CGRectGetMaxX(backimage1.frame), CGRectGetMinY(self.yhlab.frame),[UIScreen mainScreen].bounds.size.width/2-1, 20);
//    self.yihuilab.textAlignment = NSTextAlignmentCenter;
//    self.yihuilab.text = @"0.00";
//    self.yihuilab.font = [UIFont systemFontOfSize: 18.0];
//    self.yihuilab.textColor = [UIColor whiteColor];
//
//    [self.twoview addSubview:self.yihuilab];
//
//
//    UILabel * yhlab1 = [[UILabel alloc]init];
//    yhlab1.frame = CGRectMake(CGRectGetMaxX(backimage1.frame), CGRectGetMaxY(self.yhlab.frame)+5, [UIScreen mainScreen].bounds.size.width/2-1, 15);
//    yhlab1.textColor = [UIColor whiteColor];
//    yhlab1.textAlignment = NSTextAlignmentCenter;
//    yhlab1.text = @"本月已回(元)";
//    yhlab1.font = [UIFont systemFontOfSize: 16.0];
//
//    [self.twoview addSubview:yhlab1];
//
//    if ([UIScreen mainScreen].bounds.size.height < 570) {
//
//        self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.twoview.frame), calendarPicker.frame.size.width, [UIScreen mainScreen].bounds.size.height/10*5-45) style:UITableViewStylePlain];
//    }else if([UIScreen mainScreen].bounds.size.height > 670){
//        NSLog(@"%f",[UIScreen mainScreen].bounds.size.height);
//
//        self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.twoview.frame), calendarPicker.frame.size.width, [UIScreen mainScreen].bounds.size.height/12*7-20-15) style:UITableViewStylePlain];
//    }else{
//        self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.twoview.frame), calendarPicker.frame.size.width, [UIScreen mainScreen].bounds.size.height/12*7-50) style:UITableViewStylePlain];
//    }
//
//    if ([UIScreen mainScreen].bounds.size.height < 481){
//        self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.twoview.frame), calendarPicker.frame.size.width, [UIScreen mainScreen].bounds.size.height/12*7-50-30-43) style:UITableViewStylePlain];
//    }
//
    
    self.tableview.delegate = self ;
    
    self.tableview.dataSource = self;
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel * lbb = [[UILabel alloc]init];
    lbb.backgroundColor = [UIColor whiteColor];
    lbb.frame = self.tableview.frame;
    [self.scollView addSubview:lbb];
    [self.scollView addSubview:self.tableview];
    calendarPicker.myblock = ^(NSString * bx){
        
        self.mouthstr = bx;
        [self loaddata];
    };
    
    //calendarPicker.myblock(@"111");
   
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.cbxArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RHRLTableViewCell * cell =(RHRLTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"rhrltableview"];
    
    
    if (cell == nil) {
       cell = [[[NSBundle mainBundle] loadNibNamed:@"RHRLTableViewCell" owner:nil options:nil] objectAtIndex:0];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.cbxArray.count <6) {
//        cell.datelab.text = self.cbxArray[indexPath.row];
        
    }else{
   // cell.textLabel.text = self.cbxArray[indexPath.row];
    }
    [cell updata:self.cbxArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    [self.cbxArray removeAllObjects];
    
//    [tableView reloadData];
    
    NSLog(@"%ld",(long)indexPath.row);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)loaddata{
    
//    return;
//    [self.cbxArray removeAllObjects];
    NSDictionary *parameters = @{@"monthDate":self.mouthstr};
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[RHNetworkService instance] POST:@"app/common/user/appGatheringCalendar/monthGathering" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
//            self.datadic = responseObject;
            if (responseObject!=nil) {
                
                
                [self updatemydata:responseObject];
                
                
            }
            
            
        }
        //        [MBProgressHUD hideAllHUDsForView:self animated:YES];
     
        
        // NSLog(@"%@",responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSDictionary * dic ;
        [self updatemydata:dic];
    }];
    
}

-(void)updatemydata :(NSDictionary *)dic{
    
    if (dic.count<1) {
        self.yhlab.text =@"0.00";
        self.yihuilab.text =@"0.00";
        NSMutableArray * ar;
        self.cbxArray = ar;
//        [self.cbxArray removeAllObjects];
        [self.tableview reloadData];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        return;
    }
    
    if (!dic[@"should"]|| ![dic[@"should"] isKindOfClass:[NSNull class]]) {
        //CGFloat mony = [dic[@"should"][0] integerValue];
        self.yhlab.text = [NSString stringWithFormat:@"%.@",dic[@"should"]];
      
        
    }else{
         self.yhlab.text =@"0.00";
        
       
        
    }
    if (!dic[@"already"]|| ![dic[@"already"] isKindOfClass:[NSNull class]]) {
       // CGFloat mony = [dic[@"already"][0] integerValue];
        self.yihuilab.text = [NSString stringWithFormat:@"%.@",dic[@"already"]];
    }else{
        self.yihuilab.text =@"0.00";
        
    }
//    if (dic[@"should"][0]&&dic[@"already"][0]&&![dic[@"should"][0] isKindOfClass:[NSNull class]]&&![dic[@"already"][0] isKindOfClass:[NSNull class]]) {
//        CGFloat mony = [dic[@"should"][0] integerValue];
//        CGFloat mony1 = [dic[@"already"][0] integerValue];
//        self.yhlab.text = [NSString stringWithFormat:@"%.2f",mony];
//        self.yihuilab.text = [NSString stringWithFormat:@"%.2f",mony1];
//        
//        
//        self.cbxArray = dic[@"dayGathers"];
//        [self.tableview reloadData];
//    }else{
//        
//       
//        self.yihuilab.text = @"0.00";
//       self.cbxArray = dic[@"dayGathers"];
//        [self.tableview reloadData];
//    }
    
        
    self.cbxArray = dic[@"dayGathers"];
//    [self.tableview reloadData];
     self.tableview.hidden = NO;
    if ([self.yhlab.text intValue]==0) {
        self.bryhlab.text = @"0.00";
        self.bryihuilab.text =@"0.00";
        self.tableview.hidden = YES;
//                    [self.cbxArray removeAllObjects];
//                    [self.tableview reloadData];
    }
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

-(NSDictionary *)datadic{
    
    if (!_datadic) {
        _datadic = [NSDictionary dictionary];
    }
    return _datadic;
    
}
@end
