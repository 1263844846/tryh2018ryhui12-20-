//
//  RHhelper.m
//  ryhui
//
//  Created by 糊涂虫 on 16/2/1.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import "RHhelper.h"

@implementation RHhelper



+(instancetype)ShraeHelp{
    
    static RHhelper *help = nil;
    
    static dispatch_once_t oncegcd;
    
    dispatch_once(&oncegcd, ^{
        help = [RHhelper new];
    });
    
    
    return help;
}
- (void)loadhelpWith:(NSString *)urlstring{
    
    
    
    
}

@end
