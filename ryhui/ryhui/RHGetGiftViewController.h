//
//  RHGetGiftViewController.h
//  ryhui
//
//  Created by jufenghudong on 15/4/16.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHBaseViewController.h"

@interface RHGetGiftViewController : RHBaseViewController

@property(nonatomic,strong)NSString* amount;

@property (weak, nonatomic) IBOutlet UILabel *amountLabel;

- (IBAction)pushRecharge:(id)sender;
- (IBAction)pushMyGift:(id)sender;
@end
