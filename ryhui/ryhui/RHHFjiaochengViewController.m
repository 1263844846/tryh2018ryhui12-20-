//
//  RHHFjiaochengViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 2017/10/31.
//  Copyright © 2017年 stefan. All rights reserved.
//

#import "RHHFjiaochengViewController.h"
#import <SobotKit/SobotKit.h>
#import <SobotKit/ZCUIChatController.h>
@interface RHHFjiaochengViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webview;

@end

@implementation RHHFjiaochengViewController
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
-(void)rightbutton{
    
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
//                [DQViewController Sharedbxtabar].tarbar.hidden = NO;
                [[DQViewController Sharedbxtabar].tabBar setHidden:YES];
            });
        }
        
        // 页面UI初始化完成，可以获取UIView，自定义UI
        if(type==ZCPageBlockLoadFinish){
            [DQViewController Sharedbxtabar].tarbar.hidden = YES;
            //            object.navigationController.interactivePopGestureRecognizer.delegate = object;
            // banner 返回按钮
            [object.backButton setTitle:@"关闭" forState:UIControlStateNormal];
            
            
        }
    } messageLinkClick:nil];
    NSLog(@"nicaicai");
    
}

-(void)backw{
    
    
    // NSLog(@"1111");
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    UIButton* button=[UIButton buttonWithType:UIButtonTypeCustom];
//    [button addTarget:self action:@selector(backw) forControlEvents:UIControlEventTouchUpInside];
//    //    UIImage * image = [UIImage imageNamed:@"back.png"];
//
//    [button setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
//    button.frame=CGRectMake(0, 0, 11, 17);
//
//
//    self.navigationItem.leftBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:button];
    [self configBackButton];
    [self configTitleWithString:@"汇付天下官网转出余额"];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@huifuAppCourse",[RHNetworkService instance].newdoMain]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url];
    [request setHTTPMethod:@"GET"];
    [self.webview loadRequest: request];
    
    UIButton*rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,30,30)];
    NSString *version = [UIDevice currentDevice].systemVersion;
    if ([version doubleValue]>=11) {
        UIImage *theImage = [self imageWithImageSimple:[UIImage imageNamed:@"kefu.png"] scaledToSize:CGSizeMake(40, 40)];
        // [self imageWithImageSimple:imageview1.image scaledToSize:CGSizeMake(12, 12)];
        
        //NSData * imageData = UIImageJPEGRepresentation(imageview1.image, 0.1);
        [rightButton setImage:theImage forState:UIControlStateNormal];
    }else{
        [rightButton setImage:[UIImage imageNamed:@"kefu.png"]forState:UIControlStateNormal];
    }
    [rightButton addTarget:self action:@selector(rightbutton)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    
    
    //    [btn setTitle:@""];
    //
    //
    //    [btn setTintColor:[RHUtility colorForHex:@"#44bbc1"]];
    //btn.image = [UIImage imageNamed:@"gengduo"];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    [self configBackButton];
}
- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize {
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
}

#pragma mark 保存图片到document
- (void)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName {
    NSData* imageData = UIImagePNGRepresentation(tempImage);
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    // Now we get the full path to the file
    NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:imageName];
    // and then we write it out
    [imageData writeToFile:fullPathToFile atomically:NO];
}

#pragma mark 从文档目录下获取Documents路径
- (NSString *)documentFolderPath {
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
