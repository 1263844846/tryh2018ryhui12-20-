//
//  RHJXRechargeWebViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 2018/5/17.
//  Copyright © 2018年 stefan. All rights reserved.
//

#import "RHJXRechargeWebViewController.h"
#import "RHErrorViewController.h"
@interface RHJXRechargeWebViewController ()<UIWebViewDelegate>
{
    NSURLConnection *_urlConnection;
    NSMutableURLRequest *_request;
    BOOL _authenticated;
}
@property (weak, nonatomic) IBOutlet UIWebView *webview;
@property (weak, nonatomic) IBOutlet UIView *hidenview;

@end

@implementation RHJXRechargeWebViewController

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.hidenview.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@app/front/payment/appReformAccountJx/appDirectRechargePageData",[RHNetworkService instance].newdoMain]];
    NSString *deviceUUID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    
    NSString *body = [NSString stringWithFormat: @"txAmount=%@&popularizeCompany=appstore&equipment=%@",self.money,deviceUUID];
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
    self.webview.delegate =self;
    [self.webview loadRequest: _request];
    
    //    [[UIApplication sharedApplication].keyWindow addSubview:self.hidenview];
    //    self.hidenview.frame = CGRectMake(0, 64, RHScreeWidth, RHScreeHeight-10);
    //    if ([UIScreen mainScreen].bounds.size.height>810) {
    //        self.hidenview.frame = CGRectMake(0, 90, RHScreeWidth, RHScreeHeight-40);
    //    }
    [[UIApplication sharedApplication].keyWindow addSubview:self.hidenview];
    self.hidenview.frame = CGRectMake(0, 64, RHScreeWidth, RHScreeHeight-10);
    if ([UIScreen mainScreen].bounds.size.height>810) {
        self.hidenview.frame = CGRectMake(0, 90, RHScreeWidth, RHScreeHeight-40);
    }
    [self configTitleWithString:@"充值"];
    [self configBackButton];
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
    if ([url rangeOfString:@"ommon/paymentJxResponse/directRechargePageSucc"].location !=NSNotFound) {
        //chenggong
        
        RHErrorViewController* controller=[[RHErrorViewController alloc]initWithNibName:@"RHErrorViewController" bundle:nil];
        controller.titleStr=[NSString stringWithFormat:@"充值金额%@元",self.money];
        controller.tipsStr=@"好项目不等人，快去抢吧~";
        controller.type=RHPaySucceed;
        [self.navigationController pushViewController:controller animated:YES];
        
//        [self.navigationController popToRootViewControllerAnimated:YES];
        return NO;
    }
    if ([url rangeOfString:@"common/paymentJxResponse/directRechargePageRet"].location !=NSNotFound) {
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
