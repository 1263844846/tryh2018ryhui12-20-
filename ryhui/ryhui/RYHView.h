//
//  Created by  on 15/9/12.
//  Copyright (c)  All rights reserved.
//

#import <UIKit/UIKit.h>

@class RYHView;
@protocol RYHviewDelegate <NSObject>

@optional

- (void)tabBar:(RYHView *)tabBar didSelectedIndex:(int)index;

//- (void)didbtn:(UIButton *)btn;
@end

@interface RYHView : UIView

@property(nonatomic,strong)NSString * str;
@property (nonatomic, assign) id<RYHviewDelegate> delegate;
- (void)btnClick:(UIButton *)buttond;
+ (instancetype)Shareview;
@end
