//
//  RHOfficeNetAndWeiBoViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 15/4/24.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHOfficeNetAndWeiBoViewController.h"

@interface RHOfficeNetAndWeiBoViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *officalWebView;
@end

@implementation RHOfficeNetAndWeiBoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self configBackButton];
    if (_Type == 0) {
        [self configTitleWithString:@"融益汇官网"];
    }else{
        [self configTitleWithString:@"融益汇微博"];
    }
    
    NSURL *webUrl = [NSURL URLWithString:_urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:webUrl];
    [_officalWebView loadRequest:request];
    _officalWebView.scalesPageToFit = YES;

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden = NO;
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
