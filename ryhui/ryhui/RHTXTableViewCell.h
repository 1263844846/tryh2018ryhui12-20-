//
//  RHTXTableViewCell.h
//  ryhui
//
//  Created by 糊涂虫 on 16/3/21.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^cbxhiddenBlock)();


@interface RHTXTableViewCell : UITableViewCell

@property(nonatomic,copy)cbxhiddenBlock myblock;
@property (weak, nonatomic) IBOutlet UILabel *yhanglab;
@property (weak, nonatomic) IBOutlet UILabel *kahaolab;


-(void)updateCell:(NSDictionary*)dic;
@end
