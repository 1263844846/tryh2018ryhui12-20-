//
//  XMyScrollView.h
//  ImageScrollAndClick
//
//  Created by svendson on 14-5-30.
//  Copyright (c) 2014年 SinoGlobal. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XmyScrollViewDelegate;
@protocol XmyScrollViewDatasource;
@interface XMyScrollView : UIView<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIPageControl *pageControl;
@property(nonatomic,assign)int totalPages;
@property(nonatomic,strong)NSMutableArray* curViews;
@property (nonatomic,assign) int currentPage;
@property (nonatomic,assign,setter = setDataource:) id<XmyScrollViewDatasource> datasource;
@property (nonatomic,assign,setter = setDelegate:) id<XmyScrollViewDelegate> delegate;
@property(nonatomic,strong)UIView* myView;
//@property(nonatomic,strong)UILabel* label;
//@property(nonatomic,strong)NSString* currenrtString;

//@property(nonatomic,strong)NSMutableArray* ziMu;
@property (nonatomic, strong) NSTimer *timer;
@property(nonatomic)int x;

- (void)reloadData;
- (void)setViewContent:(UIView *)view atIndex:(NSInteger)index;

@end

@protocol XmyScrollViewDelegate <NSObject>

@optional
- (void)didClickPage:(XMyScrollView *)csView atIndex:(NSInteger)index;

//-(void)getStringByTap:(NSString*)string;
//-(void)getZiMuStringByTap:(NSString*)string;
@end

@protocol XmyScrollViewDatasource <NSObject>

@required
- (NSInteger)numberOfPages;
- (UIView *)scrollViewPageAtIndex:(NSInteger)index;


@end
