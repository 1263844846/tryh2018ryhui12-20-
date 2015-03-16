//
//  AISegmentContentView.h
//  AISegmentViewController
//
//  Created by ops on 14-1-6.
//  Copyright (c) 2014 iiApple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RHSegmentContentViewDelegate;

@interface RHSegmentContentView : UIView

@property (nonatomic, assign) NSUInteger pageCount;
@property (nonatomic, strong) NSArray *views;
@property (nonatomic, assign) id <RHSegmentContentViewDelegate> delegate;
@property (nonatomic, assign) NSUInteger selectPage;




/**
 *	@brief	添加一个视图到某一页
 *
 *	@param 	view 	单个视图
 *	@param 	page 	指定要插入的页码
 */
- (void)addView:(UIView *)view
         atPage:(NSUInteger)page;


@end

@protocol RHSegmentContentViewDelegate <NSObject>


- (void)segmentContentView:(RHSegmentContentView *)segmentContentView
                selectPage:(NSUInteger)page;

@end
