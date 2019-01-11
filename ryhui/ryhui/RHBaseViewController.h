//
//  RHBaseViewController.h
//  ryhui
//
//  Created by stefan on 15/2/13.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import <UIKit/UIKit.h>
#define RHScreeWidth   ([[UIScreen mainScreen] bounds].size.width)
#define RHScreeHeight   ([[UIScreen mainScreen] bounds].size.height)
@interface RHBaseViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *messageNumLabel;
@property(nonatomic,strong)NSString * shouyexunhuan;
@property(nonatomic,strong)NSString * tabbarstr;
- (void)configBackButton;
- (void)configTitleWithString:(NSString*)title;
- (void)configRightButtonWithTitle:(NSString*)title action:(SEL)action;
-(void)setMessageNum:(NSNotification*)notss;
-(void)rightbuttonwhithimagrstring:(NSString *)imagestring action:(SEL)action;
- (void)getright:(NSString*)namelab action:(SEL)action;
@end
