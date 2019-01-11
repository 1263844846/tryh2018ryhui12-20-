//
//  RHZZTableViewCell.m
//  ryhui
//
//  Created by 糊涂虫 on 16/3/18.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import "RHZZTableViewCell.h"
#import "RHUtility.h"

@implementation RHZZTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    
    
    
    
    
    
//    CGFloat w = [UIScreen mainScreen].bounds.size.width;
//    
//    self.nianhualab = [[UILabel alloc]init];
//    self.nianhualab.frame = CGRectMake(0, 17, w/3, 34);
//    self.nianhualab.textAlignment = NSTextAlignmentCenter;
//    self.nianhualab.font = [UIFont systemFontOfSize: 16.0];
//    self.nianhualab.text = @"12%";
//    
//    [self.secondview addSubview:self.nianhualab];
//    
//    self.kzlab = [[UILabel alloc]init];
//    self.kzlab.frame = CGRectMake(CGRectGetMaxX(self.nianhualab.frame), 17, w/3, 34);
//    self.kzlab.textAlignment = NSTextAlignmentCenter;
//    self.kzlab.font = [UIFont systemFontOfSize: 16.0];
//    self.kzlab.text = @"1000000";
//    [self.secondview addSubview:self.kzlab];
//    
//    
//    self.gongyunlab = [[UILabel alloc]init];
//    self.gongyunlab.frame = CGRectMake(CGRectGetMaxX(self.kzlab.frame), 17, w/3, 34);
//    self.gongyunlab.textAlignment = NSTextAlignmentCenter;
//    self.gongyunlab.font = [UIFont systemFontOfSize: 16.0];
//    self.gongyunlab.text = @"1111111";
//    [self.secondview addSubview:self.gongyunlab];
//    
//    UILabel * lab1 = [[UILabel alloc]init];
//    lab1.frame =CGRectMake(0, 50, w/3, 21);
//    lab1.textAlignment = NSTextAlignmentCenter;
//    lab1.font = [UIFont systemFontOfSize: 15.0];
//    lab1.textColor = [RHUtility colorForHex:@"#e4e6e6"];
//    lab1.text = @"原标年华";
//    [self.secondview addSubview:lab1];
//    UILabel * lab2 = [[UILabel alloc]init];
//    lab2.frame =CGRectMake(CGRectGetMaxX(lab1.frame), 50, w/3, 21);
//    lab2.textAlignment = NSTextAlignmentCenter;
//    lab2.font = [UIFont systemFontOfSize: 15.0];
//    lab2.text = @"可转金额(元)";
//    lab2.textColor = [RHUtility colorForHex:@"#e4e6e6"];
//    [self.secondview addSubview:lab2];
//    UILabel * lab3 = [[UILabel alloc]init];
//    lab3.frame =CGRectMake(CGRectGetMaxX(lab2.frame), 50, w/3, 21);
//    lab3.textAlignment = NSTextAlignmentCenter;
//    lab3.font = [UIFont systemFontOfSize: 15.0];
//    lab3.text = @"公允价值(元)";
//    lab3.textColor = [RHUtility colorForHex:@"#e4e6e6"];
//    [self.secondview addSubview:lab3];
//    
//    UILabel * lab4 = [[UILabel alloc]init];
//    
//    lab4.frame = CGRectMake(CGRectGetMaxX(lab1.frame), 16, 1,53);
//    lab4.backgroundColor = [RHUtility colorForHex:@"#e4e6e6"];
//    [self.secondview addSubview:lab4];
//    
//    UILabel * lab5=[[UILabel alloc]init];
//    lab5.frame = CGRectMake(CGRectGetMaxX(lab2.frame), 16, 1,53);
//    lab5.backgroundColor = [RHUtility colorForHex:@"#e4e6e6"];
//    [self.secondview addSubview:lab5];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)zhaunrang:(id)sender {
    
    
    NSLog(@"zzzzzzz");
}
- (IBAction)xiangqing:(id)sender {
    
    NSLog(@"111111");
    
}

-(void)updateCell:(NSDictionary*)dic with:(NSString*)type{
    
    if ([type isEqualToString:@"1"]) {
        self.hkjhimage.hidden = YES;
        self.hkjhlabble.hidden = YES;
        self.zrbutton.hidden = YES;
        self.secondmoneylab.text = @"已转金额(元)";
        self.threemoneylab.text = @"实际到账(元)";
        self.shengyulab.hidden = YES;
    }else if ([type isEqualToString:@"2"]){
        

        self.shengyulab.hidden = YES;
        self.hkjhimage.hidden = YES;
        self.hkjhlabble.hidden = YES;
        self.zrbutton.hidden = YES;
        self.secondmoneylab.text = @"转出金额(元)";
        self.threemoneylab.text = @"实际到账(元)";
        
    }else{
        self.detailebtn.hidden = YES;
        self.lasttimelab.hidden = YES;
    }
}

@end
