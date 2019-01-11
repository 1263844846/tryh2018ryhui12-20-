//
//  RHZZListTableViewCell.h
//  ryhui
//
//  Created by 糊涂虫 on 16/3/30.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircleProgressView.h"
typedef void(^QiangGeBlock)();

@interface RHZZListTableViewCell : UITableViewCell
@property(nonatomic,copy)QiangGeBlock myblock;
@property(nonatomic,strong)UIButton * RHbutton;
@property(nonatomic,strong)NSString * lilv;
@property(nonatomic,strong)CircleProgressView* progressView;

@property (weak, nonatomic) IBOutlet UIView *custView;

@property (weak, nonatomic) IBOutlet UILabel *namelab;

@property (weak, nonatomic) IBOutlet UILabel *moneylab;
@property (weak, nonatomic) IBOutlet UILabel *timelab;

@property (weak, nonatomic) IBOutlet UILabel *lilvlab;
@property (weak, nonatomic) IBOutlet UILabel *dblab;
@property (weak, nonatomic) IBOutlet UILabel *fuxifangshilab;

-(void)updateCell:(NSDictionary*)dic;
@end
