//
//  RHSLBViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 16/7/19.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import "RHSLBViewController.h"
#import "MBProgressHUD.h"
#import "RHErrorViewController.h"
@interface RHSLBViewController ()<UIWebViewDelegate>
{
    NSURLConnection *_urlConnection;
    NSURLRequest *_request;
    BOOL _authenticated;
    
}
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation RHSLBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self configBackButton];
    [self configTitleWithString:@"生利宝"];
    // Do any additional setup after loading the view from its nib.
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@app/front/payment/appAccount/appFssTrans",[RHNetworkService instance].newdoMain]];
    self.webView.scalesPageToFit =YES;
//    self.webView.scrollView.scrollEnabled = NO;
   
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url];
    NSString* session=[[NSUserDefaults standardUserDefaults] objectForKey:@"RHSESSION"];
    
    if (session&&[session length]>0) {
        [request setValue:session forHTTPHeaderField:@"Cookie"];
    }
    [request setHTTPMethod:@"GET"];
    [self.webView loadRequest: request];
    self.webView.delegate = self;
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
    DLog(@"---====---%@",url);
    
    if ([url rangeOfString:@"/common/paymentResponse/fssTransClientSuccess"].location!=NSNotFound) {
    //i
        RHErrorViewController* controller=[[RHErrorViewController alloc]initWithNibName:@"RHErrorViewController" bundle:nil];
         NSArray* array=[url componentsSeparatedByString:@"&TransType="];
      //  controller.titleStr=[NSString stringWithFormat:@"充值金额%@元",price];
        if ([array[1] isEqualToString:@"I"]) {
            controller.tipsStr=@"余额转入生利宝成功";
            controller.type = RHSLBSucceed;
            
        }else{
            controller.tipsStr=@"生利宝转出成功";
            controller.type = RHZCSLBSucceed;
        }
        
//        controller.tipsStr=@"余额转入生利宝成功";
//        controller.type = RHSLBSucceed;
        [self.navigationController pushViewController:controller animated:YES];
        
        return NO;
    }
    if ([url rangeOfString:@"/common/paymentResponse/fssTransClientFailed"].location!=NSNotFound) {
        RHErrorViewController* controller=[[RHErrorViewController alloc]initWithNibName:@"RHErrorViewController" bundle:nil];
       // controller.titleStr = @"银行卡余额不足";
        NSArray* array=[url componentsSeparatedByString:@"&TransType="];
        if ([array[1] isEqualToString:@"I"]) {
            controller.tipsStr=@"余额转入生利宝失败";
             controller.type = RHSLBFail;
            
        }else{
            controller.tipsStr=@"生利宝转出失败";
             controller.type = RHZCSLBFail;
        }
        if ([array count]>1) {
            NSArray *codeArray = [array[0] componentsSeparatedByString:@"="];
            if (codeArray.count > 1) {
                NSString *code = codeArray[1];
                //                NSLog(@"==============%@",code);
                if ([code integerValue] == 436) {
                   // controller.titleStr = @"余额转入生利宝失败";
                    //controller.tipsStr = @"请避免以下情况并重试：\n姓名／身份证号与开户身份信息不符\n银行预留手机号与开户绑定手机号不符\n银行卡所属地区录入有误";
                } else {
                   // controller.errorType = 435;
                }
            }
        }
//        controller.type = RHSLBFail;
        [self.navigationController pushViewController:controller animated:YES];
        return NO;
    }
    
//    if ([url rangeOfString:@"/common/user/login/index"].location != NSNotFound) {
//        if ([RHUserManager sharedInterface].username&&[[RHUserManager sharedInterface].username length]>0) {
//            [app sessionFail:nil];
//            if ([[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@Gesture",[RHUserManager sharedInterface].username]]&&[[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@Gesture",[RHUserManager sharedInterface].username]] length]>0) {
//                RHGesturePasswordViewController* controller=[[RHGesturePasswordViewController alloc]init];
//                controller.isEnter = YES;
//                //                UINavigationController *navi = (UINavigationController *)app.window.rootViewController;
//                //                UIViewController *vc = navi.viewControllers[navi.viewControllers.count - 1];
//                [self.navigationController pushViewController:controller animated:YES];
//            }
//        }
    
  //      return NO;
  //  }
    
    
    
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
    [_urlConnection cancel];
}

// We use this method is to accept an untrusted site which unfortunately we need to do, as our PVM servers are self signed.
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace
{
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

@end
