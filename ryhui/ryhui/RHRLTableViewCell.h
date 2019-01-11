//
//  RHRLTableViewCell.h
//  ryhui
//
//  Created by 糊涂虫 on 16/3/23.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RHRLTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *datelab;
@property (weak, nonatomic) IBOutlet UILabel *namelab;
@property (weak, nonatomic) IBOutlet UILabel *mouneylab;
@property (weak, nonatomic) IBOutlet UILabel *typenamelab;
@property (weak, nonatomic) IBOutlet UIImageView *typeImagView;

-(void)updata:(NSDictionary *)dic;
@end
