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
    
    int h = image.size.height;
    
    int w = image.size.width;
    
    float b = CGRectGetWidth([UIScreen mainScreen].bounds)/w < CGRectGetHeight([UIScreen mainScreen].bounds) / h ? CGRectGetWidth([UIScreen mainScreen].bounds)/w : CGRectGetHeight([UIScreen mainScreen].bounds) /h;
    CGSize itemSize = CGSizeMake(b*w, b*h);
    
    UIGraphicsBeginImageContext(itemSize);
    
    CGRect imageRect = CGRectMake(0, 0, b*w, b*h);
    
    [image drawInRect:imageRect];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight(imageRect) + 44)];

    imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    [_mainScrollView addSubview:imageView];
    
    _mainScrollView.contentSize = CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), imageView.frame.size.height );
    
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
