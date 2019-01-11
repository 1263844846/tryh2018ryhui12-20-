//
//  CycleScrollView.h
//  PagedScrollView
//
//  Created by 陈政 on 14-1-23.
//  Copyright (c) 2014年 Apple Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PRJ_ScrollPageControl.h"
@interface CycleScrollView : UIView

@property (nonatomic , readonly) UIScrollView *scrollView;
/**
 *  初始化
 *
 *  @param frame             frame
 *  @param animationDuration 自动滚动的间隔时长。如果<=0，不自动滚动。
 *
 *  @return instance
 */
- (id)initWithFrame:(CGRect)frame animationDuration:(NSTimeInterval)animationDuration;

/**
 数据源：获取总的page个数
 **/
@property (nonatomic , copy) NSInteger (^totalPagesCount)(void);
/**
 数据源：获取第pageIndex个位置的contentView
 **/
@property (nonatomic , copy) UIView *(^fetchContentViewAtIndex)(NSInteger pageIndex);
/**
 当点击的时候，执行的block
 **/
@property (nonatomic , copy) void (^TapActionBlock)(NSInteger pageIndex);

@property (nonatomic , strong) NSTimer *animationTimer;

@property (nonatomic, strong) PRJ_ScrollPageControl *pageControll;
/*
 *2014.12.02 YX      添加轮播图下面的文字说明 以及页数及当前页数的指示器  默认显示指示器
 *@param    openImageDetails  是否显示文字    0 不显示文字    1.显示文字
 *@param    details  底部文字的集合
 *@param    state    控制pagecontroll的位置   1 左边    2 中间  3 右边
 */

-(void) openThePageControllAndIsOpenImageDetails:(BOOL)openImageDetails andTheDetails:(NSArray *)details andState:(int)state;

@end