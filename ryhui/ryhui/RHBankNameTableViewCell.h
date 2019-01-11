//
//  RHBankNameTableViewCell.h
//  ryhui
//
//  Created by 糊涂虫 on 16/7/14.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RHBankNameTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labname;

-(void)updateCell:(NSDictionary *)dic;
@end
