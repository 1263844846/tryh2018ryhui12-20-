//
//  RHmainModel.h
//  ryhui
//
//  Created by 糊涂虫 on 15/11/25.
//  Copyright © 2015年 stefan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RHmainModel : NSObject

@property(nonatomic,strong)NSString * maintest;

@property(nonatomic,strong)NSString * hongbao;

@property(nonatomic,strong)NSString * tabbarstr;
@property(nonatomic,strong)NSString * mainhide;

@property(nonatomic,strong)NSString * urlstr;
@property(nonatomic,strong)NSString * imagestr;
+(instancetype)ShareRHmainModel;

@end
