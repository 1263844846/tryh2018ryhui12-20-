//
//  RHHFWebviewViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 16/6/24.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import "RHHFWebviewViewController.h"
#import "MBProgressHUD.h"

@interface RHHFWebviewViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *WebView;

@end

@implementation RHHFWebviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configBackButton];
    [self configTitleWithString:@"汇付天下"];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@app/front/payment/appAccount/appLoginHuifu",[RHNetworkService instance].newdoMain]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url];
    [request setHTTPMethod:@"GET"];
    [self.WebView loadRequest: request];
}
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}






@end
