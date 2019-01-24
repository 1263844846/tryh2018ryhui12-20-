//
//  RHTabbarManager.h
//  ryhui
//
//  Created by stefan on 15/3/15.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RHMainViewController.h"
#import "RHUserCenterMainViewController.h"
#import "RHMoreViewController.h"
#import "RHProjectListViewController.h"
#import "RHUserCountViewController.h"
#import "RYHViewController.h"
@interface RHTabbarManager : NSObject

{
   
//    RHUserCountViewController * usercon;
    RHMainViewController* mainController;
    RHUserCenterMainViewController* userController;
    RHMoreViewController* moreController;
    RHProjectListViewController * projectvc;
}
@property(nonatomic,strong) RYHViewController * tabbar ;
@property(nonatomic,strong)RHUserCountViewController * usercon;

+(instancetype)sharedInterface;

-(void)initTabbar;
-(UINavigationController*)selectTabbarMain;
-(UINavigationController*)selectTabbarUser;
-(UINavigationController*)selectTabbarMore;
-(UINavigationController*)selectTabbarProject;
-(void)selectLogin;
-(void)selectGuidan;
-(void)cleanTabbar;
-(void)selectALogin;

@property(nonatomic,strong)UINavigationController* tabbarMain;
@property(nonatomic,strong)UINavigationController* tabbarUser;
@property(nonatomic,strong)UINavigationController* tabbarMore;
@property(nonatomic,strong)UINavigationController* tabbarproject;

@end
