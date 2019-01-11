//
//  RHJLTableViewCell.h
//  ryhui
//
//  Created by 糊涂虫 on 16/2/22.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RHJLTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timelab;
@property (weak, nonatomic) IBOutlet UILabel *lab;
@property (weak, nonatomic) IBOutlet UILabel *moneylab;
@property (weak, nonatomic) IBOutlet UIImageView *image;
-(void)updatacell:(NSDictionary *)dic;
@property (weak, nonatomic) IBOutlet UILabel *imagelab;
@end
