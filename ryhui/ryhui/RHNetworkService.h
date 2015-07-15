//
//  RHNetworkService.h
//  ryhui
//
//  Created by stefan on 15/2/13.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RHNetworkService : NSObject

@property(nonatomic,strong)NSString* niubiMd5;
@property (nonatomic, strong) AppDelegate *delegate;

+(RHNetworkService*)instance;

-(NSString*)doMain;
-(NSString*)doMainhttp;

- (AFHTTPRequestOperation*)POST:(NSString *)URLString
                     parameters:(id)parameters
                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;


@end
