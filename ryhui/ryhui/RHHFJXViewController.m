//
//  RHHFJXViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 17/10/11.
//  Copyright © 2017年 stefan. All rights reserved.
//

#import "RHHFJXViewController.h"
#import "MBProgressHUD.h"
#import "RHhelper.h"
#import "RHTXTableViewCell.h"
#import "RHBankwebviewViewController.h"
#import "RHJXWebViewController.h"

#import "RHJXHFTXViewController.h"
#import <SobotKit/SobotKit.h>
#import <SobotKit/ZCUIChatController.h>
#import "RHHFJXScuessViewController.h"
@interface RHHFJXViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    int secondsCountDown;
    NSTimer *countDownTimer;
    int a ;
}
@property (weak, nonatomic) IBOutlet UIButton *xuanzeyinhangkabtn;
@property (weak, nonatomic) IBOutlet UILabel *bangkjlab;
@property (weak, nonatomic) IBOutlet UILabel *miaoshulab;
@property (weak, nonatomic) IBOutlet UIView *zongview;
@property (weak, nonatomic) IBOutlet UIButton *bangkabtn;
@property (weak, nonatomic) IBOutlet UIButton *hfbangkabtn;
@property (weak, nonatomic) IBOutlet UIImageView *bangkaimage;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UITextField *yazhengmatf;
@property (weak, nonatomic) IBOutlet UIButton *hqyzhengmabtn;
@property (weak, nonatomic) IBOutlet UILabel *banknamelab;
@property (weak, nonatomic) IBOutlet UILabel *banknumberlab;
@property (weak, nonatomic) IBOutlet UILabel *testlab;
@property (weak, nonatomic) IBOutlet UILabel *testlab1;
@property (weak, nonatomic) IBOutlet UILabel *myyue1;

@property (weak, nonatomic) IBOutlet UILabel *myyuelab;
@property (weak, nonatomic) IBOutlet UIView *zhuanview;

@property (weak, nonatomic) IBOutlet UIButton *tixianbtn;

@property(nonatomic,strong)NSMutableArray * array;
@property (weak, nonatomic) IBOutlet UILabel *phonelab;


@property(nonatomic,assign)NSInteger indax;

@property(nonatomic,copy)NSString *txbankcardstr;

@end

@implementation RHHFJXViewController
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    
}
-(void)viewWillAppear:(BOOL)animated{
   self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    [super viewWillAppear:animated];
    [self.array removeAllObjects];
    [self getbankcard];
}
-(BOOL)prefersStatusBarHidden

{
    if (a==0) {
        return NO;
    }
    
    return YES;// 返回YES表示隐藏，返回NO表示显示
    
}
-(NSMutableArray *)array{
    
    if (!_array) {
        _array = [NSMutableArray array];
    }
    return _array;
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
    NSLog(@"nicaicai");
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    a = 0;
    // Do any additional setup after loading the view from its nib.
   // [self prefersStatusBarHidden];
    [self configTitleWithString:@"汇付余额转出"];
   // [self getbankcard];
    self.tableview.hidden = YES;
    self.hfbangkabtn.hidden = YES;
    self.bangkaimage.hidden = YES;
    UIButton* button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(back1) forControlEvents:UIControlEventTouchUpInside];
    //    UIImage * image = [UIImage imageNamed:@"back.png"];
    
    [button setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    button.frame=CGRectMake(0, 0, 11, 17);
    NSString *str = [RHUserManager sharedInterface].telephone;
    
    NSString * laststr = [str substringFromIndex:str.length - 4];
    NSString * firststr = [str substringToIndex:3];
    // self.phonenumberlab.text = [NSString stringWithFormat:@"%@******%@",firststr,laststr];
    //    self.phonelab.text = [RHUserManager sharedInterface].telephone;
    self.phonelab.text = [NSString stringWithFormat:@"%@****%@",firststr,laststr];
  
    self.navigationItem.leftBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:button];
    
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:@"###,##0.00;"];
     NSString *formattedNumberString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble: [[RHhelper ShraeHelp].moneystr doubleValue] ]];
    self.myyuelab.text = [NSString stringWithFormat:@"%@",formattedNumberString];
    self.myyue1.text = [NSString stringWithFormat:@"%@",formattedNumberString];
    
    
    self.yazhengmatf.delegate = self;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    
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
- (void)textFieldDidBeginEditing:(UITextField *)textField;{
    
    a = 1;
    [self prefersStatusBarHidden];
    
    if ([UIScreen mainScreen].bounds.size.width < 380) {
        self.zhuanview.frame = CGRectMake(0, -200, [UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.height);
    }else{
        
        self.zhuanview.frame = CGRectMake(0, -30, [UIScreen mainScreen].bounds.size.width ,self.zhuanview.frame.size.height);
    }
    self.navigationController.navigationBar.subviews.firstObject.alpha = 1;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    a = 0;
     [self prefersStatusBarHidden];
    [self.yazhengmatf resignFirstResponder];
    self.zhuanview.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width ,self.zhuanview.frame.size.height);
    
}
-(void)back1{
    
   // [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getbankcard{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[RHNetworkService instance] POST:@"app/front/payment/appAccount/appMyCards" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            
            NSLog(@"%@",responseObject);
            
            if (responseObject[@"cards"][0][2] &&![responseObject[@"cards"][0][2]  isKindOfClass:[NSNull class]]) {
                
            
            if ([responseObject[@"cards"][0][2] isEqualToString:@"QP"]) {
                //快捷
                self.tableview.hidden = YES;
                self.hfbangkabtn.hidden = YES;
                self.bangkaimage.hidden = YES;
                
                self.bangkabtn.hidden = YES;
                self.xuanzeyinhangkabtn.hidden = YES;
                NSArray * array = responseObject[@"cards"][0];
                if (array.count>3){
                    self.banknamelab.text = [NSString stringWithFormat:@"%@",responseObject[@"cards"][0][3]];
                    }
                
                
            }else{
                //不是快捷
                
                NSArray * array = [NSArray arrayWithArray:responseObject[@"cards"]];
                
                for (NSArray * arr in array) {
                    
                
                
                NSString * bankname = @"";
                //                    NSLog(@"%@",arr[2]);
                if (arr.count>3) {
                    if (![arr[3] isKindOfClass:[NSNull class]]) {
                        bankname = arr[3];
                    }
                }
                
                
                NSString * str ;
                
                if (![arr[1] isKindOfClass:[NSNull class]]) {
                    str = arr[1];
                }else{
                    str= @"";
                }
                
                
                
                NSDictionary * dic = @{@"yh":bankname,
                                       @"kh":str};
                
                [self.array addObject:dic];
                
                }
                self.tableview.hidden = YES;
                self.hfbangkabtn.hidden = YES;
                self.bangkaimage.hidden = YES;
                
                self.bangkjlab.hidden = YES;
                 self.banknamelab.text = [NSString stringWithFormat:@"%@",responseObject[@"cards"][0][3]];
            }
            }
            NSString *str = [NSString stringWithFormat:@"%@",responseObject[@"cards"][0][1]];
            //NSString *str = [RHUserManager sharedInterface].telephone;
            self.txbankcardstr = str;
            NSString * laststr = [str substringFromIndex:str.length - 4];
            NSString * firststr = [str substringToIndex:4];
            self.banknumberlab.text = [NSString stringWithFormat:@"%@ **** %@",firststr,laststr];
            
            
//
            self.bangkabtn.hidden = NO;
            self.xuanzeyinhangkabtn.hidden = NO;
            self.hqyzhengmabtn.hidden = NO;
            self.yazhengmatf.hidden = NO;
            self.tixianbtn.hidden = NO;
            self.testlab.hidden = NO;
            self.phonelab.hidden = NO;
            self.testlab1.hidden = NO;
           
            //self.bankcardstr = [NSString stringWithFormat:@"%@",dic[@"bankNo"]];
        }else{
            
            self.tableview.hidden = YES;
            self.hfbangkabtn.hidden = NO;
            self.bangkaimage.hidden = NO;
            self.tixianbtn.hidden = YES;
            self.bangkabtn.hidden = YES;
            self.xuanzeyinhangkabtn.hidden = YES;
            self.bangkjlab.hidden = YES;
            
            self.hqyzhengmabtn.hidden = YES;
            self.yazhengmatf.hidden = YES;
            self.testlab.hidden = YES;
            self.phonelab.hidden = YES;
            self.testlab1.hidden = YES;
            //没绑卡
        }
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSLog(@"%@---",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
        
        
    }];

}

- (IBAction)bangka:(id)sender {
    RHJXWebViewController * vc = [[RHJXWebViewController alloc]initWithNibName:@"RHJXWebViewController" bundle:nil];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)hfbangka:(id)sender {
    RHJXWebViewController * vc = [[RHJXWebViewController alloc]initWithNibName:@"RHJXWebViewController" bundle:nil];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (IBAction)huoquyanzhengma:(id)sender {
    NSDictionary *parameters = @{@"telephone":[RHUserManager sharedInterface].telephone,@"type":@"SMS_CAPTCHA_CASH"};
    NSLog(@"%@",[RHUserManager sharedInterface].telephone);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = [[RHNetworkService instance] customSecurityPolicy];
    manager.responseSerializer = [[AFCompoundResponseSerializer alloc]init];
    [manager POST:[NSString stringWithFormat:@"%@app/common/user/appGeneral/appSendTelCaptcha",[RHNetworkService instance].newdoMain] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        DLog(@"result==%@ <<<",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        if ([responseObject isKindOfClass:[NSData class]]) {
            NSString *restult = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            if ([restult isEqualToString:@"{\"msg\":\"success\"}"]||[restult isEqualToString:@"success"]) {
                //短信发送成功
                
                [RHUtility showTextWithText:@"验证码已发送至您的手机"];
                [self reSendMessage];
//                self.mengban.hidden = NO;
//                self.alterview.hidden = NO;
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //        DLog(@"%@",error);
    }];

    
}
- (void)reSendMessage {
    secondsCountDown = 60;
    [self.yazhengmatf becomeFirstResponder];
    self.hqyzhengmabtn.enabled = NO;
    countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
}

- (void)timeFireMethod {
    secondsCountDown --;
    [self.hqyzhengmabtn setTitle:[NSString stringWithFormat:@"%dS后重新发送",secondsCountDown] forState:UIControlStateDisabled];
    if (secondsCountDown == 0) {
        self.hqyzhengmabtn.enabled = YES;
        [self.hqyzhengmabtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [countDownTimer invalidate];
    }
}
- (IBAction)tixian:(id)sender {
    
//    RHHFJXScuessViewController * vc = [[RHHFJXScuessViewController alloc]initWithNibName:@"RHHFJXScuessViewController" bundle:nil];
//    vc.str = @"1";
//    [self.navigationController pushViewController:vc animated:YES];
//    
//    return;
    
    
    NSDictionary* parameters=@{@"captcha":self.yazhengmatf.text};
    [[RHNetworkService instance] POST:@"app/front/payment/appAccount/verifyTelCaptcha" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        RHJXHFTXViewController * vc = [[RHJXHFTXViewController alloc]initWithNibName:@"RHJXHFTXViewController" bundle:nil];
        
        vc.bankcard = self.txbankcardstr;
        vc.yzmstr = self.yazhengmatf.text;
        [self.navigationController pushViewController:vc animated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
        DLog(@"%@",[[NSString alloc] initWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
        
//        self.mengban.hidden = NO;
      //  [RHUtility showTextWithText:@"验证码错误"];
        if ([error.userInfo.allKeys containsObject:@"com.alamofire.serialization.response.error.data"]) {
            NSDictionary* errorDic=[NSJSONSerialization JSONObjectWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] options:NSJSONReadingMutableContainers error:nil];
            if ([errorDic objectForKey:@"msg"]) {
                
                //self.shibailab.text = errorDic[@"msg"];
                [RHUtility showTextWithText:errorDic[@"msg"]];
            }
        }
        
        // self.shibaiview.hidden = NO;
    }];
    

    
    
    
    
}
- (IBAction)xuanzeyinhangka:(id)sender {
    
    self.tableview.hidden = NO;
    [self.tableview reloadData];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return self.array.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * string = @"RHxuanzebankcard";
    
    RHTXTableViewCell * cell =(RHTXTableViewCell*) [tableView dequeueReusableCellWithIdentifier:string];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"RHTXTableViewCell" owner:nil options:nil] objectAtIndex:0];
    }
    
    [cell updateCell:self.array[indexPath.row]];
    cell.myblock = ^{
        [self tableView:tableView didSelectRowAtIndexPath:indexPath];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    self.tableview.hidden = YES;
    
    self.indax = indexPath.row;
    [self getbankcardname];
    
}

-(void)getbankcardname{
    
    NSDictionary * dic = self.array[self.indax];
    self.banknamelab.text = dic[@"yh"];
    NSString *  str = dic[@"kh"];
    
    self.txbankcardstr = str;
    NSString * laststr = [str substringFromIndex:str.length - 4];
    NSString * firststr = [str substringToIndex:4];
    
    self.banknumberlab.text = [NSString stringWithFormat:@"  %@  ****  %@  ",firststr,laststr];
    //self.banknumberlab.text = dic[@"kh"];
}
@end
