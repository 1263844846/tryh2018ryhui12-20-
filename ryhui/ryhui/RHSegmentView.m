//
//  RHSegmentView.m
//  ryhui
//
//  Created by stefan on 15/3/14.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHSegmentView.h"

@implementation RHSegmentView

@synthesize delegate;
@synthesize selectedIndex;

-(void)initData {
    self.segmentView1.hidden=NO;
    self.segmentView2.hidden=YES;
    [delegate didSelectSegmentAtIndex:0];
    //self.segmentLabel.text = @"可投0";
}

- (IBAction)segment1Action:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if (btn.tag == 0){
        if (self.segmentView1.hidden) {
            self.segmentView1.hidden=NO;
            self.segmentView2.hidden=YES;
            [delegate didSelectSegmentAtIndex:0];
        }
    } else {
        if (self.segmentView2.hidden) {
            self.segmentView2.hidden=NO;
            self.segmentView1.hidden=YES;
            [delegate didSelectSegmentAtIndex:1];
        }
    }
}

-(void)hidd{
    
    self.segmentView2.hidden=NO;
    self.segmentView1.hidden=YES;
    [delegate didSelectSegmentAtIndex:1];
    
}
- (void)hiddd{
    
    self.segmentView2.hidden=YES;
    self.segmentView1.hidden=NO;
    [delegate didSelectSegmentAtIndex:0];
    
}
@end
