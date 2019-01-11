//
//  RHkuaijViewController.h
//  ryhui
//
//  Created by 糊涂虫 on 17/8/3.
//  Copyright © 2017年 stefan. All rights reserved.
//

#import "RHBaseViewController.h"
typedef void (^kuaijieBlock)();
@interface RHkuaijViewController : RHBaseViewController
@property(nonatomic,strong)UINavigationController * nav;
@property(nonatomic,strong)NSDictionary *bankdic;
-(void)setbankcarddata:(NSDictionary*)dic;
@property(nonatomic,copy)NSString *bancle;
@property(nonatomic,copy)NSString *bankress;
@property(nonatomic,copy)kuaijieBlock mykjblock;
-(void)respfirsttf;
-(void)hidenbankcard;
@end
