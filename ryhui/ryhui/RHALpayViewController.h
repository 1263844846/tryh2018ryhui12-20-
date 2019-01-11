//
//  RHALpayViewController.h
//  ryhui
//
//  Created by 糊涂虫 on 17/8/3.
//  Copyright © 2017年 stefan. All rights reserved.
//

#import "RHBaseViewController.h"
typedef void(^myblock)() ;
@interface RHALpayViewController : RHBaseViewController
@property (weak, nonatomic) IBOutlet UIButton *albtn2;

@property (strong, nonatomic) IBOutlet UIButton *alipaybtn;
@property(nonatomic,strong)NSDictionary *bankdic;
@property(nonatomic,copy)myblock myblock;
@end
