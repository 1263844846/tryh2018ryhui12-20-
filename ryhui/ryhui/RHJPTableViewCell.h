//
//  RHJPTableViewCell.h
//  ryhui
//
//  Created by 糊涂虫 on 16/4/15.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RHJPTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *giftname;
@property (weak, nonatomic) IBOutlet UILabel *onfromlab;
@property (weak, nonatomic) IBOutlet UILabel *datetime;

@property (weak, nonatomic) IBOutlet UILabel *mailmethod;

-(void)updata:(NSDictionary *)dic;
@end
