//
//  RHMyNewGiftTableViewCell.h
//  ryhui
//
//  Created by 糊涂虫 on 15/7/20.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RHMyNewGiftTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *RMBLabel;   //人民币小图标
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;   //红包金额
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;   //  红包类型（投资现金。。。）
@property (weak, nonatomic) IBOutlet UILabel *effectNoticeLabel;    //用途
@property (weak, nonatomic) IBOutlet UILabel *validTimeLabel;    // 有效期／使用时间／过期时间
@property (weak, nonatomic) IBOutlet UILabel *conditionLabel;    // 使用条件
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;    // 红包来源
@property (weak, nonatomic) IBOutlet UIImageView *backGroundImage;    // 背景图片
@property (weak, nonatomic) IBOutlet UIButton *giftTypeButton;    //投资／兑换按钮
@property (weak, nonatomic) IBOutlet UIButton *clickButton;

-(void)updateCell:(NSDictionary*)dic with:(NSString*)type;

@end
