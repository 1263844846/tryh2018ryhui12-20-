//
//  RHRegisterWebViewController.m
//  ryhui
//
//  Created by stefan on 15/3/15.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHRegisterWebViewController.h"
#import "MBProgressHUD.h"
#import "RHGesturePasswordViewController.h"
#import "RHhelper.h"
@interface RHRegisterWebViewController ()
{
    NSURLConnection *_urlConnection;
    NSMutableURLRequest *_request;
    BOOL _authenticated;
    
}



@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation RHRegisterWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configBackButton];
    [self configTitleWithString:@"开户"];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@app/front/payment/appAccount/appAccountHF",[RHNetworkService instance].newdoMain]];

   _request = [[NSMutableURLRequest alloc]initWithURL: url];
    [_request setHTTPMethod:@"GET"];
    [self.webView loadRequest: _request];
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
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
    NSString* url=[request.URL absoluteString];
//    DLog(@"%@",url);
    
    if ([url rangeOfString:@"front/payment/account/myAccount"].location !=NSNotFound) {
        [RHUserManager sharedInterface].custId = @"first";
        
        if ([RHUserManager sharedInterface].username&&[[RHUserManager sharedInterface].username length]>0) {
//             [RHhelper ShraeHelp].registnum = 9;
            if ([[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@Gesture",[RHUserManager sharedInterface].username]]&&[[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@Gesture",[RHUserManager sharedInterface].username]] length]>0) {
                [RHhelper ShraeHelp].registnum = 9;
                RHUserCountViewController *controller = [[RHUserCountViewController alloc]initWithNibName:@"RHUserCountViewController" bundle:nil];
                [self.navigationController popToRootViewControllerAnimated:NO];
                //            controller.type = @"0";
//                [nav pushViewController:controller animated:YES];
               
                
                [[DQViewController Sharedbxtabar]tabBar:(DQview *)controller.view didSelectedIndex:2];
                UIButton *btn = [[UIButton alloc]init];
                btn.tag = 2;
                [[DQview Shareview] btnClick:btn];
//
                
                
//                return;
            } else {
                RHGesturePasswordViewController* controller=[[RHGesturePasswordViewController alloc]init];
                controller.isRegister = YES;
                [RHhelper ShraeHelp].registnum = 9;
                [self.navigationController pushViewController:controller animated:NO];
            }
        }else{
            [RHhelper ShraeHelp].registnum = 9;
            RHGesturePasswordViewController* controller=[[RHGesturePasswordViewController alloc]init];
            controller.isRegister = YES;
            [self.navigationController pushViewController:controller animated:NO];
        }
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
