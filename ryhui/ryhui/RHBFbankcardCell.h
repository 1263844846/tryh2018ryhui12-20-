//
//  RHBFbankcardCell.h
//  ryhui
//
//  Created by 糊涂虫 on 2018/1/18.
//  Copyright © 2018年 stefan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RHBFbankcardCell : UITableViewCell

@property(nonatomic,copy)NSString * ress;
@property (weak, nonatomic) IBOutlet UILabel *bankcarknumlab1;
@property (weak, nonatomic) IBOutlet UILabel *xianelab1;
@property (weak, nonatomic) IBOutlet UILabel *banknamelab1;

@property (weak, nonatomic) IBOutlet UIImageView *logoiamge1;
@property (weak, nonatomic) IBOutlet UIImageView *xuanzhongimage;


@property (weak, nonatomic) IBOutlet UIView *removeview;
@property (weak, nonatomic) IBOutlet UIImageView *logoimage;

@property (weak, nonatomic) IBOutlet UIImageView *removeimage;
@property (weak, nonatomic) IBOutlet UILabel *banknamelab;
@property (weak, nonatomic) IBOutlet UILabel *bankcardnumlab;
@property (weak, nonatomic) IBOutlet UILabel *xiaelab;


-(void)updatemydata:(NSDictionary *)dic;
@end
