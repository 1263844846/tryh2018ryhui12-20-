//
//  PRJ_ScrollPageControl.m
//  ChillingAmend
//
//  Created by svendson on 14-12-31.
//  Copyright (c) 2014年 SinoGlobal. All rights reserved.
//

#import "PRJ_ScrollPageControl.h"

@implementation PRJ_ScrollPageControl

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.numbners = [[NSMutableArray alloc]init];
        self.imageViews = [[NSMutableArray alloc]init];
        self.Heights = [[NSMutableArray alloc]init];
        self.Widths = [[NSMutableArray alloc]init];
        self.orginYs = [[NSMutableArray alloc]init];

    }

    
    return self;
}


- (void) setCurrentPage:(NSInteger)page {
    [super setCurrentPage:page];
    for (NSUInteger subviewIndex = 0; subviewIndex < [self.subviews count]; subviewIndex++) {
        UIImageView* subview = [self.subviews objectAtIndex:subviewIndex];
        
        UIImageView *firstImageView = [self.subviews objectAtIndex:0];
       float dexOringin = firstImageView.frame.origin.y;

        NSLog(@"----dexOringindexOringin-----%f",dexOringin);
        CGSize size;
        if (subviewIndex == page) {
            size.height = 7;
            size.width = 7;
        }else{
            size.height = 5;
            size.width = 5;
        }

        [subview setFrame:CGRectMake(subview.frame.origin.x, subview.frame.origin.y,
                                     size.width,size.height)];
        subview.backgroundColor = [UIColor whiteColor];
    }
}

//- (void) setCurrentPage:(NSInteger)page {
//    [super setCurrentPage:page];
//    
//    [self.imageViews removeAllObjects];
//    [self.numbners removeAllObjects];
//    [self.Widths removeAllObjects];
//    [self.Heights removeAllObjects];
//    [self.orginYs removeAllObjects];
//    for (NSUInteger subviewIndex = 0; subviewIndex < [self.subviews count]; subviewIndex++) {
//        float dexOringin = 0.0;
//
//        UIImageView *firstImageView = [self.subviews objectAtIndex:0];
//        dexOringin = firstImageView.frame.origin.x;
//        NSLog(@"-----dexOringindexOringin-----%f",dexOringin);
//        
//        UIImageView* subview = (UIImageView *)[self.subviews objectAtIndex:subviewIndex];
//        
//        [self.imageViews addObject:subview];
//        
//         CGSize size;
//        if (subviewIndex == page) {
//            size.height = 7;
//            size.width = 7;
//        }else{
//            size.height = 5;
//            size.width = 5;
//        }
//
//        [self.numbners addObject:[NSNumber numberWithFloat:(dexOringin + subviewIndex * 7 + subviewIndex * 7) ]];
//        
//        [self.Heights addObject:[NSNumber numberWithFloat:size.height]];
//        
//        [self.orginYs addObject:[NSNumber numberWithFloat:subview.frame.origin.y]];
//
//        [self.Widths addObject:[NSNumber numberWithFloat:size.width]];
//    }
//    
//    if (self.imageViews.count == [self.subviews count]) {
//        [self setTheSpaceWithCurrentPage:page];
//    }
//}

-(void)setTheSpaceWithCurrentPage:(NSInteger)page
{
    
    NSLog(@"-----------%d",self.imageViews.count);
    NSLog(@"-----------%@",self.orginYs);
    
    for ( int i = 0; i < self.imageViews.count ; i ++) {
        UIImageView *subView = self.imageViews[i];
        if (i == page) {
             subView.frame = CGRectMake([self.numbners[i] floatValue], [self.orginYs[i] floatValue], [self.Widths[i] floatValue],[self.Heights[i] floatValue]);
        }else{
            subView.frame = CGRectMake([self.numbners[i] floatValue], [self.orginYs[i] floatValue], [self.Widths[i] floatValue], [self.Heights[i] floatValue]);
        }
        subView.backgroundColor = [UIColor whiteColor];
    }
}
//-(float)sizeForNumberOfPages:(NSInteger)pages{
//    return _distanceOfPoint * (pages + 1) + _PointSize * pages;
//}
//
//-(void) setNumberOfPages:(NSInteger)pages{
//    
//    float size = [self sizeForNumberOfPages:pages];
//    
//    for (int i = 0; i < pages; i++) {
//        UIImageView * pointImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_distanceOfPoint +(_distanceOfPoint+_PointSize)*i, (self.frame.size.height-_PointSize)/2, _PointSize, _PointSize)];
//        [self addSubview:pointImageView];
//    }
//}
//
//- (void) setCurrentPage:(NSInteger)page {
//    int countOfPages = [self.subviews count];
//    
//    for (NSUInteger subviewIndex = 0; subviewIndex < countOfPages; subviewIndex++) {
//        UIImageView* subview = [self.subviews objectAtIndex:subviewIndex];
//        if (subviewIndex == page) {
//            self.PointSize = 7.0;
//            subview.image = [UIImage imageNamed:@"banner_img_default.png"];
//        }else{
//             self.PointSize = 3.0;
//            subview.image = [UIImage imageNamed:@"banner_img_selected.png"];
//        }
//    }
//}
@end
