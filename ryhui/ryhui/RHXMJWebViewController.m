//
//  RHXMJWebViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 2018/6/6.
//  Copyright © 2018年 stefan. All rights reserved.
//

#import "RHXMJWebViewController.h"

@interface RHXMJWebViewController ()
{
    NSURLConnection *_urlConnection;
    NSMutableURLRequest *_request;
    BOOL _authenticated;
    
}

@property (weak, nonatomic) IBOutlet UIWebView *webview;
@property (weak, nonatomic) IBOutlet UIView *hidenview;

@end

@implementation RHXMJWebViewController
-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.hidenview.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configTitleWithString:self.nametitle];
    [self configBackButton];
    NSURL *webUrl = [NSURL URLWithString:_xmjurl];
    _request = [NSMutableURLRequest requestWithURL:webUrl];
    //NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url];
    //NSString * namestr = [RHUserManager sharedInterface].username;
    NSString* session=[[NSUserDefaults standardUserDefaults] objectForKey:@"RHSESSION"];
    if (![RHUserManager sharedInterface].username) {
        session = nil;
    }
    if (session&&[session length]>0) {
        [_request setValue:session forHTTPHeaderField:@"Set-Cookie"];
    }
    [_request setHTTPMethod:@"GET"];
    
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
