//
//  RHNetworkService.h
//  ryhui
//
//  Created by 江 云龙 on 15/2/13.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RHNetworkService : NSObject

@property(nonatomic,strong)NSString* session;

@property(nonatomic,strong)NSString* niubiMd5;

+(RHNetworkService*)instance;

-(NSString*)doMain;

- (AFHTTPRequestOperation*)POST:(NSString *)URLString
                     parameters:(id)parameters
                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;


@end
