//
//  RHJXHFTXViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 17/10/12.
//  Copyright © 2017年 stefan. All rights reserved.
//

#import "RHJXHFTXViewController.h"
#import "MBProgressHUD.h"
#import "RHHFJXScuessViewController.h"
#import "RHhelper.h"
@interface RHJXHFTXViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webview;

@end

@implementation RHJXHFTXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   // app = [UIApplication sharedApplication].delegate;
    
    [self configBackButton];
    [self configTitleWithString:@"提现"];
    
    self.webview.delegate = self;
    
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@app/front/payment/appAccount/appAutoCash",[RHNetworkService instance].newdoMain]];
    NSString *body = [NSString stringWithFormat: @"bankId=%@",self.bankcard];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url];
    [request setHTTPMethod: @"POST"];
    NSString* session = [[NSUserDefaults standardUserDefaults] objectForKey:@"RHSESSION"];
    if (session && [session length] > 0) {
        [request setValue:session forHTTPHeaderField:@"Set-Cookie"];
    }
    [request setHTTPBody: [body dataUsingEncoding: NSUTF8StringEncoding]];
    [self.webview loadRequest: request];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *url=[request.URL absoluteString];
    //    DLog(@"%@",url);
    if ([url rangeOfString:@"common/paymentResponse/cashClientBackSuccess"].location != NSNotFound) {
        
        RHHFJXScuessViewController * vc = [[RHHFJXScuessViewController alloc]initWithNibName:@"RHHFJXScuessViewController" bundle:nil];
        vc.str = @"1";
        [RHhelper ShraeHelp].moneystr = @"0";
        [self.navigationController pushViewController:vc animated:YES];
        
        return NO;
    }
    
    if ([url rangeOfString:@"common/paymentResponse/cashClientBackFailed"].location != NSNotFound) {
        
     
            NSArray* array=[url componentsSeparatedByString:@"&RespDesc="];
            
            NSString * str = [NSString stringWithFormat:@"%@",array[1]];
            NSLog(@"--===---%ld",str.length);
            
            NSString *encodedString;
            if (str.length>5) {
                encodedString =[str stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                
                encodedString = [encodedString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            }
        RHHFJXScuessViewController * vc = [[RHHFJXScuessViewController alloc]initWithNibName:@"RHHFJXScuessViewController" bundle:nil];
        vc.str = encodedString;
        [self.navigationController pushViewController:vc animated:YES];
//        [self.navigationController popViewControllerAnimated:YES];
        return NO;
    }
    
   
    return YES;
}
@end
