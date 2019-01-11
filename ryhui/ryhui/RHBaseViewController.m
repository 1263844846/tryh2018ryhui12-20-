//
//  RHBaseViewController.m
//  ryhui
//
//  Created by stefan on 15/2/13.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHBaseViewController.h"
#import "RHMainViewController.h"
#import "RHmainModel.h"
#import "UIColor+ZXLazy.h"
#import "DQViewController.h"
#import "RHALoginViewController.h"
#import "RHhelper.h"
@interface RHBaseViewController ()<UIGestureRecognizerDelegate>
{
    
    id _deleget;
}
@end

@implementation RHBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if(([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        self.edgesForExtendedLayout= UIRectEdgeNone;
        [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    }else{
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navBG.png"] forBarMetrics:UIBarMetricsDefault];
    }
    
    self.messageNumLabel.layer.cornerRadius=8;
    self.messageNumLabel.layer.masksToBounds=YES;
    NSString* num=[[NSUserDefaults standardUserDefaults] objectForKey:@"RHMessageNumSave"];
//    DLog(@"%@",num);
    if (num&&[num length]>0) {
        if ([RHUserManager sharedInterface].custId) {
            if ([num intValue]>99) {
                
                self.messageNumLabel.text=@"99+";
                self.messageNumLabel.hidden=NO;
            }else{
                if ([num isEqualToString:@"0"]) {
                    self.messageNumLabel.hidden=YES;
                }else{
                    self.messageNumLabel.text=num;
                    self.messageNumLabel.hidden=NO;
                }
            }
        }else{
            self.messageNumLabel.hidden=YES;
        }
    }else{
        self.messageNumLabel.hidden=YES;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setMessageNum:) name:@"RHMessageNum" object:nil];
  /*
   //回首
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
//    self.navigationController.interactivePopGestureRecognizer.delegate =(id)self;
   */
    
//    self.view.userInteractionEnabled = YES;
//    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(backHandle:)];
//    [self.view addGestureRecognizer:panGesture];

}
//- (void)backHandle:(UIPanGestureRecognizer *)recognizer
//{
//    NSArray * array = self.navigationController.viewControllers;
//
//    if (array.count>1) {
//        [self.navigationController popViewControllerAnimated:YES];
//    }
//}

-(void)setMessageNum:(NSNotification*)notss
{
    NSString* numStr=notss.object;
    if ([RHUserManager sharedInterface].custId) {
        if ([numStr intValue]>99) {
            self.messageNumLabel.text=@"99+";
            self.messageNumLabel.hidden=NO;
        }else{
            if ([numStr isEqualToString:@"0"]) {
                self.messageNumLabel.hidden=YES;
            }else{
                self.messageNumLabel.text=numStr;
                self.messageNumLabel.hidden=NO;
            }
        }
    }else{
        self.messageNumLabel.hidden=YES;
    }
}
/*
//huishou
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
//
   __block int a = 0;
    NSArray * array = self.navigationController.childViewControllers;
    [array enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[RHALoginViewController class]]) {
            NSLog(@"%@-索引%d",obj, (int)idx);
            a = 10;
        }
    }];
    if (a==10) {
        return NO;
    }
    return self.navigationController.childViewControllers.count > 1;
//    
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
//    
    return self.navigationController.viewControllers.count > 1;
}
 */
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setNeedsStatusBarAppearanceUpdate];
   /*
    //回首
   if (self.navigationController.viewControllers.count > 1) {          // 记录系统返回手势的代理
        _deleget = self.navigationController.interactivePopGestureRecognizer.delegate;          // 设置系统返回手势的代理为当前控制器
       self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
    */
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    /*
    // 设置系统返回手势的代理为我们刚进入控制器的时候记录的系统的返回手势代理
    //回首
    self.navigationController.interactivePopGestureRecognizer.delegate = _deleget;
     */
}
- (void)configBackButton
{
    UIButton* button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//    UIImage * image = [UIImage imageNamed:@"back.png"];
   
    [button setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    button.frame=CGRectMake(0, 0, 30, 50);

   // button.backgroundColor = [UIColor colorWithHexString:@"44bbc1"];
    self.navigationItem.leftBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:button];
    // button.backgroundColor = [UIColor colorWithHexString:@"44bbc1"];
  //  self.navigationItem.leftBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:button1];
}
-(void)myback{
    [RHhelper ShraeHelp].resss=2;
    if ([[RHmainModel ShareRHmainModel].tabbarstr isEqualToString:@"cbx"]) {
        //[DQViewController Sharedbxtabar].tarbar.hidden = NO;
        
        NSLog(@"232323232");
    }
    
    if ([self.shouyexunhuan isEqualToString:@"qiangge"]) {
        NSArray * array = self.navigationController.viewControllers;
        for (UIViewController * contr in array) {
            if ([contr isKindOfClass:[RHMainViewController class] ]) {
                
                [RHmainModel ShareRHmainModel].maintest = @"qiangge";
                
                [self.navigationController popToViewController:contr animated:YES];
                return;
            }
        }
        
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)configRightButtonWithTitle:(NSString*)title action:(SEL)action
{
    UIButton* button=[UIButton buttonWithType:UIButtonTypeCustom];
   // button.titleLabel.backgroundColor =  [RHUtility colorForHex:@"#44BBC1"];
    [button setTitleColor:[RHUtility colorForHex:@"#44BBC1"] forState:UIControlStateNormal];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:title forState:UIControlStateNormal];
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    button.frame=CGRectMake(0, 0, 50, 20);
    self.navigationItem.rightBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)configTitleWithString:(NSString*)title
{
    CGFloat font=18;
    
    UILabel* titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 30)];
    titleLabel.font=[UIFont boldSystemFontOfSize:font];
    titleLabel.textAlignment=NSTextAlignmentCenter;
    titleLabel.textColor= [UIColor colorWithHexString:@"202020"];
    titleLabel.backgroundColor=[UIColor clearColor];
    titleLabel.text=title;
    self.navigationItem.titleView = titleLabel;
}

-(void)back
{
    [RHhelper ShraeHelp].resss=2;
    if ([[RHmainModel ShareRHmainModel].tabbarstr isEqualToString:@"cbx"]) {
        //[DQViewController Sharedbxtabar].tarbar.hidden = NO;
        
        NSLog(@"232323232");
    }
    
    if ([self.shouyexunhuan isEqualToString:@"qiangge"]) {
        NSArray * array = self.navigationController.viewControllers;
        for (UIViewController * contr in array) {
            if ([contr isKindOfClass:[RHMainViewController class] ]) {
                
                [RHmainModel ShareRHmainModel].maintest = @"qiangge";
                
                [self.navigationController popToViewController:contr animated:YES];
                return;
            }
        }
        
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
-(BOOL)prefersStatusBarHidden
{
    return NO;
}
-(void)rightbuttonwhithimagrstring:(NSString *)imagestring action:(SEL)action{
    
    UIButton* button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
//    [button setTitle:title forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:imagestring] forState:UIControlStateNormal];
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    button.frame=CGRectMake(0, 0, 20, 20);
    self.navigationItem.leftBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:button];
    
    UIBarButtonItem * btn = [[UIBarButtonItem alloc]initWithTitle:@"登录" style:UIBarButtonItemStylePlain target:self action:@selector(loginryh)];
    
    [btn setTitle:@"登录"];
    [btn setTintColor:[RHUtility colorForHex:@"#44bbc1"]];
    
    
    self.navigationItem.rightBarButtonItem = btn;
    
    
}

-(void)loginryh{
    
    
    
    
}

- (void)getright:(NSString*)namelab action:(SEL)action{
    UIButton* button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[RHUtility colorForHex:@"44bbc1"] forState:UIControlStateNormal];
    //    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:namelab forState:UIControlStateNormal];
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    button.frame=CGRectMake(0, 0, 80, 20);
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    self.navigationItem.rightBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:button];
    
    
}

@end
