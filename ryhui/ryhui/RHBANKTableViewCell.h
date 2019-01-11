//
//  RHBANKTableViewCell.h
//  ryhui
//
//  Created by 糊涂虫 on 16/4/20.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RHBANKTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *bankimage;
@property (weak, nonatomic) IBOutlet UILabel *bankname;
@property (weak, nonatomic) IBOutlet UILabel *bankcard;
@property (weak, nonatomic) IBOutlet UILabel *lab;

@property (weak, nonatomic) IBOutlet UIButton *RemoveButton;
- (void)updatacell:(NSArray *)dic;

@end
