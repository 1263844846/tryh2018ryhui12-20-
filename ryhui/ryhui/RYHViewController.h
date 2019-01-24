//
//
//  Created by on 15/9/12.
//  Copyright (c) . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RYHView.h"
@interface RYHViewController : UITabBarController
@property(nonatomic,strong)RYHView * tarbar;
+(instancetype)Sharedbxtabar;
- (void)tabBar:(RYHView *)tabBar didSelectedIndex:(int)index;
@end
