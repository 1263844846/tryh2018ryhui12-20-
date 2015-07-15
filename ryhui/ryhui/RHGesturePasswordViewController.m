//
//  RHGesturePasswordViewController.m
//  ryhui
//
//  Created by stefan on 15/2/28.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHGesturePasswordViewController.h"
#import <CoreFoundation/CoreFoundation.h>
#import "RHALoginViewController.h"
#import "RHMyMessageViewController.h"
@interface RHGesturePasswordViewController ()
{
    BOOL isDrawPan;
    int checkNum;
}
@property (nonatomic,strong) RHGesturePasswordView * gesturePasswordView;

@end

@implementation RHGesturePasswordViewController{
    NSString * previousString;
    NSString * password;
}

@synthesize gesturePasswordView;
@synthesize isForgotV;
@synthesize isReset;
@synthesize isRegister;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    previousString = [NSString string];
    
    password = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@Gesture",[RHUserManager sharedInterface].username]];
   
//    DLog(@"%@",password);
    if (!password) {
        
        [self reset];
    }
    else {
        if (isReset) {
            [self reset];
        }else{
            [self verify];
        }
//        [self verify];
//        if (isReset) {
//            [gesturePasswordView.forgetButton setHidden:YES];
//            [gesturePasswordView.changeButton setHidden:YES];
//            [gesturePasswordView.state setTextColor:[UIColor colorWithRed:2/255.f green:174/255.f blue:240/255.f alpha:1]];
//            [gesturePasswordView.state setText:@"请输入密码"];
//        }

    }
    
    checkNum=0;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden=NO;
    for (UIView *subView in [UIApplication sharedApplication].keyWindow.subviews) {
        if (subView.tag == 1000) {
            [subView removeFromSuperview];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 验证手势密码
- (void)verify{
    gesturePasswordView = [[RHGesturePasswordView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [gesturePasswordView.tentacleView setRerificationDelegate:self];
    [gesturePasswordView.tentacleView setStyle:1];
    [gesturePasswordView setGesturePasswordDelegate:self];
    [self.view addSubview:gesturePasswordView];
}

#pragma mark - 重置手势密码
- (void)reset{
    gesturePasswordView = [[RHGesturePasswordView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [gesturePasswordView setGesturePasswordDelegate:self];
    [gesturePasswordView.tentacleView setResetDelegate:self];
    [gesturePasswordView.tentacleView setStyle:2];
    //    [gesturePasswordView.imgView setHidden:YES];
    [gesturePasswordView.forgetButton setHidden:YES];
    [gesturePasswordView.changeButton setHidden:YES];
    [gesturePasswordView.clearButton setHidden:NO];
    [gesturePasswordView.enterButton setHidden:NO];

    [gesturePasswordView.state setTextColor:[UIColor colorWithRed:2/255.f green:174/255.f blue:240/255.f alpha:1]];
    [gesturePasswordView.state setText:@"请设置手势密码"];
    isDrawPan=YES;
    [self.view addSubview:gesturePasswordView];
}

#pragma mark - 判断是否已存在手势密码
- (BOOL)exist{
    password = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@Gesture",[RHUserManager sharedInterface].username]];
    if (!password)return NO;
    return YES;
}

#pragma mark - 清空记录
- (void)clear{
    password=nil;
    previousString=@"";
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:[NSString stringWithFormat:@"%@Gesture",[RHUserManager sharedInterface].username]];
}

#pragma mark - 改变手势密码
- (void)change{
    RHALoginViewController* controller=[[RHALoginViewController alloc]initWithNibName:@"RHALoginViewController" bundle:nil];
    controller.isPan=YES;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - 忘记手势密码
- (void)forget{
    [[RHUserManager sharedInterface] logout];
    RHALoginViewController* controller=[[RHALoginViewController alloc]initWithNibName:@"RHALoginViewController" bundle:nil];
    controller.isForgotV=YES;
    [self.navigationController pushViewController:controller animated:YES];
    [self clear];
}

-(void)cleanPan{
    previousString = @"";
    [gesturePasswordView.state setText:@"请设置手势密码"];
    [gesturePasswordView.state setTextColor:[UIColor colorWithRed:2/255.f green:174/255.f blue:240/255.f alpha:1]];
    [gesturePasswordView.tentacleView enterArgin];
    [gesturePasswordView.clearButton setHidden:NO];
    [gesturePasswordView.enterButton setHidden:NO];
}


-(void)enterPan{
    
    if ([previousString isEqualToString:@""]) {
        [RHUtility showTextWithText:@"请先设置正确的手势密码"];
    }else{
        [gesturePasswordView.tentacleView enterArgin];
        [gesturePasswordView.state setTextColor:[UIColor colorWithRed:2/255.f green:174/255.f blue:240/255.f alpha:1]];
        [gesturePasswordView.state setText:@"请确认手势密码"];
        [gesturePasswordView.clearButton setHidden:YES];
        [gesturePasswordView.enterButton setHidden:YES];
        isDrawPan=NO;
    }
}

- (BOOL)verification:(NSString *)result{
    if ([result isEqualToString:password]) {
        [gesturePasswordView.state setTextColor:[UIColor colorWithRed:2/255.f green:174/255.f blue:240/255.f alpha:1]];
        [gesturePasswordView.state setText:@"输入正确"];
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"GestureSave"];

        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        [[RHTabbarManager sharedInterface] initTabbar];

        if (delegate.isNotificationCenter) {
            delegate.isNotificationCenter = NO;
            RHMyMessageViewController *myMessage = [[RHMyMessageViewController alloc] initWithNibName:@"RHMyMessageViewController" bundle:nil];
           
            [[[RHTabbarManager  sharedInterface] selectTabbarUser] pushViewController:myMessage animated:NO];
        } else {
            if (isReset) {
                [self reset];
                [self clear];
                
            }else{
                if (self.isEnter) {
                    [self.navigationController popViewControllerAnimated:NO];
                } else {
                    [[[RHTabbarManager sharedInterface] selectTabbarMain] popToRootViewControllerAnimated:NO];
                }
            }
        }

        [[NSNotificationCenter defaultCenter] postNotificationName:@"RHGestureSuccessed" object:nil];
        return YES;
    }
    [gesturePasswordView.state setTextColor:[UIColor redColor]];
    [gesturePasswordView.state setText:[NSString stringWithFormat:@"手势密码错误,您还可输入%d次",4 - checkNum]];
    checkNum++;
    if (checkNum >= 5) {
        checkNum=0;
        UIAlertView* alertView=[[UIAlertView alloc]initWithTitle:@"手势密码错误超过5次"
                                                         message:@"手势密码错误超过5次，您将退出登录，请重新登录设置新的手势密码"
                                                        delegate:self
                                               cancelButtonTitle:@"我知道了"
                                               otherButtonTitles:nil, nil];
        [alertView show];
    }
    return NO;
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [[RHUserManager sharedInterface] logout];
    [[RHTabbarManager sharedInterface] selectALogin];
}

//修改手势密码
- (BOOL)resetPassword:(NSString *)result{
    if ([previousString isEqualToString:@""]||isDrawPan) {
//        DLog(@"%@",result);
        previousString=result;
        return YES;
    }
    else {
//        DLog(@"%@",result);
        if ([result isEqualToString:previousString]) {
            password=result;
            
            [[NSUserDefaults standardUserDefaults] setObject:result forKey:[NSString stringWithFormat:@"%@Gesture",[RHUserManager sharedInterface].username]];
            //[self presentViewController:(UIViewController) animated:YES completion:nil];
            [gesturePasswordView.state setTextColor:[UIColor colorWithRed:2/255.f green:174/255.f blue:240/255.f alpha:1]];
            [gesturePasswordView.state setText:@"已保存手势密码"];
            if (isReset) {
                [RHUtility showTextWithText:@"手势密码修改成功"];
                if (self.navigationController.childViewControllers.count > 1) {
                    [self.navigationController popViewControllerAnimated:YES];
                }else{
                    [self turnToUserCenterOrMainViewcontroller];
                }
            }else{
                [self turnToUserCenterOrMainViewcontroller];
            }
            
            return YES;
        }
        else{
            [gesturePasswordView.clearButton setHidden:NO];
            [gesturePasswordView.tentacleView enterArgin];
            [gesturePasswordView.state setTextColor:[UIColor redColor]];
            [gesturePasswordView.state setText:@"两次密码不一致，请重新输入"];
            return NO;
        }
    }
}

- (void)turnToUserCenterOrMainViewcontroller {
   
        if (isRegister) {
            [[RHTabbarManager sharedInterface] initTabbar];
            [[[RHTabbarManager sharedInterface] selectTabbarUser] popToRootViewControllerAnimated:NO];
        }else{
            [[RHTabbarManager sharedInterface] initTabbar];
            [[[RHTabbarManager sharedInterface] selectTabbarMain] popToRootViewControllerAnimated:NO];
        }
}

@end
