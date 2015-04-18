//
//  UIViewController+NoData.h
//  ryhui
//
//  Created by 江 云龙 on 15/4/18.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (NoData)
-(void)showNoDataWithFrame:(CGRect)frame insertView:(UIView*)insetView;
-(void)hiddenNoData;
@end
