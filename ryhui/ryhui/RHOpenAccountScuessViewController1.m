//
//  RHOpenAccountScuessViewController1.m
//  ryhui
//
//  Created by 糊涂虫 on 2018/5/9.
//  Copyright © 2018年 stefan. All rights reserved.
//

#import "RHOpenAccountScuessViewController1.h"
#import "RHhelper.h"

#import "RHGesturePasswordViewController.h"
@interface RHOpenAccountScuessViewController1 ()
{
    int secondsCountDown;
    NSTimer *countDownTimer;
}
@property (weak, nonatomic) IBOutlet UILabel *miaolab;
@property (weak, nonatomic) IBOutlet UIImageView *hidenimage;

@property (weak, nonatomic) IBOutlet UILabel *hidenfuhao;
@property (weak, nonatomic) IBOutlet UILabel *hidenmoney;
@property (weak, nonatomic) IBOutlet UILabel *hidenmiaoshu;

@end

@implementation RHOpenAccountScuessViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [RHUserManager sharedInterface].custId = @"first";
    [self configTitleWithString:@"开户成功"];
    [self reSendMessage];
    [self configBackButton];
    [self getmydata];
}

-(void)getmydata{
    [[RHNetworkService instance]POST:@"front/payment/reformAccountJx/isAccountJx" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
             if (responseObject[@"isGift"]&&![responseObject[@"isGift"] isKindOfClass:[NSNull class]]) {
                 
                 if ([responseObject[@"isGift"]isEqualToString:@"no"]) {
                     self.hidenfuhao.hidden = YES;
                     self.hidenimage.hidden = YES;
                     self.hidenmiaoshu.hidden = YES;
                     self.hidenmoney.hidden = YES;
                 }else{
                     if (responseObject[@"giftType"]&&![responseObject[@"giftType"] isKindOfClass:[NSNull class]]) {
                         if ([responseObject[@"giftType"] isEqualToString:@"instead_cash"])  {
                             
                             if (responseObject[@"giftmoney"]&&![responseObject[@"giftmoney"] isKindOfClass:[NSNull class]]){
                                 self.hidenmoney.text = [NSString stringWithFormat:@"%@",responseObject[@"giftmoney"]];
                             }
                             
                         }else{
                             if (responseObject[@"giftmoney"]&&![responseObject[@"giftmoney"] isKindOfClass:[NSNull class]]){
                             self.hidenmoney.text = [NSString stringWithFormat:@"%@%%",responseObject[@"giftmoney"]];
                             self.hidenfuhao.hidden = YES;
                             }
                         }
                         
                         
                         
                         
                     }
                     
                 }
             }
            
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)reSendMessage {
    secondsCountDown = 5;
    //[self.yanzhengmatf becomeFirstResponder];
    // self.huoqubtn.enabled = NO;
    countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
}

- (void)timeFireMethod {
    secondsCountDown --;
    
    self.miaolab.text = [NSString stringWithFormat:@"%dS后自动跳转",secondsCountDown] ;
    if (secondsCountDown == 0) {
        [self myaccout:nil];
        [countDownTimer invalidate];
    }
}

- (IBAction)myaccout:(id)sender {
    [countDownTimer invalidate];
    [RHUserManager sharedInterface].custId = @"first";
    //    UINavigationController* nav = [[RHTabbarManager sharedInterface] selectTabbarUser];
    //    [RHhelper ShraeHelp].resss =5;
    //    RHUserCountViewController *controller = [[RHUserCountViewController alloc]initWithNibName:@"RHUserCountViewController" bundle:nil];
    //    //            controller.type = @"0";
    //    [nav pushViewController:controller animated:YES];
    //    [[RYHViewController Sharedbxtabar]tabBar:(RYHView *)controller.view didSelectedIndex:2];
    //    UIButton *btn = [[UIButton alloc]init];
    //    btn.tag = 2;
    //    [[RYHView Shareview] btnClick:btn];
    //  [self.navigationController popToRootViewControllerAnimated:NO];
    
    
    
    //    RHUserCountViewController *controller = [[RHUserCountViewController alloc]initWithNibName:@"RHUserCountViewController" bundle:nil];
    //
    //    //            controller.type = @"0";
    ////                    [nav pushViewController:controller animated:YES];
    //
    //
    //    [[RYHViewController Sharedbxtabar]tabBar:(RYHView *)controller.view didSelectedIndex:2];
    //    UIButton *btn = [[UIButton alloc]init];
    //    btn.tag = 2;
    //    [[RYHView Shareview] btnClick:btn];
    //    [nav popToRootViewControllerAnimated:NO];
    
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@Gesture",[RHUserManager sharedInterface].username]]&&[[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@Gesture",[RHUserManager sharedInterface].username]] length]>0) {
        [RHhelper ShraeHelp].registnum = 9;
        RHUserCountViewController *controller = [[RHUserCountViewController alloc]initWithNibName:@"RHUserCountViewController" bundle:nil];
        [self.navigationController popToRootViewControllerAnimated:NO];
        //            controller.type = @"0";
        //                [nav pushViewController:controller animated:YES];
        
        
        [[RYHViewController Sharedbxtabar]tabBar:(RYHView *)controller.view didSelectedIndex:2];
        UIButton *btn = [[UIButton alloc]init];
        btn.tag = 2;
        [[RYHView Shareview] btnClick:btn];
        //
        
        
        //                return;
    } else {
        RHGesturePasswordViewController* controller=[[RHGesturePasswordViewController alloc]init];
        controller.isRegister = YES;
        [RHhelper ShraeHelp].registnum = 9;
        [self.navigationController pushViewController:controller animated:NO];
    }

}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [countDownTimer invalidate];
}
@end
