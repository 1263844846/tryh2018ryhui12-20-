//
//  RHWithdrawWebViewController.h
//  ryhui
//
//  Created by 江 云龙 on 15/3/29.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHBaseViewController.h"

@interface RHWithdrawWebViewController : RHBaseViewController<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property(nonatomic,strong)NSString* amount;
@property(nonatomic,strong)NSString* captcha;
@end