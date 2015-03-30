//
//  RHContractViewContoller.h
//  ryhui
//
//  Created by 江 云龙 on 15/3/30.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHBaseViewController.h"

@interface RHContractViewContoller : RHBaseViewController

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property(nonatomic,strong)NSString* projectId;
@property(nonatomic,strong)NSString* userId;

@end
