//
//  RHShowGiftTableViewCell.h
//  ryhui
//
//  Created by 糊涂虫 on 17/4/12.
//  Copyright © 2017年 stefan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RHShowGiftTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *GiftName;
@property (weak, nonatomic) IBOutlet UILabel *MoneyLab;
@property (weak, nonatomic) IBOutlet UILabel *XianZhiLab;
@property (weak, nonatomic) IBOutlet UILabel *TimeLab;
@property (weak, nonatomic) IBOutlet UIImageView *GiftImage;

@property (weak, nonatomic) IBOutlet UILabel *tytelab;

-(void)setGiftData:(NSDictionary *)dic;
@end
