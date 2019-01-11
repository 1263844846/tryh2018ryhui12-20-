//
//  RHRLTableViewCell.m
//  ryhui
//
//  Created by 糊涂虫 on 16/3/23.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import "RHRLTableViewCell.h"

@implementation RHRLTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updata:(NSDictionary *)dic{
    
    if (!dic[@"projectName"]|| ![dic[@"projectName"] isKindOfClass:[NSNull class]]) {
        
        self.namelab.text = dic[@"projectName"];
    }
//       self.namelab.text = dic[@"projectName"];
//    }
    
    
    CGFloat mony  = [[NSString stringWithFormat:@"%@",dic[@"money"]] integerValue];
    
    self.mouneylab.text = [NSString stringWithFormat:@"%@",dic[@"money"]];
    
    self.datelab.text = dic[@"payDate"];
    self.typenamelab.text =  dic[@"typeName"];
    NSString* status=nil;
    if ([[dic objectForKey:@"status"] isKindOfClass:[NSNumber class]]) {
        status=[[dic objectForKey:@"status"] stringValue];
    }else{
        status=[dic objectForKey:@"status"];
    }
    if ([status isEqualToString:@"0"]) {
        
        self.typeImagView.image= [UIImage imageNamed:@"融益汇app完整wh"];
    }else{
        
        self.typeImagView.image= [UIImage imageNamed:@"融益汇app完整hk"];
    }
}

@end
