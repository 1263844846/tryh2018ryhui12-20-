//
//  RHGesturePasswordView.m
//  ryhui
//
//  Created by stefan on 15/2/28.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHGesturePasswordView.h"
#import "RHGesturePasswordButton.h"


@implementation RHGesturePasswordView{
    NSMutableArray * buttonArray;
    
    CGPoint lineStartPoint;
    CGPoint lineEndPoint;
    
}
@synthesize imgView;
@synthesize forgetButton;
@synthesize changeButton;
@synthesize clearButton;
@synthesize enterButton;

@synthesize tentacleView;
@synthesize state;
@synthesize gesturePasswordDelegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        buttonArray = [[NSMutableArray alloc]initWithCapacity:0];
        self.backgroundColor=[RHUtility colorForHex:@"#318fc5"];
        
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(frame.size.width/2-160, frame.size.height/2-80, 320, 320)];
        for (int i=0; i<9; i++) {
            NSInteger row = i/3;
            NSInteger col = i%3;
            // Button Frame
            
            NSInteger distance = 320/3;
            NSInteger size = distance/1.7;
            NSInteger yPoint = size+30;
            NSInteger margin = size/2+5;
            if ([UIScreen mainScreen].bounds.size.height>480) {
                size=distance/1.7;
                margin =size/4 + 8;
                yPoint=distance;
            }
            
            RHGesturePasswordButton * gesturePasswordButton = [[RHGesturePasswordButton alloc]initWithFrame:CGRectMake(col*yPoint+margin, row*yPoint - 10, size, size)];
            [gesturePasswordButton setTag:i];
            [view addSubview:gesturePasswordButton];
            [buttonArray addObject:gesturePasswordButton];
        }
        frame.origin.y=0;
        [self addSubview:view];
        tentacleView = [[RHGestureView alloc]initWithFrame:view.frame];
        [tentacleView setButtonArray:buttonArray];
        [tentacleView setTouchBeginDelegate: self];
        [self addSubview:tentacleView];
        
        state = [[UILabel alloc]initWithFrame:CGRectMake(frame.size.width/2-140, frame.size.height/2-120, 280, 30)];
        [state setTextAlignment:NSTextAlignmentCenter];
        [state setFont:[UIFont systemFontOfSize:14.f]];
        [self addSubview:state];
        
        CGRect imageRect=CGRectMake(frame.size.width/2-39,40, 80, 80);
        if ([UIScreen mainScreen].bounds.size.height>480) {
            imageRect=CGRectMake(frame.size.width/2-49, frame.size.width/2-100, 100, 100);
        }
        imgView = [[UIImageView alloc]initWithFrame:imageRect];
        [imgView setBackgroundColor:[UIColor clearColor]];
        [imgView.layer setCornerRadius:35];
        [imgView setImage:[UIImage imageNamed:@"GestureIcon.png"]];
        [self addSubview:imgView];
        
        forgetButton = [[UIButton alloc]initWithFrame:CGRectMake(frame.size.width/2-150, frame.size.height-70, 120, 30)];
        [forgetButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [forgetButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [forgetButton setTitle:@"忘记手势密码" forState:UIControlStateNormal];
        [forgetButton addTarget:self action:@selector(forget) forControlEvents:UIControlEventTouchDown];
        [self addSubview:forgetButton];
        
        changeButton = [[UIButton alloc]initWithFrame:CGRectMake(frame.size.width/2+30, frame.size.height-70, 120, 30)];
        [changeButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [changeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [changeButton setTitle:@"用其他账号登录" forState:UIControlStateNormal];
        [changeButton addTarget:self action:@selector(change) forControlEvents:UIControlEventTouchDown];
        [self addSubview:changeButton];
        
        clearButton = [[UIButton alloc]initWithFrame:CGRectMake(frame.size.width/2-150, frame.size.height-70, 120, 30)];
        [clearButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [clearButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [clearButton setTitle:@"重绘" forState:UIControlStateNormal];
        [clearButton addTarget:self action:@selector(cleanPan) forControlEvents:UIControlEventTouchDown];
        [self addSubview:clearButton];
        
        enterButton = [[UIButton alloc]initWithFrame:CGRectMake(frame.size.width/2+30, frame.size.height-70, 120, 30)];
        [enterButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [enterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [enterButton setTitle:@"继续" forState:UIControlStateNormal];
        [enterButton addTarget:self action:@selector(enterPan) forControlEvents:UIControlEventTouchDown];
        [self addSubview:enterButton];
        
        [self.clearButton setHidden:YES];
        [self.enterButton setHidden:YES];

    }
    
    return self;
}

//// Only override drawRect: if you perform custom drawing.
//// An empty implementation adversely affects performance during animation.
//
//- (void)drawRect:(CGRect)rect
//{
//    // Drawing code
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
//    CGFloat colors[] =
//    {
//        134 / 255.0, 157 / 255.0, 147 / 255.0, 1.00,
//        3 / 255.0,  3 / 255.0, 37 / 255.0, 1.00,
//    };
//    CGGradientRef gradient = CGGradientCreateWithColorComponents
//    (rgb, colors, NULL, sizeof(colors)/(sizeof(colors[0])*4));
//    CGColorSpaceRelease(rgb);
//    CGContextDrawLinearGradient(context, gradient,CGPointMake
//                                (0.0,0.0) ,CGPointMake(0.0,self.frame.size.height),
//                                kCGGradientDrawsBeforeStartLocation);
//}

- (void)gestureTouchBegin {
    [self.state setText:@""];
}

- (void)gestureStateWithText:(NSString*)text
{
    [self.state setTextColor:[UIColor redColor]];
    [self.state setText:text];
}

-(void)forget{
    [gesturePasswordDelegate forget];
}

-(void)change{
    [gesturePasswordDelegate change];
}

-(void)cleanPan{

    [gesturePasswordDelegate cleanPan];
}

-(void)enterPan{
    [gesturePasswordDelegate enterPan];
}

@end
