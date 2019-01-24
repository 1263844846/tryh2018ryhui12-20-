//
//  RHTabbarManager.m
//  ryhui
//
//  Created by stefan on 15/3/15.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHTabbarManager.h"

#import "AppDelegate.h"
#import "RHLoginViewController.h"
#import "RHALoginViewController.h"
#import "RHGuidanceViewController.h"
#import "RYHViewController.h"

static RHTabbarManager* _instance =nil;

@implementation RHTabbarManager
@synthesize tabbarMain;
@synthesize tabbarUser;
@synthesize tabbarMore;
@synthesize tabbarproject;
//@synthesize usercon;
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
    mainController=[[RHMainViewController alloc]initWithNibName:@"RHMainViewController" bundle:nil];
    
    self.tabbarMain=[[UINavigationController alloc]initWithRootViewController:mainController];
    
    self.usercon = [[RHUserCountViewController alloc]initWithNibName:@"RHUserCountViewController" bundle:nil];
    //userController=[[RHUserCenterMainViewController alloc]initWithNibName:@"RHUserCenterMainViewController" bundle:nil];
    self.tabbarUser=[[UINavigationController alloc]initWithRootViewController:self.usercon];
    
    moreController=[[RHMoreViewController alloc]initWithNibName:@"RHMoreViewController" bundle:nil];
    self.tabbarMore=[[UINavigationController alloc]initWithRootViewController:moreController];
    self.tabbarMore.navigationBar.hidden=YES;
    
//    UITabBarController * tabar = [[UITabBarController alloc]init];
//    tabar.viewControllers = @[self.tabbarMain,self.tabbarUser,self.tabbarMore];
//    AppDelegate* delegate=[UIApplication sharedApplication].delegate;
//    delegate.window.rootViewController= tabar;
    
    projectvc = [[RHProjectListViewController alloc]initWithNibName:@"RHProjectListViewController" bundle:nil];
////
    self.tabbarproject = [[UINavigationController alloc]initWithRootViewController:projectvc];
    //self.tabbarproject.navigationBar.hidden = YES;
    
//    UIViewController * vc = [UIViewController new];
//    self.tabbarproject = [[UINavigationController alloc]initWithRootViewController:vc];
//    self.tabbarproject.navigationBar.hidden = YES;
    self.tabbar = [RYHViewController Sharedbxtabar];
    self.tabbar.tarbar.hidden = NO;
    self.tabbar.viewControllers = @[self.tabbarMain,self.tabbarproject,self.tabbarUser,self.tabbarMore];
    AppDelegate* delegate=[UIApplication sharedApplication].delegate;
    delegate.window.rootViewController= self.tabbar;
}

-(UINavigationController*)selectTabbarMain
{
  //  AppDelegate* delegate=[UIApplication sharedApplication].delegate;
   // delegate.window.rootViewController= [RYHViewController Sharedbxtabar];
    
    return  self.tabbarMain;
}

-(UINavigationController*)selectTabbarUser
{
//    AppDelegate* delegate=[UIApplication sharedApplication].delegate;
//    delegate.window.rootViewController=self.tabbarUser;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RHSELECTUSER" object:nil];
    
    return self.tabbarUser;
}

-(UINavigationController*)selectTabbarMore
{
//    AppDelegate* delegate=[UIApplication sharedApplication].delegate;
//    delegate.window.rootViewController=self.tabbarMore;
    return self.tabbarMore;
}
-(UINavigationController *)selectTabbarProject
{
//    AppDelegate* delegate=[UIApplication sharedApplication].delegate;
//    delegate.window.rootViewController=self.tabbarproject;
    return self.tabbarproject;
    
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
