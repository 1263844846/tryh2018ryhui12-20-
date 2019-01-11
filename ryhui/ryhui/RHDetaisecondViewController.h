//
//  RHDetaisecondViewController.h
//  ryhui
//
//  Created by 糊涂虫 on 16/4/8.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^myblock)() ;
typedef void(^scroolblock)() ;

@interface RHDetaisecondViewController : RHBaseViewController
@property(nonatomic,copy)NSString * projectid;
@property(nonatomic,strong)NSDictionary * datadic;
@property(nonatomic,strong)UINavigationController *nav;
@property(nonatomic,copy)NSString * nhstr;
@property(nonatomic,copy)NSString * mouthstr;
@property(nonatomic,copy)myblock myblock;
@property(nonatomic,assign)BOOL newpeo;
@property (weak, nonatomic) IBOutlet UILabel *jietitle;
@property (weak, nonatomic) IBOutlet UILabel *firsthidenlab;
@property (weak, nonatomic) IBOutlet UILabel *secondhidenlab;
@property (weak, nonatomic) IBOutlet UILabel *threehidenlab;
@property (weak, nonatomic) IBOutlet UILabel *fourhidenlab;
@property (weak, nonatomic) IBOutlet UILabel *yongtu;
@property (weak, nonatomic) IBOutlet UILabel *baozhang;
@property (weak, nonatomic) IBOutlet UILabel *tupian;
@property (weak, nonatomic) IBOutlet UIScrollView *newscrool;


@property(nonatomic,assign)BOOL sess;
@property(nonatomic,copy)scroolblock scroolblock;
@end
