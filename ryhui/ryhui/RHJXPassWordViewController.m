//
//  RHJXPassWordViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 17/8/8.
//  Copyright © 2017年 stefan. All rights reserved.
//

#import "RHJXPassWordViewController.h"
#import "MBProgressHUD.h"
#import "RHErrorViewController.h"
#import "NSString+URL.h"
#import "RHGesturePasswordViewController.h"
#import "RHhelper.h"
@interface RHJXPassWordViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webview;
@property (weak, nonatomic) IBOutlet UIWebView *myview;

@end

@implementation RHJXPassWordViewController

- (void)viewDidLoad {
     self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configBackButton];
    [self configTitleWithString:@"交易密码"];
    if ([self.urlstr isEqualToString:@"app/front/payment/appJxAccount/passwordSetJxData"]) {
        self.urlstr = @"app/front/payment/appReformAccountJx/passwordResetPageData";
    }
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[RHNetworkService instance].newdoMain,self.urlstr]];
    //    NSString *body = [NSString stringWithFormat: @"money=%@&projectId=%@&giftId=%@",price,projectId,giftId?giftId:@""];
    
//    NSString *body = [NSString stringWithFormat: @"idType=01"];
    
    if (self.messagestr.length>1) {
//        body = [NSString stringWithFormat: @"idType=01&smsCode=%@",self.messagestr];
    }
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
//    [request setHTTPBody:[body dataUsingEncoding: NSUTF8StringEncoding]];
    NSLog(@"--------=============%@",url);
    [self.webview loadRequest: request];
    
    self.webview.delegate = self;
    
    if (![self.xiugai isEqualToString:@"1"]) {
//        [[UIApplication sharedApplication].keyWindow addSubview:self.myview];
        self.myview.frame = CGRectMake(0, 0, self.myview.frame.size.width, RHScreeHeight-80-60);
        if ([UIScreen mainScreen].bounds.size.height>810) {
            self.myview.frame = CGRectMake(0, 0, self.myview.frame.size.width, RHScreeHeight-80-60-30);
        }
    }
    
}
-(void)viewWillDisappear:(BOOL)animated{
    self.myview.hidden = YES;
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showHUDAddedTo:self.webview animated:YES];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideAllHUDsForView:self.webview animated:YES];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"----------------%@",error.description);
    [MBProgressHUD hideAllHUDsForView:self.webview animated:YES];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString* url=[request.URL absoluteString];
    //    DLog(@"%@",url);
    //front/payment/account/mySafe
    if ([url rangeOfString:@"common/paymentJxResponse/passwordSetBefore"].location!=NSNotFound) {
        
         if ([[RHhelper ShraeHelp].dbsxstr isEqualToString:@"1"]) {
             
             [self.navigationController popViewControllerAnimated:YES];
         }else{
             [self.navigationController popToRootViewControllerAnimated:YES];
         }
        
           DLog(@"%@",url);
        
        
        return NO;
        
    }
        return YES;
}


@end
