//
//  RHMyGiftViewController.h
//  ryhui
//
//  Created by jufenghudong on 15/4/14.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHBaseViewController.h"
#import "RHSegmentContentView.h"
typedef void(^myblock)() ;
@interface RHMyGiftViewController : RHBaseViewController<RHSegmentContentViewDelegate>

@property(nonatomic,copy)myblock myblock;
@end
