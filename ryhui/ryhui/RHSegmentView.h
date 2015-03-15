//
//  RHSegmentView.h
//  ryhui
//
//  Created by stefan on 15/3/14.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RHSegmentControlDelegate <NSObject>

- (void)didSelectSegmentAtIndex:(int)index;

@end


@interface RHSegmentView : UIView
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel1;

@property (weak, nonatomic) IBOutlet UIView *segmentView1;
@property (weak, nonatomic) IBOutlet UIView *segmentView2;

@property (nonatomic, assign) id<RHSegmentControlDelegate> delegate;
@property (nonatomic, assign) int selectedIndex;

-(void)initData;

- (void)setItems:(NSArray *)items; // items is an array of title
- (IBAction)segment1Action:(id)sender;
- (IBAction)segment2Action:(id)sender;

@end
