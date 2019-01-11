//
//  RHRegisterAgreenWebViewController.m
//  ryhui
//
//  Created by jufenghudong on 15/4/9.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHRegisterAgreenWebViewController.h"

@interface RHRegisterAgreenWebViewController (){
    
    AppDelegate *app;
    NSURLConnection *_urlConnection;
    NSMutableURLRequest *_request;
    BOOL _authenticated;
}

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation RHRegisterAgreenWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configBackButton];
    [self configTitleWithString:@"《融益汇注册服务协议》"];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@regProtocol",[RHNetworkService instance].newdoMain]];
//    NSURL * url1 = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.baidu.com"]];
    
    _request = [[NSMutableURLRequest alloc]initWithURL: url];
   // [_request setHTTPMethod: @"POST"];
    NSString* session = [[NSUserDefaults standardUserDefaults] objectForKey:@"RHSESSION"];
    if (session&&[session length] > 0) {
        [_request setValue:session forHTTPHeaderField:@"Set-Cookie"];
    }
    [_request setHTTPMethod:@"GET"];
    [self.webView loadRequest: _request];
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    if (!_authenticated) {
        _authenticated =NO;
        _urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self]; // 网上好多教程这句写的request写的是_request
        _request = request; //网上好多教程这句代码忘记加了
        [_urlConnection start];
        return NO;
    }
        //    if ([url isEqualToString:[NSString stringWithFormat:@"%@common/paymentResponse/cashClientBackFailed",[RHNetworkService instance].doMain]]) {
    //
    //        return NO;
    //    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    if ([challenge previousFailureCount] == 0)
    {
        _authenticated = YES;
        NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        [challenge.sender useCredential:credential forAuthenticationChallenge:challenge];
    } else
    {
        [[challenge sender] cancelAuthenticationChallenge:challenge];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // remake a webview call now that authentication has passed ok.
    _authenticated = YES;
    [self.webView loadRequest:_request]; //  self.webView替换成自己的webview
    // Cancel the URL connection otherwise we double up (webview + url connection, same url = no good!)
    // [_urlConnection cancel];
}

// We use this method is to accept an untrusted site which unfortunately we need to do, as our PVM servers are self signed.
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace
{
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}
@end
