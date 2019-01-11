//
//  RHGZdetailViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 16/10/26.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import "RHGZdetailViewController.h"

@interface RHGZdetailViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scollview;
@property (weak, nonatomic) IBOutlet UILabel *lab;

@end

@implementation RHGZdetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configBackButton ];
    [self configTitleWithString:@"活动规则"];
    // Do any additional setup after loading the view from its nib.
    CGSize size = CGSizeMake(300,2000);
    CGSize size1 = [self.lab.text sizeWithFont:self.lab.font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
    if ([UIScreen mainScreen].bounds.size.width > 376) {
//        size1.height = size1.height;
//        self.lab.frame = CGRectMake(10,15 ,300, size1.height);
//        //        self.tishilab.backgroundColor = [UIColor redColor];
//       
//        self.scollview.contentSize = CGSizeMake(self.scollview.frame.size.width, size1.height+20);
//        self.scollview.bounces = NO;
        self.lab.font = [UIFont systemFontOfSize:17];
    }else if ([UIScreen mainScreen].bounds.size.width <321){
        
        self.lab.font = [UIFont systemFontOfSize:13];
        //        size1.height = size1.height+90;
//        self.lab.frame = CGRectMake(10,10 , 300, size1.height);
//        
//        self.scollview.contentSize = CGSizeMake(self.scollview.frame.size.width, size1.height+40);
//        
//        self.scollview.bounces = NO;
    }else{
        //        size1.height = size1.height;
//        self.lab.frame = CGRectMake(10,15 ,300, size1.height);
//        //    self.newtishilab.backgroundColor = [UIColor redColor];
//        
//        self.scollview.contentSize = CGSizeMake(self.scollview.frame.size.width, size1.height+20);
//        
//        self.scollview.bounces = NO;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
