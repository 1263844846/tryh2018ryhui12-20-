//
//  RHMoreViewController.m
//  ryhui
//
//  Created by stefan on 15/3/15.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHMoreViewController.h"
#import "RHAboutViewController.h"
#import "RHIntroductionViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKUI/SSUIShareActionSheetStyle.h>
#import "WXApi.h"
#import "WeiboSDK.h"
#import "RHHelpCenterViewController.h"
#import "RHFeedbackViewController.h"

#import "RHhelper.h"

@interface RHMoreViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *alertView;
@property (weak, nonatomic) IBOutlet UILabel *more;

@end

@implementation RHMoreViewController
-(void)stzfpush{
    
    [[RHNetworkService instance] POST:@"front/payment/account/trusteePayAlter" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSString * str = [NSString stringWithFormat:@"%@",responseObject[@"flag"]];
            
//            self.dbsxstr = str;
            [RHhelper ShraeHelp].dbsxstr = str;
            
        }
        
        NSLog(@"%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
    }];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden=NO;
}
-(void)viewWillAppear:(BOOL)animated {
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
//    [self stzfpush];
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;
    [RYHViewController Sharedbxtabar].tarbar.hidden = NO;
    [[RHNetworkService instance] POST:@"front/payment/account/countUnReadMessage" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        DLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSString* numStr=nil;
            if (![[responseObject objectForKey:@"msgCount"] isKindOfClass:[NSNull class]]) {
                if ([[responseObject objectForKey:@"msgCount"] isKindOfClass:[NSNumber class]]) {
                    numStr=[[responseObject objectForKey:@"msgCount"] stringValue];
                }else{
                    numStr=[responseObject objectForKey:@"msgCount"];
                }
            }
            if (numStr) {
                [[NSUserDefaults standardUserDefaults] setObject:numStr forKey:@"RHMessageNumSave"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"RHMessageNum" object:numStr];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
   // [self configTitleWithString:@"11"];
    self.alertView.hidden=YES;
    self.scrollView.contentSize=CGSizeMake(self.scrollView.frame.size.width, 483);
    if ([UIScreen mainScreen].bounds.size.height < 481){
        self.scrollView.contentSize=CGSizeMake(self.scrollView.frame.size.width, 500);
    }
}


- (IBAction)pushMain:(id)sender {
    [[[RHTabbarManager sharedInterface] selectTabbarMain] popToRootViewControllerAnimated:NO];
}

- (IBAction)pushUser:(id)sender {
    [[[RHTabbarManager sharedInterface] selectTabbarUser] popToRootViewControllerAnimated:NO];
}

- (IBAction)pushAbout:(id)sender {
    [RYHViewController Sharedbxtabar].tarbar.hidden = YES;
    RHAboutViewController* controller=[[RHAboutViewController alloc]initWithNibName:@"RHAboutViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)callPhone:(id)sender {
    self.alertView.hidden=NO;
    [[UIApplication sharedApplication].keyWindow addSubview:self.alertView];
}

- (IBAction)call:(id)sender {
    self.alertView.hidden=YES;
}

- (IBAction)cancelCall:(id)sender {
   
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:4000104001"]];
}

//平台介绍
- (IBAction)pushIntroduction:(id)sender {
    [RYHViewController Sharedbxtabar].tarbar.hidden = YES;
    RHIntroductionViewController* controller=[[RHIntroductionViewController alloc]initWithNibName:@"RHIntroductionViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}
//分享
- (IBAction)shareAction:(id)sender {
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"GestureIcon" ofType:@"png"];
    
    
    [SSUIShareActionSheetStyle setShareActionSheetStyle:ShareActionSheetStyleSimple];
    NSArray* imageArray = @[[UIImage imageNamed:@"fenxiang1.png"]];
    //    images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"银行资金存管，优质机构担保，100元起出借，目标年化利率7~12%，注册送豪华大礼包。"
                                         images:imageArray
                                            url:[NSURL URLWithString:@"http://www.ryhui.com"]
                                          title:@"我在融益汇赚取好收益，邀您一起来体验！ "
                                           type:SSDKContentTypeAuto];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                   message:nil
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                               [alertView show];
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           default:
                               break;
                       }
                   }
         ];}

    
    //构造分享内容
//    id<ISSContent> publishContent = [ShareSDK content:@"中国普惠金融联席会指导、国开行金融管理团队打造。100元起投，年化收益7-12%，注册开户再送258元红包”！http://www.ryhui.com" defaultContent:nil
//                                                image:[ShareSDK imageWithPath:imagePath]
//                                                title:@"我在融益汇赚取好收益，邀您一起安全理财！"
//                                                  url:@"http://www.ryhui.com/appDownload"
//                                          description:nil
//                                            mediaType:SSPublishContentMediaTypeNews | SSPublishContentMediaTypeText];
//    //创建弹出菜单容器
//    id<ISSContainer> container = [ShareSDK container];
//    [container setIPhoneContainerWithViewController:self];
//     //弹出分享菜单
//    [ShareSDK showShareActionSheet:container    
//                         shareList:nil
//                           content:publishContent
//                     statusBarTips:YES
//                       authOptions:nil
//                      shareOptions:nil
//                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
//                                if (state == SSResponseStateSuccess) {
//                                    if (type == ShareTypeWeixiFav) {
//                                        [RHUtility showTextWithText:@"收藏成功!"];
//                                    } else {
//                                        [RHUtility showTextWithText:@"分享成功!"];
//                                    }
//                                } else if (state == SSResponseStateFail) {
//                                    [RHUtility showTextWithText:[NSString stringWithFormat:@"%@",[error errorDescription]]];
//                                }
//                            }];
}



- (IBAction)help:(id)sender {
    
    [RYHViewController Sharedbxtabar].tarbar.hidden = YES;
    RHHelpCenterViewController * vc = [[RHHelpCenterViewController alloc]initWithNibName:@"RHHelpCenterViewController" bundle:nil];
    
    [self.navigationController pushViewController:vc animated:NO];
    
}
- (IBAction)yijianfankui:(id)sender {
    [RYHViewController Sharedbxtabar].tarbar.hidden = YES;
//     RHHelpCenterViewController * vc = [[RHHelpCenterViewController alloc]initWithNibName:@"RHHelpCenterViewController" bundle:nil];
    RHFeedbackViewController * vc = [[RHFeedbackViewController alloc]initWithNibName:@"RHFeedbackViewController" bundle:nil];
    

    [self.navigationController pushViewController:vc animated:YES];
}


@end
