//
//  RHHFJXScuessViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 17/10/13.
//  Copyright © 2017年 stefan. All rights reserved.
//

#import "RHHFJXScuessViewController.h"
#import <SobotKit/SobotKit.h>
#import <SobotKit/ZCUIChatController.h>
@interface RHHFJXScuessViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *namelab;
@property (weak, nonatomic) IBOutlet UILabel *miaoshulab;
@property (weak, nonatomic) IBOutlet UILabel *right;
@property (weak, nonatomic) IBOutlet UILabel *left;

@end

@implementation RHHFJXScuessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [RYHViewController Sharedbxtabar].tarbar.hidden = YES;
    UIButton* button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(backw) forControlEvents:UIControlEventTouchUpInside];
    //    UIImage * image = [UIImage imageNamed:@"back.png"];
    
    [button setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    button.frame=CGRectMake(0, 0, 11, 17);
    
    
    self.navigationItem.leftBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:button];
    if (![self.str isEqualToString:@"1"]) {
       // self.miaoshulab.text = @"资金转出失败，请联系客服或拨打 400-010-4001 。 ";
        self.namelab.text = @"余额转出失败";
        self.image.image = [UIImage imageNamed:@"PNG_失败"];
        self.miaoshulab.text = [NSString stringWithFormat:@"%@\n资金转出失败，请联系客服或拨打 400-010-4001 。",self.str];
        self.left.text = @"联系客服";
        self.right.text = @"重新转出";
    }
    
    
}

-(void)backw{

    
   // NSLog(@"1111");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)customUserInformationWith:(ZCLibInitInfo*)initInfo{
    // 用户手机号码
    //    initInfo.phone        = @"Your phone";
    
    // 用户昵称
    initInfo.nickName     = [RHUserManager sharedInterface].username;
}
- (void)setZCLibInitInfoParam:(ZCLibInitInfo *)initInfo{
    // 获取AppKey
    initInfo.appKey = @"75bdfe3a9f9c4b8a846e9edc282c92b4";
    //    initInfo.appKey = @"23a063ddadb1485a9a59f391b46bcb8b";
    //    initInfo.skillSetId = _groupIdTF.text;
    //    initInfo.skillSetName = _groupNameTF.text;
    //    initInfo.receptionistId = _aidTF.text;
    //    initInfo.robotId = _robotIdTF.text;
    //    initInfo.tranReceptionistFlag = _aidTurn;
    //    initInfo.scopeTime = [_historyScopeTF.text intValue];
    //    initInfo.titleType = titleType;
    //    initInfo.customTitle = _titleCustomTF.text;
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    
}
- (IBAction)leftbtn:(id)sender {
    
    if ([self.left.text isEqualToString:@"项目列表"]) {
        
        RHProjectListViewController *controller = [[RHProjectListViewController alloc]initWithNibName:@"RHProjectListViewController" bundle:nil];
        controller.type = @"0";
        //    [nav pushViewController:controller animated:YES];
        [[RYHViewController Sharedbxtabar]tabBar:(RYHView *)controller.view didSelectedIndex:1];
        UIButton *btn = [[UIButton alloc]init];
        btn.tag = 1;
        [[RYHView Shareview] btnClick:btn];
        [self.navigationController popToRootViewControllerAnimated:NO];
        return;
    }
    ZCLibInitInfo *initInfo = [ZCLibInitInfo new];
    // Appkey    *必填*
    //initInfo.appKey  = @"75bdfe3a9f9c4b8a846e9edc282c92b4";//appKey;
    initInfo.nickName     = [RHUserManager sharedInterface].username;
    //自定义用户参数
    [self customUserInformationWith:initInfo];
    [self setZCLibInitInfoParam:initInfo];
    ZCKitInfo *uiInfo=[ZCKitInfo new];
    // uiInfo.info=initInfo;
    uiInfo.isOpenEvaluation = YES;
    [[ZCLibClient getZCLibClient] setLibInitInfo:initInfo];
    // 自定义UI
    //    [self customerUI:uiInfo];
    
    
    // 之定义设置参数
    //    [self customerParameter:uiInfo];
    
    
    // 未读消息
    //    [self customUnReadNumber:uiInfo];
    
    
    // 测试模式
    //    [ZCSobot setShowDebug:YES];
    
    
    // 自动提醒消息
    //    if ([_configModel.autoNotification intValue] == 1) {
    //        [[ZCLibClient getZCLibClient] setAutoNotification:YES];
    //    }else{
    //        [[ZCLibClient getZCLibClient] setAutoNotification:NO];
    //    }
    
    
    // 启动
    [ZCSobot startZCChatView:uiInfo with:self target:nil pageBlock:^(ZCUIChatController *object, ZCPageBlockType type) {
        // 点击返回
        if(type==ZCPageBlockGoBack){
            NSLog(@"点击了关闭按钮");
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                //                            [self.navigationController setNavigationBarHidden:NO];
//                [RYHViewController Sharedbxtabar].tarbar.hidden = NO;
                [[RYHViewController Sharedbxtabar].tabBar setHidden:YES];
            });
        }
        
        // 页面UI初始化完成，可以获取UIView，自定义UI
        if(type==ZCPageBlockLoadFinish){
            [RYHViewController Sharedbxtabar].tarbar.hidden = YES;
            //            object.navigationController.interactivePopGestureRecognizer.delegate = object;
            // banner 返回按钮
            [object.backButton setTitle:@"关闭" forState:UIControlStateNormal];
            
            
        }
    } messageLinkClick:nil];
}

- (IBAction)rightbtn:(id)sender {
    if ([self.right.text isEqualToString:@"我的账户"]) {
//        [RHhelper ShraeHelp].resss =5;
        RHUserCountViewController *controller = [[RHUserCountViewController alloc]initWithNibName:@"RHUserCountViewController" bundle:nil];
        //            controller.type = @"0";
//        [nav pushViewController:controller animated:YES];
        [[RYHViewController Sharedbxtabar]tabBar:(RYHView *)controller.view didSelectedIndex:2];
        UIButton *btn = [[UIButton alloc]init];
        btn.tag = 2;
        [[RYHView Shareview] btnClick:btn];
        [self.navigationController popToRootViewControllerAnimated:NO];
        return;
        
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
