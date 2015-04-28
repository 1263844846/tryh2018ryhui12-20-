//
//  RHBindCardWebViewController.h
//  ryhui
//
//  Created by 江 云龙 on 15/3/30.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHBaseViewController.h"
#import "RHWithdrawViewController.h"

@interface RHBindCardWebViewController : RHBaseViewController<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic,assign)RHWithdrawViewController* delegate;
@end
