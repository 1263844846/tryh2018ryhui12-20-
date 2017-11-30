//
//  RHGesturePasswordButton.m
//  ryhui
//
//  Created by stefan on 15/2/28.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHGesturePasswordButton.h"
#define bounds self.bounds

@implementation RHGesturePasswordButton
@synthesize selected;
@synthesize success;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        success=YES;
        [self setBackgroundColor:[RHUtility colorForHex:@"#f1f9f9"]];
//        self.layer
//        [self.layer setMasksToBounds:YES];
//        [self.layer setCornerRadius:31.0];
        
        self.layer.cornerRadius = 31.0;
        self.layer.masksToBounds = 31.0;
        NSLog(@"%f",self.frame.size.height);
        NSLog(@"%f----",self.frame.size.width);
    }
    return self;
}
// 0,206,209 lanse
// 175,238,238

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (selected) {
        if (success) {
            CGContextSetRGBStrokeColor(context, 2/255.f, 174/255.f, 240/255.f,1);//线条颜色
            CGContextSetRGBFillColor(context,2/255.f, 174/255.f, 240/255.f,1);
        }
        else {
            CGContextSetRGBStrokeColor(context, 0/255.f, 206/255.f, 208/255.f,1);//线条颜色
            CGContextSetRGBFillColor(context,0/255.f, 206/255.f, 208/255.f,1);
        }
        CGRect frame = CGRectMake(bounds.size.width/2-bounds.size.width/8+1, bounds.size.height/2-bounds.size.height/8, bounds.size.width/4, bounds.size.height/4);
        
        CGContextAddEllipseInRect(context,frame);
        CGContextFillPath(context);
    }
    else{
        CGContextSetRGBStrokeColor(context, 74/255.f, 186/255.f, 192/255.f,1);//线条颜色
    }
    
    CGContextSetLineWidth(context,2);
    CGRect frame = CGRectMake(2, 2, bounds.size.width-3, bounds.size.height-3);
    CGContextAddEllipseInRect(context,frame);
    CGContextStrokePath(context);
    if (success) {
        CGContextSetRGBFillColor(context,0/255.f, 83/255.f, 131/255.f,0.3);
        
    }
    else {
        CGContextSetRGBFillColor(context,208/255.f, 36/255.f, 36/255.f,0.3);
    }
    CGContextAddEllipseInRect(context,frame);
    if (selected) {
        CGContextFillPath(context);
    }
    
}

@end
