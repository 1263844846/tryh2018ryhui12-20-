//
//  RHUserHFViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 16/3/1.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import "RHUserHFViewController.h"
#import "RHHFTXViewController.h"
//#import "RHHFDLViewController.h"
#import "RHHFLoginPasswordViewController.h"
#import "RHHFphonenumberViewController.h"
#import "RYHViewController.h"
#import "RHForgotPasswordViewController.h"
#import "AppDelegate.h"
#import "RHRegisterWebViewController.h"
#import "RHGesturePasswordViewController.h"
#import "UIImageView+WebCache.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "RHOpenCountViewController.h"
#import "RHJXPassWordViewController.h"
#import "RHCPFirstViewController.h"

#import "RHWSQViewController.h"
#import "RHYSQViewController.h"

#import "RHPFnumberwebViewController.h"
#import "RHXMJUserViewController.h"
#import "RHPhoneKHxiugaiViewController.h"
#import "RHXYWebviewViewController.h"

@interface RHUserHFViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *cbxView;
@property (weak, nonatomic) IBOutlet UILabel *phonenumberlab;
@property (weak, nonatomic) IBOutlet UIScrollView *scoll;
@property (weak, nonatomic) IBOutlet UILabel *userCountlab;
@property (weak, nonatomic) IBOutlet UILabel *hfusercountlab;
@property (weak, nonatomic) IBOutlet UIView *hfview;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UIImageView *userphoto;
@property (weak, nonatomic) IBOutlet UIButton *hfhelpbtn;
@property (weak, nonatomic) IBOutlet UIImageView *hflogoimage;
@property (weak, nonatomic) IBOutlet UISwitch *zhiwen;

@property(copy,nonatomic)NSString * zhenwenString;
@property (weak, nonatomic) IBOutlet UIView *hidenview;
@property (weak, nonatomic) IBOutlet UILabel *cepinglab;

@property(nonatomic,copy)NSString * passwordbool;

@property (weak, nonatomic) IBOutlet UILabel *sqnamelab;
@property(nonatomic,copy)NSString *sqstring;
@property (weak, nonatomic) IBOutlet UIButton *sqbtn;

@property (weak, nonatomic) IBOutlet UILabel *sqlab;
@property (weak, nonatomic) IBOutlet UIImageView *sqimage;
@property(nonatomic,copy)NSString * sqtime;
@property(nonatomic,copy)NSString * sqmoney;

@property (weak, nonatomic) IBOutlet UILabel *sqlabwhite;

@property (copy, nonatomic) NSString *phoneSwitch;

@property (weak, nonatomic) IBOutlet UILabel *xmjsqlab;

@property(nonatomic,copy)NSString * xmjsqstr;
@property(nonatomic,copy)NSString * xmjphonenumber;

@property (weak, nonatomic) IBOutlet UIButton *xmjsqbtn;


@end

@implementation RHUserHFViewController
-(void)sqmyswitch{
    
    [[RHNetworkService instance] POST:@"front/payment/reformAccountJx/authSwitch" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        DLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            self.myswitch = responseObject[@"checkSwitch"];
            if ([self.myswitch isEqualToString:@"ON"]) {
                [self getsq];
                self.sqlabwhite.hidden = NO;
//                self.hfview.frame = CGRectMake(0, 285,  self.hfview.frame.size.width,  self.hfview.frame.size.height+45);
            }else{
                self.sqbtn.hidden = YES;
                self.sqlab.hidden = YES;
                self.sqimage.hidden = YES;
                self.sqnamelab.hidden = YES;
                self.sqlabwhite.hidden = YES;
                
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //  NSLog(@"%@",error);
        DLog(@"%@",[[NSString alloc] initWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
        
    }];
    
    NSLog(@"111");
    
}
-(void)getmyphonenumber{
    
    [[RHNetworkService instance] POST:@"app/front/payment/appJxAccount/getTelephone" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        DLog(@"%@",responseObject);
        // [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            
            
            [RHUserManager sharedInterface].telephone = responseObject[@"telephone"];
//            NSString *str = [RHUserManager sharedInterface].telephone;
            
            NSString *str = [RHUserManager sharedInterface].telephone;
            
            NSString * laststr = [str substringFromIndex:str.length - 4];
            NSString * firststr = [str substringToIndex:3];
            self.phonenumberlab.text = [NSString stringWithFormat:@"%@******%@",firststr,laststr];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //        [RHUtility showTextWithText:@"请求失败"];
        
    }];
    
}
- (void)viewDidLoad {
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    [super viewDidLoad];
//    self.hfview.frame = CGRectMake(0, 285,  self.hfview.frame.size.width,  self.hfview.frame.size.height-45);
    // Do any additional setup after loading the view from its nib.
    self.scoll.contentSize=CGSizeMake([UIScreen mainScreen].bounds.size.width,480);
    
    NSLog(@"%f",[UIScreen mainScreen].bounds.size.height);
    self.scoll.bounces = NO;
    //CGFloat www = [UIScreen mainScreen].bounds.size.width;
//    if ([UIScreen mainScreen].bounds.size.height > 660) {
//        
//        self.btn.frame = CGRectMake(self.btn.frame.origin.x, self.btn.frame.origin.y+60, www, self.btn.frame.size.height);
//        
//    }
//    [[UIApplication sharedApplication].keyWindow addSubview:self.hidenview];
 /*  if ([UIScreen mainScreen].bounds.size.width<321) {
        self.hidenview.frame = CGRectMake(self.hidenview.frame.origin.x, self.hidenview.frame.origin.y-135, [UIScreen mainScreen].bounds.size.width, self.hidenview.frame.size.height);
    }else{
    self.hidenview.frame = CGRectMake(self.hidenview.frame.origin.x, self.hidenview.frame.origin.y-30, [UIScreen mainScreen].bounds.size.width, self.hidenview.frame.size.height);
    }
  */
    [RYHViewController Sharedbxtabar].tabBar.translucent = YES;
    
    self.tabBarController.tabBar.translucent = YES;
    [RYHViewController Sharedbxtabar].tarbar.hidden = YES;
   // [self configBackButton];
    /*
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    //titleLabel.backgroundColor = [UIColor grayColor];
    
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    
    titleLabel.textColor = [UIColor whiteColor];
    
    titleLabel.textAlignment = NSTextAlignmentCenter;
    

    
     titleLabel.text = @"账户设置";
    self.navigationItem.titleView = titleLabel;
     */
    //self.view.backgroundColor = [RHUtility colorForHex:@"#e4e6e6"];
    
    [self configTitleWithString:@"账户设置"];
    [self.userphoto.layer setMasksToBounds:YES];
    [self.userphoto.layer setCornerRadius:15.0];
   
    
//    self.phonenumberlab.text = [RHUserManager sharedInterface].telephone;
    
    
    self.userphoto.userInteractionEnabled = YES;
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(mainTainHeaderImage)];
    
    self.hflogoimage.hidden = YES;
    [self.userphoto addGestureRecognizer:tap];
    [self getphotoimage];
    
    
    
    
    self.userCountlab.text = [NSString stringWithFormat:@"%@",[RHUserManager sharedInterface].username];
    
//    NSString *str = [RHUserManager sharedInterface].custId;
//
//    NSString * laststr = [str substringFromIndex:str.length - 4];
//    NSString * firststr = [str substringToIndex:4];
//    self.hfusercountlab.text = [NSString stringWithFormat:@"%@******%@",firststr,laststr];
  //  self.hfusercountlab.text = [NSString stringWithFormat:@"%@",[RHUserManager sharedInterface].custId];
    NSString * zhiwen = [[NSUserDefaults standardUserDefaults] objectForKey:@"zhiwen"];
    if ([zhiwen isEqualToString:@"zhiwen"]) {
        
        self.zhiwen.on = YES;
    }else{
        self.zhiwen.on = NO;
    }
    
    
    [self configBackButton];
    
    [self getmyjxpassword];
    
    if (RHScreeWidth <325) {
       [[UIApplication sharedApplication].keyWindow addSubview:self.hidenview];
        self.scoll.frame =CGRectMake(0, self.scoll.frame.origin.y, self.scoll.frame.size.width, self.scoll.frame.size.height-230);
        self.scoll.contentSize=CGSizeMake([UIScreen mainScreen].bounds.size.width,530);
        self.hidenview.frame = CGRectMake(self.hidenview.frame.origin.x, RHScreeHeight-80, [UIScreen mainScreen].bounds.size.width, self.hidenview.frame.size.height);
    }
    
    if ([self.myswitch isEqualToString:@"ON"]) {
         [self getsq];
    }else{
        self.sqbtn.hidden = YES;
        self.sqlab.hidden = YES;
        self.sqimage.hidden = YES;
        self.sqnamelab.hidden = YES;
    }
    
    [self switchphonenumber];
    
   
    
}

-(void)shouquanyanzhengxmj{
    
    [[RHNetworkService instance] POST:@"front/payment/accountJx/userAutoAuth" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        DLog(@"%@",responseObject);
        // [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            
            self.xmjsqstr = [NSString stringWithFormat:@"%@",responseObject[@"isAutoInvest"]];
            if ([self.xmjsqstr isEqualToString:@"no"]) {
                self.xmjsqlab.text = @"请授权";
            }else{
                self.xmjsqlab.text = @"已授权";
//                self.xmjsqbtn.userInteractionEnabled = NO;
            }
            
            NSString *str = [RHUserManager sharedInterface].telephone;
            
            NSString * laststr = [str substringFromIndex:str.length - 4];
            NSString * firststr = [str substringToIndex:3];
            self.xmjphonenumber = [NSString stringWithFormat:@"%@****%@",firststr,laststr];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //        [RHUtility showTextWithText:@"请求失败"];
        
    }];
}

-(void)getmyjxpassword{
    [[RHNetworkService instance] POST:@"app/front/payment/appReformAccountJx/getAccountId" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"----===============-1111---%@",responseObject);
        
        
        if (responseObject[@"accountId"]&&![responseObject[@"accountId"] isKindOfClass:[NSNull class]]) {
            
            NSString *str  = [NSString stringWithFormat:@"%@",responseObject[@"accountId"]];
            NSString * laststr = [str substringFromIndex:str.length - 4];
            NSString * firststr = [str substringToIndex:4];
            self.hfusercountlab.text = [NSString stringWithFormat:@"%@******%@",firststr,laststr];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
        DLog(@"%@",[[NSString alloc] initWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
        
    }];
    [[RHNetworkService instance] POST:@"app/front/payment/appJxAccount/isSetPassword" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"----===============-1111---%@",responseObject);
        
        
        self.passwordbool = [NSString stringWithFormat:@"%@",responseObject[@"setPwd"]];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
        DLog(@"%@",[[NSString alloc] initWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
        
    }];
    
}


- (IBAction)didxmjsq:(id)sender {
    
    if (![self.passwordbool isEqualToString:@"yes"]) {
        [RHUtility showTextWithText:@"请先设置交易密码"];
        
        return;
    }
    
    if ([self.xmjsqlab.text isEqualToString: @"已授权"]) {
        RHXYWebviewViewController * controller = [[RHXYWebviewViewController alloc]initWithNibName:@"RHXYWebviewViewController" bundle:nil];
        
        controller.namestr = @"融益汇自动投标服务协议";
        
        
        [self.navigationController pushViewController:controller animated:YES];
    }else{
    
          RHXMJUserViewController * vc = [[RHXMJUserViewController alloc]initWithNibName:@"RHXMJUserViewController" bundle:nil];
           vc.phonenumber = self.xmjphonenumber ;
          [self.navigationController pushViewController:vc animated:YES];
    
    
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}
-(void)viewWillDisappear:(BOOL)animated{
    
    if (RHScreeWidth <325) {
        self.hidenview.hidden = YES;
    }
    self.hidenview.hidden = YES;
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
   // self.hidenview.hidden = YES;
    //[[UIApplication sharedApplication].keyWindow addSubview:nil];
    [super viewWillDisappear:animated];
}
- (IBAction)zhiwen:(id)sender {
    
    if (self.zhiwen.on ==YES) {
        LAContext * con = [[LAContext alloc]init];
        NSError * error;
        BOOL can = [con canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
        NSLog(@"%d",can);
        if (can) {
            [RHUtility showTextWithText:@"指纹解锁开启"];
            NSString* _zhenwen=@"zhiwen";
            [RHUserManager sharedInterface].zhiwen=_zhenwen;
            [[NSUserDefaults standardUserDefaults] setObject:[RHUserManager sharedInterface].zhiwen forKey:@"zhiwen"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }else{
            [RHUtility showTextWithText:@"该设备没有设置指纹或不支持指纹"];
            self.zhiwen.on =NO;
//            return;
            self.zhenwenString = @"ryh";
        }
        
    }else{
        if (![self.zhenwenString isEqualToString:@"ryh"]) {
        [RHUtility showTextWithText:@"指纹解锁关闭"];
            NSString* _zhenwen=@"";
            [RHUserManager sharedInterface].zhiwen=_zhenwen;
            [[NSUserDefaults standardUserDefaults] setObject:[RHUserManager sharedInterface].zhiwen forKey:@"zhiwen"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }
    
}

-(void)viewWillAppear:(BOOL)animated{
    [self getceping];
    [self sqmyswitch];
     [self shouquanyanzhengxmj];
     [[UIApplication sharedApplication].keyWindow addSubview:self.hidenview];
    
    [RYHViewController Sharedbxtabar].tarbar.hidden = YES;
    
    [self getmyphonenumber];
    [super viewWillDisappear:animated];
    if ([RHUserManager sharedInterface].custId.length > 4 ) {
        self.hflogoimage.hidden = NO;
        self.hfhelpbtn.hidden = YES;
        self.hfhelpbtn.userInteractionEnabled = NO;
        
        //        [self.hfhelpbtn setImage:[UIImage imageNamed:@"hflogo"] forState:UIControlStateNormal];
        
    }else{
        
        self.hfview.hidden = YES;
    }
    self.btn.hidden = NO;
    //[[UIApplication sharedApplication].keyWindow addSubview:self.btn];
    [super viewWillAppear:animated];

    
//    if (RHScreeWidth <325) {
        self.hidenview.hidden = NO;
//    }
}

- (void)toback
{
    UIButton* button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    //    UIImage * image = [UIImage imageNamed:@"back.png"];
    
    [button setImage:[UIImage imageNamed:@"back1.png"] forState:UIControlStateNormal];
    button.frame=CGRectMake(0, 0, 11, 17);
    
    // button.backgroundColor = [UIColor colorWithHexString:@"44bbc1"];
    self.navigationItem.leftBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:button];
}
- (void)back{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}


//手机号
- (IBAction)phone:(id)sender {
    
    
     if ([RHUserManager sharedInterface].custId.length > 4 ) {
    
         RHHFphonenumberViewController * vc = [[RHHFphonenumberViewController alloc]initWithNibName:@"RHHFphonenumberViewController" bundle:nil];
         
         [self.navigationController pushViewController: vc animated:YES];
         
  
     }else{
         
         RHPhoneKHxiugaiViewController *vc1 = [[RHPhoneKHxiugaiViewController alloc]initWithNibName:@"RHPhoneKHxiugaiViewController" bundle:nil];
         
         [self.navigationController pushViewController: vc1 animated:YES];

    
    NSLog(@"手机号");
  
     }
}

//登录密码
- (IBAction)loginpassword:(id)sender {
    
    RHForgotPasswordViewController * vc = [[RHForgotPasswordViewController alloc]initWithNibName:@"RHForgotPasswordViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
    NSLog(@"登录密码");
}
//手势密码
- (IBAction)shoushimima:(id)sender {

        RHGesturePasswordViewController* controller=[[RHGesturePasswordViewController alloc]init];
        controller.isReset=YES;
        controller.myres = @"ryh";
        [self.navigationController pushViewController:controller animated:YES];
    
    NSLog(@"手势密码");
}

//开通汇付
- (IBAction)kaitonghf:(id)sender {
    RHOpenCountViewController * vc = [[RHOpenCountViewController alloc]initWithNibName:@"RHOpenCountViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
    
    NSLog(@"开通汇付");
}


//交易密码
- (IBAction)hfphone:(id)sender {
     if (![self.passwordbool isEqualToString:@"yes"]) {
         //[RHUtility showTextWithText:@"请先设置交易密码"];
         RHHFLoginPasswordViewController * controller =[[RHHFLoginPasswordViewController alloc]initWithNibName:@"RHHFLoginPasswordViewController" bundle:nil];
         controller.boolres = @"res";
//         controller.urlstr = @"app/front/payment/appReformAccountJx/passwordResetPageData";
         [self.navigationController pushViewController:controller animated:YES];
         return;
     }
    
    RHHFLoginPasswordViewController * controller =[[RHHFLoginPasswordViewController alloc]initWithNibName:@"RHHFLoginPasswordViewController" bundle:nil];
    
//    controller.urlstr = @"app/front/payment/appReformAccountJx/passwordUpdate";
//    controller.messagestr = self.yanzhengmatf.text;
    [self.navigationController pushViewController:controller animated:YES];
    
}


//汇付交易密码
- (IBAction)hflogin:(id)sender {
    
    

    RHCPFirstViewController * vc = [[RHCPFirstViewController alloc]initWithNibName:@"RHCPFirstViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}
//退出登录
- (IBAction)countloginout:(id)sender {
    NSLog(@"111111111");
    [self logoutAction:sender];
//    self
}

- (IBAction)logoutAction:(id)sender {
    
    UIAlertView* alertView=[[UIAlertView alloc]initWithTitle:@"退出确认"
                                                     message:@"您确定要退出当前账号？"
                                                    delegate:self
                                           cancelButtonTitle:@"确定"
                                           otherButtonTitles:@"取消", nil];
    alertView.tag=9999;
    [alertView show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        [self loginoutmyarccout];
        if (alertView.tag==9999) {
            [[RHUserManager sharedInterface] logout];
        }else{
            [[RHUserManager sharedInterface] logout];
            [[RHTabbarManager sharedInterface] selectALogin];
        }
    }
}

-(void)loginoutmyarccout{
    [[RHNetworkService instance] POST:@"app/common/user/appLogout/appUser" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        
    }];
    
}

- (IBAction)mainTainHeaderImage{
    //
    UIActionSheet *act = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册",@"拍照", nil];
    [act showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        //相册
        [self pickImage];
    } else if (buttonIndex == 1) {
        //拍照
        [self performSelector:@selector(snapImage) withObject:nil afterDelay:1.0];
    }
}

- (void) pickImage {
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    ipc.delegate =self;
    ipc.allowsEditing =YES;
    [self presentViewController:ipc animated:YES completion:nil];
}

- (void) snapImage {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])    {
        UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
        ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
        ipc.delegate =self;
        ipc.allowsEditing =YES;
        [self presentViewController:ipc animated:YES completion:nil];
    } else {
        [RHUtility showTextWithText:@"没有可用相机"];
    }
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
    NSDictionary *dict = [NSDictionary dictionaryWithObject:image forKey:@"UIImagePickerControllerOriginalImage"];
    [self imagePickerController:picker didFinishPickingMediaWithInfo:dict];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image= [info objectForKey:UIImagePickerControllerEditedImage];
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera)
    {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    }
    UIImage *theImage = [self imageWithImageSimple:image scaledToSize:CGSizeMake(120, 120)];
    
    self.userphoto.image = theImage;
    [self saveImage:theImage WithName:@"salesImageSmall.jpg"];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    NSData *data;
    if (UIImagePNGRepresentation(theImage) == nil) {
        data = UIImageJPEGRepresentation(theImage, 0.1);
    } else {
        data = UIImagePNGRepresentation(theImage);
    }
    
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:@"salesImageSmall.jpg"];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];

    [dic setObject:[RHUserManager sharedInterface].userId forKey:@"uid"];
   // [dic setObject:@"recentphoto" forKey:@"phototype"];
  
    
   
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = [[RHNetworkService instance] customSecurityPolicy];
    NSString* session=[[NSUserDefaults standardUserDefaults] objectForKey:@"RHSESSION"];
    NSString* session1=[[NSUserDefaults standardUserDefaults] objectForKey:@"RHNEWMYSESSION"];
    
    if (session1.length>12) {
        session = [NSString stringWithFormat:@"%@,%@",session,session1];
    }
    if (session&&[session length]>0) {
        [manager.requestSerializer setValue:session forHTTPHeaderField:@"cookie"];
        
    }
    [manager POST:[NSString stringWithFormat:@"%@app/back/archives/appHeadSculpture/updateUserHead",[RHNetworkService instance].newdoMain] parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:data
                                    name:@"myFile"
                                fileName:fullPathToFile
                                mimeType:@"image/png"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //                NSLog(@"Success: %@", responseObject);
        if ([responseObject[@"returnvalue"] integerValue] == 1) {
            //            [[NSNotificationCenter defaultCenter] postNotificationName:@"changeDataNotification" object:nil];
            //[self getThePersonalDetailInfo];
            [RHUtility showTextWithText:@"修改成功!"];
        } else {
            [RHUtility showTextWithText:responseObject[@"msg"]];
        }
        [self  getphotoimage];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //        NSLog(@"Error: %@", error);
        [RHUtility showTextWithText:@"上传失败！"];
    }];
   
}

//压缩图片
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


-(void)getphotoimage{
    
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    [dic setObject:[RHUserManager sharedInterface].userId forKey:@"uid"];
    [[RHNetworkService instance] POST:@"app/back/archives/appHeadSculpture/queryUserHead" parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        
       [self.userphoto sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@common/main/attachment/%@",[RHNetworkService instance].newdoMain,responseObject[@"headUrl"]]]];
        //NSLog(@"%@",responseObject);
        
        NSString* photoimage=[responseObject objectForKey:@"headUrl"];
        if (photoimage&&[photoimage length]>0) {
            
            photoimage = [NSString stringWithFormat:@"%@common/main/attachment/%@",[RHNetworkService instance].newdoMain,responseObject[@"headUrl"]];
            [[NSUserDefaults standardUserDefaults] setObject:photoimage forKey:@"headUrl"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    
        NSLog(@"%@",error);
        
    }];
    
    
}
-(void)getceping{
    
    
    [[RHNetworkService instance] POST:@"app/front/payment/appReskTest/isReskTest" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        DLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary * dic = responseObject[@"reskData"];
            if ([dic[@"isTest"] isEqualToString:@"no"]) {
//               self.cepinglab.text = @"";
                if (dic[@"reskType"] && ![dic[@"reskType"] isKindOfClass:[NSNull class]]) {
                    self.cepinglab.text = dic[@"reskType"];
                }else{
                    self.cepinglab.text = @"未测评";
                }
                
            }else{
                self.cepinglab.text = dic[@"reskType"];
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //  NSLog(@"%@",error);
        DLog(@"%@",[[NSString alloc] initWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
        
    }];
}
-(void)switchphonenumber{
    
    return;
    [[RHNetworkService instance] POST:@"app/common/appMain/updateTelephoneSwitch" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        DLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
           
            self.phoneSwitch = [NSString stringWithFormat:@"%@",responseObject[@"phoneSwitch"]] ;
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //  NSLog(@"%@",error);
        DLog(@"%@",[[NSString alloc] initWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
        
    }];
}
- (IBAction)sq:(id)sender {
    if (![self.passwordbool isEqualToString:@"yes"]) {
        [RHUtility showTextWithText:@"请先设置交易密码"];
        
        return;
    }
    
    if ([self.sqstring isEqualToString:@"yes"]) {
        RHYSQViewController * vc = [[RHYSQViewController alloc]initWithNibName:@"RHYSQViewController" bundle:nil];
        vc.money = self.sqmoney;
        vc.time = self.sqtime;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
    RHWSQViewController * vc = [[RHWSQViewController alloc]initWithNibName:@"RHWSQViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
    }
}
-(void)getsq{
    
    self.sqbtn.hidden = NO;
    self.sqlab.hidden = NO;
    self.sqimage.hidden = NO;
    self.sqnamelab.hidden = NO;
    [[RHNetworkService instance] POST:@"app/front/payment/appReformAccountJx/appUserPaymentAuthState" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        DLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            self.sqstring = responseObject[@"paymentState"];
            if ([self.sqstring isEqualToString:@"yes"]) {
                self.sqlab.text = @"已授权";
                self.sqtime = responseObject[@"deadline"];
                self.sqmoney = responseObject[@"payAuthAmt"];
            }else{
                 self.sqlab.text = @"请授权";
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //  NSLog(@"%@",error);
        DLog(@"%@",[[NSString alloc] initWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
        
    }];
    
}
@end
