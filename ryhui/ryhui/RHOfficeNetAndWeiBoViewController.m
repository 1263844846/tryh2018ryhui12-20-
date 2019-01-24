//
//  RHOfficeNetAndWeiBoViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 15/4/24.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHOfficeNetAndWeiBoViewController.h"
#import "MBProgressHUD.h"
#import "RHRegisterViewController.h"
#import "RHhelper.h"
#import <WebKit/WebKit.h>
#import "RHALoginViewController.h"
#import "RHFriendViewController.h"
#import "RHProjectListViewController.h"
#import "RHRNewShareWebViewController.h"

@interface RHOfficeNetAndWeiBoViewController ()<UIWebViewDelegate,WKUIDelegate,WKNavigationDelegate>
{
    NSURLConnection *_urlConnection;
    NSMutableURLRequest *_request;
    BOOL _authenticated;
    
}
@property (weak, nonatomic) IBOutlet UIView *myview;
@property (weak, nonatomic) IBOutlet UIWebView *officalWebView;
@property(nonatomic,strong)WKWebView * wkWebview;
@end

@implementation RHOfficeNetAndWeiBoViewController

-(void)viewWillDisappear:(BOOL)animated{
//     self.myview.hidden = YES;
//    [MBProgressHUD hideAllHUDsForView:self.myview animated:YES];
    
    [super viewWillDisappear:animated];
   
}
-(void)back{
//    self.myview.hidden = YES;
    
//     [[NSURLCache sharedURLCache] removeAllCachedResponses];
    _urlString=@"";
    self.myview.tag = 2009;
    UIView * view = [[UIApplication sharedApplication].keyWindow viewWithTag:2009];
    [view removeFromSuperview];
     [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    self.navigationController.interactivePopGestureR ecognizer.enabled = NO;
}


- (void)configBackButton
{
    UIButton* button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    //    UIImage * image = [UIImage imageNamed:@"back.png"];
    
    [button setImage:[UIImage imageNamed:@"icon_back.png"] forState:UIControlStateNormal];
     button.frame=CGRectMake(0, 0, 25, 40);
    
    // button.backgroundColor = [UIColor colorWithHexString:@"44bbc1"];
    self.navigationItem.leftBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:button];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
    [self configBackButton];
    if (_Type == 0) {
        [self configTitleWithString:@"融益汇官网"];
    }else if (_Type == 1){
        [self configTitleWithString:@"融益汇微博"];
    }else{
        [self configTitleWithString:@"融益汇"];
    }
    
    if (self.NavigationTitle.length >1) {
        [self configTitleWithString:self.NavigationTitle];
    }
    self.myview.frame = CGRectMake(0, 55, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-50);
    if ([UIScreen mainScreen].bounds.size.height>740) {
        self.myview.frame = CGRectMake(0,85, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-55);
    }
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.myview];
//     NSString * urlStr = [_urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *webUrl = [NSURL URLWithString:_urlString];
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

    [_officalWebView loadRequest:_request];
    _officalWebView.scalesPageToFit = YES;
    _officalWebView.delegate = self;
//    
//    self.wkWebview = [[WKWebView alloc]init];
////    self.officalWebView.hidden = YES;
//    self.wkWebview.frame = CGRectMake(200, 55, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-50);
//    [self.wkWebview loadRequest:_request];
//    self.wkWebview.backgroundColor = [UIColor redColor];
////    [self.myview addSubview:self.wkWebview];
//    self.wkWebview.UIDelegate = self;
//    self.wkWebview.navigationDelegate = self;
//    self.wkWebview.allowsBackForwardNavigationGestures = YES;
    
    
     
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden = NO;
    self.myview.hidden = NO;
//     self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    //当页面为一级页面时禁止手势
    if (self.navigationController.viewControllers.count == 1)
    {
        return NO;
    }
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
//
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showHUDAddedTo:self.myview animated:YES];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideAllHUDsForView:self.myview animated:YES];
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
    
    //  /common/playGames/webViewRegBtn
    NSString *url=[request.URL absoluteString];
    //    DLog(@"%@",url);
    if ([url rangeOfString:@"/common/playGames/webViewRegBtn"].location != NSNotFound) {
        
//        [self.navigationController pushViewController:controller animated:YES];
        self.myview.hidden = YES;
        RHRegisterViewController * vc = [[RHRegisterViewController alloc]initWithNibName:@"RHRegisterViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
        return NO;
    }
    if ([url rangeOfString:@"/common/playGames/webViewLogBtn"].location != NSNotFound) {
        
        //        [self.navigationController pushViewController:controller animated:YES];
        self.myview.hidden = YES;
        RHALoginViewController * vc = [[RHALoginViewController alloc]initWithNibName:@"RHALoginViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
        return NO;
    }
    if ([url rangeOfString:@"/common/playGames/webViewProBtn"].location != NSNotFound) {
        
        //        [self.navigationController pushViewController:controller animated:YES];
        self.myview.hidden = YES;
        RHProjectListViewController *controller = [[RHProjectListViewController alloc]initWithNibName:@"RHProjectListViewController" bundle:nil];
        controller.type = @"0";
        //    [nav pushViewController:controller animated:YES];
        [[RYHViewController Sharedbxtabar]tabBar:(RYHView *)controller.view didSelectedIndex:1];
        UIButton *btn = [[UIButton alloc]init];
        btn.tag = 1;
        [[RYHView Shareview] btnClick:btn];
        [self.navigationController popToRootViewControllerAnimated:NO];
        return NO;
    }
    if ([url rangeOfString:@"/common/playGames/webViewFriBtn"].location != NSNotFound) {
        
        //        [self.navigationController pushViewController:controller animated:YES];
        self.myview.hidden = YES;
        RHRNewShareWebViewController * vc = [[RHRNewShareWebViewController alloc]initWithNibName:@"RHRNewShareWebViewController" bundle:nil];
        vc.pinjie = @"true";
        vc.Type = 3;
        vc.shareid = @"5";
        vc.urlString = @"https://www.ryhui.com/common/main/inviteFriendApp";
        
        
          [self.navigationController pushViewController:vc animated:YES];
//        [[RYHViewController Sharedbxtabar]tabBar:(RYHView *)vc.view didSelectedIndex:2];
//        UIButton *btn = [[UIButton alloc]init];
//        btn.tag = 2;
//        [[RYHView Shareview] btnClick:btn];
//        return NO;
    }
//
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
    [self.officalWebView loadRequest:_request]; //  self.webView替换成自己的webview
    // Cancel the URL connection otherwise we double up (webview + url connection, same url = no good!)
    [_urlConnection cancel];
}

// We use this method is to accept an untrusted site which unfortunately we need to do, as our PVM servers are self signed.
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace
{
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    [MBProgressHUD showHUDAddedTo:self.myview animated:YES];
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
     [MBProgressHUD hideAllHUDsForView:self.myview animated:YES];
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"-----------");
}
// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    
}
// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    
    NSLog(@"%@",navigationResponse.response.URL.absoluteString);
    //允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
    //不允许跳转
    decisionHandler(WKNavigationResponsePolicyCancel);
}
// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    NSLog(@"%@",navigationAction.request.URL.absoluteString);
    //允许跳转
    if (navigationAction.targetFrame == nil) {
        [webView loadRequest:navigationAction.request];
    }
//    decisionHandler(WKNavigationActionPolicyAllow);
    decisionHandler(WKNavigationActionPolicyAllow);
    //不允许跳转
    //    decisionHandler(WKNavigationActionPolicyCancel);
}
#pragma mark - WKUIDelegate
// 创建一个新的WebView
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
    
    
    
    return [[WKWebView alloc]init];
}
// 输入框
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler{
    completionHandler(@"http");
}
//// 确认框
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler{
    completionHandler(YES);
}
//// 警告框
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    NSLog(@"%@",message);
    completionHandler();
}
//


@end
