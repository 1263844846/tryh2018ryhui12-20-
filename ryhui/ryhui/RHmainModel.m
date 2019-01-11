//
//  RHmainModel.m
//  ryhui
//
//  Created by 糊涂虫 on 15/11/25.
//  Copyright © 2015年 stefan. All rights reserved.
//

#import "RHmainModel.h"

@implementation RHmainModel

+(instancetype)ShareRHmainModel{
    
   static RHmainModel * model = nil;
    
    if (model == nil) {
        model = [RHmainModel new];
    }
    return model;
    
}

@end
