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
-(void)selectTabbarMain;
-(void)selectTabbarUser;
-(void)selectTabbarMore;
-(void)selectLogin;


@property(nonatomic,strong)UINavigationController* tabbarMain;
@property(nonatomic,strong)UINavigationController* tabbarUser;
@property(nonatomic,strong)UINavigationController* tabbarMore;
@end
