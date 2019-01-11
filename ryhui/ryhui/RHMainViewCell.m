//
//  RHMainViewCell.m
//  ryhui
//
//  Created by stefan on 15/3/14.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHMainViewCell.h"
#import "CircleProgressView.h"

@implementation RHMainViewCell
@synthesize progressView;

- (void)awakeFromNib {
    _fontArray = [[NSMutableArray alloc] initWithCapacity:242];
    for (NSString * familyName in [UIFont familyNames]) {
        // NSLog(@Font FamilyName = %@,familyName); //*输出字体族科名字
        for (NSString * fontName in [UIFont fontNamesForFamilyName:familyName]) {
            ///NSLog(@    %@,fontName);
            [_fontArray addObject:fontName];
        }
    }
    self.backgroundColor=[UIColor clearColor];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    // Initialization code
    self.progressView = [[CircleProgressView alloc]
                         initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-18-5-60, 20, 80, 80)
                         withCenter:CGPointMake(60.0 / 2.0, 60 / 2.0)
                         Radius:54 / 2.0
                         lineWidth:6];

   // [self.customView addSubview:progressView];
    
    self.pointImageView.layer.cornerRadius=12;
    
    self.RHbutton = [[UIButton alloc]init];
    
    self.RHbutton.frame = CGRectMake(CGRectGetMinX(self.progressView.frame), CGRectGetMaxY(self.progressView.frame)-5, 60, 20);
   // [self addSubview:self.RHbutton];
//
    [self.RHbutton setTitle:@"立即出借" forState:UIControlStateNormal];
//
    self.RHbutton.titleLabel.font =[UIFont systemFontOfSize: 10.0];
    self.RHbutton.backgroundColor = [RHUtility colorForHex:@"#f89779"];
//
    [self.button addTarget:self action:@selector(toubiao:) forControlEvents:UIControlEventTouchUpInside];
    
    self.button.layer.masksToBounds=YES;
    self.button.layer.cornerRadius=5;
    self.mylab = [[UILabel alloc]init];
    
    
    self.mylab.backgroundColor = [RHUtility colorForHex:@"#44bbc1"];
    
    self.secondlab.hidden = YES;
    [self addSubview:self.mylab];
    self.newpeopleimage.hidden = YES;
    
    self.test=  self.firstlab.frame.size.width*([UIScreen mainScreen].bounds.size.width/320.00);
    self.firstlab.frame = CGRectMake(CGRectGetMinX(self.firstlab.frame), CGRectGetMinY(self.firstlab.frame), self.test, 1);
    
    
}
- (IBAction)rhtoubiao:(id)sender {
    self.myblock();
}

- (void)toubiao:(id)sender{
    
    
    self.myblock();
}
//available = 0;
//fullTime = "2015-03-13 17:09:28";
//id = 36;
//insuranceId = 24;
//insuranceLogo = "pubNews/56b21a0f-4fa3-472d-bd5c-8c63453c9ba9.png";
//insuranceMethod = "\U4e91\U5357\U5408\U5174\U878d\U8d44\U62c5\U4fdd\U80a1\U4efd\U6709\U9650\U516c\U53f8";
//investorRate = 10;
//limitTime = 6;
//logo = "<null>";
//name = "\U755c\U4ea7\U54c1\U751f\U4ea7\U4f01\U4e1a\U6cd5\U4eba\U4ee3\U8868\U7ecf\U8425\U6027\U501f\U6b3e";
//paymentName = "\U6309\U6708\U4ed8\U606f\U3001\U5230\U671f\U8fd8\U672c";
//percent = 100;
//projectFund = 2000000;
//projectStatus = "repayment_normal";
//studentLoan = 0;
-(void)updateCell:(NSDictionary*)dic
{
    self.listlab.hidden = YES;
    if ([self.listres isEqualToString:@"res"]) {
        self.listlab.hidden = NO;
    }
    
    if (![[dic objectForKey:@"monthOrDay"] isKindOfClass:[NSNull class]]&&[dic objectForKey:@"monthOrDay"]){
        
        self.mouthordaylab.text = dic[@"monthOrDay"];
    }else{
        
        self.mouthordaylab.text = @"个月";
    }
    
    if (![[dic objectForKey:@"activityType"] isKindOfClass:[NSNull class]])
    {
        NSString * imagetype = [dic objectForKey:@"activityType"];
        
        NSArray *items = @[@"LineExclusive", @"ActivityExclusive",@"VIPExclusive"];
        NSInteger item = [items indexOfObject:imagetype];
        if (imagetype.length > 1) {
            
       
        switch (item) {
            
            case 0:
                self.xiangouimage.image = [UIImage imageNamed:@"hotxianxia"];
                break;
            case 1:
               self.xiangouimage.image = [UIImage imageNamed:@"hothuodong"];
                break;
            case 2:
                self.xiangouimage.image = [UIImage imageNamed:@"hotvip"];
                break;
            default:
                self.xiangouimage.hidden = YES;
                break;
        }
        }else{
            
            self.xiangouimage.hidden = YES;

        }
        
    }else{
        
        self.xiangouimage.hidden = YES;
    }
    
    NSString* name=@"";
    if (![[dic objectForKey:@"name"] isKindOfClass:[NSNull class]]) {
        name=[dic objectForKey:@"name"];
    }
    self.nameLabel.text=name;
    NSString* paymentName=@"";
    if (![[dic objectForKey:@"paymentName"] isKindOfClass:[NSNull class]]) {
        paymentName=[dic objectForKey:@"paymentName"];
    }
    self.huankuanfangshi.text = paymentName;
    self.paymentNameLabel.text=paymentName;
    NSString* investorRate=@"0";
    NSString * fuhaostr = @"%%";
    if (![[dic objectForKey:@"investorFixedRate"] isKindOfClass:[NSNull class]]) {
        
        investorRate=[[dic objectForKey:@"investorFixedRate"] stringValue];
        CGSize size = [investorRate sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:30],NSFontAttributeName, nil]];
        CGFloat nameW = size.width;
        
        self.investorRateLabel.frame = CGRectMake(self.investorRateLabel.frame.origin.x, self.investorRateLabel.frame.origin.y, nameW+3, self.investorRateLabel.frame.size.height);
        self.fuhaolab.frame = CGRectMake(CGRectGetMaxX(self.investorRateLabel.frame), self.fuhaolab.frame.origin.y, self.fuhaolab.frame.size.width, self.fuhaolab.frame.size.height);
        if (![[dic objectForKey:@"investorAddRate"] isKindOfClass:[NSNull class]]){
            fuhaostr=[[dic objectForKey:@"investorAddRate"] stringValue];
            if ([fuhaostr isEqualToString:@"0"]) {
                fuhaostr = @"%";
//                self.moveview.frame = CGRectMake(CGRectGetMinX(self.moveview.frame)-30, CGRectGetMinY(self.moveview.frame), self.moveview.frame.size.width, self.moveview.frame.size.height);
                
            }else{
                fuhaostr = [NSString stringWithFormat:@"+%@%%",fuhaostr];
            }
        }
        
        
    }
    self.fuhaolab.text = fuhaostr;
    
    self.hidenimage.frame = CGRectMake(CGRectGetMaxX(self.fuhaolab.frame)-5, self.hidenimage.frame.origin.y, self.hidenimage.frame.size.width, self.hidenimage.frame.size.height);
    self.investorRateLabel.text=[NSString stringWithFormat:@"%@",investorRate];
    NSString* limitTime=@"0";
    if (![[dic objectForKey:@"limitTime"] isKindOfClass:[NSNull class]]&&dic[@"limitTime"]) {
        limitTime=[[dic objectForKey:@"limitTime"] stringValue];
        
//        limitTime = [NSString stringWithFormat:@"%@",[dic objectForKey:@"limitTime"]];
                NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:limitTime];
        
                [str1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Light" size:25] range:NSMakeRange(0,str1.length)];
                self.limitTimeLabel.attributedText = str1;
    }
//    self.limitTimeLabel.text=limitTime;
    NSString* projectFund=@"0";
    if (![[dic objectForKey:@"projectFund"] isKindOfClass:[NSNull class]]) {
//        DLog(@"%@",[NSString stringWithFormat:@"%.2f",([[dic objectForKey:@"projectFund"] floatValue]/10000.0)]);
        
        if (self.res) {
            NSString * str = [[dic objectForKey:@"projectFund"] stringByReplacingOccurrencesOfString:@"," withString:@""];
            NSLog(@"%f",[str floatValue]);
            projectFund=[NSString stringWithFormat:@"%.2f",([str floatValue]/10000.0)];
            self.xiangouimage.hidden = NO;
            self.xiangouimage.image = [UIImage imageNamed:@"hotxinshou"];
            self.hidenimage.hidden = NO;
            
            NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:projectFund];
            
            [str1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Light" size:16] range:NSMakeRange(0,str1.length)];
            self.projectFundLabel.attributedText = str1;
            
            
        }else{
            self.hidenimage.hidden = YES;
        NSLog(@"%f",[[dic objectForKey:@"available"] floatValue]);
        projectFund=[NSString stringWithFormat:@"剩余%.2f万元",([[dic objectForKey:@"available"] floatValue]/10000.0)];
           
        if (([[dic objectForKey:@"available"] floatValue]/10000.0)<=0) {
                projectFund=[NSString stringWithFormat:@"总额%.2f万元",([[dic objectForKey:@"projectFund"] floatValue]/10000.0)];
            }
             NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:projectFund];
            [str1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Light" size:16] range:NSMakeRange(0,str1.length)];
            self.projectFundLabel.attributedText = str1;
        }
    }
    //self.projectFundLabel.text=projectFund;
    NSString* insuranceMethod=@"";
    if (![[dic objectForKey:@"insuranceName"] isKindOfClass:[NSNull class]]) {
        insuranceMethod=[dic objectForKey:@"insuranceName"];
    }
    self.insuranceMethodLabel.text=insuranceMethod;
    
    if ([[dic objectForKey:@"insuranceLogo"] isKindOfClass:[NSNull class]]) {
        CGRect rect=self.insuranceMethodLabel.frame;
        rect.origin.x=63;
       // self.insuranceMethodLabel.frame=rect;
        self.logoImageView.hidden=YES;
    }else{
        self.logoImageView.hidden=NO;
        [self.logoImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@common/main/attachment/%@",[RHNetworkService instance].newdoMain,[dic objectForKey:@"insuranceLogo"]]]];
    }
    CGFloat percent=0;
    if (![[dic objectForKey:@"percent"] isKindOfClass:[NSNull class]]) {
        percent=[[dic objectForKey:@"percent"] floatValue]/100.0;
        self.button.userInteractionEnabled = YES;
    }
    if (percent ==1) {
        
//         [self.button setTitle:@"已满标" forState:UIControlStateNormal];
//        self.button.userInteractionEnabled = NO;
//        self.button.backgroundColor = [RHUtility colorForHex:@"#bdbdbe"];
        self.projectjdimage.hidden= YES;
    }
    NSString * projectStatus;
    if (![[dic objectForKey:@"percent"] isKindOfClass:[NSNull class]]) {
        projectStatus=[dic objectForKey:@"projectStatus"] ;
        self.button.userInteractionEnabled = YES;
    }
    if ([projectStatus isEqualToString:@"finished"]) {
        
        [self.button setTitle:@"还款完毕" forState:UIControlStateNormal];
        self.button.userInteractionEnabled = NO;
      self.btnimage.image = [UIImage imageNamed:@"按钮点击后"];
        //按钮点击后
    }else if ([projectStatus isEqualToString:@"repayment_normal"]||[projectStatus isEqualToString:@"repayment_abnormal"]){
        
        [self.button setTitle:@"还款中" forState:UIControlStateNormal];
        self.button.userInteractionEnabled = NO;
        self.btnimage.image = [UIImage imageNamed:@"按钮点击后"];
    }else if ([projectStatus isEqualToString:@"loans"]||[projectStatus isEqualToString:@"loans_audit"]){
        
        [self.button setTitle:@"放款审核" forState:UIControlStateNormal];
        self.button.userInteractionEnabled = NO;
        self.btnimage.image = [UIImage imageNamed:@"按钮点击后"];
    }else if ([projectStatus isEqualToString:@"full"]){
        
        [self.button setTitle:@"已满标" forState:UIControlStateNormal];
        self.button.userInteractionEnabled = NO;
        self.btnimage.image = [UIImage imageNamed:@"按钮点击后"];
    }else if ([projectStatus isEqualToString:@"publishedWaiting"]){
        
       
        [self.button setTitle:@"稍后出借" forState:UIControlStateNormal];
        self.button.userInteractionEnabled = NO;
//        self.button.backgroundColor = [RHUtility colorForHex:@"#bdbdbe"];
//         [self.button setImage:[UIImage imageNamed:@"按钮点击后"] forState:UIControlStateNormal];
        
        self.btnimage.image = [UIImage imageNamed:@"按钮点击后"];
        
    }
    
    NSLog(@"---%f-----%@",percent,self.nameLabel.text);
    CGFloat  width= percent * self.test;
//    self.firstlab.frame = CGRectMake(CGRectGetMinX(self.firstlab.frame), CGRectGetMinY(self.firstlab.frame), self.test, 3);
    self.secondlab.frame = CGRectMake(CGRectGetMinX(self.secondlab.frame), CGRectGetMinY(self.secondlab.frame), width, 1);
    self.projectjdimage.frame = CGRectMake(CGRectGetMaxX(self.secondlab.frame), CGRectGetMinY(self.secondlab.frame)-4, 8, 8);
    if (percent>=1) {
        self.secondlab.hidden = NO;
        self.mylab.hidden = YES;
    }
    self.mylab.frame = CGRectMake(CGRectGetMinX(self.secondlab.frame), CGRectGetMinY(self.secondlab.frame), percent * self.firstlab.frame.size.width, 1);
    NSLog(@"------====%f----%f",self.secondlab.frame.size.width,width);
    
//    [self.progressView setProgress:percent];
//    [self.progressView setTintColor:[UIColor redColor]];
    
    //if ([UIScreen mainScreen].bounds.size.width < 330) {
//        self.investorRateLabel.font = [UIFont boldSystemFontOfSize:18];
//        self.projectFundLabel.font = [UIFont boldSystemFontOfSize:14];
        
//        self.limitTimeLabel.font = [UIFont boldSystemFontOfSize:14];
//        self.nameLabel.font = [UIFont boldSystemFontOfSize:12];
//        self.insuranceMethodLabel.font = [UIFont boldSystemFontOfSize:10];
//        self.huankuanfangshi.font = [UIFont boldSystemFontOfSize:10];
        
//        [self.investor]
//        NSString * str ;
        
      
       NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self.investorRateLabel.text];
        
        [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Medium" size:30] range:NSMakeRange(0,str.length)];
        self.investorRateLabel.attributedText = str;
    
    
//        NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:self.limitTimeLabel.text];
//        
//        [str1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Light" size:25] range:NSMakeRange(0,str1.length)];
//        self.limitTimeLabel.attributedText = str1;
    
    //}
 
    
}

-(void)updatexmjCell:(NSDictionary*)dic{
    self.listlab.hidden = YES;
    if ([self.listres isEqualToString:@"res"]) {
        self.listlab.hidden = NO;
    }
    
    NSString* limitTime=@"0";
    if (![[dic objectForKey:@"period"] isKindOfClass:[NSNull class]]&&dic[@"period"]) {
        limitTime=[NSString stringWithFormat:@"%@",dic[@"period"]];
        
        //        limitTime = [NSString stringWithFormat:@"%@",[dic objectForKey:@"limitTime"]];
        NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:limitTime];
        
        [str1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Light" size:25] range:NSMakeRange(0,str1.length)];
        self.limitTimeLabel.attributedText = str1;
    }
    NSString* name=@"";
    if (![[dic objectForKey:@"name"] isKindOfClass:[NSNull class]]) {
        name=[dic objectForKey:@"name"];
    }
    self.nameLabel.text=name;
    
    NSString* paymentName=@"";
    if (![[dic objectForKey:@"paymentType"] isKindOfClass:[NSNull class]]&&dic[@"paymentType"]) {
        paymentName=[dic objectForKey:@"paymentType"];
    }
    self.huankuanfangshi.text = paymentName;
    
    
    
    NSString* projectFund=@"0";
    if (![[dic objectForKey:@"remainMoney"] isKindOfClass:[NSNull class]]&&dic[@"remainMoney"]) {
        //        DLog(@"%@",[NSString stringWithFormat:@"%.2f",([[dic objectForKey:@"projectFund"] floatValue]/10000.0)]);
        
        if (self.res) {
            NSString * str = [[dic objectForKey:@"remainMoney"] stringByReplacingOccurrencesOfString:@"," withString:@""];
            NSLog(@"%f",[str floatValue]);
            projectFund=[NSString stringWithFormat:@"%.2f",([str floatValue]/10000.0)];
            
            
            self.xiangouimage.hidden = NO;
            self.xiangouimage.image = [UIImage imageNamed:@"hotxinshou"];
            self.hidenimage.hidden = NO;
            
            NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:projectFund];
            
            [str1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Light" size:16] range:NSMakeRange(0,str1.length)];
            self.projectFundLabel.attributedText = str1;
            
            
        }else{
            self.hidenimage.hidden = YES;
            NSLog(@"%f",[[dic objectForKey:@"remainMoney"] floatValue]);
            
            
            projectFund=[NSString stringWithFormat:@"剩余%.2f万元",([[dic objectForKey:@"remainMoney"] floatValue]/10000.0)];
            if (([[dic objectForKey:@"remainMoney"] floatValue]/10000.0)<=0) {
                projectFund=[NSString stringWithFormat:@"总额%.2f万元",([[dic objectForKey:@"totalMoney"] floatValue]/10000.0)];
            }
            
            NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:projectFund];
            
            [str1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Light" size:16] range:NSMakeRange(0,str1.length)];
            
            self.projectFundLabel.attributedText = str1;
        }
    }
    
    NSString * projectStatus;
    if (![[dic objectForKey:@"projectStatus"] isKindOfClass:[NSNull class]]) {
        projectStatus=[dic objectForKey:@"projectStatus"] ;
        self.button.userInteractionEnabled = YES;
    }
    if ([projectStatus isEqualToString:@"finished"]) {
        
        [self.button setTitle:@"还款完毕" forState:UIControlStateNormal];
        self.button.userInteractionEnabled = NO;
        self.btnimage.image = [UIImage imageNamed:@"按钮点击后"];
        
    }else if ([projectStatus isEqualToString:@"repayment_normal"]||[projectStatus isEqualToString:@"repayment_abnormal"]){
        
        [self.button setTitle:@"还款中" forState:UIControlStateNormal];
        self.button.userInteractionEnabled = NO;
        self.btnimage.image = [UIImage imageNamed:@"按钮点击后"];
    }else if ([projectStatus isEqualToString:@"loans"]||[projectStatus isEqualToString:@"loans_audit"]){
        
        [self.button setTitle:@"放款审核" forState:UIControlStateNormal];
        self.button.userInteractionEnabled = NO;
        self.btnimage.image = [UIImage imageNamed:@"按钮点击后"];
    }else if ([projectStatus isEqualToString:@"full"]){
        
        [self.button setTitle:@"已满标" forState:UIControlStateNormal];
        self.button.userInteractionEnabled = NO;
        self.btnimage.image = [UIImage imageNamed:@"按钮点击后"];
    }else if ([projectStatus isEqualToString:@"publishedWaiting"]){
        
        
        [self.button setTitle:@"稍后出借" forState:UIControlStateNormal];
        self.button.userInteractionEnabled = NO;
        self.btnimage.image = [UIImage imageNamed:@"按钮点击后"];
        self.projectFundLabel.text = @"新额度发布中";
        
    }
    
    if (![[dic objectForKey:@"rate"] isKindOfClass:[NSNull class]]&&dic[@"rate"]) {
        NSString *xmjlilv=[NSString stringWithFormat:@"%@",dic[@"rate"]];
        
//        //        limitTime = [NSString stringWithFormat:@"%@",[dic objectForKey:@"limitTime"]];
//        NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:xmjlilv];
//
//        [str1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Light" size:25] range:NSMakeRange(0,str1.length)];
        self.investorRateLabel.text = xmjlilv;
        
        CGSize size = [xmjlilv sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:30],NSFontAttributeName, nil]];
        CGFloat nameW = size.width;
        
        self.investorRateLabel.frame = CGRectMake(self.investorRateLabel.frame.origin.x, self.investorRateLabel.frame.origin.y, nameW+3, self.investorRateLabel.frame.size.height);
        self.fuhaolab.frame = CGRectMake(CGRectGetMaxX(self.investorRateLabel.frame), self.fuhaolab.frame.origin.y, self.fuhaolab.frame.size.width, self.fuhaolab.frame.size.height);
    }
    
}


@end
