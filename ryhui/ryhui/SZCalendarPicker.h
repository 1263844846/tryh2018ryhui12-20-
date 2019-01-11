//
//  SZCalendarPicker.h
//  SZCalendarPicker
//
//  Created by Stephen Zhuang on 14/12/1.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^QiangGeBlock)(NSString * qq);
typedef void(^myblock) (NSString * qwe);
@interface SZCalendarPicker : UIView<UICollectionViewDelegate , UICollectionViewDataSource>
@property (nonatomic , strong) NSDate *date;
@property (nonatomic , strong) NSDate *today;

@property(nonatomic,strong)NSMutableArray * datearray;
@property(nonatomic,strong)NSMutableArray * timearray;
@property(nonatomic,copy)QiangGeBlock myblock;
@property(nonatomic,copy)myblock dayblock;

@property (nonatomic, copy) void(^calendarBlock)(NSInteger day, NSInteger month, NSInteger year);

+ (instancetype)showOnView:(UIView *)view;
@end
