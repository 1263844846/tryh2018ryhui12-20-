//
//  RHXMJXQTableViewCell.h
//  ryhui
//
//  Created by 糊涂虫 on 2018/6/21.
//  Copyright © 2018年 stefan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RHXMJXQTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *namelab;
@property (weak, nonatomic) IBOutlet UILabel *zongelab;
@property (weak, nonatomic) IBOutlet UILabel *yuelab;

-(void)updatemydata:(NSDictionary * )dic;

@end
