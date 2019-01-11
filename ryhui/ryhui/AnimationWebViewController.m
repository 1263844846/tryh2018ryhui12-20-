//
//  AnimationWebViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 16/12/9.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import "AnimationWebViewController.h"
#import "RHGesturePasswordViewController.h"
#import "MBProgressHUD.h"
#import "NSString+URL.h"
#import "RHmainModel.h"
@interface AnimationWebViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation AnimationWebViewController
- (void)getdata{
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self getdata];
    [self configTitleWithString:@"活动介绍" ];
    
    [self configBackButton];
    
    self.navigationController.navigationBar.hidden = NO;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[RHNetworkService instance].newdoMain,[RHmainModel ShareRHmainModel].urlstr]];
    //    NSString *body = [NSString stringWithFormat: @"money=%@&projectId=%@&giftId=%@",price,projectId,giftId?giftId:@""];
    
//    NSString *body = [NSString stringWithFormat: @"money=%@&projectId=%@&giftId=%@&investType=App",price,projectId,giftId?giftId:@""];
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
    [self.webView loadRequest: request];

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

-(void)back{
    
//    [[RHTabbarManager sharedInterface] initTabbar];
    RHGesturePasswordViewController * controller = [[RHGesturePasswordViewController alloc]init];
    
    [self presentViewController:controller animated:YES completion:nil];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"----------------%@",error.description);
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString* url=[request.URL absoluteString];
    //    DLog(@"%@",url);
    
    
    return YES;
}



@end
