//
//  RHChooseGiftViewCell.h
//  ryhui
//
//  Created by jufenghudong on 15/4/14.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RHChooseGiftViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UILabel *threshodLabel;
@property (weak, nonatomic) IBOutlet UILabel *usingTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (nonatomic,assign)int investNum;

-(void)updateCell:(NSDictionary*)dic;

@end
