//
//  RHUserManager.h
//  ryhui
//
//  Created by stefan on 15/3/15.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RHUserManager : NSObject

@property(nonatomic,strong)NSString *username;

@property(nonatomic,strong)NSString *infoType;

@property(nonatomic,strong)NSString *custId;

@property(nonatomic,strong)NSString *telephone;

@property(nonatomic,strong)NSString *md5;

@property(nonatomic,strong)NSString *email;

@property(nonatomic,strong)NSString *userId;

@property(nonatomic,strong)NSString *balance;

+(instancetype)sharedInterface;

-(void)logout;

@end
