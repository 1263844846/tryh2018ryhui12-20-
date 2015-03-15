//
//  CircleProgressView.h
//  HelloWordWithRootView
//
//  Created by siver on 12-3-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#define dev 7

@protocol CircleProgressViewDelegate;

typedef enum {
    TOUCHSTATUSEND = 0,
    TOUCHSTATUSBEGIN,
    TOUCHSTATUSMOVE,
    TOUCHSTATUSINPLAY
}TOUCHSTATUS;


@interface CircleProgressView : UIView{
    CGPoint center;
    CGFloat radius;
    double progress;
    CGFloat linewidth;
    double lastdegree;
    TOUCHSTATUS status;
    BOOL seekable;
    id <CircleProgressViewDelegate> delegate;
    BOOL lock;
    
}

- (id)initWithFrame:(CGRect)frame withCenter:(CGPoint)acenter Radius:(CGFloat)aradius lineWidth:(CGFloat)width;

@property (nonatomic) CGPoint center;
@property (nonatomic) BOOL lock;

@property (nonatomic) TOUCHSTATUS status;
@property (nonatomic) CGFloat radius;
@property (nonatomic) CGFloat linewidth;
@property (nonatomic) BOOL seekable;
@property (nonatomic, assign) id <CircleProgressViewDelegate> delegate;

- (void)setProgress:(double)newProgress;

@end

@protocol CircleProgressViewDelegate <NSObject>
@optional

- (void)hasSeekToEnd:(CircleProgressView *)circle;
- (void)hasSeekToBegin:(CircleProgressView *)circle;
- (void)seekToProgress:(double)newProgress;
- (void)touchInPlayArea:(CircleProgressView *)circle;
- (void)touchOutPlayArea:(CircleProgressView *)circle;
- (void)finishPlayClick:(CircleProgressView *)circle;
- (void)touchingProgress:(CircleProgressView *)circle;
- (void)moveoutProgress:(CircleProgressView *)circle;

@end
