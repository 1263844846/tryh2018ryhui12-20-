//
//  RHBindCardViewController.h
//  ryhui
//
//  Created by jufenghudong on 15/4/12.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHBaseViewController.h"

@interface RHBindCardViewController : RHBaseViewController
- (IBAction)bindAction:(id)sender;
- (IBAction)pushBankList:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;

@property(nonatomic,strong)NSString* amountStr;

@end
