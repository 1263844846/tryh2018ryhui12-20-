//
//  RHOpenCountWebViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 2018/4/16.
//  Copyright © 2018年 stefan. All rights reserved.
//

#import "RHOpenCountWebViewController.h"
#import "RHOpenAccountScuessViewController.h"
#import "RHOpenAccountScuessViewController1.h"
@interface RHOpenCountWebViewController ()<UIWebViewDelegate>
{
    NSURLConnection *_urlConnection;
    NSMutableURLRequest *_request;
    BOOL _authenticated;
    
}
@property (weak, nonatomic) IBOutlet UIWebView *WebView;
@property (weak, nonatomic) IBOutlet UIView *hidenview;

@end

@implementation RHOpenCountWebViewController

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.hidenview.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@app/front/payment/appReformAccountJx/accountOpenEncryptPageDataForApp",[RHNetworkService instance].newdoMain]];
    NSString *deviceUUID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSString *body = [NSString stringWithFormat: @"gender=%@&name=%@&acctUse=%@&identity=%@&mobile=%@&channelOpenAccount=appstore&equipmentOpenAccount=%@",self.idcardstr,self.namestr,self.accusestr,self.identitystr,self.mobilestr,deviceUUID];
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
    self.WebView.delegate =self;
    [self.WebView loadRequest: _request];
    
     [[UIApplication sharedApplication].keyWindow addSubview:self.hidenview];
    self.hidenview.frame = CGRectMake(0, 64, RHScreeWidth, RHScreeHeight-10);
     if ([UIScreen mainScreen].bounds.size.height>810) {
         self.hidenview.frame = CGRectMake(0, 90, RHScreeWidth, RHScreeHeight-40);
     }
    [self configBackButton];
    [self configTitleWithString:@"开户"];
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
    if ([url rangeOfString:@"common/paymentJxResponse/accountOpenEncryptPageFail"].location!=NSNotFound) {
        // [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        self.webview.hidden = YES;
        // self.hidenview.hidden = NO;
        //return NO;
//        RHOpenAccountScuessViewController * vc = [[RHOpenAccountScuessViewController alloc]initWithNibName:@"RHOpenAccountScuessViewController" bundle:nil];
//        [self.navigationController pushViewController:vc animated:YES];
//        
//        NSLog(@"sucsess");
//        return YES;
//        RHOpenAccountScuessViewController1 * vc = [[RHOpenAccountScuessViewController1 alloc]initWithNibName:@"RHOpenAccountScuessViewController1" bundle:nil];
//        [self.navigationController pushViewController:vc animated:YES];
//        return NO ;
//        
//        NSLog(@"fail");
        [self.navigationController popViewControllerAnimated:YES];
        return NO;
    }
    if ([url rangeOfString:@"common/paymentJxResponse/accountOpenEncryptPageBefore"].location!=NSNotFound) {
    
        RHOpenAccountScuessViewController1 * vc = [[RHOpenAccountScuessViewController1 alloc]initWithNibName:@"RHOpenAccountScuessViewController1" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
        
        NSLog(@"sucsess");
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
    [self.WebView loadRequest:_request]; //  self.webView替换成自己的webview
    // Cancel the URL connection otherwise we double up (webview + url connection, same url = no good!)
    // [_urlConnection cancel];
}

// We use this method is to accept an untrusted site which unfortunately we need to do, as our PVM servers are self signed.
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace
{
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

@end
