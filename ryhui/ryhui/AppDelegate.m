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
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"
#import "WeiboApi.h"
#import "WeiboSDK.h"
//#import <RennSDK/RennSDK.h>
@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize window=_window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [UIApplication sharedApplication].statusBarStyle=UIStatusBarStyleLightContent;
    
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    [self.window makeKeyWindow];
    
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
            [[RHTabbarManager sharedInterface] selectLogin];
        }
        
    }
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sessionFail:) name:@"RHSESSIONFAIL" object:nil];
    
    //分享
    [self initShareSDK];

    //推送
    [self registerJPushNotifyWithLauchOptions:launchOptions];
    
    //统计
//    [MobClick startWithAppkey:@"554c126f67e58e7434007259" reportPolicy:BATCH   channelId:@""];
//    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
//    [MobClick setAppVersion:version];
//    [MobClick setCrashReportEnabled:YES];
    
    return YES;
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
    // Required
    [APService setupWithOption:launchOptions];
    
    [APService setBadge:0];
}

-(void)initShareSDK
{
    [ShareSDK registerApp:@"6c23db79a7e8"];//字符串api20为您的ShareSDK的AppKey

    //添加新浪微博应用 注册网址 http://open.weibo.com
    [ShareSDK connectSinaWeiboWithAppKey:@"1083852544"
                               appSecret:@"1d0c857bd233092ee0b2d69a494864b9"
                             redirectUri:@"http://www.ryhui.com"];

//    //当使用新浪微博客户端分享的时候需要按照下面的方法来初始化新浪的平台
//    [ShareSDK  connectSinaWeiboWithAppKey:@"568898243"
//                                appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
//                              redirectUri:@"http://www.sharesdk.cn"
//                              weiboSDKCls:[WeiboSDK class]];
    
    //添加微信应用 注册网址 http://open.weixin.qq.com
    [ShareSDK connectWeChatWithAppId:@"wx2010bdd8c8c72a3f"
                           wechatCls:[WXApi class]];

}

-(void)sessionFail:(NSNotification*)nots
{
    NSDictionary* parameters=@{@"account":[RHUserManager sharedInterface].username,@"password":[RHUserManager sharedInterface].md5};
    
    [[RHNetworkService instance] POST:@"common/user/login/appLogin" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"%@",responseObject);
        NSArray* array=[[operation.response.allHeaderFields objectForKey:@"Set-Cookie"] componentsSeparatedByString:@";"];
        [[NSUserDefaults standardUserDefaults] setObject:[array objectAtIndex:0] forKey:@"RHSESSION"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        DLog(@"%@",operation.response.allHeaderFields);
        
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
            }
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"%@",error);
    }];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (BOOL)application:(UIApplication *)application
      handleOpenURL:(NSURL *)url
{
    return [ShareSDK handleOpenURL:url
                        wxDelegate:self];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return [ShareSDK handleOpenURL:url
                 sourceApplication:sourceApplication
                        annotation:annotation
                        wxDelegate:self];
}

//jpush 相关设置
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [APService registerDeviceToken:deviceToken];
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"-------------%@",userInfo);
    
    [APService handleRemoteNotification:userInfo];
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    NSLog(@"-------------%@",userInfo);
    [APService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

-(void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void (^)())completionHandler
{
    NSLog(@"------------%@",identifier);
    NSLog(@"------------%@",userInfo);
//    NSLog(@"------------%@",);
    
}

-(BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray *))restorationHandler
{
    NSLog(@"-------------%@",userActivity);
    return YES;
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
