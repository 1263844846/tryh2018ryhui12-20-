//
//  CycleScrollView.m
//  PagedScrollView
//
//  Created by 陈政 on 14-1-23.
//  Copyright (c) 2014年 Apple Inc. All rights reserved.
//

#import "CycleScrollView.h"
#import "NSTimer+Addition.h"

@interface CycleScrollView () <UIScrollViewDelegate>

@property (nonatomic , assign) NSInteger currentPageIndex;
@property (nonatomic , assign) NSInteger totalPageCount;
@property (nonatomic , strong) NSMutableArray *contentViews;
@property (nonatomic , strong) UIScrollView *scrollView;

@property (nonatomic , assign) NSTimeInterval animationDuration;

//以下2个属性  2014.12.02 YX
@property (nonatomic, strong) NSArray *allDetails;
@property (nonatomic, strong) UILabel *detailLabel;
@end

@implementation CycleScrollView

- (void)setTotalPagesCount:(NSInteger (^)(void))totalPagesCount
{
    _totalPageCount = totalPagesCount();
    if (_totalPageCount > 0) {
        [self configContentViews];
        [self.animationTimer resumeTimerAfterTimeInterval:self.animationDuration];
    }
    
    //2014.12.02 YX
    if (_totalPageCount > 1) {
        self.pageControll.numberOfPages = self.totalPageCount;
    }
}

- (id)initWithFrame:(CGRect)frame animationDuration:(NSTimeInterval)animationDuration
{
    self = [self initWithFrame:frame];
    if (animationDuration > 0.0) {
        if (self.animationTimer) {
            [self.animationTimer invalidate];
            self.animationTimer = nil;
        }
        self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:(self.animationDuration = animationDuration)
                                                               target:self
                                                             selector:@selector(animationTimerDidFired:)
                                                             userInfo:nil
                                                              repeats:YES];
        [self.animationTimer pauseTimer];
        
        //2014.12.02 YX
        self.allDetails = [[NSArray alloc]init];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.autoresizesSubviews = YES;
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.autoresizingMask = 0xFF;
        self.scrollView.contentMode = UIViewContentModeCenter;
        self.scrollView.contentSize = CGSizeMake(3 * CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
        self.scrollView.delegate = self;
        self.scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.scrollView.frame), 0);
        self.scrollView.pagingEnabled = YES;
        [self addSubview:self.scrollView];
        self.currentPageIndex = 0;
    }
    return self;
}

#pragma mark -
#pragma mark - 私有函数

- (void)configContentViews
{
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self setScrollViewContentDataSource];
    
    NSInteger counter = 0;
        for (UIView *contentView in self.contentViews) {
            contentView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentViewTapAction:)];
            [contentView addGestureRecognizer:tapGesture];
            CGRect rightRect = contentView.frame;
            rightRect.origin = CGPointMake(CGRectGetWidth(self.scrollView.frame) * (counter ++), 0);
            
            contentView.frame = rightRect;
            [self.scrollView addSubview:contentView];
        }
        [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0)];
}

/**
 *  设置scrollView的content数据源，即contentViews
 */
- (void)setScrollViewContentDataSource
{
        NSInteger previousPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex - 1];
        NSInteger rearPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex + 1];
        if (self.contentViews == nil) {
            self.contentViews = [@[] mutableCopy];
        }
        [self.contentViews removeAllObjects];
        
        if (self.fetchContentViewAtIndex) {
            [self.contentViews addObject:self.fetchContentViewAtIndex(previousPageIndex)];
            [self.contentViews addObject:self.fetchContentViewAtIndex(_currentPageIndex)];
            [self.contentViews addObject:self.fetchContentViewAtIndex(rearPageIndex)];
        }
}

- (NSInteger)getValidNextPageIndexWithPageIndex:(NSInteger)currentPageIndex;
{
    if(currentPageIndex == -1) {
        return self.totalPageCount - 1;
    } else if (currentPageIndex == self.totalPageCount) {
        return 0;
    } else {
        return currentPageIndex;
    }
}

#pragma mark -
#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.animationTimer pauseTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.animationTimer resumeTimerAfterTimeInterval:self.animationDuration];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int contentOffsetX = scrollView.contentOffset.x;
    if(contentOffsetX >= (2 * CGRectGetWidth(scrollView.frame))) {
        self.currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex + 1];
        NSLog(@"next，当前页:%ld",(long)self.currentPageIndex);
        [self configContentViews];
    }
    if(contentOffsetX <= 0) {
        self.currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex - 1];
        NSLog(@"previous，当前页:%ld",(long)self.currentPageIndex);
        [self configContentViews];
    }
    //以下三行代码  2014.12.02  YX
    self.pageControll.currentPage = self.currentPageIndex;
    if (self.allDetails && self.allDetails.count > 0) {
        self.detailLabel.text = [self.allDetails objectAtIndex:self.currentPageIndex];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [scrollView setContentOffset:CGPointMake(CGRectGetWidth(scrollView.frame), 0) animated:YES];
}

#pragma mark -
#pragma mark - 响应事件

- (void)animationTimerDidFired:(NSTimer *)timer
{
    CGPoint newOffset = CGPointMake(self.scrollView.contentOffset.x + CGRectGetWidth(self.scrollView.frame), self.scrollView.contentOffset.y);
    [self.scrollView setContentOffset:newOffset animated:YES];
}

- (void)contentViewTapAction:(UITapGestureRecognizer *)tap
{
    if (self.TapActionBlock) {
        self.TapActionBlock(self.currentPageIndex);
    }
}

//2014.12.02 YX
-(void)openThePageControllAndIsOpenImageDetails:(BOOL)openImageDetails andTheDetails:(NSArray *)details andState:(int)state
{
    UIView *detailView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 38, self.frame.size.width, 38)];
    detailView.backgroundColor = [UIColor clearColor];
//    detailView.alpha = 0.3;
    [self addSubview:detailView];
    
    if (state == 3) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,  self.frame.size.width, 38)];
        imageView.backgroundColor = [UIColor clearColor];
        imageView.image = [UIImage imageNamed:@"videohome_gallery_bg.png"];
        [detailView addSubview:imageView];
    }
    
    if (openImageDetails) {
        self.detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, detailView.frame.size.width - 100, detailView.frame.size.height)];
        self.detailLabel.backgroundColor = [UIColor clearColor];
        self.detailLabel.font = [UIFont systemFontOfSize:16.0];
        self.detailLabel.textColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        self.detailLabel.text = details[0];
        self.allDetails = details;
        [detailView  addSubview:self.detailLabel];
    }else{
        detailView.backgroundColor = [UIColor clearColor];
    }
    
//   self.pageControll  = [[PRJ_ScrollPageControl alloc]initWithFrame:CGRectMake(0, detailView.frame.size.height - 6 - 8, 320, 8)];
//    if (state == 1) {
//        self.pageControll.frame  = CGRectMake(0, 0, 160, detailView.frame.size.height);
//    }else if (state == 2){
//        self.pageControll.center = CGPointMake(detailView.frame.size.width / 2, self.pageControll.center.y);
//    }else if (state == 3){
//        self.pageControll.frame  = CGRectMake(detailView.frame.size.width - 210, 0 , 320, detailView.frame.size.height);
//    }
//    
//    self.pageControll.userInteractionEnabled = NO;
//    self.pageControll.hidesForSinglePage = YES;
//    self.pageControll.backgroundColor = [UIColor clearColor];
//    self.pageControll.currentPageIndicatorTintColor = [UIColor whiteColor];
//    [self.pageControll setNumberOfPages:self.totalPageCount];
//    [detailView addSubview:self.pageControll];
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
