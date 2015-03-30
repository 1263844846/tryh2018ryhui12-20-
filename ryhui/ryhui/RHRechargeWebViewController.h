//
//  RHRechargeWebViewController.h
//  ryhui
//
//  Created by stefan on 15/3/15.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHBaseViewController.h"

@interface RHRechargeWebViewController : RHBaseViewController<UIWebViewDelegate>
@property(nonatomic,strong)NSString* price;

@property (weak, nonatomic) IBOutlet UIWebView *webView;


@end
