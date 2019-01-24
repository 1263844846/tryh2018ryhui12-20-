//
//  RHJXPassWordNewViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 2018/9/30.
//  Copyright © 2018年 stefan. All rights reserved.
//

#import "RHJXPassWordNewViewController.h"
#import <WebKit/WebKit.h>

@interface RHJXPassWordNewViewController ()<WKUIDelegate,WKNavigationDelegate,UIWebViewDelegate>
{
    AppDelegate *app;
    int secondsCountDown;
    NSTimer *countDownTimer;
    NSURLConnection *_urlConnection;
    NSMutableURLRequest *_request;
    BOOL _authenticated;
}
@property (weak, nonatomic) IBOutlet UIWebView *webview;
@property(nonatomic,strong)WKWebView * wkWebview;
@end

@implementation RHJXPassWordNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.wkWebview =  [[WKWebView alloc] initWithFrame:self.view.bounds];
     NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[RHNetworkService instance].newdoMain,self.urlstr]];
    
   
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url];
    [request setHTTPMethod: @"POST"];
    
    NSString* session=[[NSUserDefaults standardUserDefaults] objectForKey:@"RHSESSION"];
    NSString* session1=[[NSUserDefaults standardUserDefaults] objectForKey:@"RHNEWMYSESSION"];
    
    if (session1.length>12) {
        session = [NSString stringWithFormat:@"%@,%@",session,session1];
    }
    if (session&&[session length]>0) {
        [request setValue:session forHTTPHeaderField:@"cookie"];
        
        
    }
    
    
    [self.webview loadRequest: request];
    
    self.webview.delegate = self;
    
   
    [[UIApplication sharedApplication].keyWindow addSubview:self.webview];
        self.webview.frame = CGRectMake(0, 64, RHScreeWidth, RHScreeHeight-80);
        if ([UIScreen mainScreen].bounds.size.height>810) {
            self.webview.frame = CGRectMake(0, 90, RHScreeWidth, RHScreeHeight-80);
        }
  
    
    return;
//     [_request setHTTPBody:[body dataUsingEncoding: NSUTF8StringEncoding]];
    [self.wkWebview loadRequest:_request];
    [self.view addSubview:self.wkWebview];
    self.wkWebview.navigationDelegate = self;
    //    [[UIApplication sharedApplication].keyWindow addSubview:self.wkWebview];
    self.wkWebview.UIDelegate = self;
    self.wkWebview.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-65);
    if ([UIScreen mainScreen].bounds.size.height>740) {
        self.wkWebview.frame = CGRectMake(0,84, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-95);
    }
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.wkWebview];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated{
    self.wkWebview.hidden = YES;
    self.webview.hidden = YES;
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
}





-(void)webViewDidStartLoad:(UIWebView *)webView
{
//    [MBProgressHUD showHUDAddedTo:self.webview animated:YES];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
//    [MBProgressHUD hideAllHUDsForView:self.webview animated:YES];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"----------------%@",error.description);
//    [MBProgressHUD hideAllHUDsForView:self.webview animated:YES];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString* url=[request.URL absoluteString];
    //    DLog(@"%@",url);
    //front/payment/account/mySafe
    if ([url rangeOfString:@"common/paymentJxResponse/passwordSetBefore"].location!=NSNotFound) {
        
        self.webview.hidden = YES;
            
            [self.navigationController popViewControllerAnimated:YES];
       
        
        DLog(@"%@",url);
        
        
        return YES;
        
    }
    return YES;
}





- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    NSLog(@"%@",navigationAction.request.URL.absoluteString);
    NSString *url=[navigationAction.request.URL absoluteString];
    //    DLog(@"%@",url);
    if ([url rangeOfString:@"app/front/payment/appReskTest/webViewReskBtn"].location != NSNotFound) {
        NSLog(@"----------");
        decisionHandler(WKNavigationActionPolicyCancel);
//        RHProjectListViewController *controller = [[RHProjectListViewController alloc]initWithNibName:@"RHProjectListViewController" bundle:nil];
//        controller.type = @"0";
//        //    [nav pushViewController:controller animated:YES];
//        [[RYHViewController Sharedbxtabar]tabBar:(RYHView *)controller.view didSelectedIndex:1];
//        UIButton *btn = [[UIButton alloc]init];
//        btn.tag = 1;
//        [[RYHView Shareview] btnClick:btn];
        [self.navigationController popToRootViewControllerAnimated:NO];
        return;
        
    }
    
    if ([url rangeOfString:@"common/paymentJxResponse/passwordSetBefore"].location!=NSNotFound) {
        
      
            
            [self.navigationController popViewControllerAnimated:YES];
        
        
        DLog(@"%@",url);
        
        
        return ;
        
    }
    
    
    //允许跳转
    decisionHandler(WKNavigationActionPolicyAllow);
}


- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler{
    
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        
        NSURLCredential *card = [[NSURLCredential alloc]initWithTrust:challenge.protectionSpace.serverTrust];
        
        completionHandler(NSURLSessionAuthChallengeUseCredential,card);
        
    }
}


@end
