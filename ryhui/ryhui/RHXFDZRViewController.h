//
//  RHXFDZRViewController.h
//  ryhui
//
//  Created by 糊涂虫 on 17/7/12.
//  Copyright © 2017年 stefan. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^scroolblock)() ;
@interface RHXFDZRViewController : UIViewController
@property(nonatomic,copy)NSString * projectid;
@property(nonatomic,strong)UINavigationController *nav;
@property(nonatomic,strong)NSDictionary * datadic;

@property(nonatomic,copy)NSString * nhstr;
@property(nonatomic,copy)NSString * mouthstr;

@property(nonatomic,copy)scroolblock scroolblock;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property(nonatomic,assign)BOOL sess;
@end
