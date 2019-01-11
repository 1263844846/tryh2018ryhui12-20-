//
//  RHXFDTableViewCell.h
//  ryhui
//
//  Created by 糊涂虫 on 16/9/1.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RHXFDTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *namelab;
@property (weak, nonatomic) IBOutlet UILabel *numberlab;
@property (weak, nonatomic) IBOutlet UILabel *monlab;
@property (weak, nonatomic) IBOutlet UILabel *firstlab;

-(void)updata:(NSDictionary *)dic withnum:(NSInteger)inter;
@end
