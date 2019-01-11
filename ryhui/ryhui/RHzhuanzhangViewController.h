//
//  RHzhuanzhangViewController.h
//  ryhui
//
//  Created by 糊涂虫 on 17/8/3.
//  Copyright © 2017年 stefan. All rights reserved.
//

#import "RHBaseViewController.h"
typedef void (^baofuBlock)(NSArray* dic);
@interface RHzhuanzhangViewController : RHBaseViewController
@property(nonatomic,strong)UINavigationController * nav;
@property(nonatomic,strong)NSDictionary *bankdic;
@property(nonatomic,copy)NSString *bancle;
@property(nonatomic,copy)baofuBlock baofumykjblock;
@end
