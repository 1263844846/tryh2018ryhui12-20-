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

@interface RHMoreViewController ()

@end

@implementation RHMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.alertView.hidden=YES;
    self.scrollView.contentSize=CGSizeMake(self.scrollView.frame.size.width, 483);
}

- (IBAction)pushMain:(id)sender {
    [[[RHTabbarManager sharedInterface] selectTabbarMain] popToRootViewControllerAnimated:NO];
}

- (IBAction)pushUser:(id)sender {
    [[[RHTabbarManager sharedInterface] selectTabbarUser] popToRootViewControllerAnimated:NO];
}

- (IBAction)pushAbout:(id)sender {
    RHAboutViewController* controller=[[RHAboutViewController alloc]initWithNibName:@"RHAboutViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)callPhone:(id)sender {
    self.alertView.hidden=NO;
}

- (IBAction)call:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:4000104001"]];
}

- (IBAction)cancelCall:(id)sender {
    self.alertView.hidden=YES;
}

- (IBAction)pushIntroduction:(id)sender {
    RHIntroductionViewController* controller=[[RHIntroductionViewController alloc]initWithNibName:@"RHIntroductionViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)shareAction:(id)sender {
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"GestureIcon" ofType:@"png"];
    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:@"全国唯一由国家级金融组织和国家级信息科技组织共同打造的互联网金融平台，投资理财“容易会”！http://www.ryhui.com"
                                       defaultContent:nil
                                                image:[ShareSDK imageWithPath:imagePath]
                                                title:@"权威专业的投资理财平台“融益汇”，快来下载客户端吧～"
                                                  url:@"http://www.ryhui.com/appDownload"
                                          description:nil
                                            mediaType:SSPublishContentMediaTypeNews];
    //创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];
    [container setIPadContainerWithView:sender arrowDirect:UIPopoverArrowDirectionUp];
    
    //弹出分享菜单

    [ShareSDK showShareActionSheet:container
                         shareList:nil
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions:nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                
                                if (state == SSResponseStateSuccess)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_ShARE_SUC", @"分享成功"));
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_ShARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
                                }
                            }];
}
@end
