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

-(NSString *)newdoMain{
    //zhouming
//     return @"http://223.223.180.146:8096/TinyFinance/";
    
    //laoniu
//    return @"http://223.223.180.146:8093/TinyFinance/";
    //wuzhiqiang
    
//    return @"http://39.106.110.53/";
//  return @"http://223.223.180.146:8097/TinyFinance/";
//
//    return @"https://123.57.133.7/";
   return @"https://123.57.133.7/TinyFinance4/";
    return @"https://www.ryhui.com/";
//    return @"http://223.223.180.146:8093/TinyFinance/";
}

+ (AFSecurityPolicy*)customSecurityPolicy
{
    // /先导入证书
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"server" ofType:@"cer"];//证书的路径
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
//    NSSet * certSet = [[NSSet alloc] initWithObjects:certData, nil];
    // AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = NO;
    
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = NO;
    
    securityPolicy.pinnedCertificates = @[certData];
    
    return securityPolicy;
}
- (AFSecurityPolicy*)customSecurityPolicy
{
  
    // /先导入证书
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"server1" ofType:@"cer"];//证书的路径
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    NSSet * certSet = [[NSSet alloc] initWithObjects:certData, nil];
    // AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    [securityPolicy setValidatesDomainName:NO];
    
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
//    securityPolicy.validatesDomainName = NO;
    
//    securityPolicy.pinnedCertificates = @[certData];
    [securityPolicy setPinnedCertificates:certSet];
   
    return securityPolicy;
    
    
}

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
    
//   return @"https://app.ryhui.com/";
    
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
   // UITableView * tableview =(UITableView *) [vc.view viewWithTag:717];
    if (navi) {
        vc = navi.viewControllers[navi.viewControllers.count - 1];
        if (vc != nil) {
            
//            if ([self.rhafn isEqualToString:@"yanan"]) {
//                //manager.panduan = @"zhuanquan";
//            }else{

           // [MBProgressHUD showHUDAddedTo:vc.view animated:YES];
//            }
        }
    }
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userTimeOut:) name:@"UserTimeOut" object:nil];
    

    
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    if ([self.rhafn isEqualToString:@"yanan"]) {
        manager.panduan = @"zhuanquan";
    }

    
    [manager.securityPolicy setAllowInvalidCertificates:YES];
      manager.securityPolicy = [self customSecurityPolicy];
//    [manager setSecurityPolicy:[self customSecurityPolicy]];
     [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    [manager.operationQueue cancelAllOperations];
    
    
     
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString* session=[[NSUserDefaults standardUserDefaults] objectForKey:@"RHSESSION"];
    if (session&&[session length]>0) {
        [manager.requestSerializer setValue:session forHTTPHeaderField:@"cookie"];
        
    }
    
    
    return [manager POST:[NSString stringWithFormat:@"%@%@",[self newdoMain],URLString]
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
