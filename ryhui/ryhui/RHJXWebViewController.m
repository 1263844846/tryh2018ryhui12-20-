//
//  RHJXWebViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 17/10/12.
//  Copyright © 2017年 stefan. All rights reserved.
//

#import "RHJXWebViewController.h"
#import "MBProgressHUD.h"
@interface RHJXWebViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webview;

@end

@implementation RHJXWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configBackButton];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@app/back/archives/appBank/appBindCard",[RHNetworkService instance].newdoMain]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url];
    [request setHTTPMethod:@"GET"];
    [self.webview loadRequest: request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
       return YES;
}


@end
