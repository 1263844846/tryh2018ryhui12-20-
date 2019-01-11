//
//  RHALpayViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 17/8/3.
//  Copyright © 2017年 stefan. All rights reserved.
//

#import "RHALpayViewController.h"

@interface RHALpayViewController ()
@property (weak, nonatomic) IBOutlet UILabel *framlab;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *bankcardnumberlab;

@property (weak, nonatomic) IBOutlet UIView *mengban;
@property (weak, nonatomic) IBOutlet UIView *alterview;
@property (weak, nonatomic) IBOutlet UILabel *lab;
@property (weak, nonatomic) IBOutlet UIImageView *myimage;

@property (weak, nonatomic) IBOutlet UIButton *suobtn;
@property(nonatomic,strong)UIView * alipayiamgeview;


@property(nonatomic,assign)CGFloat scrolrect;
@end

@implementation RHALpayViewController


-(void)getmyalipayimage;{
    
    self.alipayiamgeview = [[UIView alloc]init];
    self.alipayiamgeview.frame = CGRectMake(0, CGRectGetMaxY(self.framlab.frame), [UIScreen mainScreen].bounds.size.width, 3000);
    
    
    UILabel * lab = [[UILabel alloc]init];
    lab.frame = CGRectMake(15, 10, [UIScreen mainScreen].bounds.size.width-30, 20);
    UILabel * lab1 = [[UILabel alloc]init];
    lab1.frame = CGRectMake(15, CGRectGetMaxY(lab.frame), [UIScreen mainScreen].bounds.size.width-30, 40);
    lab.text = @"详细操作：";
    lab1.text = @"1.打开支付宝电脑客户端或手机APP，选择转账功能；";
    lab1.numberOfLines = 0;
    lab.font =[UIFont systemFontOfSize:14.0];
    lab1.font =[UIFont systemFontOfSize:14.0];
    lab.textColor = [RHUtility colorForHex:@"#666666"];
    lab1.textColor = [RHUtility colorForHex:@"#666666"];
    [self.alipayiamgeview addSubview:lab];
    [self.alipayiamgeview addSubview:lab1];
    
   // self.myimage.frame = CGRectMake(15, CGRectGetMaxY(lab1.frame), [UIScreen mainScreen].bounds.size.width-30, 265);
    if ([UIScreen mainScreen].bounds.size.width<321) {
        self.myimage.frame = CGRectMake(15, CGRectGetMaxY(lab1.frame), [UIScreen mainScreen].bounds.size.width-30, 220);
    }else if ([UIScreen mainScreen].bounds.size.width>375){
        self.myimage.frame = CGRectMake(15, CGRectGetMaxY(lab1.frame), [UIScreen mainScreen].bounds.size.width-30, 305);
    }else{
        
        self.myimage.frame = CGRectMake(15, CGRectGetMaxY(lab1.frame), [UIScreen mainScreen].bounds.size.width-30, 265);
    }
    [self.alipayiamgeview addSubview:self.myimage];
    
    
    UILabel * lab2 = [[UILabel alloc]init];
    lab2.frame = CGRectMake(15, CGRectGetMaxY(self.myimage.frame), [UIScreen mainScreen].bounds.size.width-30, 20);
    lab2.text = @"2.转到银行卡；";
    lab2.numberOfLines = 0;
    lab2.font =[UIFont systemFontOfSize:14.0];
    lab2.textColor = [RHUtility colorForHex:@"#666666"];
    [self.alipayiamgeview addSubview:lab2];
    
    UIImageView * myimage1 = [[UIImageView alloc]init];
    myimage1.image = [UIImage imageNamed:@"支付宝2"];
    [self.alipayiamgeview addSubview:myimage1];
    if ([UIScreen mainScreen].bounds.size.width<321) {
        myimage1.frame = CGRectMake(15, CGRectGetMaxY(lab2.frame), [UIScreen mainScreen].bounds.size.width-30, 160);
    }else if ([UIScreen mainScreen].bounds.size.width>375){
        
        myimage1.frame = CGRectMake(15, CGRectGetMaxY(lab2.frame), [UIScreen mainScreen].bounds.size.width-30, 245);
    }else{
        
      myimage1.frame = CGRectMake(15, CGRectGetMaxY(lab2.frame), [UIScreen mainScreen].bounds.size.width-30, 200);
    }
    
    
    UILabel * lab3 = [[UILabel alloc]init];
    lab3.frame = CGRectMake(15, CGRectGetMaxY(myimage1.frame), [UIScreen mainScreen].bounds.size.width-30, 20);
    lab3.text = @"3.填写转账信息，按提示步骤确认转账；";
    lab3.numberOfLines = 0;
    lab3.font =[UIFont systemFontOfSize:14.0];
    lab3.textColor = [RHUtility colorForHex:@"#666666"];
    [self.alipayiamgeview addSubview:lab3];
    
    UIImageView * myimage2 = [[UIImageView alloc]init];
    myimage2.image = [UIImage imageNamed:@"支付宝3"];
    [self.alipayiamgeview addSubview:myimage2];
    if ([UIScreen mainScreen].bounds.size.width<321) {
        myimage2.frame = CGRectMake(15, CGRectGetMaxY(lab3.frame), [UIScreen mainScreen].bounds.size.width-30, 235);
    }else if ([UIScreen mainScreen].bounds.size.width>375){
        
        myimage2.frame = CGRectMake(15, CGRectGetMaxY(lab3.frame), [UIScreen mainScreen].bounds.size.width-30, 335);
    }else{
        
        myimage2.frame = CGRectMake(15, CGRectGetMaxY(lab3.frame), [UIScreen mainScreen].bounds.size.width-30, 285);
    }
    
    UILabel * lab4 = [[UILabel alloc]init];
    lab4.frame = CGRectMake(15, CGRectGetMaxY(myimage2.frame), [UIScreen mainScreen].bounds.size.width-30, 20);
    lab4.text = @"4.以后再转账时，只需选择转账记录中的银行卡即可。";
    lab4.numberOfLines = 0;
    lab4.font =[UIFont systemFontOfSize:14.0];
    lab4.textColor = [RHUtility colorForHex:@"#666666"];
    [self.alipayiamgeview addSubview:lab4];
    
    UIImageView * myimage3 = [[UIImageView alloc]init];
    myimage3.image = [UIImage imageNamed:@"支付宝4"];
    [self.alipayiamgeview addSubview:myimage3];
    if ([UIScreen mainScreen].bounds.size.width<321) {
        myimage3.frame = CGRectMake(15, CGRectGetMaxY(lab4.frame), [UIScreen mainScreen].bounds.size.width-30, 140);
    }else if ([UIScreen mainScreen].bounds.size.width>375){
        
        myimage3.frame = CGRectMake(15, CGRectGetMaxY(lab4.frame), [UIScreen mainScreen].bounds.size.width-30, 225);
    }else{
        
        myimage3.frame = CGRectMake(15, CGRectGetMaxY(lab4.frame), [UIScreen mainScreen].bounds.size.width-30, 180);
    }

    
    [self.scrollview addSubview:self.alipayiamgeview];
    
   self.alipayiamgeview.hidden = YES;
//    self.scrollview.contentSize=CGSizeMake([UIScreen mainScreen].bounds.size.width,CGRectGetMaxY(self.framlab.frame)+CGRectGetMaxY(myimage3.frame)+60);
    
    self.scrolrect = CGRectGetMaxY(self.framlab.frame)+CGRectGetMaxY(myimage3.frame)+60;
}


- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // self.scrollview.contentSize=CGSizeMake([UIScreen mainScreen].bounds.size.width,CGRectGetMaxY(self.framlab.frame)+2805+20);
   // self.alipaybtn.frame= CGRectMake(0, [UIScreen mainScreen].bounds.size.height-400, [UIScreen mainScreen].bounds.size.width, 40);
    self.albtn2.frame= CGRectMake(0, [UIScreen mainScreen].bounds.size.height-40, [UIScreen mainScreen].bounds.size.width, 40);
    if ([UIScreen mainScreen].bounds.size.height>740) {
        self.albtn2.frame= CGRectMake(0, [UIScreen mainScreen].bounds.size.height-100, [UIScreen mainScreen].bounds.size.width, 40);
        
        self.scrollview.frame = CGRectMake(0, self.scrollview.frame.origin.y, self.scrollview.frame.size.width, self.scrollview.frame.size.height-110);
       
        
    }
    self.myblock= ^(){
        //self.alipaybtn = [[UIButton alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-40, [UIScreen mainScreen].bounds.size.width, 40)];
       // self.albtn2.hidden = YES;
    };
    
    
    
     [[UIApplication sharedApplication].keyWindow addSubview:self.alipaybtn];
    [[UIApplication sharedApplication].keyWindow addSubview:self.albtn2];
    [self.alipaybtn addTarget:self action:@selector(goalipay:) forControlEvents:UIControlEventTouchUpInside];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.mengban];
    [[UIApplication sharedApplication].keyWindow addSubview:self.alterview];
    self.alterview.frame = CGRectMake(self.alterview.frame.origin.x, self.alterview.frame.origin.y, [UIScreen mainScreen].bounds.size.width-40, self.alterview.frame.size.height);
    if ([UIScreen mainScreen].bounds.size.width<321) {
        self.lab.font = [UIFont systemFontOfSize:12];
    }
    
    CGSize size = [self.lab sizeThatFits:CGSizeMake(self.lab.frame.size.width, MAXFLOAT)];
    self.lab.frame = CGRectMake(self.lab.frame.origin.x, self.lab.frame.origin.y, self.lab.frame.size.width,      size.height);
    
    self.mengban.hidden = YES;
    
    self.alterview.hidden = YES;
    [self setbankdata:self.bankdic];
    
    CGSize sizetishi = [self.lab sizeThatFits:CGSizeMake(self.lab.frame.size.width, MAXFLOAT)];
    self.lab.frame = CGRectMake(self.lab.frame.origin.x, self.lab.frame.origin.y, self.lab.frame.size.width,      sizetishi.height);
    
    
    if ([UIScreen mainScreen].bounds.size.width<321) {
//        self.myimage.image = [self resizableImage:@"支付宝1"];
    }
    //d2d36a9e0d74e6f11d7bb5a9645b52a65e8480bd
    
    [self getmyalipayimage];
}
-(void)setbankdata:(NSDictionary *)dic{
    
    if (dic[@"realName"] && ![dic[@"realName"] isKindOfClass:[NSNull class]]) {
        self.name.text = [NSString stringWithFormat:@"   收款方户名：%@",dic[@"realName"]];
    }
    if (dic[@"accountId"] && ![dic[@"accountId"] isKindOfClass:[NSNull class]]) {
        self.bankcardnumberlab.text = [NSString stringWithFormat:@"%@",dic[@"accountId"]];
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)goalipay:(id)sender {
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"Alipay://"]]) {
        NSString* url = [NSString stringWithFormat:@"%@://",@"Alipay"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
        
    }else{
        
//        [RHUtility showTextWithText:@"请先安装“支付宝”"];
        NSString* url = [NSString stringWithFormat:@"%@://",@"Alipay://"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
        return;
    }
    NSLog(@"cbxcmm");
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
- (IBAction)hidenmyimage:(id)sender {
    
    if (self.alipayiamgeview.hidden) {
       // [self.suobtn setImage:[UIImage imageNamed:@"sjt"] forState:UIControlStateNormal];
        
        [self.suobtn setBackgroundImage:[UIImage imageNamed:@"sjt"] forState:UIControlStateNormal];
//        self.myimage.hidden = NO;
        self.alipayiamgeview.hidden = NO;
        self.scrollview.contentSize=CGSizeMake([UIScreen mainScreen].bounds.size.width,self.scrolrect);
        return;
    }
//    self.myimage.hidden = YES;
    self.alipayiamgeview.hidden = YES;
    
     [self.suobtn setBackgroundImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
  //  [self.suobtn setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
    self.scrollview.contentSize=CGSizeMake([UIScreen mainScreen].bounds.size.width,CGRectGetMaxY(self.framlab.frame));
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
- (UIImage *)resizableImage:(NSString *)name
{
    UIImage *normal = [UIImage imageNamed:name];
    CGFloat w = normal.size.width * 0.5;
    CGFloat h = normal.size.height * 0.5;
    return [normal resizableImageWithCapInsets:UIEdgeInsetsMake(w, h, w, h)];
}
@end
