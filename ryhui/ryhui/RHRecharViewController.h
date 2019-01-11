//
//  RHRecharViewController.h
//  ryhui
//
//  Created by 糊涂虫 on 2018/1/8.
//  Copyright © 2018年 stefan. All rights reserved.
//

#import "RHBaseViewController.h"

@interface RHRecharViewController : RHBaseViewController<UITextFieldDelegate>

@property(nonatomic,strong)NSString* balance;
@property(nonatomic,strong)NSDictionary *bankdic;
@property(nonatomic,copy)NSString * bankress;
@end
