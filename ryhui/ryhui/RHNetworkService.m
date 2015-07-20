//
//  RHNetworkService.m
//  ryhui
//
//  Created by stefan on 15/2/13.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHNetworkService.h"
#import "RHGesturePasswordViewController.h"
#import "MBProgressHUD.h"
#import "RHMainViewController.h"
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
    
//    return @"https://123.57.133.7/";
    return @"https://app.ryhui.com/";

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
    
//    return @"https://123.57.133.7/";
    
    return @"https://app.ryhui.com/";
    
#ifdef DEBUG
    return @"https://www.ryhui.com/";
#else
    return @"http://app.ryhui.com/";
#endif
}

-(AFHTTPRequestOperation*)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(AFHTTPRequestOperation *opp, id ress))success failure:(void (^)(AFHTTPRequestOperation *opp, NSError *rss))failure
{
    
    self.delegate = [UIApplication sharedApplication].delegate;
    UINavigationController *navi = (UINavigationController *)self.delegate.window.rootViewController;
    UIViewController *vc;
    if (navi) {
        vc = navi.viewControllers[navi.viewControllers.count - 1];
        if (vc != nil) {
            [MBProgressHUD showHUDAddedTo:vc.view animated:YES];
        }
    }
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userTimeOut:) name:@"UserTimeOut" object:nil];
    

    
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    [manager.operationQueue cancelAllOperations];
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
    
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"RHSESSION"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if ([RHUserManager sharedInterface].username&&[[RHUserManager sharedInterface].username length]>0) {
        if ([[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@Gesture",[RHUserManager sharedInterface].username]]&&[[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@Gesture",[RHUserManager sharedInterface].username]] length]>0) {
            RHGesturePasswordViewController* controller=[[RHGesturePasswordViewController alloc]init];
//            controller.isEnter = YES;

            UINavigationController *nv = [[RHTabbarManager sharedInterface] selectTabbarMain];
            UINavigationController *nv1 = [[RHTabbarManager sharedInterface] selectTabbarMore];
            UINavigationController *nv2 = [[RHTabbarManager sharedInterface] selectTabbarUser];
            UINavigationController *navi = (UINavigationController *)self.delegate.window.rootViewController;
            UIViewController *vc = navi.viewControllers[navi.viewControllers.count - 1];
            
            if (vc != nil) {
                [MBProgressHUD showHUDAddedTo:vc.view animated:YES];
            }
            
            if ([vc.navigationController isEqual:nv ]) {
                [vc.navigationController pushViewController:controller animated:NO];
            }
            
            if ([vc.navigationController isEqual:nv1]) {
                [vc.navigationController pushViewController:controller animated:NO];
            }
            if ([vc.navigationController isEqual:nv2]) {
                [vc.navigationController pushViewController:controller animated:NO];
            }
        }
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
