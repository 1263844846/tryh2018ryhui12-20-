//
//  AITableFooterVew.m
//  AppInstaller
//
//  Created by liuweina on 12-4-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AITableFooterVew.h"
#define AI_STORE_TEXT_DETAILCOLOR   [UIColor colorWithRed:0x99 / 255.0f green:0x99 / 255.0f blue:0x99 / 255.0f alpha:1]

@implementation AITableFooterVew

@synthesize footerButton = _footerButton;
@synthesize activityIndicatorView = _activityIndicatorView;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self.activityIndicatorView startAnimating];
        float version = [[[UIDevice currentDevice] systemVersion] floatValue];
        if (version < 5.0) {
            [self.activityIndicatorView setFrame:CGRectMake(60.0, 10.0, 25.0, 25.0)];
        }
        
        self.footerButton = [[UIButton alloc] initWithFrame:CGRectMake(_activityIndicatorView.frame.origin.x, 0.0, 149, self.frame.size.height)];

		self.footerButton.titleLabel.font = [UIFont systemFontOfSize:13.0f];
		self.footerButton.titleLabel.backgroundColor = [UIColor clearColor];
		self.footerButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.footerButton setTitleColor:AI_STORE_TEXT_DETAILCOLOR forState:UIControlStateNormal];
        [self.footerButton setTitle:@"显示更多..." forState:UIControlStateNormal];
        [self.footerButton setTitle:@"亲,已经到底部了" forState:UIControlStateDisabled];

        [self addSubview:self.activityIndicatorView];
        [self addSubview:self.footerButton];
        
        CGRect footFrame = self.footerButton.frame;
        footFrame.origin.x = (self.frame.size.width - footFrame.size.width) / 2;
        footFrame.origin.y = (self.frame.size.height - footFrame.size.height) / 2;
        footFrame.size.width = CGRectGetWidth([UIScreen mainScreen].bounds) - 2 * footFrame.origin.x;
        self.footerButton.frame = footFrame;
        [self.footerButton setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin];
        
        CGRect activityFrame = self.activityIndicatorView.frame;
        activityFrame.origin.x = footFrame.origin.x - activityFrame.size.width - 5;
        activityFrame.origin.y = (self.frame.size.height - activityFrame.size.height) / 2;
        
        self.activityIndicatorView.frame = activityFrame;
        [self.activityIndicatorView setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin];
    }
    return self;
}

- (void)dealloc {
    self.activityIndicatorView = nil;
    self.footerButton = nil;
}

@end
