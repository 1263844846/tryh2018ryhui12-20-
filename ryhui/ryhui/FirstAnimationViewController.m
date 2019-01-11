//
//  FirstAnimationViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 16/12/8.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import "FirstAnimationViewController.h"
#import "DQViewController.h"
#import "RHGesturePasswordViewController.h"
#import "AnimationWebViewController.h"
#import "RHmainModel.h"
@interface FirstAnimationViewController ()
{
    NSTimer * timer;
}
@property (weak, nonatomic) IBOutlet UIImageView *AnimationImage;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property(nonatomic,assign)NSInteger mytimer;


@end

@implementation FirstAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.mytimer = 3;
    self.AnimationImage.userInteractionEnabled = YES;
    self.navigationController.navigationBar.hidden = YES;
   
        [self.AnimationImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@common/main/attachment/%@",[RHNetworkService instance].newdoMain,[RHmainModel ShareRHmainModel].imagestr]]];
        
        NSString * str = [NSString stringWithFormat:@"%@common/main/attachment/%@",[RHNetworkService instance].newdoMain,[RHmainModel ShareRHmainModel].imagestr];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Jump)];
        [self.AnimationImage addGestureRecognizer:tap];
        
        timer =  [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerdown) userInfo:nil repeats:YES];
   
 //  UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Jump)];
//    
//    [self.AnimationImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@common/main/attachment/%@",[RHNetworkService instance].newdoMain,[RHmainModel ShareRHmainModel].imagestr]]];
//    [self.AnimationImage addGestureRecognizer:tap];
//    self.navigationController.navigationBar.hidden = YES;
//   timer =  [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerdown) userInfo:nil repeats:YES];
    
}
-(void)Jump{
    
    AnimationWebViewController * controller = [[AnimationWebViewController alloc]initWithNibName:@"AnimationWebViewController" bundle:nil];
    [timer invalidate];
    [self.navigationController pushViewController:controller animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)upanimationbtn:(id)sender {
    if ([RHUserManager sharedInterface].username&&[[RHUserManager sharedInterface].username length]>0) {
        RHGesturePasswordViewController* controller=[[RHGesturePasswordViewController alloc]init];
        //        controller.isReset=YES;
        [self.navigationController pushViewController:controller animated:NO];
    }else{
        [[RHTabbarManager sharedInterface] initTabbar];
        [[[RHTabbarManager  sharedInterface] selectTabbarMain] popToRootViewControllerAnimated:NO];
    }
    
    [timer invalidate];
}

-(void)timerdown{
    self.mytimer--;
    self.button.titleLabel.text = [NSString stringWithFormat:@"%ld跳过",self.mytimer];
    [self.button setTitle:[NSString stringWithFormat:@"%ld跳过",self.mytimer] forState:UIControlStateNormal];
    
//     [self.button setTitle:[NSString stringWithFormat:@"%ld跳过",self.mytimer] forState:UIControlStateNormal];
    if (self.mytimer==0) {
        
       if ([RHUserManager sharedInterface].username&&[[RHUserManager sharedInterface].username length]>0) {
        RHGesturePasswordViewController* controller=[[RHGesturePasswordViewController alloc]init];
//        controller.isReset=YES;
        [self.navigationController pushViewController:controller animated:NO];
       }else{
           [[RHTabbarManager sharedInterface] initTabbar];
           [[[RHTabbarManager  sharedInterface] selectTabbarMain] popToRootViewControllerAnimated:NO];
       }

         [timer invalidate];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
