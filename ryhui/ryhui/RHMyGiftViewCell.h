//
//  RHMyGiftViewCell.h
//  ryhui
//
//  Created by jufenghudong on 15/4/14.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RHMyGiftViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIImageView *iconimageView;

@property (weak, nonatomic) IBOutlet UILabel *threshodLabel;
@property (weak, nonatomic) IBOutlet UILabel *usingTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *activityNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

-(void)updateCell:(NSDictionary*)dic with:(NSString*)type;

@end
