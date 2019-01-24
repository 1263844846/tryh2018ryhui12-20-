//
//  RHCPFirstViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 2018/1/29.
//  Copyright © 2018年 stefan. All rights reserved.
//

#import "RHCPFirstViewController.h"
#import "MBProgressHUD.h"
#import "RHProjectListViewController.h"
@interface RHCPFirstViewController ()<UIWebViewDelegate>

{
   
}

@property (weak, nonatomic) IBOutlet UIWebView *webview;




@end

@implementation RHCPFirstViewController

-(void)viewWillDisappear:(BOOL)animated{
   
    [super viewWillDisappear:animated];
    self.webview.hidden = YES;
}
- (void)viewDidLoad {
   
    [super viewDidLoad];
    //app = [UIApplication sharedApplication].delegate;
    
    [self configBackButton];
    [self configTitleWithString:@"风险出借测评"];
    [[UIApplication sharedApplication].keyWindow addSubview:self.webview];
    
    self.webview.frame = CGRectMake(0, 65, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-65);
    if ([UIScreen mainScreen].bounds.size.height>740) {
        self.webview.frame = CGRectMake(0, 95, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-95);
    }
    self.webview.delegate = self;
    
//    self.view.backgroundColor = [[UIColor redColor]];
    
    
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@common/main/evaluatMobile",[RHNetworkService instance].newdoMain]];
    //    NSString *body = [NSString stringWithFormat: @"money=%@&projectId=%@&giftId=%@",price,projectId,giftId?giftId:@""];
    
  //  NSString *body = [NSString stringWithFormat: @"money=%@&projectId=%@&giftId=%@&investType=App"];
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url];
    [request setHTTPMethod: @"GET"];
    
    NSString* session=[[NSUserDefaults standardUserDefaults] objectForKey:@"RHSESSION"];
    NSString* session1=[[NSUserDefaults standardUserDefaults] objectForKey:@"RHNEWMYSESSION"];
    
    if (session1.length>12) {
        session = [NSString stringWithFormat:@"%@,%@",session,session1];
    }
    if (session&&[session length]>0) {
        [request setValue:session forHTTPHeaderField:@"cookie"];
        
        
    }
   // [request setHTTPBody:[body dataUsingEncoding: NSUTF8StringEncoding]];
    NSLog(@"--------=============%@",url);
    [self.webview loadRequest: request];
    
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
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
    
   
    if ([url rangeOfString:@"app/front/payment/appReskTest/webViewReskBtn"].location!=NSNotFound) {
        // [MBProgressHUD showHUDAddedTo:self.view animated:YES];
       // self.webView.hidden = YES;
        // self.hidenview.hidden = NO;
        //return NO;
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
   
    
    
    return YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
