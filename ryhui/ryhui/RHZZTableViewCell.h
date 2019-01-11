//
//  RHZZTableViewCell.h
//  ryhui
//
//  Created by 糊涂虫 on 16/3/18.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RHZZTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *secondview;

@property(nonatomic,copy)NSString * type;
@property (weak, nonatomic) IBOutlet UILabel *kezhuanlab;

@property(nonatomic,strong)UILabel * nianhualab;
@property(nonatomic,strong)UILabel * kzlab;
@property(nonatomic,strong)UILabel * gongyunlab;

@property (weak, nonatomic) IBOutlet UILabel *lasttimelab;
@property (weak, nonatomic) IBOutlet UIButton *detailebtn;
@property (weak, nonatomic) IBOutlet UILabel *nhlab;
@property (weak, nonatomic) IBOutlet UILabel *kzmoneylab;
@property (weak, nonatomic) IBOutlet UILabel *gongyunmoneylab;
@property (weak, nonatomic) IBOutlet UILabel *firstnhlab;
@property (weak, nonatomic) IBOutlet UILabel *secondmoneylab;
@property (weak, nonatomic) IBOutlet UILabel *threemoneylab;
@property (weak, nonatomic) IBOutlet UILabel *shengyulab;
@property (weak, nonatomic) IBOutlet UIButton *zrbutton;
@property (weak, nonatomic) IBOutlet UIImageView *hkjhimage;
@property (weak, nonatomic) IBOutlet UILabel *hkjhlabble;

-(void)updateCell:(NSDictionary*)dic with:(NSString*)type;
@end
