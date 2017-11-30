//
//  AppDelegate.m
//  ryhui
//
//  Created by stefan on 15/2/13.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "AppDelegate.h"
#import "RHLoginViewController.h"
#import "RHGesturePasswordViewController.h"
#import "RHMainViewController.h"
#import <ShareSDK/ShareSDK.h>
//#import "WXApi.h"
//#import "WeiboSDK.h"
#import "RHMyMessageViewController.h"
#import "RHMyGiftViewController.h"
#import "RHProjectListViewController.h"

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <ShareSDKUI/SSUIShareActionSheetStyle.h>
//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "RHmainModel.h"
//微信SDK头文件
#import "WXApi.h"

//新浪微博SDK头文件
#import "WeiboSDK.h"
//新浪微博SDK需要在项目Build Settings中的Other Linker Flags添加"-ObjC"

//人人SDK头文件
//#import <RennSDK/RennSDK.h>
#import <SobotKit/SobotKit.h>
#import <UserNotifications/UserNotifications.h>
#define SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#import "FirstAnimationViewController.h"
@interface AppDelegate ()<UNUserNotificationCenterDelegate>
@property(nonatomic,assign)BOOL updatares;
@end

@implementation AppDelegate
@synthesize window=_window;
@synthesize isNotificationCenter = _isNotificationCenter;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
   
    application.statusBarHidden = NO;
    _isNotificationCenter = NO;
    
   /*
    [[RHNetworkService instance] POST:@"app/common/appMain/appImportantVersion" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        //        DLog(@"%@",responseObject);
        [RHmainModel ShareRHmainModel].urlstr = responseObject[@"link"];
        [RHmainModel ShareRHmainModel].imagestr = responseObject[@"imageUrl"];
//        
        [self chooseWindowToIndicate1];
//       
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
        [self chooseWindowToIndicate];
//        
    }];
   */
    [UIApplication sharedApplication].statusBarStyle=UIStatusBarStyleLightContent;
     [self updataAPP];
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    [self.window makeKeyWindow];
    
    [self chooseWindowToIndicate];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sessionFail:) name:@"RHSESSIONFAIL" object:nil];
    
    //分享
    [self initShareSDK];

    //推送
    [self registerJPushNotifyWithLauchOptions:launchOptions];
    // Required
    [APService setupWithOption:launchOptions];
    [APService setBadge:0];
    
    //统计
    [MobClick startWithAppkey:@"554c126f67e58e7434007259" reportPolicy:BATCH   channelId:@""];
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    [MobClick setCrashReportEnabled:YES];
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"AppUpdate"];
    
    self.isAPPActive = NO;
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    
    if (SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(@"10")) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert |UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (!error) {
                [[UIApplication sharedApplication] registerForRemoteNotifications];
            }
        }];
    }else{
        [self registerPush:application];
    }
    
    // 获取APPKEY
    NSString *APPKEY = @"75bdfe3a9f9c4b8a846e9edc282c92b4";
    [[ZCLibClient getZCLibClient] setAppKey:APPKEY];
    
    [self getaddress];
    
    return YES;
}

-(void)getaddress{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = [[RHNetworkService instance] customSecurityPolicy];
    manager.responseSerializer = [[AFCompoundResponseSerializer alloc]init];
    [manager POST:@"http://223.223.180.146:8097/TinyFinance/app/common/appMain/localAddress" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
     //   usleep(0.1);
        if ([responseObject isKindOfClass:[NSData class]]) {
           
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //        DLog(@"%@",error);
        //[RHUtility showTextWithText:@"过几秒后重新获取"];
    }];
  
    
}
-(void)registerPush:(UIApplication *)application{
    // ios8后，需要添加这个注册，才能得到授权
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        //IOS8
        //创建UIUserNotificationSettings，并设置消息的显示类类型
        UIUserNotificationSettings *notiSettings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIRemoteNotificationTypeSound) categories:nil];
        
        [application registerUserNotificationSettings:notiSettings];
        
    } else{ // ios7
        [application registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge                                       |UIRemoteNotificationTypeSound                                      |UIRemoteNotificationTypeAlert)];
    }
}


- (void)chooseWindowToIndicate1{
    NSString* guidan=[[NSUserDefaults standardUserDefaults] objectForKey:@"RHGUIDAN"];
    if (!guidan) {
        
        [[RHTabbarManager sharedInterface] selectGuidan];
        
        [[NSUserDefaults standardUserDefaults] setObject:@"123" forKey:@"RHGUIDAN"];
    }else{
        if ([RHUserManager sharedInterface].username&&[[RHUserManager sharedInterface].username length]>0) {
            [self sessionFail:nil];
            if ([[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@Gesture",[RHUserManager sharedInterface].username]]&&[[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@Gesture",[RHUserManager sharedInterface].username]] length]>0) {
                //                RHGesturePasswordViewController* controller=[[RHGesturePasswordViewController alloc]init];
                //                UINavigationController* nav=[[UINavigationController alloc]initWithRootViewController:controller];
                //
                //                self.window.rootViewController=nav;
                //                [[RHTabbarManager sharedInterface] selectLogin];
                FirstAnimationViewController* controller=[[FirstAnimationViewController alloc]initWithNibName:@"FirstAnimationViewController" bundle:nil];
                UINavigationController* nav=[[UINavigationController alloc]initWithRootViewController:controller];
                
                self.window.rootViewController=nav;
                
            }else{
                //                RHGesturePasswordViewController* controller=[[RHGesturePasswordViewController alloc]init];
                //                controller.isReset=YES;
                //                UINavigationController* nav=[[UINavigationController alloc]initWithRootViewController:controller];
                //
                //                self.window.rootViewController=nav;
                //                [[RHTabbarManager sharedInterface] selectLogin];
                FirstAnimationViewController* controller=[[FirstAnimationViewController alloc]initWithNibName:@"FirstAnimationViewController" bundle:nil];
                UINavigationController* nav=[[UINavigationController alloc]initWithRootViewController:controller];
                
                self.window.rootViewController=nav;
            }
        }else{
            [[RHTabbarManager sharedInterface] selectLogin];
            FirstAnimationViewController* controller=[[FirstAnimationViewController alloc]initWithNibName:@"FirstAnimationViewController" bundle:nil];
            UINavigationController* nav=[[UINavigationController alloc]initWithRootViewController:controller];
            
            AppDelegate* delegate=[UIApplication sharedApplication].delegate;
            delegate.window.rootViewController=nav;
            //
            //             [[RHTabbarManager sharedInterface] initTabbar];
            //             [[[RHTabbarManager sharedInterface] selectTabbarMain] popToRootViewControllerAnimated:NO];
        }
    }

    
}
- (void)chooseWindowToIndicate {
    
  
        
    
  
    NSString* guidan=[[NSUserDefaults standardUserDefaults] objectForKey:@"RHGUIDAN"];
    if (!guidan) {
        
        [[RHTabbarManager sharedInterface] selectGuidan];
        
        [[NSUserDefaults standardUserDefaults] setObject:@"123" forKey:@"RHGUIDAN"];
    }else{
        if ([RHUserManager sharedInterface].username&&[[RHUserManager sharedInterface].username length]>0) {
            [self sessionFail:nil];
            if ([[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@Gesture",[RHUserManager sharedInterface].username]]&&[[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@Gesture",[RHUserManager sharedInterface].username]] length]>0) {
                RHGesturePasswordViewController* controller=[[RHGesturePasswordViewController alloc]init];
                UINavigationController* nav=[[UINavigationController alloc]initWithRootViewController:controller];
                
                self.window.rootViewController=nav;
                
            }else{
                RHGesturePasswordViewController* controller=[[RHGesturePasswordViewController alloc]init];
                controller.isReset=YES;
                UINavigationController* nav=[[UINavigationController alloc]initWithRootViewController:controller];
                
                self.window.rootViewController=nav;
            }
        }else{
            //            [[RHTabbarManager sharedInterface] selectLogin];
            [[RHTabbarManager sharedInterface] initTabbar];
            [[[RHTabbarManager sharedInterface] selectTabbarMain] popToRootViewControllerAnimated:NO];
        }
    }
    

    
   
}

-(void)registerJPushNotifyWithLauchOptions:(NSDictionary *)launchOptions
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [APService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                       UIUserNotificationTypeSound |
                                                       UIUserNotificationTypeAlert)
                                           categories:nil];
    } else {
        //categories 必须为nil
        [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                       UIRemoteNotificationTypeSound |
                                                       UIRemoteNotificationTypeAlert)
                                           categories:nil];
    }
#else
    //categories 必须为nil
    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                   UIRemoteNotificationTypeSound |
                                                   UIRemoteNotificationTypeAlert)
                                       categories:nil];
#endif
  
}

-(void)initShareSDK
{
//    [ShareSDK registerApp:@"6c23db79a7e8"];//字符串api20为您的ShareSDK的AppKey
//
//    //添加新浪微博应用 注册网址 http://open.weibo.com
//    [ShareSDK connectSinaWeiboWithAppKey:@"1083852544"
//                               appSecret:@"1d0c857bd233092ee0b2d69a494864b9"
//                             redirectUri:@"https://www.ryhui.com"];
//
////    //当使用新浪微博客户端分享的时候需要按照下面的方法来初始化新浪的平台
////    [ShareSDK  connectSinaWeiboWithAppKey:@"1083852544"
////                                appSecret:@"1d0c857bd233092ee0b2d69a494864b9"
////                              redirectUri:@"https://www.ryhui.com"
////                              weiboSDKCls:[WeiboSDK class]];
//    
//    
//    //添加微信应用 注册网址 http://open.weixin.qq.com
//   [ShareSDK connectWeChatWithAppId:@"wx2010bdd8c8c72a3f"
//                           wechatCls:[WXApi class]];

    
    [ShareSDK registerApp:@"6c23db79a7e8"
     
          activePlatforms:@[
                            @(SSDKPlatformTypeSinaWeibo),
                            @(SSDKPlatformTypeWechat)]
                 onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
            
             case SSDKPlatformTypeSinaWeibo:
                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                 break;
            
             default:
                 break;
         }
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
             case SSDKPlatformTypeSinaWeibo:
                 //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                 [appInfo SSDKSetupSinaWeiboByAppKey:@"1083852544"
                                           appSecret:@"1d0c857bd233092ee0b2d69a494864b9"
                                         redirectUri:@"https://www.ryhui.com"
                                            authType:SSDKAuthTypeBoth];
                 break;
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wx2010bdd8c8c72a3f"
                                       appSecret:@""];
                 break;
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:@"100371282"
                                      appKey:@"aed9b0303e3ed1e27bae87c33761161d"
                                    authType:SSDKAuthTypeBoth];
                 break;
             case SSDKPlatformTypeRenren:
                 [appInfo        SSDKSetupRenRenByAppId:@"226427"
                                                 appKey:@"fc5b8aed373c4c27a05b712acba0f8c3"
                                              secretKey:@"f29df781abdd4f49beca5a2194676ca4"
                                               authType:SSDKAuthTypeBoth];
                 break;
             case SSDKPlatformTypeGooglePlus:
                 [appInfo SSDKSetupGooglePlusByClientID:@"232554794995.apps.googleusercontent.com"
                                           clientSecret:@"PEdFgtrMw97aCvf0joQj7EMk"
                                            redirectUri:@"http://localhost"];
                 break;
             default:
                 break;
         }
     }];
    
    
}

-(void)sessionFail:(NSNotification*)nots
{
    NSDictionary* parameters=@{@"account":[RHUserManager sharedInterface].username,@"password":[RHUserManager sharedInterface].md5};

    NSString * str = @"app/common/user/appLogin/appLogin";
//    NSString * str1 = @"common/user/login/appLogin";
    [[RHNetworkService instance] POST:str parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        DLog(@"%@",responseObject);
        NSArray* array=[[operation.response.allHeaderFields objectForKey:@"Set-Cookie"] componentsSeparatedByString:@";"];
        [[NSUserDefaults standardUserDefaults] setObject:[array objectAtIndex:0] forKey:@"RHSESSION"];
        [[NSUserDefaults standardUserDefaults] synchronize];
//        DLog(@"%@",operation.response.allHeaderFields);
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSString* result=[responseObject objectForKey:@"md5"];
            if (result&&[result length]>0) {
                NSString* md5=[responseObject objectForKey:@"md5"];
                [RHNetworkService instance].niubiMd5=md5;
                
                NSString* _custId=[responseObject objectForKey:@"custId"];
                if (![_custId isKindOfClass:[NSNull class]]&&_custId&&[_custId length]>0) {
                    [RHUserManager sharedInterface].custId=_custId;
                    [[NSUserDefaults standardUserDefaults] setObject:[RHUserManager sharedInterface].custId forKey:@"RHcustId"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                }
                
                NSString* _email=[responseObject objectForKey:@"email"];
                if (![_email isKindOfClass:[NSNull class]]&&_email&&[_email length]>0) {
                    [RHUserManager sharedInterface].email=_email;
                    [[NSUserDefaults standardUserDefaults] setObject:[RHUserManager sharedInterface].email forKey:@"RHemail"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                }
                
                NSString* _infoType=[responseObject objectForKey:@"infoType"];
                if (_infoType&&[_infoType length]>0) {
                    [RHUserManager sharedInterface].infoType=_infoType;
                    [[NSUserDefaults standardUserDefaults] setObject:[RHUserManager sharedInterface].infoType forKey:@"RHinfoType"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                }
                
                NSString* _md5=[responseObject objectForKey:@"md5"];
                if (_md5&&[_md5 length]>0) {
                    [RHUserManager sharedInterface].md5=_md5;
                    [[NSUserDefaults standardUserDefaults] setObject:[RHUserManager sharedInterface].md5 forKey:@"RHmd5"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                }
                
                NSString* _telephone=[responseObject objectForKey:@"telephone"];
                if (_telephone&&[_telephone length]>0) {
                    [RHUserManager sharedInterface].telephone=_telephone;
                    [[NSUserDefaults standardUserDefaults] setObject:[RHUserManager sharedInterface].telephone forKey:@"RHtelephone"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                }
                NSString* _userid=[[responseObject objectForKey:@"userId"] stringValue];
                if (_userid&&[_userid length]>0) {
                    [RHUserManager sharedInterface].userId=_userid;
                    [[NSUserDefaults standardUserDefaults] setObject:[RHUserManager sharedInterface].userId forKey:@"RHUSERID"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                }
                //[MBProgressHUD hideHUDForView:self.view animated:YES];
            }
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"%@",error);
//        [[RHUserManager sharedInterface] logout];
        
//        if ([error.userInfo.allKeys containsObject:@"com.alamofire.serialization.response.error.data"]) {
//            NSDictionary* errorDic=[NSJSONSerialization JSONObjectWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] options:NSJSONReadingMutableContainers error:nil];
//            if ([errorDic objectForKey:@"msg"]) {
//                
//                [RHMobHua showTextWithText:[errorDic objectForKey:@"msg"]];
//            }
//        }
        
//        NSLog(@"%@",error);
    }];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    NSDate *date = [self getInternetDate];
    [[NSUserDefaults standardUserDefaults] setObject:date forKey:@"backTime"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    NSLog(@"-----------");
    NSDate *date = [self getInternetDate];
    [[NSUserDefaults standardUserDefaults] setObject:date forKey:@"backTime"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    self.isAPPActive = NO;
}


-(BOOL)getminutesTimeFromTime:(NSDate *)date compareTime:(NSDate *)date2{
    
    
   NSString *pass =  [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@Gesture",[RHUserManager sharedInterface].username]];;
    NSString * str =[[NSUserDefaults standardUserDefaults] objectForKey:@"RHUSERNAME"];
    if (pass.length <1&& str.length >0) {
        [[RHUserManager sharedInterface] logout];
    }
    
  
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy"];
    
    NSString *yearString=[dateFormatter stringFromDate:date];
    NSLog(@"------------%@",yearString);
    NSString *yearString1=[dateFormatter stringFromDate:date2];
    NSLog(@"------------%@",yearString1);
    
    if ([yearString integerValue] > [yearString1 integerValue]) {
        return YES;
    }
    
    [dateFormatter setDateFormat:@"MM"];
    
    NSString *monthString =[dateFormatter stringFromDate:date];
    NSString *monthString1 =[dateFormatter stringFromDate:date2];
    if ([monthString integerValue] > [monthString1 integerValue]) {
        return YES;
    }
    
    [dateFormatter setDateFormat:@"dd"];
    NSString *dayString = [dateFormatter stringFromDate:date];
    
    NSString *dayString1 = [dateFormatter stringFromDate:date2];
    
    [dateFormatter setDateFormat:@"HH"];
    NSString *hourString = [dateFormatter stringFromDate:date];
    NSString *hourString1 = [dateFormatter stringFromDate:date2];
    
    [dateFormatter setDateFormat:@"mm"];
    NSString *minuteString = [dateFormatter stringFromDate:date];
    NSString *minuteString1 = [dateFormatter stringFromDate:date2];
    
    long int time = ([dayString integerValue] - [dayString1 integerValue]) * 24 + ([hourString integerValue] - [hourString1 integerValue]) * 60 + ([minuteString integerValue] - [minuteString1 integerValue]);
   
    
    if (time > 20) {
        return YES;
    }
    
    
    return NO;

}
-(NSDate *)getInternetDate
{
    
    NSString *urlString = @"http://m.baidu.com";
    
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    
    // 实例化NSMutableURLRequest，并进行参数配置
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    [request setURL:[NSURL URLWithString: urlString]];
    
    [request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
    
    [request setTimeoutInterval: 2];
    
    [request setHTTPShouldHandleCookies:FALSE];
    
    [request setHTTPMethod:@"GET"];
    
    NSError *error = nil;
    
    NSHTTPURLResponse *response;
    
    [NSURLConnection sendSynchronousRequest:request
     
                          returningResponse:&response error:&error];
    
    
    
    // 处理返回的数据
    
    //    NSString *strReturn = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    
    if (error) {
        return [NSDate date];
    }
    
    NSLog(@"response is %@",response);
    
    NSString *date = [[response allHeaderFields] objectForKey:@"Date"];
    
    date = [date substringFromIndex:5];
    
    date = [date substringToIndex:[date length]-4];
    
    NSDateFormatter *dMatter = [[NSDateFormatter alloc] init];
    
    dMatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    [dMatter setDateFormat:@"dd MMM yyyy HH:mm:ss"];
    
    
    
    NSDate *netDate = [[dMatter dateFromString:date] dateByAddingTimeInterval:60*60*8];
    
    return netDate;
    
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [self openTheGesture];
     [self updataAPP];
}

-(void)openTheGesture {
    NSDate *date = [NSDate date];
    //获取百度时间
    
    NSDate * date1 = [self getInternetDate];
    NSDate *back = [[NSUserDefaults standardUserDefaults] objectForKey:@"backTime"];
    BOOL isOut = [self getminutesTimeFromTime:date1 compareTime:back];
    
    if (isOut) {
        if ([RHUserManager sharedInterface].username&&[[RHUserManager sharedInterface].username length]>0) {
            if ([[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@Gesture",[RHUserManager sharedInterface].username]]&&[[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@Gesture",[RHUserManager sharedInterface].username]] length]>0) {
                
//                RHGesturePasswordViewController* controller=[[RHGesturePasswordViewController alloc]init];
//                controller.isEnter = YES;
//                self.window.rootViewController = controller;
//                UINavigationController *nc = [[RHTabbarManager sharedInterface] selectTabbarMain];
//                UINavigationController *nc1 = [[RHTabbarManager sharedInterface] selectTabbarMore];
//                UINavigationController *nc2 = [[RHTabbarManager sharedInterface] selectTabbarUser];
//                UINavigationController *navi = (UINavigationController *)self.window.rootViewController;
//                
//                UIViewController *vc = navi.viewControllers[navi.viewControllers.count - 1];
//                [vc.navigationController pushViewController:controller animated:NO];
                 [self chooseWindowToIndicate];
//                if ([vc.navigationController isEqual:nc]) {
//                    [vc.navigationController pushViewController:controller animated:NO];
//                } else if ([vc.navigationController isEqual:nc1]) {
//                    
//                    [vc.navigationController pushViewController:controller animated:NO];
//                } else if ([vc.navigationController isEqual:nc2]) {
//                    [vc.navigationController pushViewController:controller animated:NO];
//                } else {
////                    [self chooseWindowToIndicate];
////                    169 254 32
////                    
//                }
            }
        }
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [self openTheGesture];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"GestureSave"];
    [self saveContext];
    self.isAPPActive = NO;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
//    return [ShareSDK handleOpenURL:url
//                        wxDelegate:self];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
//    return [ShareSDK handleOpenURL:url
//                 sourceApplication:sourceApplication
//                        annotation:annotation
//                        wxDelegate:self];
    return YES;
}

//jpush 相关设置
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [[ZCLibClient getZCLibClient] setToken:deviceToken];
    [APService registerDeviceToken:deviceToken];
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
//    NSString *message = [[userInfo objectForKey:@"aps"]objectForKey:@"alert"];
    
    
    [APService handleRemoteNotification:userInfo];
    [APService setBadge:0];
    [self didRecevieMessageWithUserInfo:userInfo];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    [APService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    [APService setBadge:0];
    [self didRecevieMessageWithUserInfo:userInfo];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}


-(void)didRecevieMessageWithUserInfo:(NSDictionary *)userinfo {
    
//    NSLog(@"=============%@",userinfo);
    
//    [[RHNetworkService instance] POST:@"front/payment/account/countUnReadMessage" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        [self openTheGesture];
//        
//            if ([RHUserManager sharedInterface].username&&[[RHUserManager sharedInterface].username length]>0) {
////                BOOL isGesture = [[NSUserDefaults standardUserDefaults] boolForKey:@"GestureSave"];
////                if (isGesture) {
////                    NSString *getString = [userinfo objectForKey:@"type"];
////                    if (getString && getString.length > 0 && [getString integerValue] == 1) {
////                        //project
////                        _isNotificationCenter = NO;
////                        RHProjectListViewController *myMessage = [[RHProjectListViewController alloc] initWithNibName:@"RHProjectListViewController" bundle:nil];
////                        NSString *investtype = [userinfo objectForKey:@"investType"];
////                        if (investtype && investtype.length > 0) {
////                            if ([investtype integerValue] > 1 || [investtype integerValue] < 0) {
////                                myMessage.type = @"0";
////                            } else {
////                                myMessage.type = investtype;
////                            }
////                        } else {
////                            myMessage.type = @"0";
////                        }
////                        [[RHTabbarManager sharedInterface] initTabbar];
////                        [[[RHTabbarManager  sharedInterface] selectTabbarMain] pushViewController:myMessage animated:NO];
////                    } else if (getString && getString.length > 0 && [getString integerValue] == 2) {
////                        //hongbao
////                        _isNotificationCenter = NO;
////                        RHMyGiftViewController *myMessage = [[RHMyGiftViewController alloc] initWithNibName:@"RHMyGiftViewController" bundle:nil];
////                        [[RHTabbarManager sharedInterface] initTabbar];
////                        [[[RHTabbarManager  sharedInterface] selectTabbarUser] pushViewController:myMessage animated:NO];
////                    } else if (getString && getString.length > 0 && [getString integerValue] == 3) {
////                        //消息
////                        _isNotificationCenter = NO;
////                        RHMyMessageViewController *myMessage = [[RHMyMessageViewController alloc] initWithNibName:@"RHMyMessageViewController" bundle:nil];
////                        [[RHTabbarManager sharedInterface] initTabbar];
////                        [[[RHTabbarManager  sharedInterface] selectTabbarUser] pushViewController:myMessage animated:NO];
////                    } else  {
////                        //首页
////                        [[RHTabbarManager sharedInterface] initTabbar];
////                        [[[RHTabbarManager  sharedInterface] selectTabbarMain] popToRootViewControllerAnimated:NO];
////                    }
////                } else {
//                if (self.isAPPActive == NO) {
//                    RHGesturePasswordViewController* controller=[[RHGesturePasswordViewController alloc]init];
//                    controller.isNotification = YES;
//                    controller.userInfo = userinfo;
//                    UINavigationController* nav=[[UINavigationController alloc]initWithRootViewController:controller];
//                    self.window.rootViewController = nav;
//                }else {
//                   self.alert  = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:[userinfo objectForKey:@"aps"][@"alert"] delegate:self cancelButtonTitle:@"关闭" otherButtonTitles: nil];
//                    [self.alert show];
//                }
//                
////                }
//            } else {
//                //首页
//                [[RHTabbarManager sharedInterface] initTabbar];
//                [[[RHTabbarManager  sharedInterface] selectTabbarMain] popToRootViewControllerAnimated:NO];
//            }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        RHGesturePasswordViewController* controller=[[RHGesturePasswordViewController alloc]init];
//        controller.isNotification = YES;
//        controller.userInfo = userinfo;
//        UINavigationController* nav=[[UINavigationController alloc]initWithRootViewController:controller];
//        self.window.rootViewController = nav;
//    }];
}


-(void)updataAPP{
    
    NSDictionary* parameters=@{@"appType":@"IOS"};
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.securityPolicy.allowInvalidCertificates = YES;
    [manager.securityPolicy setValidatesDomainName:NO];
    
    
    [manager POST:[NSString stringWithFormat:@"%@app/common/appUpdate/updateApp",[RHNetworkService instance].newdoMain] parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject[@"msg"] isEqualToString:@"yes"]) {
            self.updatares = YES;
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"AppUpdate"];
        }else{
            
            self.updatares = NO;
//            NSString *localVersion = [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleShortVersionString"];
//             [self onCheckVersion:localVersion];
        }
        //self.updateres = responseObject[@"msg"];
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"AppUpdate"]) {
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"AppUpdate"];
            //获取本地软件的版本号
            NSString *localVersion = [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleShortVersionString"];
            [self onCheckVersion:localVersion];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        ;
        
    }];
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
   /* [manager POST:[NSString stringWithFormat:@"%@app/common/appUpdate/updateApp",[RHNetworkService instance].newdoMain] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        ;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        NSLog(@"%@",responseObject);
        if ([responseObject[@"msg"] isEqualToString:@"yes"]) {
            self.updatares = YES;
        }else{
            
            self.updatares = NO;
        }
        //self.updateres = responseObject[@"msg"];
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"AppUpdate"]) {
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"AppUpdate"];
            //获取本地软件的版本号
            NSString *localVersion = [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleShortVersionString"];
            [self onCheckVersion:localVersion];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"AppUpdate"]) {
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"AppUpdate"];
            //获取本地软件的版本号
            NSString *localVersion = [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleShortVersionString"];
            [self onCheckVersion:localVersion];
        }
        
    }];
    */
    
}
- (void)onCheckVersion:(NSString *)currentVersion {
    
     NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/lookup?id=977505438"];
     NSLog(@"%@",currentVersion);
     NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
     [request setHTTPMethod:@"GET"];
     [request setTimeoutInterval:10.0];
     NSOperationQueue *queue = [[NSOperationQueue alloc]init];
     //    [NSURLSession]
     NSURLSession *session = [NSURLSession sharedSession];
     NSURLSessionDataTask *task = [session dataTaskWithRequest:request
     completionHandler:
     ^(NSData *data, NSURLResponse *response, NSError *error) {
     if (error) {
     
     NSLog(@"%@",error);
     }else{
     
     NSError* jasonErr = nil;
     // jason 解析
     NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jasonErr];
     if (responseDict && [responseDict objectForKey:@"results"]) {
     NSDictionary* results = [[responseDict objectForKey:@"results"] objectAtIndex:0];
     if (results) {
     NSString*  fVeFromNet = [results objectForKey:@"version"] ;
     
     CGFloat  flfVe = [fVeFromNet floatValue];
     fVeFromNet = [fVeFromNet substringToIndex:1];
     int fve = [fVeFromNet intValue];
     // NSLog(@"========%f",fVeFromNet);
     NSString *strVerUrl = [results objectForKey:@"trackViewUrl"];
     if (0 < fve && strVerUrl) {
     NSString * fCurVer = currentVersion ;
     CGFloat flfc = [currentVersion floatValue];
     fCurVer = [fCurVer substringToIndex:1];
     int fcu = [fCurVer intValue];
     //                                                                                                         fve = 2;
     //                                                      NSLog(@"========%f",fCurVer);
     if (fcu < fve) {
     
     //                                                          NSString * vresionstr = results[@"version"];
     //                                                          [RHNetworkService instance].updateress = YES;
     [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"AppUpdate"];
     dispatch_async(dispatch_get_main_queue(), ^{
     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""message:@"融益汇升级啦！因新版本新增功能较多，请更新后继续使用！" delegate:self cancelButtonTitle:@"立即更新" otherButtonTitles: nil];
     [alert show];
     });
     }else{
     
     if (flfc < flfVe){
     if (self.updatares) {
     [RHNetworkService instance].updateress = YES;
     [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"AppUpdate"];
     dispatch_async(dispatch_get_main_queue(), ^{
     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""message:@"融益汇升级啦！因新版本新增功能较多，请更新后继续使用！" delegate:self cancelButtonTitle:@"立即更新" otherButtonTitles: nil];
     [alert show];
     });
     }else{
     
     dispatch_async(dispatch_get_main_queue(), ^{
     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""message:@"发现新版本，立即去更新吧！" delegate:self cancelButtonTitle:@"立即更新" otherButtonTitles:@"稍后提醒", nil];
     [alert show];
     });
     }
     }
     NSLog(@"111111111111");
     
     }
     }
     }
     }
     
     
     }
     }];
     [task resume];
    
}
- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    //如果选择“现在升级”
    if (buttonIndex == 0){
        //打开iTunes  方法一
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/rong-yi-hui/id977505438?mt=8"]];
    }
}




#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "ryhui.ryhui" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"ryhui" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"ryhui.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
