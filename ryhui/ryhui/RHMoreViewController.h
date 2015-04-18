//
//  RHMoreViewController.h
//  ryhui
//
//  Created by stefan on 15/3/15.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHBaseViewController.h"

@interface RHMoreViewController : RHBaseViewController<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)pushMain:(id)sender;
- (IBAction)pushUser:(id)sender;
- (IBAction)pushAbout:(id)sender;
- (IBAction)callPhone:(id)sender;
- (IBAction)call:(id)sender;
- (IBAction)cancelCall:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *alertView;
- (IBAction)pushIntroduction:(id)sender;
- (IBAction)shareAction:(id)sender;
@end
