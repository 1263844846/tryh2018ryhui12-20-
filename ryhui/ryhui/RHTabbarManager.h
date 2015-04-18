//
//  RHTabbarManager.h
//  ryhui
//
//  Created by stefan on 15/3/15.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RHTabbarManager : NSObject

+(instancetype)sharedInterface;

-(void)initTabbar;
-(UINavigationController*)selectTabbarMain;
-(UINavigationController*)selectTabbarUser;
-(UINavigationController*)selectTabbarMore;
-(void)selectLogin;
-(void)selectGuidan;
-(void)cleanTabbar;
-(void)selectALogin;

@property(nonatomic,strong)UINavigationController* tabbarMain;
@property(nonatomic,strong)UINavigationController* tabbarUser;
@property(nonatomic,strong)UINavigationController* tabbarMore;
@end
