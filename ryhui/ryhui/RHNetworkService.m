//
//  RHNetworkService.m
//  ryhui
//
//  Created by stefan on 15/2/13.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHNetworkService.h"

static RHNetworkService* _instance;

@implementation RHNetworkService
@synthesize niubiMd5;

+(RHNetworkService*)instance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance=[[RHNetworkService alloc]init];
    });
    return _instance;
}
-(NSString*)doMain
{
    return @"https://www.ryhui.com/";

#ifdef DEBUG
    return @"https://www.ryhui.com/";
#else
    return @"https://www.ryhui.com/";
#endif
}
-(NSString*)doMainhttp
{
    return @"https://www.ryhui.com/";
    
#ifdef DEBUG
    return @"https://www.ryhui.com/";
#else
    return @"http://www.ryhui.com/";
#endif
}

-(AFHTTPRequestOperation*)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
{
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    NSString* session=[[NSUserDefaults standardUserDefaults] objectForKey:@"RHSESSION"];
    if (session&&[session length]>0) {
        [manager.requestSerializer setValue:session forHTTPHeaderField:@"cookie"];
    }
    return [manager POST:[NSString stringWithFormat:@"%@%@",[self doMain],URLString]
              parameters:parameters
    constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    }
                 success:success
                 failure:failure];
    
}



@end
