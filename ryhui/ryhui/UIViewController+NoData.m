//
//  UIViewController+NoData.m
//  ryhui
//
//  Created by 江 云龙 on 15/4/18.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "UIViewController+NoData.h"

@implementation UIViewController (NoData)

-(void)showNoDataWithFrame:(CGRect)frame insertView:(UIView*)insetView
{
    UIView* view=[[UIView alloc] initWithFrame:frame];
    view.tag=198;
    view.backgroundColor=[UIColor clearColor];
    UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(view.center.x-47, view.center.y-20-47, 94, 94)];
    imageView.image=[UIImage imageNamed:@"noData.jpg"];
    [view addSubview:imageView];
    
    UILabel* label=[[UILabel alloc]initWithFrame:CGRectMake(0, imageView.frame.origin.y+94+5, [UIScreen mainScreen].bounds.size.width, 20)];
    label.backgroundColor=[UIColor clearColor];
    label.font=[UIFont systemFontOfSize:18];
    label.textColor=[RHUtility colorForHex:@"#c7c7c7"];
    label.textAlignment=NSTextAlignmentCenter;
    label.text=@"暂时没有相应数据";
    [view addSubview:label];
    
    [self.view insertSubview:view belowSubview:insetView];
}

-(void)hiddenNoData
{
    for (UIView* view in self.view.subviews) {
        if (view.tag==198) {
            [view removeFromSuperview];
        }
    }
}
@end
