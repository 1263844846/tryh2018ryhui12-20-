//
//  XMyScrollView.m
//  ImageScrollAndClick
//
//  Created by svendson on 14-5-30.
//  Copyright (c) 2014年 SinoGlobal. All rights reserved.
//

#import "XMyScrollView.h"
//#import "LYViewController.h"

#define LABELFONT 18
#define SUBVIEWHEIGHTBILI 8
@implementation XMyScrollView

//-(NSMutableArray *)ziMu{
//    if (!_ziMu) {
//        _ziMu=[@[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"] copy];
//    }
//    return _ziMu;
//}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.curViews=[NSMutableArray array];
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        self.scrollView.delegate = self;
        self.scrollView.contentSize = CGSizeMake(self.bounds.size.width * 5, self.bounds.size.height);
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.contentOffset = CGPointMake(self.bounds.size.width, 0);
        self.scrollView.pagingEnabled = YES;
        [self addSubview:self.scrollView];
        
        
        
//        self.myView=[[UIView alloc]initWithFrame:CGRectMake(0, (self.bounds.size.height/SUBVIEWHEIGHTBILI)*(SUBVIEWHEIGHTBILI-1), 320, self.bounds.size.height/8)];
//        self.myView.backgroundColor=[UIColor whiteColor];
//        self.myView.alpha = .7;
//        [self addSubview:self.myView];
        
//        self.label=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 320, self.bounds.size.height/SUBVIEWHEIGHTBILI)];
//        self.label.backgroundColor=[UIColor clearColor];
//        self.label.textColor=[UIColor redColor];
//        self.label.textAlignment=NSTextAlignmentLeft;
//        self.label.font=[UIFont systemFontOfSize:LABELFONT];
//    
//        [self.myView addSubview:self.label];
        
//        CGRect rect = self.myView.bounds;
//        rect.origin.y = rect.size.height - 30;
//        rect.size.height = self.myView.frame.size.height;
//        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(180, (self.bounds.size.height/SUBVIEWHEIGHTBILI)*(SUBVIEWHEIGHTBILI-1)+ self.myView.frame.size.height/2-3, 180, 5)];
//        self.pageControl.userInteractionEnabled = NO;
//        //self.pageControl.backgroundColor=[UIColor redColor];
//        self.pageControl.currentPageIndicatorTintColor=[UIColor redColor];
//        self.pageControl.pageIndicatorTintColor=[UIColor blueColor];
//        [self addSubview:self.pageControl];
//        self.currentPage = 0;

    }
//    [self reloadData];
    self. x = self.scrollView.contentOffset.x;
    return self;
}


- (void)setDataource:(id<XmyScrollViewDatasource>)datasource
{
    _datasource = datasource;
    [self reloadData];
}

- (void)reloadData
{
    self.totalPages = (int)[self.datasource numberOfPages];
    if ( self.totalPages == 0) {
        return;
    }
    self.pageControl.numberOfPages = self.totalPages;
    [self loadData];
    if (self.scrollView) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(loadimages:) userInfo:Nil repeats:YES];
    }
}

- (void)loadData
{
    
    self.pageControl.currentPage = self.currentPage;
    
    
    //从scrollView上移除所有的subview
    NSArray *subViews = [self.scrollView subviews];
    if([subViews count] != 0) {
        [subViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    if (self.scrollView) {
        [self getDisplayImagesWithCurpage:self.currentPage]; 
    }
    for (int i = 0; i < 3; i++) {
        
        UIImageView *v = [self.curViews objectAtIndex:i];
        v.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(handleTap:)];
        [v addGestureRecognizer:singleTap];
        v.frame = CGRectOffset(v.frame, v.frame.size.width * i, 0);
        
        [self.scrollView addSubview:v];
        
        
//        self.label.text=self.ziMu[0];
    }
       [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width, 0)];
}


-(void)loadimages:(NSThread*)timer{

   
//    self.x++;
//     NSLog(@"+++++++++++++%d",self.x);
    
   // UIImageView *v = [self.curViews objectAtIndex:self.currentPage];
    
    
    //[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(imageSlide:) userInfo:v repeats:YES];
    
    [self switchFocusImageItems];
    
//        self.currentPage = [self validPageValue:self.currentPage+1];
//        [self loadData];

}


- (void)switchFocusImageItems
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(switchFocusImageItems) object:nil];
    
    CGFloat targetX = self.scrollView.contentOffset.x + self.scrollView.frame.size.width;
    [self moveToTargetPosition:targetX];
    
//    [self performSelector:@selector(switchFocusImageItems) withObject:nil afterDelay:3.0];
}


- (void)moveToTargetPosition:(CGFloat)targetX
{
//    NSLog(@"moveToTargetPosition : %f" , targetX);
    if (targetX >= self.scrollView.contentSize.width) {
        targetX = 0.0;
    }
    
    [self.scrollView setContentOffset:CGPointMake(targetX, 0) animated:YES] ;
    
}



- (void)getDisplayImagesWithCurpage:(int)page {
    
    int pre = [self validPageValue:self.currentPage-1];
    int last = [self validPageValue:self.currentPage+1];
    
    if (!self.curViews) {
        self.curViews = [[NSMutableArray alloc] init];
    }
    [self.curViews removeAllObjects];
    
    [self.curViews addObject:[self.datasource scrollViewPageAtIndex:pre]];
    [self.curViews addObject:[self.datasource scrollViewPageAtIndex:page]];
    [self.curViews addObject:[self.datasource scrollViewPageAtIndex:last]];
}

- (int)validPageValue:(int)value {
    
    if(value == -1) value = self.totalPages - 1;
    if(value == self.totalPages) value = 0;
    
    return value;
    
}

- (void)handleTap:(UITapGestureRecognizer *)tap {

    if (![self.delegate respondsToSelector:@selector(didClickPage:atIndex:)]) {
        
//         self.currenrtString=[NSString stringWithFormat:@"%d",self.currentPage+1 ];
//       // [self.delegate didClickPage:self atIndex:self.currentPage];
//       
//        [self.delegate getStringByTap:self.currenrtString];
//        NSLog(@"%@",self.currenrtString);
    }
    
    [self.timer invalidate];
    [self.delegate didClickPage:self atIndex:_currentPage];
}


//- (void)setViewContent:(UIView *)view atIndex:(NSInteger)index
//{
//    if (index == self.currentPage) {
//        [self.curViews replaceObjectAtIndex:1 withObject:view];
//        for (int i = 0; i < 3; i++) {
//            UIImageView *v = [self.curViews objectAtIndex:i];
//            v.userInteractionEnabled = YES;
//            UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
//                                                                                        action:@selector(handleTap:)];
//           [v addGestureRecognizer:singleTap];
//            v.frame = CGRectOffset(v.frame, v.frame.size.width * i, 0);
//            [self.scrollView addSubview:v];
//        }
//    }
//}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)aScrollView {
    
    int x = aScrollView.contentOffset.x;
    
//    NSLog(@"...........%d",x);
    //往下翻一张
    if(x >= (2*self.frame.size.width)) {
        self.currentPage = [self validPageValue:self.currentPage+1];
        [self loadData];
    }
    
    //往上翻
    if(x <= 0) {
        self.currentPage = [self validPageValue:self.currentPage-1];
        [self loadData];
    }
    
    
//    self.label.text=[self.ziMu objectAtIndex:self.currentPage];
    
//     [self.delegate getZiMuStringByTap:[self.ziMu objectAtIndex:self.currentPage]];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)aScrollView {
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width, 0) animated:YES];
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
