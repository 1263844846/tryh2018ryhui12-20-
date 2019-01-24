//
//  RHRNewShareWebViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 17/4/7.
//  Copyright © 2017年 stefan. All rights reserved.
//

#import "RHRNewShareWebViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKUI/SSUIShareActionSheetStyle.h>
#import "WXApi.h"
#import "WeiboSDK.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"
#import "RHALoginViewController.h"
#import <WebKit/WebKit.h>
#import "RHFriendViewController.h"
#import "RHProjectListViewController.h"
#import "RHRegisterViewController.h"
@interface RHRNewShareWebViewController ()<UIWebViewDelegate>
{
    NSURLConnection *_urlConnection;
    NSMutableURLRequest *_request;
    BOOL _authenticated;
    
}
@property (weak, nonatomic) IBOutlet UIWebView *WebView;
@property(nonatomic,strong)WKWebView * wkWebview;
@property (weak, nonatomic) IBOutlet UIButton *sharebtn;
@property(nonatomic,strong)NSDictionary *dic;
@property(nonatomic,copy)NSString * giftstr;
@property(nonatomic,strong)UIImageView * image;

@property (weak, nonatomic) IBOutlet UIView *shareview;

@property (weak, nonatomic) IBOutlet UIImageView *shareimage1;
@property (weak, nonatomic) IBOutlet UIImageView *sahreiamge2;
@property (weak, nonatomic) IBOutlet UIImageView *shareiamge3;
@property (weak, nonatomic) IBOutlet UIImageView *shareimage4;
@property(nonatomic,assign)CGPoint center;
@property(nonatomic,assign)CGPoint center1;
@property(nonatomic,assign)CGPoint center2;
@property(nonatomic,assign)CGPoint center3;
@property (weak, nonatomic) IBOutlet UILabel *lab1;
@property (weak, nonatomic) IBOutlet UILabel *lab2;

@property (weak, nonatomic) IBOutlet UILabel *lab3;
@property (weak, nonatomic) IBOutlet UILabel *lab4;
@property (weak, nonatomic) IBOutlet UIView *mengbanView;
@property(nonatomic,strong)NSTimer* timer;
@end

@implementation RHRNewShareWebViewController

//-(NSDictionary *)dic{
//    
//    if (!_dic) {
//        _dic = [NSDictionary dictionary];
//    }
//    return _dic;
//}
-(void)rightbtn{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)getrightbtn{
    UIBarButtonItem * btn = [[UIBarButtonItem alloc]initWithTitle:@"登录" style:UIBarButtonItemStylePlain target:self action:@selector(rightbtn)];
    
    [btn setTitle:@"关闭"];
    [btn setTintColor:[RHUtility colorForHex:@"#44bbc1"]];
    
    
    self.navigationItem.rightBarButtonItem = btn;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self getloaddata];
    [self configTitleWithString:@"邀请有礼"];
    [self configBackButton];
    [self getrightbtn];
    
    //https://www.ryhui.com/common/main/inviteFriendApp
    [[UIApplication sharedApplication].keyWindow addSubview:self.shareview];
    self.shareview.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-220, [UIScreen mainScreen].bounds.size.width, 220);
    self.shareview.hidden = YES;
    self.mengbanView.hidden = YES;
    [[UIApplication sharedApplication].keyWindow addSubview:self.sharebtn];
    self.sharebtn.frame = CGRectMake(10, [UIScreen mainScreen].bounds.size.height-42,  [UIScreen mainScreen].bounds.size.width-20, 37);
    [self getdatasharefriend];
    self.wkWebview.frame = self.wkWebview.frame;
    NSURL *webUrl = [NSURL URLWithString:_urlString];
    _request = [NSMutableURLRequest requestWithURL:webUrl];
    //NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url];
    //NSString * namestr = [RHUserManager sharedInterface].username;
    NSString* session=[[NSUserDefaults standardUserDefaults] objectForKey:@"RHSESSION"];
    if (![RHUserManager sharedInterface].username) {
        session = nil;
    }
    if (session&&[session length]>0) {
        [_request setValue:session forHTTPHeaderField:@"Set-Cookie"];
    }
    [_request setHTTPMethod:@"GET"];
    //[self.webView loadRequest: request];
    
//    self.wkWebview.UIDelegate = self;
    [_WebView loadRequest:_request];
    _WebView.scalesPageToFit = YES;
    _WebView.delegate = self;
    
    
    CGPoint center = self.shareimage1.center ;
    
    
    center.y += [UIScreen mainScreen].bounds.size.height-400;
    
    
    self.shareimage1.center = center;
    self.lab1.center = center;
    CGPoint center1 = self.sahreiamge2.center ;
    
    
    center1.y += [UIScreen mainScreen].bounds.size.height-400;
    
    
    self.sahreiamge2.center = center1;
    self.lab2.center = center1;
    CGPoint center2 = self.shareiamge3.center ;
    
    
    center2.y += [UIScreen mainScreen].bounds.size.height-400;
    
    
    self.shareiamge3.center = center2;
    self.lab3.center = center2;
    
    CGPoint center3 = self.shareimage4.center ;
    
    
    center3.y += [UIScreen mainScreen].bounds.size.height-400;
    
    
    self.shareimage4.center = center3;
    self.lab4.center = center3;
    self.center = CGPointMake(center.x, center.y);
    self.center1 = CGPointMake(center1.x, center1.y);
    self.center2 = CGPointMake(center2.x, center2.y);
    self.center3 = CGPointMake(center3.x, center3.y);
    
    UITapGestureRecognizer * tap1 = [[UITapGestureRecognizer alloc]init];
    [tap1 addTarget:self action:@selector(setstatshare)];
    UITapGestureRecognizer * tap2 = [[UITapGestureRecognizer alloc]init];
    [tap2 addTarget:self action:@selector(setstatshare2)];
    UITapGestureRecognizer * tap3 = [[UITapGestureRecognizer alloc]init];
    [tap3 addTarget:self action:@selector(setstatshare3)];
    UITapGestureRecognizer * tap4 = [[UITapGestureRecognizer alloc]init];
    [tap4 addTarget:self action:@selector(setstatshare4)];
    [self.shareimage1 addGestureRecognizer:tap1];
    [self.sahreiamge2 addGestureRecognizer:tap2];
    [self.shareiamge3 addGestureRecognizer:tap3];
    [self.shareimage4 addGestureRecognizer:tap4];
    self.shareimage1.userInteractionEnabled = YES;
    self.sahreiamge2.userInteractionEnabled = YES;
    self.shareiamge3.userInteractionEnabled = YES;
    self.shareimage4.userInteractionEnabled = YES;
    
    
    if ([UIScreen mainScreen].bounds.size.height>740) {
        self.sharebtn.frame = CGRectMake(10, [UIScreen mainScreen].bounds.size.height-42-27,  [UIScreen mainScreen].bounds.size.width-20, 37);
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.sharebtn.hidden = YES;
    self.shareview.hidden = YES;
    self.mengbanView.hidden = YES;
    [self.timer invalidate];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getdatasharefriend{
    NSDictionary* parameters=@{@"shareId":self.shareid};
    [[RHNetworkService instance] POST:@"app/common/appMain/shareLinkById" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
           
            self.dic = [NSDictionary dictionaryWithDictionary:responseObject];
            NSLog(@"%@",responseObject);
            
            self.sharebtn.backgroundColor = [RHUtility colorForHex:[NSString stringWithFormat:@"#%@",self.dic[@"buttonColor"]]];
//            self.sharebtn.titleLabel.text = self.dic[@"buttonWord"];
            [self.sharebtn setTitle:self.dic[@"buttonWord"] forState:UIControlStateNormal];
            [self.sharebtn setTitleColor:[RHUtility colorForHex:[NSString stringWithFormat:@"#%@",self.dic[@"buttonWordColor"]]]forState:UIControlStateNormal];
            self.image  = [[UIImageView alloc]init];
            //    image.frame = CGRectMake(414, 414, 414, 414);
            [self.image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@common/main/attachment/%@",[RHNetworkService instance].newdoMain,self.dic[@"linkImageUrl"]]]];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        
    }];
    
    
}
- (IBAction)ShareFriend:(id)sender {
    
   
    
    
    if (![RHUserManager sharedInterface].username) {
        RHALoginViewController * vc = [[RHALoginViewController alloc]initWithNibName:@"RHALoginViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
    
    self.mengbanView.hidden = NO;
    self.shareview.hidden = NO;
    self.sharebtn.hidden = YES;
    CGPoint center1 = CGPointMake(self.center.x, self.center.y);
    center1.y -=[UIScreen mainScreen].bounds.size.height+5-400;
    
    
    CGPoint center2 = CGPointMake(self.center1.x, self.center1.y);
    center2.y -=[UIScreen mainScreen].bounds.size.height+5-400;
    CGPoint center3 = CGPointMake(self.center2.x, self.center2.y);
    center3.y -=[UIScreen mainScreen].bounds.size.height+5-400;
    CGPoint center4 = CGPointMake(self.center3.x, self.center3.y);
    center4.y -=[UIScreen mainScreen].bounds.size.height+5-400;
    [UIView animateWithDuration:0.2 delay:0 options:0.1 animations:^{
        
        self.shareimage1.center = center1;
        self.lab1.center = CGPointMake(center1.x, center1.y+50);
    } completion:nil];
    [UIView animateWithDuration:0.2 delay:0.05 options:0.1 animations:^{
        
        //        self.lab2.transform = CGAffineTransformMakeScale(1, 1);
        self.sahreiamge2.center = center2;
        self.lab2.center = CGPointMake(center2.x, center2.y+50);
    } completion:nil];
    [UIView animateWithDuration:0.2 delay:0.1 options:0.2 animations:^{
        
        self.shareiamge3.center = center3;
        self.lab3.center =CGPointMake(center3.x, center3.y+50);
    } completion:nil];
    [UIView animateWithDuration:0.2 delay:0.15 options:0.2 animations:^{
        
        self.shareimage4.center = center4;
        self.lab4.center = CGPointMake(center4.x, center4.y+50);
    } completion:nil];
    center1.y +=5;
    center2.y +=5;
    center3.y+=5;
    center4.y+=5;
    [UIView animateWithDuration:0.1 delay:0.2 options:0.1 animations:^{
        
        //        self.lab2.transform = CGAffineTransformMakeScale(1, 1);
        self.shareimage1.center = center1;
        self.lab1.center = CGPointMake(center1.x, center1.y+50);
    } completion:nil];
    [UIView animateWithDuration:0.1 delay:0.25 options:0.1 animations:^{
        
        //        self.lab2.transform = CGAffineTransformMakeScale(1, 1);
        self.sahreiamge2.center = center2;
        self.lab2.center = CGPointMake(center2.x, center2.y+50);
    } completion:nil];
    [UIView animateWithDuration:0.1 delay:0.3 options:0.1 animations:^{
        
        //        self.lab2.transform = CGAffineTransformMakeScale(1, 1);
        self.shareiamge3.center = center3;
        self.lab3.center = CGPointMake(center3.x, center3.y+50);
    } completion:nil];
    [UIView animateWithDuration:0.1 delay:0.35 options:0.1 animations:^{
        
        //        self.lab2.transform = CGAffineTransformMakeScale(1, 1);
        self.shareimage4.center = center4;
        self.lab4.center = CGPointMake(center4.x, center4.y+50);
    } completion:nil];
    
    
    return;
    
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"fenxiang1" ofType:@"png"];
    [SSUIShareActionSheetStyle setShareActionSheetStyle:ShareActionSheetStyleSimple];
   
//     UIImageView * image  = [[UIImageView alloc]init];
//    image.frame = CGRectMake(414, 414, 414, 414);
//    [image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@common/main/attachment/%@",[RHNetworkService instance].newdoMain,self.dic[@"linkImageUrl"]]]];
     NSArray* imageArray = @[@"111"];
//     NSArray* imageArray1 = @[[UIImage imageNamed:@"fenxiang1.png"]];
    
//    NSArray* imageArray = @[[UIImage imageWithCGImage:(__bridge CGImageRef _Nonnull)(image)]];
    //    images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (imageArray) {
//        UIImageView * image  = [[UIImageView alloc]init];
        
//        UIImageView * img = [[UIImageView alloc]init];
//        [img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@common/main/attachment/%@",[RHNetworkService instance].newdoMain,self.dic[@"linkImageUrl"]]]];
//        imageArray =@[img];
        
        //[UIImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@common/main/attachment/%@",[RHNetworkService instance].newdoMain,self.dic[@"linkImageUrl"]]]]
        NSURL * url ;
        if ([self.pinjie isEqualToString:@"true"]) {
            url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",self.dic[@"sharedLink"],self.giftstr]];
        }else{
            url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",self.dic[@"sharedLink"]]];
        }
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:[NSString stringWithFormat:@"%@",self.dic[@"linkWord"]]
                                         images:self.image.image
                                            url:url
                                          title:[NSString stringWithFormat:@"%@",self.dic[@"shareName"]]
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
//    self.sharebtn.titleLabel.text = self.dic[@"buttonWord"];
    
}

-(void)getloaddata{
    
    //    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[RHNetworkService instance] POST:@"app/front/payment/appInviteFriends/getMyInviteCode" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSLog(@"%@",responseObject);
            if (responseObject[@"code"]||![responseObject[@"code"] isKindOfClass:[NSNull class]]) {
                self.giftstr = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
            }
//            if (responseObject[@"myAward"]||![responseObject[@"myAward"] isKindOfClass:[NSNull class]]) {
//                self.mygiftlab.text = [NSString stringWithFormat:@"%@",responseObject[@"myAward"]];
//            }
//            if (responseObject[@"invites"]||![responseObject[@"invites"] isKindOfClass:[NSNull class]]) {
//                self.mygiftmoney.text = [NSString stringWithFormat:@"%@",responseObject[@"invites"]];
//            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
    }];
    
}



-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if (!_authenticated) {
        _authenticated =NO;
        _urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self]; // 网上好多教程这句写的request写的是_request
        _request = request; //网上好多教程这句代码忘记加了
        [_urlConnection start];
        [self.WebView stopLoading];
        return NO;
    }
    NSString *url=[request.URL absoluteString];
    //    DLog(@"%@",url);
    if ([url rangeOfString:@"/common/main/webViewLoginBtn"].location != NSNotFound) {
        
        //        [self.navigationController pushViewController:controller animated:YES];
        RHALoginViewController * vc = [[RHALoginViewController alloc]initWithNibName:@"RHALoginViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
        return NO;
    }
    
    if ([url rangeOfString:@"/common/playGames/webViewRegBtn"].location != NSNotFound) {
        
        //        [self.navigationController pushViewController:controller animated:YES];
        
        RHRegisterViewController * vc = [[RHRegisterViewController alloc]initWithNibName:@"RHRegisterViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
        return NO;
    }
   
    if ([url rangeOfString:@"/common/playGames/webViewProBtn"].location != NSNotFound) {
        
        //        [self.navigationController pushViewController:controller animated:YES];
        
        RHProjectListViewController *controller = [[RHProjectListViewController alloc]initWithNibName:@"RHProjectListViewController" bundle:nil];
        controller.type = @"0";
        //    [nav pushViewController:controller animated:YES];
        [[RYHViewController Sharedbxtabar]tabBar:(RYHView *)controller.view didSelectedIndex:1];
        UIButton *btn = [[UIButton alloc]init];
        btn.tag = 1;
        [[RYHView Shareview] btnClick:btn];
        [self.navigationController popToRootViewControllerAnimated:NO];
        return NO;
    }
   
    
    return YES;
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    if ([challenge previousFailureCount] == 0)
    {
        _authenticated = YES;
        NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        [challenge.sender useCredential:credential forAuthenticationChallenge:challenge];
    } else
    {
        [[challenge sender] cancelAuthenticationChallenge:challenge];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // remake a webview call now that authentication has passed ok.
    _authenticated = YES;
    [self.WebView loadRequest:_request]; //  self.webView替换成自己的webview
    // Cancel the URL connection otherwise we double up (webview + url connection, same url = no good!)
    [_urlConnection cancel];
}

// We use this method is to accept an untrusted site which unfortunately we need to do, as our PVM servers are self signed.
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace
{
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}


-(void)setstatshare{
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"fenxiang1" ofType:@"png"];
    //    [SSUIShareActionSheetStyle setShareActionSheetStyle:ShareActionSheetStyleSimple];
    NSArray* imageArray = @[[UIImage imageNamed:@"fenxiang1.png"]];
    //    images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    
    
    
    
    NSURL * url ;
    if ([self.pinjie isEqualToString:@"true"]) {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",self.dic[@"sharedLink"],self.giftstr]];
    }else{
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",self.dic[@"sharedLink"]]];
    }
    
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:[NSString stringWithFormat:@"%@",self.dic[@"linkWord"]]
                                     images:self.image.image
                                        url:url
                                      title:[NSString stringWithFormat:@"%@",self.dic[@"shareName"]]
                                       type:SSDKContentTypeAuto];
    [self startSharePlatform:SSDKPlatformSubTypeWechatSession parameters:shareParams];
}
-(void)setstatshare2{
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"fenxiang1" ofType:@"png"];
    //    [SSUIShareActionSheetStyle setShareActionSheetStyle:ShareActionSheetStyleSimple];
    NSArray* imageArray = @[[UIImage imageNamed:@"fenxiang1.png"]];
    //    images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    
    NSURL * url ;
    if ([self.pinjie isEqualToString:@"true"]) {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",self.dic[@"sharedLink"],self.giftstr]];
    }else{
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",self.dic[@"sharedLink"]]];
    }
    
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:[NSString stringWithFormat:@"%@",self.dic[@"linkWord"]]
                                     images:self.image.image
                                        url:url
                                      title:[NSString stringWithFormat:@"%@",self.dic[@"shareName"]]
                                       type:SSDKContentTypeAuto];
    
    
    [self startSharePlatform:SSDKPlatformSubTypeWechatTimeline parameters:shareParams];
    
}
-(void)setstatshare3{
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"fenxiang1" ofType:@"png"];
    //    [SSUIShareActionSheetStyle setShareActionSheetStyle:ShareActionSheetStyleSimple];
    NSArray* imageArray = @[[UIImage imageNamed:@"fenxiang1.png"]];
    //    images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    
    
    
    
    NSURL * url ;
    if ([self.pinjie isEqualToString:@"true"]) {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",self.dic[@"sharedLink"],self.giftstr]];
    }else{
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",self.dic[@"sharedLink"]]];
    }
    
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:[NSString stringWithFormat:@"%@",self.dic[@"linkWord"]]
                                     images:self.image.image
                                        url:url
                                      title:[NSString stringWithFormat:@"%@",self.dic[@"shareName"]]
                                       type:SSDKContentTypeAuto];
    [self startSharePlatform:SSDKPlatformSubTypeWechatFav parameters:shareParams];
}
-(void)setstatshare4{
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"fenxiang1" ofType:@"png"];
    //    [SSUIShareActionSheetStyle setShareActionSheetStyle:ShareActionSheetStyleSimple];
    NSArray* imageArray = @[[UIImage imageNamed:@"fenxiang1.png"]];
    //    images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    
    
    
    
    NSURL * url ;
    if ([self.pinjie isEqualToString:@"true"]) {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",self.dic[@"sharedLink"],self.giftstr]];
    }else{
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",self.dic[@"sharedLink"]]];
    }
    
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:[NSString stringWithFormat:@"%@",self.dic[@"linkWord"]]
                                     images:self.image.image
                                        url:url
                                      title:[NSString stringWithFormat:@"%@",self.dic[@"shareName"]]
                                       type:SSDKContentTypeAuto];
    [self startSharePlatform:SSDKPlatformTypeSinaWeibo parameters:shareParams];
}

-(void)startSharePlatform:(SSDKPlatformType)platform parameters:(NSMutableDictionary *)parameters{
    /*
     [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
     items:nil
     shareParams:parameters
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
     ];
     
     */
    
    [ShareSDK share:platform parameters:parameters onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
        
        switch (state) {
            case SSDKResponseStateSuccess:
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功" message:nil  delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alertView show];
                break;
            }
            case SSDKResponseStateFail:
            {
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败" message:[NSString stringWithFormat:@"%@",error] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                [alert show];
                break;
            }
            default:
                break;
        }
    }];
    
}
- (IBAction)inputinshare:(id)sender {
    
    
    
    [UIView animateWithDuration:0.5 delay:0.15 options:0.1 animations:^{
        
        self.shareimage1.center = self.center;
        self.lab1.center = self.center;
    } completion:nil];
    [UIView animateWithDuration:0.2 delay:0.1 options:0.1 animations:^{
        
        //        self.lab2.transform = CGAffineTransformMakeScale(1, 1);
        self.sahreiamge2.center = self.center1;
        self.lab2.center = self.center1;
    } completion:nil];
    [UIView animateWithDuration:0.2 delay:0.05 options:0.1 animations:^{
        
        self.shareiamge3.center = self.center2;
        self.lab3.center =self.center2;
    } completion:nil];
    [UIView animateWithDuration:0.2 delay:0 options:0.1 animations:^{
        
        self.shareimage4.center = self.center3;
        self.lab4.center = self.center3;
    } completion:nil];
    self.timer =  [NSTimer scheduledTimerWithTimeInterval:0.35f target:self selector:@selector(hidenmyview) userInfo:nil repeats:NO];
    //    [self.timer fire];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self inputinshare:nil];
}
-(void)hidenmyview{
    
    self.shareview.hidden = YES;
    self.mengbanView.hidden = YES;
         self.sharebtn.hidden = NO;
}
@end
