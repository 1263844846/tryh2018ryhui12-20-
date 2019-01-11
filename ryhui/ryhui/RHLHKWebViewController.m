//
//  RHLHKWebViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 17/9/12.
//  Copyright © 2017年 stefan. All rights reserved.
//

#import "RHLHKWebViewController.h"
#import "MBProgressHUD.h"
@interface RHLHKWebViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webview;

@end

@implementation RHLHKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configBackButton];
    [self configTitleWithString:@"联行卡查询"];
    // Do any additional setup after loading the view from its nib.
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.lianhanghao.com"]];
  //  NSString *body = [NSString stringWithFormat: @"cardNumber=%@&money=%@&txFee=%@&category=%@&cardBankCnaps=%@",self.bankcard,amount,captcha,category,self.cardBankCnaps];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url];
    [request setHTTPMethod: @"GET"];
    NSString* session = [[NSUserDefaults standardUserDefaults] objectForKey:@"RHSESSION"];
    if (session && [session length] > 0) {
        [request setValue:session forHTTPHeaderField:@"Set-Cookie"];
    }
   // [request setHTTPBody: [body dataUsingEncoding: NSUTF8StringEncoding]];
    [self.webview loadRequest: request];
    self.webview.delegate =self;
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
