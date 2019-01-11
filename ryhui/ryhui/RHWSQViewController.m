//
//  RHWSQViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 2018/5/14.
//  Copyright © 2018年 stefan. All rights reserved.
//

#import "RHWSQViewController.h"
#import "RHSQWebViewController.h"
#import "RHXYWebviewViewController.h"
@interface RHWSQViewController ()

@end

@implementation RHWSQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configTitleWithString:@"缴费授权"];
    [self configBackButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)shouquan:(id)sender {
//    NSDictionary *parameters = @{@"authType":@"withdraw",@"money":@"100000"};
//    NSString * str = @"app/front/payment/appReformAccountJx/appPaymentAuthPage";
//    AFHTTPRequestOperationManager* manager=[AFHTTPRequestOperationManager manager];
//

//    }];
    
    
    RHSQWebViewController * vc = [[RHSQWebViewController alloc]initWithNibName:@"RHSQWebViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (IBAction)xieyi:(id)sender {
    
    RHXYWebviewViewController * vc= [[RHXYWebviewViewController alloc]initWithNibName:@"RHXYWebviewViewController" bundle:nil];
    vc.namestr = @"缴费授权协议";
    [self.navigationController pushViewController:vc animated:YES];
}

@end
