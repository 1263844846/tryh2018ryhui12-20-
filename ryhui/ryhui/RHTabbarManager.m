//
//  RHTabbarManager.m
//  ryhui
//
//  Created by stefan on 15/3/15.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHTabbarManager.h"
#import "RHMainViewController.h"
#import "RHUserCenterMainViewController.h"
#import "AppDelegate.h"
#import "RHMoreViewController.h"
#import "RHLoginViewController.h"
#import "RHALoginViewController.h"
#import "RHGuidanceViewController.h"

static RHTabbarManager* _instance =nil;

@implementation RHTabbarManager
@synthesize tabbarMain;
@synthesize tabbarUser;
@synthesize tabbarMore;

+(id)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

+(instancetype)sharedInterface{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[RHTabbarManager alloc] init];
    });
    return _instance;
}

-(id)copyWithZone:(NSZone *)zone{
    return _instance;
}

-(void)initTabbar
{
    RHMainViewController* mainController=[[RHMainViewController alloc]initWithNibName:@"RHMainViewController" bundle:nil];
    
    self.tabbarMain=[[UINavigationController alloc]initWithRootViewController:mainController];
    
    RHUserCenterMainViewController* userController=[[RHUserCenterMainViewController alloc]initWithNibName:@"RHUserCenterMainViewController" bundle:nil];
    self.tabbarUser=[[UINavigationController alloc]initWithRootViewController:userController];
    
    RHMoreViewController* moreController=[[RHMoreViewController alloc]initWithNibName:@"RHMoreViewController" bundle:nil];
    self.tabbarMore=[[UINavigationController alloc]initWithRootViewController:moreController];
    self.tabbarMore.navigationBar.hidden=YES;
}

-(UINavigationController*)selectTabbarMain
{
    AppDelegate* delegate=[UIApplication sharedApplication].delegate;
    delegate.window.rootViewController=self.tabbarMain;
    return self.tabbarMain;
}

-(UINavigationController*)selectTabbarUser
{
    AppDelegate* delegate=[UIApplication sharedApplication].delegate;
    delegate.window.rootViewController=self.tabbarUser;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RHSELECTUSER" object:nil];
    return self.tabbarUser;
}

-(UINavigationController*)selectTabbarMore
{
    AppDelegate* delegate=[UIApplication sharedApplication].delegate;
    delegate.window.rootViewController=self.tabbarMore;
    return self.tabbarMore;
}

-(void)cleanTabbar
{
    self.tabbarMain=nil;
    self.tabbarMore=nil;
    self.tabbarUser=nil;
}

-(void)selectALogin
{
    RHLoginViewController* controller=[[RHLoginViewController alloc]initWithNibName:@"RHLoginViewController" bundle:nil];
    UINavigationController* nav=[[UINavigationController alloc]initWithRootViewController:controller];
    
    AppDelegate* delegate=[UIApplication sharedApplication].delegate;
    delegate.window.rootViewController=nav;
    
    RHALoginViewController* controller1=[[RHALoginViewController alloc]initWithNibName:@"RHALoginViewController" bundle:nil];
    [nav pushViewController:controller1 animated:NO];
    
}

-(void)selectLogin
{
    RHLoginViewController* controller=[[RHLoginViewController alloc]initWithNibName:@"RHLoginViewController" bundle:nil];
    UINavigationController* nav=[[UINavigationController alloc]initWithRootViewController:controller];
    
    AppDelegate* delegate=[UIApplication sharedApplication].delegate;
    delegate.window.rootViewController=nav;
}

-(void)selectGuidan
{
    RHGuidanceViewController* controller=[[RHGuidanceViewController alloc]initWithNibName:@"RHGuidanceViewController" bundle:nil];
    UINavigationController* nav=[[UINavigationController alloc]initWithRootViewController:controller];

    AppDelegate* delegate=[UIApplication sharedApplication].delegate;
    delegate.window.rootViewController=nav;
}
@end
