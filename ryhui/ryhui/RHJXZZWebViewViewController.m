//
//  RHJXZZWebViewViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 2018/5/30.
//  Copyright © 2018年 stefan. All rights reserved.
//

#import "RHJXZZWebViewViewController.h"

@interface RHJXZZWebViewViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webview;

@end

@implementation RHJXZZWebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configBackButton];
    [self configTitleWithString:@"转账提示"];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@front/payment/accountJx/rechargeApp",[RHNetworkService instance].newdoMain]];
   
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
//    [request setHTTPBody: [body dataUsingEncoding: NSUTF8StringEncoding]];
    [self.webview loadRequest: request];
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

@end
