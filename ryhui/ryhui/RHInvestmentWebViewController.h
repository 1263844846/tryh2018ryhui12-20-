//
//  RHInvestmentWebViewController.h
//  ryhui
//
//  Created by 江 云龙 on 15/3/18.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHBaseViewController.h"

@interface RHInvestmentWebViewController : RHBaseViewController
@property(nonatomic,strong)NSString* price;
@property(nonatomic,strong)NSString* projectId;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end
