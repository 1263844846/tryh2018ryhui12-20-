//
//  RHJLTableViewCell.m
//  ryhui
//
//  Created by 糊涂虫 on 16/2/22.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import "RHJLTableViewCell.h"

@implementation RHJLTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.imagelab.layer.masksToBounds=YES;
    self.imagelab.layer.cornerRadius=17;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updatacell:(NSDictionary *)dic{
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:@"###,##0.00;"];
    if (![dic[@"type"] isKindOfClass:[NSNull class]]||dic[@"type"]) {
        
        if ([dic[@"type"]isEqualToString:@""]) {
            self.lab.text = @"充值";
        }
    }
    
    if (![dic[@"money"] isKindOfClass:[NSNull class]]||dic[@"money"]) {
        self.moneylab.text = [NSString stringWithFormat:@"%@",dic[@"money"]] ;
        NSString * money = dic[@"money"];
        NSString *formattedNumberString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble: [money doubleValue] ]];
        
//        self.moneylab.backgroundColor = [UIColor redColor];
//        self.moneylab.frame = CGRectMake(CGRectGetMinX(self.moneylab.frame)-20, CGRectGetMinY(self.moneylab.frame), self.moneylab.frame.size.width+60, self.moneylab.frame.size.height);
        self.moneylab.text = formattedNumberString;
        self.moneylab.font = [UIFont systemFontOfSize:14];
//        self.moneylab.textColor = [RHUtility colorForHex:@"#44bbc1"];
        self.moneylab.textAlignment = NSTextAlignmentRight;
    }
    if (![dic[@"dateCreated"] isKindOfClass:[NSNull class]]||dic[@"dateCreated"]) {
        self.timelab.text = [NSString stringWithFormat:@"%@",dic[@"dateCreated"]];
     }
//    NSLog(@"%@",dic);
}

@end
