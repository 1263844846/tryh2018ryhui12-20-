//
//  RHPFnumberwebViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 2018/8/13.
//  Copyright © 2018年 stefan. All rights reserved.
//

#import "RHPFnumberwebViewController.h"

@interface RHPFnumberwebViewController ()<UIWebViewDelegate>
{
    NSURLConnection *_urlConnection;
    NSMutableURLRequest *_request;
    BOOL _authenticated;
}
@property (weak, nonatomic) IBOutlet UIWebView *webview;

@end

@implementation RHPFnumberwebViewController
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [RYHViewController Sharedbxtabar].tabBar.hidden = YES;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    [self configBackButton];
    [self configTitleWithString:@"修改手机号"];
   
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@app/front/payment/appReformAccountJx/mobileModifyPageData",[RHNetworkService instance].newdoMain]];
    NSString *body = [NSString stringWithFormat: @"mobile=%@",[RHUserManager sharedInterface].telephone];
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
    [_request setHTTPBody: [body dataUsingEncoding: NSUTF8StringEncoding]];
    [self.webview loadRequest: _request];
    
    self.webview.delegate = self;
    
  
    
//    [self.view addSubview:self.mainWebView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString* url=[request.URL absoluteString];
    if (!_authenticated) {
        _authenticated =NO;
        _urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self]; // 网上好多教程这句写的request写的是_request
        _request = request; //网上好多教程这句代码忘记加了
        [_urlConnection start];
        return NO;
    }
    if ([url rangeOfString:@"common/paymentJxResponse/mobileModifyPageRet"].location !=NSNotFound) {
        //chenggong
        
       
      
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        return NO;
    }
    if ([url rangeOfString:@"payment/account/mySafe"].location !=NSNotFound) {
        //chenggong
        
        
        
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        return NO;
    }
    
    return YES;
}
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
