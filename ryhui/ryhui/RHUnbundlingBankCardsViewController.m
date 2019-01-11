//
//  RHUnbundlingBankCardsViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 2018/9/19.
//  Copyright © 2018年 stefan. All rights reserved.
//

#import "RHUnbundlingBankCardsViewController.h"

@interface RHUnbundlingBankCardsViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webview;

@end

@implementation RHUnbundlingBankCardsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configBackButton];
    [self configTitleWithString:@"解绑银行卡"];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@app/front/payment/appReformAccountJx/unbindCardPage",[RHNetworkService instance].newdoMain]];
    //    NSString *body = [NSString stringWithFormat: @"money=%@&projectId=%@&giftId=%@",price,projectId,giftId?giftId:@""];
    
        NSString *body ;
    
    if (self.cardnumstring.length>1) {
                body = [NSString stringWithFormat: @"cardNo=%@",self.cardnumstring];
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
        [request setHTTPBody:[body dataUsingEncoding: NSUTF8StringEncoding]];
    NSLog(@"--------=============%@",url);
    [self.webview loadRequest: request];
    
    self.webview.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString* url=[request.URL absoluteString];
    //    DLog(@"%@",url);
    
    if ([url rangeOfString:@"common/paymentJxResponse/unbindCardPageSuccessfulUrl"].location !=NSNotFound) {
      
        [RHUtility showTextWithText:@"解绑成功"];
        [self.navigationController popToRootViewControllerAnimated:YES];
           
        return NO;
    }
    if ([url rangeOfString:@"common/paymentJxResponse/unbindCardPageRetUrl"].location !=NSNotFound) {
        
        [RHUtility showTextWithText:@"解绑失败"];
        [self.navigationController popToRootViewControllerAnimated:YES];
        
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
