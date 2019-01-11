//
//  RHNewMainCell.m
//  ryhui
//
//  Created by 糊涂虫 on 16/1/20.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import "RHNewMainCell.h"

@implementation RHNewMainCell

- (void)awakeFromNib {
    // Initialization code
    //self.backgroundColor=[UIColor clearColor];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    // Initialization code
//    self.progressView = [[CircleProgressView alloc]
//                         initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-5-60, 23, 60, 60)
//                         withCenter:CGPointMake(50.0 / 2.0, 54 / 2.0)
//                         Radius:40 / 2.0
//                         lineWidth:4];
//    [self.progressView setProgress:0.5];
//    [self addSubview:self.progressView];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)updataNewPeopleCell:(NSDictionary *)dic{
    
    self.RHrate.text = [NSString stringWithFormat:@"%@",dic[@"investorRate"]];
    self.RHmouth.text = [NSString stringWithFormat:@"%@",dic[@"limitTime"]];
    self.RHmoney.text = [NSString stringWithFormat:@"%@",dic[@"paymentName"]];
    if (![[dic objectForKey:@"monthOrDay"] isKindOfClass:[NSNull class]]&&[dic objectForKey:@"monthOrDay"]){
        
        self.mouthordaylab.text = dic[@"monthOrDay"];
    }else{
        
        self.mouthordaylab.text = @"个月";
    }
    
}
-(void)layoutSubviews{
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    
//    self.RHrate.frame = CGRectMake(23 +10, 30, w-30-60/8, 30);
//    
//    self.RHpct.frame = CGRectMake(CGRectGetMaxX(self.RHrate.frame) + 30, 30, 20, 30);
//    
//    self.RHmouth.frame = CGRectMake(CGRectGetMaxX(self.RHpct.frame) + 30, 30, 20, 30);
}
@end
