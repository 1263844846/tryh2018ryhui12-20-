//
//  RHBankLXTableViewCell.h
//  ryhui
//
//  Created by 糊涂虫 on 17/8/17.
//  Copyright © 2017年 stefan. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^bankblock)() ;
@interface RHBankLXTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *bankname;
@property (weak, nonatomic) IBOutlet UILabel *addresslab;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *bankcardnum;



@end
