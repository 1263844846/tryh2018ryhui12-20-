//
//  RHzhuanzhangViewController1.m
//  ryhui
//
//  Created by 糊涂虫 on 2018/1/15.
//  Copyright © 2018年 stefan. All rights reserved.
//

#import "RHzhuanzhangViewController1.h"
#import "RHJXZZWebViewViewController.h"

@interface RHzhuanzhangViewController1 ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (weak, nonatomic) IBOutlet UILabel *framlab;
@property (weak, nonatomic) IBOutlet UIView *mengban;
@property (weak, nonatomic) IBOutlet UIView *alterview;
@property (weak, nonatomic) IBOutlet UILabel *lab;
@property (weak, nonatomic) IBOutlet UILabel *bankcardnumberlab;
@property (weak, nonatomic) IBOutlet UILabel *namelab;

@property (weak, nonatomic) IBOutlet UIButton *suobtn;
@property (weak, nonatomic) IBOutlet UIImageView *myimage;
@property(nonatomic,strong)UIView * alipayiamgeview;
@property(nonatomic,copy)NSString * wortimestr;
@property(nonatomic,assign)CGFloat scrolrect;

@property (weak, nonatomic) IBOutlet UIView *shijianview;

@property(nonatomic,assign)CGFloat height;
@property (weak, nonatomic) IBOutlet UILabel *shijianlab;
@property (weak, nonatomic) IBOutlet UILabel *tishilab;
@property (weak, nonatomic) IBOutlet UILabel *toplab;
@property (weak, nonatomic) IBOutlet UILabel *skbanklab;
@property (weak, nonatomic) IBOutlet UILabel *skaddresslab;
@property (weak, nonatomic) IBOutlet UILabel *skopenbank;

@property(nonatomic,copy)NSString * namestr;

@end

@implementation RHzhuanzhangViewController1

-(void)getmyalipayimage;{
    self.myimage.hidden = YES;
    
    return;
    self.alipayiamgeview = [[UIView alloc]init];
    self.alipayiamgeview.frame = CGRectMake(0, CGRectGetMaxY(self.framlab.frame), [UIScreen mainScreen].bounds.size.width, 3000);
    
    UILabel * lab8 = [[UILabel alloc]init];
    lab8.frame = CGRectMake(15, 10, [UIScreen mainScreen].bounds.size.width-30, 20);
    UILabel * lab9 = [[UILabel alloc]init];
    lab9.frame = CGRectMake(15, CGRectGetMaxY(lab8.frame), [UIScreen mainScreen].bounds.size.width-30, 40);
    lab8.text = @"详细操作（下图以建行为例）：";
    lab9.text = @"网上银行转账：";
    lab9.numberOfLines = 0;
    lab8.font =[UIFont systemFontOfSize:14.0];
    lab9.font =[UIFont systemFontOfSize:16.0];
    lab8.textColor = [RHUtility colorForHex:@"#666666"];
    lab9.textColor = [UIColor blackColor];
    [self.alipayiamgeview addSubview:lab8];
    [self.alipayiamgeview addSubview:lab9];
    
    UILabel * lab = [[UILabel alloc]init];
    lab.frame = CGRectMake(15, CGRectGetMaxY(lab9.frame), [UIScreen mainScreen].bounds.size.width-30, 20);
    UILabel * lab1 = [[UILabel alloc]init];
    lab1.frame = CGRectMake(15, CGRectGetMaxY(lab.frame), [UIScreen mainScreen].bounds.size.width-30, 40);
    lab.text = @"1.需在银行柜台开通网上银行功能；";
    lab1.text = @"2.访问银行官网，登录网上银行，选择转账功能；";
    lab1.numberOfLines = 0;
    lab.font =[UIFont systemFontOfSize:14.0];
    lab1.font =[UIFont systemFontOfSize:14.0];
    lab.textColor = [RHUtility colorForHex:@"#666666"];
    lab1.textColor = [RHUtility colorForHex:@"#666666"];
    [self.alipayiamgeview addSubview:lab];
    [self.alipayiamgeview addSubview:lab1];
    
    // self.myimage.frame = CGRectMake(15, CGRectGetMaxY(lab1.frame), [UIScreen mainScreen].bounds.size.width-30, 265);
    
    self.myimage.image = [UIImage imageNamed:@"网银1"];
    if ([UIScreen mainScreen].bounds.size.width<321) {
        self.myimage.frame = CGRectMake(15, CGRectGetMaxY(lab1.frame), [UIScreen mainScreen].bounds.size.width-30, 145);
    }else if ([UIScreen mainScreen].bounds.size.width>375){
        self.myimage.frame = CGRectMake(15, CGRectGetMaxY(lab1.frame), [UIScreen mainScreen].bounds.size.width-30, 225);
    }else{
        
        self.myimage.frame = CGRectMake(15, CGRectGetMaxY(lab1.frame), [UIScreen mainScreen].bounds.size.width-30, 185);
    }
    [self.alipayiamgeview addSubview:self.myimage];
    
    
    UILabel * lab2 = [[UILabel alloc]init];
    lab2.frame = CGRectMake(15, CGRectGetMaxY(self.myimage.frame), [UIScreen mainScreen].bounds.size.width-30, 20);
    lab2.text = @"3.填写转账信息、确认转账。";
    lab2.numberOfLines = 0;
    lab2.font =[UIFont systemFontOfSize:14.0];
    lab2.textColor = [RHUtility colorForHex:@"#666666"];
    [self.alipayiamgeview addSubview:lab2];
    
    UIImageView * myimage1 = [[UIImageView alloc]init];
    myimage1.image = [UIImage imageNamed:@"网银2"];
    [self.alipayiamgeview addSubview:myimage1];
    if ([UIScreen mainScreen].bounds.size.width<321) {
        myimage1.frame = CGRectMake(15, CGRectGetMaxY(lab2.frame), [UIScreen mainScreen].bounds.size.width-30, 370);
    }else if ([UIScreen mainScreen].bounds.size.width>375){
        
        myimage1.frame = CGRectMake(15, CGRectGetMaxY(lab2.frame), [UIScreen mainScreen].bounds.size.width-30, 480);
    }else{
        
        myimage1.frame = CGRectMake(15, CGRectGetMaxY(lab2.frame), [UIScreen mainScreen].bounds.size.width-30, 420);
    }
    
    
    UILabel * lab3 = [[UILabel alloc]init];
    lab3.frame = CGRectMake(15, CGRectGetMaxY(myimage1.frame), [UIScreen mainScreen].bounds.size.width-30, 20);
    lab3.text = @"手机银行转账：";
    lab3.numberOfLines = 0;
    lab3.font =[UIFont systemFontOfSize:16.0];
    lab3.textColor = [UIColor blackColor];
    [self.alipayiamgeview addSubview:lab3];
    UILabel * lab6 = [[UILabel alloc]init];
    lab6.frame = CGRectMake(15, CGRectGetMaxY(lab3.frame), [UIScreen mainScreen].bounds.size.width-30, 20);
    lab6.text = @"1.需在网上或银行柜台开通手机银行功能；";
    lab6.numberOfLines = 0;
    lab6.font =[UIFont systemFontOfSize:14.0];
    lab6.textColor = [RHUtility colorForHex:@"#666666"];
    [self.alipayiamgeview addSubview:lab6];
    UILabel * lab7 = [[UILabel alloc]init];
    lab7.frame = CGRectMake(15, CGRectGetMaxY(lab6.frame), [UIScreen mainScreen].bounds.size.width-30, 20);
    lab7.text = @"2.下载手机银行APP，登录后选择转账功能；";
    lab7.numberOfLines = 0;
    lab7.font =[UIFont systemFontOfSize:14.0];
    lab7.textColor = [RHUtility colorForHex:@"#666666"];
    [self.alipayiamgeview addSubview:lab7];
    
    UIImageView * myimage2 = [[UIImageView alloc]init];
    myimage2.image = [UIImage imageNamed:@"网银3"];
    [self.alipayiamgeview addSubview:myimage2];
    if ([UIScreen mainScreen].bounds.size.width<321) {
        myimage2.frame = CGRectMake(15, CGRectGetMaxY(lab7.frame), [UIScreen mainScreen].bounds.size.width-30, 180);
        self.scrollview.contentSize=CGSizeMake([UIScreen mainScreen].bounds.size.width,CGRectGetMaxY(self.framlab.frame)+50+50);
    }else if ([UIScreen mainScreen].bounds.size.width>375){
        
        myimage2.frame = CGRectMake(15, CGRectGetMaxY(lab7.frame), [UIScreen mainScreen].bounds.size.width-30, 265);
    }else{
        
        myimage2.frame = CGRectMake(15, CGRectGetMaxY(lab7.frame), [UIScreen mainScreen].bounds.size.width-30, 220);
    }
    
    UILabel * lab4 = [[UILabel alloc]init];
    lab4.frame = CGRectMake(15, CGRectGetMaxY(myimage2.frame), [UIScreen mainScreen].bounds.size.width-30, 20);
    lab4.text = @"3.填写转账信息、确认转账；";
    lab4.numberOfLines = 0;
    lab4.font =[UIFont systemFontOfSize:14.0];
    lab4.textColor = [RHUtility colorForHex:@"#666666"];
    [self.alipayiamgeview addSubview:lab4];
    
    UIImageView * myimage3 = [[UIImageView alloc]init];
    myimage3.image = [UIImage imageNamed:@"网银4"];
    [self.alipayiamgeview addSubview:myimage3];
    if ([UIScreen mainScreen].bounds.size.width<321) {
        myimage3.frame = CGRectMake(15, CGRectGetMaxY(lab4.frame), [UIScreen mainScreen].bounds.size.width-30, 470);
    }else if ([UIScreen mainScreen].bounds.size.width>375){
        
        myimage3.frame = CGRectMake(15, CGRectGetMaxY(lab4.frame), [UIScreen mainScreen].bounds.size.width-30, 570);
    }else{
        
        myimage3.frame = CGRectMake(15, CGRectGetMaxY(lab4.frame), [UIScreen mainScreen].bounds.size.width-30, 520);
    }
    
    
    UILabel * lab5 = [[UILabel alloc]init];
    lab5.frame = CGRectMake(15, CGRectGetMaxY(myimage3.frame), [UIScreen mainScreen].bounds.size.width-30, 20);
    lab5.text = @"4.以后再转账时，只需选择转账记录中的银行卡即可。";
    lab5.numberOfLines = 0;
    lab5.font =[UIFont systemFontOfSize:14.0];
    lab5.textColor = [RHUtility colorForHex:@"#666666"];
    [self.alipayiamgeview addSubview:lab5];
    
    UIImageView * myimage4 = [[UIImageView alloc]init];
    myimage4.image = [UIImage imageNamed:@"网银5"];
    [self.alipayiamgeview addSubview:myimage4];
    if ([UIScreen mainScreen].bounds.size.width<321) {
        myimage4.frame = CGRectMake(15, CGRectGetMaxY(lab5.frame), [UIScreen mainScreen].bounds.size.width-30, 235);
    }else if ([UIScreen mainScreen].bounds.size.width>375){
        
        myimage4.frame = CGRectMake(15, CGRectGetMaxY(lab5.frame), [UIScreen mainScreen].bounds.size.width-30, 325);
    }else{
        
        myimage4.frame = CGRectMake(15, CGRectGetMaxY(lab5.frame), [UIScreen mainScreen].bounds.size.width-30, 275);
    }
    
    
    [self.scrollview addSubview:self.alipayiamgeview];
    
    self.alipayiamgeview.hidden = YES;
    //  self.scrollview.contentSize=CGSizeMake([UIScreen mainScreen].bounds.size.width,CGRectGetMaxY(self.framlab.frame)+CGRectGetMaxY(myimage4.frame)+60);
    
    self.height = CGRectGetMaxY(myimage4.frame);
    self.scrolrect = CGRectGetMaxY(self.framlab.frame)+CGRectGetMaxY(myimage4.frame)+60;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication].keyWindow addSubview:self.mengban];
    [[UIApplication sharedApplication].keyWindow addSubview:self.alterview];
    self.alterview.frame = CGRectMake(self.alterview.frame.origin.x, self.alterview.frame.origin.y, [UIScreen mainScreen].bounds.size.width-40, self.alterview.frame.size.height);
    if ([UIScreen mainScreen].bounds.size.width<321) {
        self.lab.font = [UIFont systemFontOfSize:12];
    }
    // self.scrollview.contentSize=CGSizeMake([UIScreen mainScreen].bounds.size.width,CGRectGetMaxY(self.framlab.frame)+2805+20);
    CGSize size = [self.lab sizeThatFits:CGSizeMake(self.lab.frame.size.width, MAXFLOAT)];
    self.lab.frame = CGRectMake(self.lab.frame.origin.x, self.lab.frame.origin.y, self.lab.frame.size.width,      size.height);
    
    self.mengban.hidden = YES;
    
    self.alterview.hidden = YES;
    [self setbankdata:self.bankdic];
    
    CGSize sizetishi = [self.lab sizeThatFits:CGSizeMake(self.lab.frame.size.width, MAXFLOAT)];
    self.lab.frame = CGRectMake(self.lab.frame.origin.x, self.lab.frame.origin.y, self.lab.frame.size.width,      sizetishi.height);
    [self getmyalipayimage];
    self.shijianview.hidden = YES;
    [self getworktime];
    
    [self gettishistr];
    [self getbanktishistr];
    [self getzhuanzhangtishistr];
    
    
    if (RHScreeWidth<325) {
        self.scrollview.contentSize=CGSizeMake([UIScreen mainScreen].bounds.size.width,CGRectGetMaxY(self.framlab.frame)+50+100);
    }
}

-(void)setbankdata:(NSDictionary *)dic{
    
    if (dic[@"realName"] && ![dic[@"realName"] isKindOfClass:[NSNull class]]) {
        self.namelab.text = [NSString stringWithFormat:@"   收款方户名：%@",dic[@"realName"]];
    }
    if (dic[@"accountId"] && ![dic[@"accountId"] isKindOfClass:[NSNull class]]) {
        self.bankcardnumberlab.text = [NSString stringWithFormat:@"%@",dic[@"accountId"]];
    }
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)guanbi:(id)sender {
    
    self.mengban.hidden = YES;
    self.alterview.hidden = YES;
}
- (IBAction)tishi:(id)sender {
    self.mengban.hidden = NO;
    self.alterview.hidden = NO;
}

-(NSDictionary*)bankdic{
    
    if (!_bankdic) {
        _bankdic = [NSDictionary dictionary];
    }
    return _bankdic;
}
- (IBAction)hiddenmyimage:(id)sender {
    
    RHJXZZWebViewViewController * vc= [[RHJXZZWebViewViewController alloc]initWithNibName:@"RHJXZZWebViewViewController" bundle:nil];
    
    [self.nav pushViewController:vc animated:YES];
    
    return;
    
    if (self.alipayiamgeview.hidden) {
        self.alipayiamgeview.hidden = NO;
        self.scrollview.contentSize=CGSizeMake([UIScreen mainScreen].bounds.size.width,self.scrolrect);
        [self.suobtn setBackgroundImage:[UIImage imageNamed:@"sjt"] forState:UIControlStateNormal];
        return;
    }
    self.alipayiamgeview.hidden = YES;
    [self.suobtn setBackgroundImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
    self.scrollview.contentSize=CGSizeMake([UIScreen mainScreen].bounds.size.width,CGRectGetMaxY(self.framlab.frame)+50);
}
- (IBAction)fuzhiname:(id)sender {
    UIPasteboard *pab = [UIPasteboard generalPasteboard];
    
    NSString *string = self.namestr;
    
    [pab setString:string];
    
    if (pab == nil) {
        [RHUtility showTextWithText:@"复制失败"];
        
    }else
    {
        [RHUtility showTextWithText:@"已复制"];
    }
    
}


- (IBAction)fuzhi:(id)sender {
    
    UIPasteboard *pab = [UIPasteboard generalPasteboard];
    
    NSString *string = self.bankcardnumberlab.text;
    
    [pab setString:string];
    
    if (pab == nil) {
        [RHUtility showTextWithText:@"复制失败"];
        
    }else
    {
        [RHUtility showTextWithText:@"已复制"];
    }
}

-(void)getworktime{
    
    [[RHNetworkService instance] POST:@"app/front/payment/appAccount/judgeThisDay" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            if (responseObject[@"isWorkDay"]&&![responseObject[@"isWorkDay"]isKindOfClass:[NSNull class]]) {
                
                self.wortimestr = [NSString stringWithFormat:@"%@",responseObject[@"isWorkDay"]];
                
                if ([self.wortimestr isEqualToString:@"false"]) {
                    self.shijianview.hidden = NO;
                    
                    if (RHScreeWidth<325) {
                        self.shijianlab.font = [UIFont systemFontOfSize:11];
                    }
                    self.scrollview.frame = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, self.scrollview.frame.size.height -100);
//                    self.scrolrect = CGRectGetMaxY(self.framlab.frame)+se+60;
                     self.scrollview.contentSize=CGSizeMake([UIScreen mainScreen].bounds.size.width,CGRectGetMaxY(self.framlab.frame)+50+100);
                }
                
            }
        }
        NSLog(@"%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        DLog(@"%@",[[NSString alloc] initWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
    }];
    
}
- (IBAction)guanbishijiantishi:(id)sender {
    
    self.shijianview.hidden = YES;
    self.scrollview.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.scrollview.frame.size.height +100);
    //                    self.scrolrect = CGRectGetMaxY(self.framlab.frame)+se+60;
    self.scrollview.contentSize=CGSizeMake([UIScreen mainScreen].bounds.size.width,CGRectGetMaxY(self.framlab.frame)+50+20+100);
    
}

-(void)gettishistr{
    
    NSDictionary* parameters=@{@"type":@"transferCharge"};
    
    [[RHNetworkService instance] POST:@"app/front/payment/appJxAccount/getMsgByType" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        if (responseObject[@"msg"]&& ![responseObject[@"msg"] isKindOfClass:[NSNull class]]) {
            self.tishilab.text = responseObject[@"msg"];
            CGSize sizetishi = [self.tishilab sizeThatFits:CGSizeMake(self.tishilab.frame.size.width, MAXFLOAT)];
            self.tishilab.frame = CGRectMake(self.tishilab.frame.origin.x, self.tishilab.frame.origin.y, self.tishilab.frame.size.width,      sizetishi.height);
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
        DLog(@"%@",[[NSString alloc] initWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
        
        
        
    }];
}


-(void)getzhuanzhangtishistr{
    
    NSDictionary* parameters=@{@"type":@"transferChargeTopMsg"};
    
    [[RHNetworkService instance] POST:@"app/front/payment/appJxAccount/getMsgByType" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        if (responseObject[@"msg"]&& ![responseObject[@"msg"] isKindOfClass:[NSNull class]]) {
            self.toplab.text = responseObject[@"msg"];
           
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
        DLog(@"%@",[[NSString alloc] initWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
        
        
        
    }];
}


-(void)getbanktishistr{
    
//    NSDictionary* parameters=@{@"type":@"transferChargeTopMsg"};
    
    [[RHNetworkService instance] POST:@"app/front/payment/appJxAccount/getTransferChargeMsg" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        
        if (responseObject[@"receivables"]&& ![responseObject[@"receivables"] isKindOfClass:[NSNull class]]) {
            //            self.toplab.text = responseObject[@"msg"];
//            self.skbanklab.text = [NSString stringWithFormat:@"   收款银行：%@",responseObject[@"cashBank"]];
            self.namelab.text = [NSString stringWithFormat:@"%@",responseObject[@"receivables"]];
            self.namestr = [NSString stringWithFormat:@"%@",responseObject[@"receivables"]];
            
        }
        if (responseObject[@"cardNumber"]&& ![responseObject[@"cardNumber"] isKindOfClass:[NSNull class]]) {
            //            self.toplab.text = responseObject[@"msg"];
//            self.skbanklab.text = [NSString stringWithFormat:@"   收款银行：%@",responseObject[@"cashBank"]];
             self.bankcardnumberlab.text = [NSString stringWithFormat:@"%@",responseObject[@"cardNumber"]];
            
        }
        
        if (responseObject[@"cashBank"]&& ![responseObject[@"cashBank"] isKindOfClass:[NSNull class]]) {
//            self.toplab.text = responseObject[@"msg"];
            self.skbanklab.text = [NSString stringWithFormat:@"   收款银行：%@",responseObject[@"cashBank"]];
           
            
            
        }
        if (responseObject[@"openingArea"]&& ![responseObject[@"openingArea"] isKindOfClass:[NSNull class]]) {
           
            self.skaddresslab.text = [NSString stringWithFormat:@"   收款方开户地区：%@",responseObject[@"openingArea"]];
            
        }
        if (responseObject[@"openingBank"]&& ![responseObject[@"openingBank"] isKindOfClass:[NSNull class]]) {
           
            self.skopenbank.text = [NSString stringWithFormat:@"   收款方开户行：%@",responseObject[@"openingBank"]];
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
        DLog(@"%@",[[NSString alloc] initWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
        
        
        
    }];
}

@end
