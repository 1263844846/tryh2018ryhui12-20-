//
//  RHSTZFWebViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 2018/5/18.
//  Copyright © 2018年 stefan. All rights reserved.
//

#import "RHSTZFWebViewController.h"
#import "RHHFLoginPasswordViewController.h"
@interface RHSTZFWebViewController ()<UIWebViewDelegate>
{
    NSURLConnection *_urlConnection;
    NSMutableURLRequest *_request;
    BOOL _authenticated;
    int secondsCountDown;
    NSTimer* countDownTimer;
}

@property (weak, nonatomic) IBOutlet UIWebView *webview;

@end

@implementation RHSTZFWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@front/payment/account/trusteePayJxData",[RHNetworkService instance].newdoMain]];
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
    [_request setHTTPBody: [body dataUsingEncoding: NSUTF8StringEncoding]];
    self.webview.delegate =self;
    [self.webview loadRequest: _request];
    
    //    [[UIApplication sharedApplication].keyWindow addSubview:self.hidenview];
    //    self.hidenview.frame = CGRectMake(0, 64, RHScreeWidth, RHScreeHeight-10);
    //    if ([UIScreen mainScreen].bounds.size.height>810) {
    //        self.hidenview.frame = CGRectMake(0, 90, RHScreeWidth, RHScreeHeight-40);
    //    }
    [self configTitleWithString:@"受托支付授权"];
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
    if ([url rangeOfString:@"front/payment/account/trusteePayList"].location !=NSNotFound) {
       [self reSendMessage];
        return NO;
    }
    if ([url rangeOfString:@"account/mySafe?id=4"].location!=NSNotFound) {
        
        RHHFLoginPasswordViewController* controller=[[RHHFLoginPasswordViewController alloc]initWithNibName:@"RHHFLoginPasswordViewController" bundle:nil];
        //        controller.titleStr=[NSString stringWithFormat:@"投资金额%@元",price];
        //        controller.tipsStr=@"赚钱别忘告诉其他小伙伴哦~";
        //        controller.type=RHInvestmentSucceed;
        
        controller.backstring = @"backback";
        [self.navigationController pushViewController:controller animated:YES];
        //NSLog(@"666");
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

- (void)reSendMessage {
    secondsCountDown = 3;
    //    self.yanzhengmabtn.enabled = NO;
    countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
}

- (void)timeFireMethod {
    secondsCountDown --;
    //    self.yanzhengmabtn.titleLabel.text = [NSString stringWithFormat:@"重新发送(%d)",secondsCountDown];
    //    [self.yanzhengmabtn setTitle:[NSString stringWithFormat:@"重新发送(%d)",secondsCountDown] forState:UIControlStateDisabled];
    [RHUtility showTextWithText:[NSString stringWithFormat:@"授权成功%dS后跳转离开此页面",secondsCountDown]];
    if (secondsCountDown == 0) {
        //        self.yanzhengmabtn.enabled = YES;
        //        [self.yanzhengmabtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.navigationController popViewControllerAnimated:YES];
        [countDownTimer invalidate];
    }
}
@end
