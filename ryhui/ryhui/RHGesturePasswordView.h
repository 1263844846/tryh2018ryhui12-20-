//
//  RHGesturePasswordView.h
//  ryhui
//
//  Created by stefan on 15/2/28.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

@protocol GesturePasswordDelegate <NSObject>

- (void)forget;
- (void)change;
-(void)cleanPan;
-(void)enterPan;

@end

#import <UIKit/UIKit.h>
#import "RHGestureView.h"

@interface RHGesturePasswordView : UIView

@property (nonatomic,strong) RHGestureView * tentacleView;
@property (nonatomic,strong) UILabel * state;
@property (nonatomic,assign) id<GesturePasswordDelegate> gesturePasswordDelegate;
@property (nonatomic,strong) UIImageView * imgView;
@property (nonatomic,strong) UIButton * forgetButton;
@property (nonatomic,strong) UIButton * changeButton;
@property (nonatomic,strong) UIButton * clearButton;
@property (nonatomic,strong) UIButton * enterButton;


@end
