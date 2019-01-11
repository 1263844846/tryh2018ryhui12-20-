//
//  RHUserManager.m
//  ryhui
//
//  Created by stefan on 15/3/15.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHUserManager.h"
static RHUserManager *_instance = nil;

@implementation RHUserManager
@synthesize username;
@synthesize infoType;
@synthesize custId;
@synthesize md5;
@synthesize telephone;
@synthesize email;
@synthesize userId;
@synthesize zhiwen;

+ (id)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

+ (instancetype)sharedInterface {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[RHUserManager alloc] init];
        [_instance initData];
    });
    return _instance;
}

- (id)copyWithZone:(NSZone *)zone {
    return _instance;
}

- (void)initData {
    NSString *_custId = [[NSUserDefaults standardUserDefaults] objectForKey:@"RHcustId"];
    if (_custId && [_custId length] > 0) {
        self.custId = _custId;
    }
    
    NSString *_email = [[NSUserDefaults standardUserDefaults] objectForKey:@"RHemail"];
    if (_email && [_email length] > 0) {
        self.email = _email;
    }

    NSString *_infoType = [[NSUserDefaults standardUserDefaults] objectForKey:@"RHinfoType"];
    if (_infoType && [_infoType length] > 0) {
        self.infoType = _infoType;
    }

    NSString *_md5=[[NSUserDefaults standardUserDefaults] objectForKey:@"RHmd5"];
    if (_md5 && [_md5 length] > 0) {
        self.md5 = _md5;
    }

    NSString *_telephone=[[NSUserDefaults standardUserDefaults] objectForKey:@"RHtelephone"];
    if (_telephone && [_telephone length] > 0) {
        self.telephone = _telephone;
    }

    NSString *_username = [[NSUserDefaults standardUserDefaults] objectForKey:@"RHUSERNAME"];
    if (_username && [_username length] > 0) {
        self.username = _username;
    }
    
    NSString *_userid = [[NSUserDefaults standardUserDefaults] objectForKey:@"RHUSERID"];
    if (_userid && [_userid length] > 0) {
        self.userId = _userid;
    }
    NSString *_zhiwen = [[NSUserDefaults standardUserDefaults] objectForKey:@"zhiwen"];
    if (_zhiwen && [_zhiwen length] > 0) {
        self.zhiwen = _zhiwen;
    }
}

- (void)logout {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"headUrl"];
     [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"RHcustId"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"RHemail"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"RHinfoType"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"RHmd5"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"RHtelephone"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"RHUSERNAME"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"RHUSERID"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"RHSESSION"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"RHNEWMYSESSION"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"RHMessageNumSave"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSString* session=[[NSUserDefaults standardUserDefaults] objectForKey:@"RHSESSION"];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"zhiwen"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RHMessageNum" object:@"0"];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:[NSString stringWithFormat:@"%@Gesture",[RHUserManager sharedInterface].username]];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [RHUserManager sharedInterface].username = @"";
    self.custId = nil;
    self.email = nil;
    self.infoType = nil;
    self.md5 = nil;
    self.telephone = nil;
    self.userId = nil;
    self.username = nil;
    self.zhiwen = nil;
    [[RHTabbarManager sharedInterface] cleanTabbar];
    [[RHTabbarManager  sharedInterface] selectALogin];
}

@end
