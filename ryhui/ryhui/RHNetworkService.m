//
//  RHNetworkService.m
//  ryhui
//
//  Created by stefan on 15/2/13.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHNetworkService.h"
#import "RHGesturePasswordViewController.h"
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
    
    
    
    //localTest
//    return @"http://192.168.1.112:8080/TinyFinance/";
    
    return @"https://123.57.133.7/";
//    return @"https://app.ryhui.com/";

#ifdef DEBUG
    return @"https://www.ryhui.com/";
#else
    return @"https://app.ryhui.com/";
#endif
}
-(NSString*)doMainhttp
{
    
    //localTest
//    return @"http://192.168.1.112:8080/TinyFinance/";
    
    return @"https://123.57.133.7/";
    
//    return @"https://app.ryhui.com/";
    
#ifdef DEBUG
    return @"https://www.ryhui.com/";
#else
    return @"http://app.ryhui.com/";
#endif
}

-(AFHTTPRequestOperation*)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(AFHTTPRequestOperation *opp, id ress))success failure:(void (^)(AFHTTPRequestOperation *opp, NSError *rss))failure
{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userTimeOut:) name:@"UserTimeOut" object:nil];
    
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


-(void)userTimeOut:(NSNotification *)noty {
    self.delegate = [UIApplication sharedApplication].delegate;
    if ([RHUserManager sharedInterface].username&&[[RHUserManager sharedInterface].username length]>0) {
        [self.delegate sessionFail:nil];
        if ([[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@Gesture",[RHUserManager sharedInterface].username]]&&[[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@Gesture",[RHUserManager sharedInterface].username]] length]>0) {
            RHGesturePasswordViewController* controller=[[RHGesturePasswordViewController alloc]init];
            controller.isEnter = YES;
            UINavigationController *navi = (UINavigationController *)self.delegate.window.rootViewController;
            UIViewController *vc = navi.viewControllers[navi.viewControllers.count - 1];
            [vc.navigationController pushViewController:controller animated:YES];
        }
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
