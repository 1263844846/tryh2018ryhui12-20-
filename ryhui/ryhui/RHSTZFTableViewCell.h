//
//  RHSTZFTableViewCell.h
//  ryhui
//
//  Created by 糊涂虫 on 2018/5/17.
//  Copyright © 2018年 stefan. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^STZFBlock)();
@interface RHSTZFTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *namelab;
@property (weak, nonatomic) IBOutlet UILabel *moneylab;
@property (weak, nonatomic) IBOutlet UILabel *qixianlab;
@property (weak, nonatomic) IBOutlet UILabel *sqtimelab;
@property (weak, nonatomic) IBOutlet UIButton *sqbtn;
@property(nonatomic,copy)STZFBlock myblock;


@end
