//
//  CMSCoinView.m
//  FlipViewTest
//
//  Created by Rebekah Claypool on 10/1/13.
//  Copyright (c) 2013 Coffee Bean Studios. All rights reserved.
//

#import "CMSCoinView.h"

//#import"UIColor+DQCOLOUR.h"

@interface CMSCoinView (){
    bool displayingPrimary;
}
@end

@implementation CMSCoinView
@synthesize primaryView=_primaryView, secondaryView=_secondaryView, spinTime;

- (id) initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        displayingPrimary = YES;
        spinTime = 1.0;
    }
    return self;
}

- (id) initWithPrimaryView: (UIView *) primaryView andSecondaryView: (UIView *) secondaryView inFrame: (CGRect) frame{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.primaryView = primaryView;
        self.secondaryView = secondaryView;
        
        displayingPrimary = YES;
        spinTime = 1.0;
    }
    return self;
}

- (void) setPrimaryView:(UIView *)primaryView{
    
    float a;
    float b;
    if ([UIScreen mainScreen].bounds.size.width >320) {
        a = 1;
    }else{
        
        a = 0;
    }
    if ([UIScreen mainScreen].bounds.size.width >375) {
        b= 1;
    }
    
    UIImageView * cbximage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"PNG_红包白底"]];
    cbximage.frame = CGRectMake(primaryView.frame.origin.x, primaryView.frame.origin.y, primaryView.frame.size.width-15, 139);
    
    [primaryView addSubview:cbximage];
    
    self.bximage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"红包页-06"]];
    self.bximage.frame = CGRectMake(cbximage.frame.size.width-52, primaryView.frame.origin.y+5, 45, 45);
    self.bximage.userInteractionEnabled = YES;
    [primaryView addSubview:self.bximage];
    
    self.namelab = [[UILabel alloc]init];
    
    self.namelab.text = @"投资现金";
    self.namelab.textAlignment = UITextAlignmentCenter;
    self.namelab.font = [UIFont systemFontOfSize:14+ a* 3];
    
    self.namelab.frame = CGRectMake(8+ a *10, 35, 65 +a*10, 28);
    
    [primaryView addSubview:self.namelab];
    
    self.namelab1 = [[UILabel alloc]init];
    
    self.namelab1.text = @"出借时使用";
    
    self.namelab1.font = [UIFont systemFontOfSize:10 + a*3];
    
    self.namelab1.frame = CGRectMake(10 + a *10,55, 60+ a *10, 40);
    self.namelab1.textColor =  [RHUtility colorForHex:@"#f89779"];
    [primaryView addSubview:self.namelab1];
    
    
    self.monerylab = [[UILabel alloc]init];
    
    self.monerylab.text = @"¥ 5000";
    
    self.monerylab.font = [UIFont systemFontOfSize:30 + a*3];
    
    //if ([self.namelab.text isEqualToString:@"现金劵"]) {
    
    //        self.monerylab.frame = CGRectMake(70 +a *20+30, 30, 140+a *10, 40);
    //        self.monerylab.textColor =  [UIColor colorWithHexString:@"#ffb618"];
    //  }else{
    
    self.monerylab.frame = CGRectMake(70 +a *20+15+b*15, 10+5, 140+a *10, 40);
    self.monerylab.textColor =  [RHUtility colorForHex:@"#f89779"];
    // }
    
    
    [primaryView addSubview:self.monerylab];
    
    self.secondmonry = [[UILabel alloc]init];
    CGSize size = [self.monerylab.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:self.monerylab.font,NSFontAttributeName, nil]];
    CGFloat nameW = size.width;
    //    self.coinView.namelab.font = [UIFont fontWithName:@"Helvetica Neue Bold" size:25+a*3];
    
    self.monerylab.frame = CGRectMake(self.monerylab.frame.origin.x, self.monerylab.frame.origin.y, nameW, self.monerylab.frame.size.height);
    //self.coinView.monerylab.backgroundColor = [UIColor redColor];
    
    
    self.secondmonry.frame = CGRectMake(CGRectGetMaxX(self.monerylab.frame), CGRectGetMinY(self.monerylab.frame)+15, 50, 20);
    self.secondmonry.font = [UIFont systemFontOfSize:20 + a*3];
    
    [primaryView addSubview:self.secondmonry];
    self.mouthlab = [[UILabel alloc]init];
    //[primaryView addSubview:self.mouthlab];
    
    self.takelab = [[UILabel alloc]init];
    
    self.takelab.text = @"单笔投资满20000元";
    
    self.takelab.font = [UIFont systemFontOfSize:10+a*2];
    
    self.takelab.frame = CGRectMake(70 +a*20+15+b*15, 60-10+5, 180, 15);
    self.takelab.textColor = [RHUtility colorForHex:@"#f89779"];
    [primaryView addSubview:self.takelab];
    
    self.addlab = [[UILabel alloc]init];
    
    self.addlab.text = @"感恩节出借礼金";
    
    self.addlab.font = [UIFont systemFontOfSize:10+a*2];
    
    self.addlab.frame = CGRectMake(70 +a*20+15+b*15, 75-10+5, 160, 15);
    self.addlab.textColor =  [RHUtility colorForHex:@"#f89779"];
    [primaryView addSubview:self.addlab];
    
    
    self.timelab = [[UILabel alloc]init];
    
    self.timelab.text = @"有效期至：2015-12-26";
    
    self.timelab.font = [UIFont systemFontOfSize:10+a*2];
    
    self.timelab.frame = CGRectMake(70 +a*20+15+b*15, 90-10+5, 170, 15);
    self.timelab.textColor =  [RHUtility colorForHex:@"#f89779"];
    [primaryView addSubview:self.timelab];
    
    self.fourlab = [[UILabel alloc]init];
    self.fourlab.frame = CGRectMake(10 + a *10,107, 60+ a *10+100, 15);
    self.fourlab.text = @"融益汇增加公告消息";
    self.fourlab.font = [UIFont systemFontOfSize:8 + a*2];
    [primaryView addSubview:self.fourlab];
    
    
    self.button = [[UIButton alloc]init];
    
    self.button.frame = CGRectMake(cbximage.frame.size.width-60-a*10, 40, 40, 40);
    
    [self.button setImage:[UIImage imageNamed:@"红包页-09"] forState:UIControlStateNormal];
    [primaryView addSubview:self.button];
    
    
    self.shiyolab = [[UILabel alloc]init];
    self.shiyolab.frame = CGRectMake(cbximage.frame.size.width-50-a*10, 15, 30, 90);
    self.shiyolab.numberOfLines = 0;
    self.shiyolab.text = @"";
    //    self.shiyolab.backgroundColor = [UIColor redColor];
    self.shiyolab.font = [UIFont systemFontOfSize:20];
    
    [primaryView addSubview:self.shiyolab];
    
    _primaryView = primaryView;
    CGRect frame = CGRectMake(0, 0, self.frame.size.width, 139);
    [self.primaryView setFrame: frame];
    [self roundView: self.primaryView];
    self.primaryView.userInteractionEnabled = YES;
    [self addSubview: self.primaryView];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(flipTouched:)];
    gesture.numberOfTapsRequired = 1;
    [self.bximage addGestureRecognizer:gesture];
    [self roundView:self];
    self.bigbtn = [[UIButton alloc]init];
    
    self.bigbtn.frame = CGRectMake( 10, 10, 200, 80);
    //    self.bigbtn.backgroundColor = [UIColor redColor];
    [primaryView addSubview:self.bigbtn];
    
    [self.bigbtn addTarget:self action:@selector(flipTouched:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void) setSecondaryView:(UIView *)secondaryView{
    
    
    self.firlab = [[UILabel alloc]init];
    self.firlab.text = @"1.出借时使用可抵扣出借本金;";
    
    self.firlab.font = [UIFont systemFontOfSize:13];
    
    self.firlab.frame = CGRectMake(30, 28, 300, 20);
    self.firlab.textColor =  [RHUtility colorForHex:@"#FFFFFF"];
    [secondaryView addSubview:self.firlab];
    
    self.twolab = [[UILabel alloc]init];
    
    self.twolab.text = @"2.使用条件：单笔投资满20000元";
    
    self.twolab.font = [UIFont systemFontOfSize:13];
    
    self.twolab.frame = CGRectMake(30 , 48, 240, 20);
    self.twolab.textColor =  [RHUtility colorForHex:@"#FFFFFF"];
    [secondaryView addSubview:self.twolab];
    
    self.threelab = [[UILabel alloc]init];
    
    self.threelab.text = @"3.限2个月以上项目";
    
    self.threelab.font = [UIFont systemFontOfSize:13];
    
    self.threelab.frame = CGRectMake(30 , 68, 240, 20);
    self.threelab.textColor =  [RHUtility colorForHex:@"#FFFFFF"];
    [secondaryView addSubview:self.threelab];
    
    
    self.forlab = [[UILabel alloc]init];
    
    self.forlab.text = @"4.债券转让项目不可使用";
    
    self.forlab.font = [UIFont systemFontOfSize:13];
    
    self.forlab.frame = CGRectMake(30, 88, 240, 20);
    self.forlab.textColor =  [RHUtility colorForHex:@"#FFFFFF"];
    [secondaryView addSubview:self.forlab];
    
    
    
    _secondaryView = secondaryView;
    CGRect frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-15, 134);
    [self.secondaryView setFrame: frame];
    [self roundView: self.secondaryView];
    self.secondaryView.userInteractionEnabled = YES;
    [self addSubview: self.secondaryView];
    [self sendSubviewToBack:self.secondaryView];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(flipTouched:)];
    gesture.numberOfTapsRequired = 1;
    [self.secondaryView addGestureRecognizer:gesture];
    //[self roundView:self];
    _secondaryView.hidden = YES;
    
}
- (void) roundView: (UIView *) view{
    //    [view.layer setCornerRadius: (self.frame.size.height/2)];
    //    [view.layer setMasksToBounds:YES];
}

-(IBAction) flipTouched:(id)sender{
    _secondaryView.hidden = NO;
    [UIView transitionFromView:(displayingPrimary ? self.primaryView : self.secondaryView)
                        toView:(displayingPrimary ? self.secondaryView : self.primaryView)
                      duration: spinTime
                       options: UIViewAnimationOptionTransitionFlipFromLeft+UIViewAnimationOptionCurveEaseInOut
                    completion:^(BOOL finished) {
                        if (finished) {
                            //UIView *view = (displayingPrimary ? view1 : view2);
                            
                            displayingPrimary = !displayingPrimary;
                        }
                    }
     ];
}

-(void)nsl{
    
    
    NSLog(@"2234343453cbxcbx");
}
@end
