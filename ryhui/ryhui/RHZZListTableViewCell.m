//
//  RHZZListTableViewCell.m
//  ryhui
//
//  Created by 糊涂虫 on 16/3/30.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import "RHZZListTableViewCell.h"

@implementation RHZZListTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.progressView = [[CircleProgressView alloc]
                         initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-18-5-80+10, 40, 80, 80)
                         withCenter:CGPointMake(60.0 / 2.0, 60 / 2.0)
                         Radius:54 / 2.0
                         lineWidth:6];
    [self.progressView setProgress:0.5];
    [self.custView addSubview:self.progressView];
    
    self.RHbutton = [[UIButton alloc]init];
    
    
//    self.RHbutton.frame = CGRectMake(10, 40, 100, 40);
    self.RHbutton.frame = CGRectMake(CGRectGetMinX(self.progressView.frame), CGRectGetMaxY(self.progressView.frame)-5-7, 60, 20);
   
    //
    [self.RHbutton setTitle:@"立即购买" forState:UIControlStateNormal];
    //
    self.RHbutton.titleLabel.font =[UIFont systemFontOfSize: 10.0];
    self.RHbutton.backgroundColor = [RHUtility colorForHex:@"#f89779"];
    //
    [self.RHbutton addTarget:self action:@selector(toubiao:) forControlEvents:UIControlEventTouchUpInside];
     [self addSubview:self.RHbutton];
}
- (void)toubiao:(id)sender{
    
    
    self.myblock();
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateCell:(NSDictionary*)dic{
    
    
    NSString* name=@"";
    if (![[dic objectForKey:@"name"] isKindOfClass:[NSNull class]]) {
        name=[dic objectForKey:@"name"];
    }
    self.namelab.text=name;
    NSString* paymentName=@"";
    if (![[dic objectForKey:@"paymentName"] isKindOfClass:[NSNull class]]) {
        paymentName=[dic objectForKey:@"paymentName"];
    }
    self.fuxifangshilab.text = paymentName;
//    self.paymentNameLabel.text=paymentName;
    NSString* investorRate=@"0";
    if (![[dic objectForKey:@"investorRate"] isKindOfClass:[NSNull class]]) {
        investorRate=[[dic objectForKey:@"investorRate"] stringValue];
    }
    self.lilvlab.text=[NSString stringWithFormat:@"%@%%",_lilv];
    NSString* limitTime=@"0";
    if (![[dic objectForKey:@"limitTime"] isKindOfClass:[NSNull class]]) {
        limitTime=[[dic objectForKey:@"limitTime"] stringValue];
    }
    self.timelab.text=limitTime;
    NSString* projectFund=@"0";
    if (![[dic objectForKey:@"projectFund"] isKindOfClass:[NSNull class]]) {
        //        DLog(@"%@",[NSString stringWithFormat:@"%.2f",([[dic objectForKey:@"projectFund"] floatValue]/10000.0)]);
        projectFund=[NSString stringWithFormat:@"%.2f",([[dic objectForKey:@"projectFund"] floatValue]/10000.0)];
    }
    self.moneylab.text=projectFund;
    NSString* insuranceMethod=@"";
    if (![[dic objectForKey:@"insuranceName"] isKindOfClass:[NSNull class]]) {
        insuranceMethod=[dic objectForKey:@"insuranceName"];
    }
    self.dblab.text=insuranceMethod;
    
//    if ([[dic objectForKey:@"insuranceLogo"] isKindOfClass:[NSNull class]]) {
//        CGRect rect=self.insuranceMethodLabel.frame;
//        rect.origin.x=63;
//        // self.insuranceMethodLabel.frame=rect;
//        self.logoImageView.hidden=YES;
//    }else{
//        self.logoImageView.hidden=NO;
//        [self.logoImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@common/main/attachment/%@",[RHNetworkService instance].doMain,[dic objectForKey:@"insuranceLogo"]]]];
//    }
    CGFloat percent=0;
    if (![[dic objectForKey:@"percent"] isKindOfClass:[NSNull class]]) {
        percent=[[dic objectForKey:@"percent"] floatValue]/100.0;
       
    }
    if (percent ==1) {
        self.RHbutton.userInteractionEnabled = NO;
        self.RHbutton.backgroundColor = [RHUtility colorForHex:@"#bdbdbe"];
    }else{
         self.RHbutton.userInteractionEnabled = YES;
        self.RHbutton.backgroundColor = [RHUtility colorForHex:@"#ef876b"];
    }
    [self.progressView setProgress:percent];
    [self.progressView setTintColor:[UIColor redColor]];
    
//    if ([UIScreen mainScreen].bounds.size.width < 330) {
//        self.lilvlab.font = [UIFont boldSystemFontOfSize:18];
//        self.moneylab.font = [UIFont boldSystemFontOfSize:14];
//        
//        self.timelab.font = [UIFont boldSystemFontOfSize:14];
//        self.namelab.font = [UIFont boldSystemFontOfSize:12];
//        self.dblab.font = [UIFont boldSystemFontOfSize:10];
//        self.fuxifangshilab.font = [UIFont boldSystemFontOfSize:10];
//    }
    

    
}
@end
