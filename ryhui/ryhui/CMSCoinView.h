//
//  CMSCoinView.h
//  FlipViewTest
//
//  Created by Rebekah Claypool on 10/1/13.
//  Copyright (c) 2013 Coffee Bean Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMSCoinView : UIView

- (id) initWithPrimaryView: (UIView *) view1 andSecondaryView: (UIView *) view2 inFrame: (CGRect) frame;

@property (nonatomic, retain) UIView *primaryView;
@property (nonatomic, retain) UIView *secondaryView;
@property float spinTime;

-(IBAction) flipTouched:(id)sender;
//第一个视图
@property(nonatomic,strong)UIImageView * bximage;

@property(nonatomic,strong)UIButton * button;
@property(nonatomic,strong)UILabel * namelab;
@property(nonatomic,strong)UILabel * namelab1;
@property(nonatomic,strong)UIButton *bigbtn;

@property(nonatomic,strong)UILabel * monerylab;
@property(nonatomic,strong)UILabel * takelab;
@property(nonatomic,strong)UILabel * addlab;
@property(nonatomic,strong)UILabel * timelab;
@property(nonatomic,strong)UILabel * fourlab;

//@property(nonatomic,strong)

@property(nonatomic,strong)UILabel * shiyolab;

@property(nonatomic,strong)UILabel * mouthlab;
@property(nonatomic,strong)UILabel * secondmonry;
//第二个视图
- (void)nsl;
@property(nonatomic,strong)UILabel * twolab;
@property(nonatomic,strong)UILabel * threelab;
@property(nonatomic,strong)UILabel * firlab;
@property(nonatomic,strong)UILabel * forlab;
@end
