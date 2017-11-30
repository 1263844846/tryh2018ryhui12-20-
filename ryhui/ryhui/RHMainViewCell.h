//
//  RHMainViewCell.h
//  ryhui
//
//  Created by stefan on 15/3/14.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircleProgressView.h"
typedef void(^QiangGeBlock)();

@interface RHMainViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *button;
@property(nonatomic,copy)QiangGeBlock myblock;
@property(nonatomic,strong)UIButton * RHbutton;
@property (weak, nonatomic) IBOutlet UIView *customView;
@property(nonatomic,strong)CircleProgressView* progressView;
//期限
@property (weak, nonatomic) IBOutlet UILabel *limitTimeLabel;
//利率
@property (weak, nonatomic) IBOutlet UILabel *investorRateLabel;
//担保方
@property (weak, nonatomic) IBOutlet UILabel *insuranceMethodLabel;
//总金额
@property (weak, nonatomic) IBOutlet UILabel *projectFundLabel;
//mingzi
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
//
@property (weak, nonatomic) IBOutlet UILabel *paymentNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *pointImageView;
@property(nonatomic,strong)NSString * lilv;
//还款方式
@property (weak, nonatomic) IBOutlet UILabel *huankuanfangshi;
@property (weak, nonatomic) IBOutlet UIImageView *xiangouimage;
@property (weak, nonatomic) IBOutlet UILabel *fuhaolab;

-(void)updateCell:(NSDictionary*)dic;
@property (weak, nonatomic) IBOutlet UILabel *firstlab;

@property (weak, nonatomic) IBOutlet UILabel *secondlab;

@property(nonatomic,strong)NSMutableArray * fontArray;

@property(nonatomic,assign)BOOL res;
@property (weak, nonatomic) IBOutlet UIImageView *hidenimage;

@property(strong,nonatomic)UILabel * mylab;
@property (weak, nonatomic) IBOutlet UIView *moveview;
@property (weak, nonatomic) IBOutlet UIImageView *newpeopleimage;
@property (weak, nonatomic) IBOutlet UILabel *mouthordaylab;

@property (weak, nonatomic) IBOutlet UIImageView *projectjdimage;
@property(nonatomic,assign)CGFloat test;
@end
