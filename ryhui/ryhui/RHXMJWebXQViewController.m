//
//  RHXMJWebXQViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 2018/6/8.
//  Copyright © 2018年 stefan. All rights reserved.
//

#import "RHXMJWebXQViewController.h"

@interface RHXMJWebXQViewController ()
{
    NSURLConnection *_urlConnection;
    NSMutableURLRequest *_request;
    BOOL _authenticated;
    
}
@property (weak, nonatomic) IBOutlet UIWebView *webview;
@property (weak, nonatomic) IBOutlet UIView *hidenview;

@end

@implementation RHXMJWebXQViewController

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.hidenview.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configTitleWithString:@"项目集"];
    [self configBackButton];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@common/projectList/myInvestToDetails",[RHNetworkService instance].newdoMain]];
    //    NSString *body = [NSString stringWithFormat: @"money=%@&projectId=%@&giftId=%@",price,projectId,giftId?giftId:@""];
    
    NSString *body = [NSString stringWithFormat: @"projectId=%@",self.projectid];
    _request = [[NSMutableURLRequest alloc]initWithURL: url];
    [_request setHTTPMethod: @"POST"];
    
    NSString* session=[[NSUserDefaults standardUserDefaults] objectForKey:@"RHSESSION"];
    NSString* session1=[[NSUserDefaults standardUserDefaults] objectForKey:@"RHNEWMYSESSION"];
    
    if (session1.length>12) {
        session = [NSString stringWithFormat:@"%@,%@",session,session1];
    }
    if (session&&[session length]>0) {
        [_request setValue:session forHTTPHeaderField:@"cookie"];
        
        
    }
    [_request setHTTPBody:[body dataUsingEncoding: NSUTF8StringEncoding]];
    
    [self.webview loadRequest:_request];
    self.webview.scalesPageToFit = YES;
    //    self.webview.delegate = self;
    [[UIApplication sharedApplication].keyWindow addSubview:self.hidenview];
    self.hidenview.frame = CGRectMake(0, 64, RHScreeWidth, RHScreeHeight-10);
    if ([UIScreen mainScreen].bounds.size.height>810) {
        self.hidenview.frame = CGRectMake(0, 90, RHScreeWidth, RHScreeHeight-40);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
