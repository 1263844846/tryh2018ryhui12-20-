//
//  RHBaseViewController.h
//  ryhui
//
//  Created by stefan on 15/2/13.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RHBaseViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *messageNumLabel;

- (void)configBackButton;
- (void)configTitleWithString:(NSString*)title;
- (void)configRightButtonWithTitle:(NSString*)title action:(SEL)action;
-(void)setMessageNum:(NSNotification*)notss;

@end
