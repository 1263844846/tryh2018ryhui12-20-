//
//  RHMyFriendTableViewCell.h
//  ryhui
//
//  Created by 糊涂虫 on 16/7/7.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RHMyFriendTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *namelab;
@property (weak, nonatomic) IBOutlet UILabel *Llisttime;
@property (weak, nonatomic) IBOutlet UILabel *friendmoney;
@property (weak, nonatomic) IBOutlet UILabel *mymoney;

- (void)updata:(NSDictionary *)dic;
@end
