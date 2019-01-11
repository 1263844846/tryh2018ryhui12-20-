//
//  PRJ_ScrollPageControl.h
//  ChillingAmend
//
//  Created by svendson on 14-12-31.
//  Copyright (c) 2014年 SinoGlobal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PRJ_ScrollPageControl : UIPageControl

{
    UIImageView *currentView;
    UIImageView *indicateView;
}

@property (nonatomic,assign) int numberOfPages;
@property (nonatomic,assign) int currentPage;
@property (nonatomic,assign) float PointSize;
@property (nonatomic,assign) float distanceOfPoint;
@property (nonatomic,assign) UIColor * currentPagePointColor;
@property (nonatomic,assign) UIColor * pagePointColor;

@property (nonatomic, strong) NSMutableArray *imageViews;
@property (nonatomic, strong) NSMutableArray *numbners;
@property (nonatomic, strong) NSMutableArray *orginYs;
@property (nonatomic, strong) NSMutableArray *Heights;
@property (nonatomic, strong) NSMutableArray *Widths;

@property (nonatomic, assign) int index;
@end
