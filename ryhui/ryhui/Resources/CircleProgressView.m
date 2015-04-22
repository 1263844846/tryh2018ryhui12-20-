//
//  CircleProgressView.m
//  HelloWordWithRootView
//
//  Created by siver on 12-3-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CircleProgressView.h"

@interface CircleProgressView ()

@property (nonatomic, strong) UILabel *text;

@end

@implementation CircleProgressView

@synthesize center, radius, linewidth, delegate = _delegate, status, seekable, lock;

- (id)initWithFrame:(CGRect)frame withCenter:(CGPoint)acenter Radius:(CGFloat)aradius lineWidth:(CGFloat)width
{
    self = [super initWithFrame:frame];
    if (self) {
        self.center = acenter;
        self.radius = aradius;
        self.linewidth = width;
        lastdegree= 0;
        progress = 0;
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        [self setUserInteractionEnabled:YES];
        self.text = [[UILabel alloc] initWithFrame:(CGRect){CGPointZero, {aradius * 2, aradius * 2}}];
        self.text.center = acenter;
        [self.text setFont:[UIFont systemFontOfSize:12]];
        [self.text setTextColor:[RHUtility colorForHex:@"#318FC5"]];
        [self.text setTextAlignment:NSTextAlignmentCenter];
        [self.text setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}
- (void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //background
	CGContextSetLineWidth(context, self.linewidth);
    CGContextBeginPath (context);
    CGContextSetRGBStrokeColor(context, 0xe3 / 255.0, 0xe3 / 255.0, 0xe2 / 255.0, 1.0);
	CGContextAddArc(context, self.center.x, self.center.y, radius, -M_PI_2, 1 * 2 * M_PI - M_PI_2, false);
    CGContextDrawPath (context, kCGPathStroke);
    
    //foreground
    ////3db9ec
	CGContextSetLineWidth(context, self.linewidth);  
    CGContextBeginPath (context);
    CGContextSetRGBStrokeColor(context, 0x3d / 255.0, 0xb9 / 255.0, 0xec / 255.0, 1.0);
	CGContextAddArc(context, self.center.x, self.center.y, radius, -M_PI_2, progress * 2 * M_PI - M_PI_2, false);
    CGContextDrawPath (context, kCGPathStroke);
}

- (BOOL)isInCircle:(CGPoint)touchpoint{
    float r = sqrtf(((touchpoint.x - center.x) * (touchpoint.x - center.x) +
                      (touchpoint.y - center.y) * (touchpoint.y - center.y)));
    if (r > self.radius - dev && r < self.radius + self.linewidth + dev){
        return YES;
    }
    return NO;
}

- (BOOL)isInPlayArea:(CGPoint)touchpoint{
    float r = sqrtf(((touchpoint.x - center.x) * (touchpoint.x - center.x) +
                     (touchpoint.y - center.y) * (touchpoint.y - center.y)));
    if (r < self.radius - 2 * dev){
        return YES;
    }
    return NO;
}

- (double)CaculateO:(CGPoint)touchpoint{
    double Degree = atan((touchpoint.y - center.y) / (touchpoint.x - center.x));
    if (touchpoint.y > center.y && touchpoint.x >= center.x){
        Degree += M_PI_2;
        //return Degree / (2.0 * M_PI);
    }else if (touchpoint.y > center.y && touchpoint.x < center.x){
        Degree += 3.0 * M_PI_2; 
    }else if (touchpoint.y <= center.y && touchpoint.x >= center.x){
        Degree += M_PI_2;
    }else{
        Degree += 3.0 * M_PI_2;
    }
    return  Degree / (2 * M_PI);
}


- (void)setProgress:(double)newProgress{
    if (lock){
        return;
    }
    progress = newProgress;
    [self setNeedsDisplay];
    [self addSubview:_text];
    [_text setText:[NSString stringWithFormat:@"%d%%", (int)(newProgress * 100)]];
}

- (void)setSeekable:(BOOL)_seekable{
    self.userInteractionEnabled = seekable = _seekable;
}

@end
