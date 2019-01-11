//
//  RHzhuangzhangalpayViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 2018/1/15.
//  Copyright © 2018年 stefan. All rights reserved.
//

#import "RHzhuangzhangalpayViewController.h"

@interface RHzhuangzhangalpayViewController ()

@end

@implementation RHzhuangzhangalpayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    //e
    //
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"马小虎"];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"SourceHanSansCN-Bold" size:12.0f] range:NSMakeRange(0, 3)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:124.0f/255.0f green:124.0f/255.0f blue:124.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 3)];
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
