//
//  RHMoreWebViewViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 16/5/4.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import "RHMoreWebViewViewController.h"
#import "MBProgressHUD.h"
#import "RHhelper.h"
@interface RHMoreWebViewViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation RHMoreWebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configBackButton];
    [self configTitleWithString:self.namestr];
    self.webView.delegate = self;
    if ([self.namestr isEqualToString:@"快捷限额"]) {
        [RHhelper ShraeHelp].filres =2;
    }
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",self.urlstr]];
    
    self.webView.scalesPageToFit =YES;
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url];
    
   
    NSString* session=[[NSUserDefaults standardUserDefaults] objectForKey:@"RHSESSION"];
    NSString* session1=[[NSUserDefaults standardUserDefaults] objectForKey:@"RHNEWMYSESSION"];
    
    if (session1.length>12) {
        session = [NSString stringWithFormat:@"%@,%@",session,session1];
    }
    if (session&&[session length]>0) {
        [request setValue:session forHTTPHeaderField:@"cookie"];
        
        
    }
   
    self.webView.scalesPageToFit = YES;
  //  [request setHTTPMethod:@"GET"];
    [self.webView loadRequest: request];
    
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
   // self.navigationController.navigationBar.hidden=NO;
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
