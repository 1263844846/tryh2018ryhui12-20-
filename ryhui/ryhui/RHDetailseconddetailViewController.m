//
//  RHDetailseconddetailViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 16/9/18.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import "RHDetailseconddetailViewController.h"

@interface RHDetailseconddetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *detailview;

@property (weak, nonatomic) IBOutlet UIScrollView *scorlview;

@end

@implementation RHDetailseconddetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configBackButton];
    [self configTitleWithString:self.namestr];
//    CGSize size = CGSizeMake(320,2000);
    //计算实际frame大小，并将label的frame变成实际大小
//    self.deatial = @"风格很舒服的共商国是都会尽快改善计划开始干活感觉神经看过后就是开个会看到更符合健康";
    
    self.scorlview .scrollEnabled = YES;
    self.detailview.text = self.deatial;
    
        if (self.deatial.length>251) {
             self.detailview.font = [UIFont systemFontOfSize:13];
        }
    self.detailview.lineBreakMode = NSLineBreakByTruncatingTail;
         CGSize maximumLabelSize = CGSizeMake(360, 9999);//labelsize的最大值
         //关键语句
       CGSize expectSize = [self.detailview sizeThatFits:maximumLabelSize];
        //别忘了把frame给回label，如果用xib加了约束的话可以只改一个约束的值
    if ([UIScreen mainScreen ].bounds.size.width <321&&self.deatial.length>251) {
        self.detailview.frame = CGRectMake(10, 3, 350, expectSize.height+100);
        self.scorlview.contentSize =  CGSizeMake([UIScreen mainScreen].bounds.size.width,expectSize.height +50+100);
        return;
        
    }
    if ([UIScreen mainScreen ].bounds.size.width <321&&self.deatial.length<251) {
        self.detailview.frame = CGRectMake(10, 3, 350, expectSize.height+20+10);
        self.scorlview.contentSize =  CGSizeMake([UIScreen mainScreen].bounds.size.width,expectSize.height +100);
        return;
        
    }
        self.detailview.frame = CGRectMake(10, 10, 350, expectSize.height+20);
//    self.scorlview.bounces = NO;
//    self.scorlview.pagingEnabled = NO;
//    self.detailview.hidden = YES;
    self.scorlview.contentSize =  CGSizeMake([UIScreen mainScreen].bounds.size.width,expectSize.height+ 100);
//         self.scorlview.
    
    

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
