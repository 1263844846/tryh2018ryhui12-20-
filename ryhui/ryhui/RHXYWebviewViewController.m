//
//  RHXYWebviewViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 2018/4/23.
//  Copyright © 2018年 stefan. All rights reserved.
//

#import "RHXYWebviewViewController.h"
#import <WebKit/WebKit.h>
@interface RHXYWebviewViewController ()<UIWebViewDelegate,WKUIDelegate,WKNavigationDelegate>
{
    AppDelegate *app;
    NSURLConnection *_urlConnection;
    NSMutableURLRequest *_request;
    BOOL _authenticated;
}
@property (weak, nonatomic) IBOutlet UIWebView *webview;
@property(nonatomic,strong)WKWebView * wkWebview;
@end

@implementation RHXYWebviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configBackButton];
    [self configTitleWithString:self.namestr];
    NSString * genstr ;
    
    if ([[RHNetworkService instance].newdoMain isEqualToString:@"https://www.ryhui.com/"]) {
        genstr = @"http://www.ryhui.com/";
    }else{
        
        genstr = @"http://www.ryhui.com/";
    }
//    genstr = [[RHNetworkService instance].newdoMain
//                                        stringByReplacingOccurrencesOfString:@"https" withString:@"http"];
    
    
    NSString * str = [NSString stringWithFormat:@"%@common/main/agreementDetail?title=%@",genstr,self.namestr];
    
    if ([self.namestr isEqualToString:@"借款协议范本"]) {
        str = [NSString stringWithFormat:@"%@front/payment/agreement/agreementBefore?projectId=%@",[RHNetworkService instance].newdoMain,self.projectid];
    }
    
    NSString* encodedString = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:encodedString];
    //    NSString *body = [NSString stringWithFormat: @"money=%@&projectId=%@&giftId=%@",price,projectId,giftId?giftId:@""];
    
    NSString* session=[[NSUserDefaults standardUserDefaults] objectForKey:@"RHSESSION"];
    NSString* session1=[[NSUserDefaults standardUserDefaults] objectForKey:@"RHNEWMYSESSION"];
    
    if (session1.length>12) {
        session = [NSString stringWithFormat:@"%@,%@",session,session1];
    }
    if (session&&[session length]>0) {
        [_request setValue:session forHTTPHeaderField:@"cookie"];
        
        
    }
    _request = [[NSMutableURLRequest alloc]initWithURL: url];
    [_request setHTTPMethod:@"GET"];
    [self.webview loadRequest: _request];
    self.webview.delegate = self;
  
//
//    self.wkWebview =  [[WKWebView alloc] initWithFrame:self.view.bounds];
//    [self.wkWebview loadRequest:_request];
//    [self.view addSubview:self.wkWebview];
//    self.wkWebview.navigationDelegate = self;
//    //    [[UIApplication sharedApplication].keyWindow addSubview:self.wkWebview];
//    self.wkWebview.UIDelegate = self;
    
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
    [self.webview loadRequest:_request]; //  self.webView替换成自己的webview
    // Cancel the URL connection otherwise we double up (webview + url connection, same url = no good!)
    // [_urlConnection cancel];
}

// We use this method is to accept an untrusted site which unfortunately we need to do, as our PVM servers are self signed.
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace
{
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

@end
