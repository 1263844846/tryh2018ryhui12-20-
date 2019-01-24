//
//  RHOpenAccountScuessViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 17/8/1.
//  Copyright © 2017年 stefan. All rights reserved.
//

#import "RHOpenAccountScuessViewController.h"
#import "RHhelper.h"

#import "RHGesturePasswordViewController.h"
@interface RHOpenAccountScuessViewController ()
{
    int secondsCountDown;
    NSTimer *countDownTimer;
}
@property (weak, nonatomic) IBOutlet UILabel *moneylab;
@property (weak, nonatomic) IBOutlet UILabel *miaolab;


@property (weak, nonatomic) IBOutlet UIImageView *hiddenimage;


@property (weak, nonatomic) IBOutlet UILabel *hiddenlab;
@property (weak, nonatomic) IBOutlet UILabel *hiddentestlab;
@end

@implementation RHOpenAccountScuessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  //   [self configBackButton];
    // Do any additional setup after loading the view from its nib.
//    [self getkaihugift];
     [RHUserManager sharedInterface].custId = @"first";
    [self configTitleWithString:@"开户成功"];
//    [self reSendMessage];
    [self configBackButton];
    
    
    if ([UIScreen mainScreen].bounds.size.width<321) {
        self.moneylab.font = [UIFont systemFontOfSize:30];
    }
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
        [self myaccount:nil];
        [countDownTimer invalidate];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)myaccount:(id)sender {
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
-(void)getkaihugift{
    
    
    return;
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    //    [manager.operationQueue cancelAllOperations];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.securityPolicy = [[RHNetworkService instance] customSecurityPolicy];
    [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    [manager POST:[NSString stringWithFormat:@"%@app/front/payment/appAccount/newsAppQueryAccountFinishedBonuses",[RHNetworkService instance].newdoMain ] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //         NSLog(@"%@1-1-1-1-11===",responseObject);
        if ([responseObject isKindOfClass:[NSData class]]) {
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            if (dic) {
                //                 self.hongbaoview.hidden = NO;
                
                NSString* isShow=[dic objectForKey:@"isShow"];
                if (![[dic objectForKey:@"giftMoney"] isKindOfClass:[NSNull class]]) {
                    
                    CGFloat a = [[dic objectForKey:@"giftMoney"] doubleValue];
                    if (a>5) {
                        self.moneylab.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"giftMoney"]];
                    }else{
                        self.moneylab.text = [NSString stringWithFormat:@"%@%%",[dic objectForKey:@"giftMoney"]];
                        self.hiddenlab.hidden = YES;
                        self.moneylab.font = [UIFont systemFontOfSize:35];
                    }
                    
                }
                if (![[dic objectForKey:@"giftContent"] isKindOfClass:[NSNull class]]) {
                    self.hiddentestlab.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"giftContent"]];
                    
                }

                if ([isShow isEqualToString:@"true"]) {
                    //                    self.kaihumybtn.userInteractionEnabled = NO;
                    //                    self.giftView.hidden = NO;
                    
                }
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //        NSLog(@"%@2-2-2-2-2-2-2-2==",error);
        self.hiddenlab.hidden = YES;
        self.hiddenimage.hidden = YES;
        self.hiddentestlab.hidden = YES;
        self.moneylab.hidden = YES;
        if ([error.userInfo.allKeys containsObject:@"com.alamofire.serialization.response.error.data"]) {
            NSDictionary* errorDic=[NSJSONSerialization JSONObjectWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] options:NSJSONReadingMutableContainers error:nil];
            if ([errorDic objectForKey:@"msg"]) {
                //                if ([[errorDic objectForKey:@"msg"] isEqualToString:@"验证码错误"]) {
                
                //                    [self changeCaptcha];
                //                }
                //                [RHMobHua showTextWithText:[errorDic objectForKey:@"msg"]];
            }
        }
        
//        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        
    }];
    
}


@end
