//
//  RHMyMessageDetailViewController.m
//  ryhui
//
//  Created by jufenghudong on 15/4/12.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHMyMessageDetailViewController.h"

@interface RHMyMessageDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timelab;

@end

@implementation RHMyMessageDetailViewController
@synthesize ids;
@synthesize titleStr;
@synthesize contentStr;
@synthesize delegate;

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
     [self refreshTheData];
}

-(void)refreshTheData {
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"[%@]",ids],@"ids", nil];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFCompoundResponseSerializer alloc]init];
    [manager POST:[NSString stringWithFormat:@"%@app/front/payment/appAccount/appMarkMessageReaded",[RHNetworkService instance].newdoMain] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        DLog(@"result==%@ <<<",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSRange range = [result rangeOfString:@"success"];
        if (range.location != NSNotFound) {
            [delegate refresh];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //        DLog(@"%@",error);
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configBackButton];
    
    [self configTitleWithString:@"消息详情"];
    
    self.titleLabel.text = titleStr;
    self.contentLabel.text = contentStr;
 
}

- (IBAction)pushMain:(id)sender {
    [[[RHTabbarManager sharedInterface] selectTabbarMain] popToRootViewControllerAnimated:NO];
}

- (IBAction)pushUser:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)pushMore:(id)sender {
    [[[RHTabbarManager sharedInterface] selectTabbarMore] popToRootViewControllerAnimated:NO];
}

@end
