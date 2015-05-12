//
//  RHLogoViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 15/5/11.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHLogoViewController.h"

@interface RHLogoViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;

@end

@implementation RHLogoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self configTitleWithString:_navigationTitle];
    [self configBackButton];
    
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_logoRrl]]];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), image.size.height/2)];
    imageView.image = image;
    
    [_mainScrollView addSubview:imageView];
    
    _mainScrollView.contentSize = CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), image.size.height/2 );
    
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
