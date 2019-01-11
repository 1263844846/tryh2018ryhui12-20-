//
//  RHBankwebviewViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 16/6/21.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import "RHBankwebviewViewController.h"
#import "MBProgressHUD.h"
@interface RHBankwebviewViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation RHBankwebviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configBackButton];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@app/back/archives/appBank/appBindCard",[RHNetworkService instance].newdoMain]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url];
    [request setHTTPMethod:@"GET"];
    [self.webView loadRequest: request];
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
    NSString* url=[request.URL absoluteString];
    //    DLog(@"%@",url);
    
    if ([url rangeOfString:@"front/payment/account/myAccount"].location !=NSNotFound) {
        [RHUserManager sharedInterface].custId = @"first";
        
        if ([RHUserManager sharedInterface].username&&[[RHUserManager sharedInterface].username length]>0) {
            if ([[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@Gesture",[RHUserManager sharedInterface].username]]&&[[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@Gesture",[RHUserManager sharedInterface].username]] length]>0) {
                
                
                [[RHTabbarManager sharedInterface] initTabbar];
                [[RHTabbarManager sharedInterface] selectTabbarUser];
            } else {
//                RHGesturePasswordViewController* controller=[[RHGesturePasswordViewController alloc]init];
//                controller.isRegister = YES;
//                [self.navigationController pushViewController:controller animated:NO];
            }
        }else{
//            RHGesturePasswordViewController* controller=[[RHGesturePasswordViewController alloc]init];
//            controller.isRegister = YES;
//            [self.navigationController pushViewController:controller animated:NO];
        }
        return NO;
    }
    return YES;
}

@end
