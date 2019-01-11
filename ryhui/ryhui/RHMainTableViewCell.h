//
//  RHMainTableViewCell.h
//  ryhui
//
//  Created by 糊涂虫 on 16/3/11.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CircleProgressView.h"
typedef void(^QiangGeBlock)();

@interface RHMainTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UICollectionView *collectionview;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *colleclayout;
@property(nonatomic,strong)UINavigationController *nav;
-(void)updateCell:(NSArray*)array;

@end
