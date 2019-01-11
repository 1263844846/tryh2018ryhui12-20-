//
//  RHXFDViewController.h
//  ryhui
//
//  Created by 糊涂虫 on 16/9/1.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import "RHBaseViewController.h"
typedef void(^myblock)() ;
typedef void(^scroolblock)() ;
@interface RHXFDViewController : RHBaseViewController
@property(nonatomic,copy)NSString * projectid;
@property(nonatomic,strong)NSDictionary * datadic;
@property(nonatomic,strong)UINavigationController *nav;
@property(nonatomic,copy)NSString * nhstr;
@property(nonatomic,copy)NSString * mouthstr;
@property(nonatomic,copy)myblock myblock;
@property(nonatomic,copy)scroolblock scroolblock;
@property(nonatomic,assign)BOOL sess;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@end
