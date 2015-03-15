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


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if (status == TOUCHSTATUSMOVE){
        return;
    }
    
    
    UITouch *touch = [touches anyObject];
    
    if ([self isInPlayArea:[touch locationInView:self]]){
        [_delegate touchInPlayArea:self];
        status = TOUCHSTATUSINPLAY;
    }else if ([self isInCircle:[touch locationInView:self]]){
        lastdegree = [self CaculateO:[touch locationInView:self]];
        [_delegate touchingProgress:self];
        [self setProgress:lastdegree];
        status = TOUCHSTATUSBEGIN;
    }else{
        status = TOUCHSTATUSEND;
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    
    if (status == TOUCHSTATUSINPLAY){
        if (![self isInPlayArea:[touch locationInView:self]]){
            [_delegate touchOutPlayArea:self];
            status = TOUCHSTATUSINPLAY;
        }
    }else if (status != TOUCHSTATUSEND){
        double degree = [self CaculateO:[touch locationInView:self]];
        if (degree >= 0 && degree < 0.25 && lastdegree <= 1 && lastdegree > 0.75){
            [self setProgress:0];
            [_delegate hasSeekToBegin:self];
            [_delegate moveoutProgress:self];
            status = TOUCHSTATUSEND;
        }else if (degree > 0.75 && degree <= 1 && lastdegree >= 0 && lastdegree < 0.25) {
            [self setProgress:0];
            [_delegate hasSeekToEnd:self];
            status = TOUCHSTATUSEND;
            [_delegate moveoutProgress:self];
        }else {
            [self setProgress:degree];
            lastdegree = degree;
            status = TOUCHSTATUSMOVE;
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if (status == TOUCHSTATUSINPLAY){
        [_delegate finishPlayClick:self];
        status = TOUCHSTATUSEND;
    }else if (status != TOUCHSTATUSEND){
        [_delegate seekToProgress:lastdegree];
        status = TOUCHSTATUSEND;
        [_delegate moveoutProgress:self];
    }
}




@end
