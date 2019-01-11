//
//  RHBngkCardDetailViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 16/4/18.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import "RHBngkCardDetailViewController.h"
#import "RHBANKTableViewCell.h"
#import "MBProgressHUD.h"
#import "RHBankwebviewViewController.h"
#import "RHHFphonenumberViewController.h"
#import <SobotKit/SobotKit.h>
#import <SobotKit/ZCUIChatController.h>
#import "RHMoreWebViewViewController.h"
#import "RHBKJXwebViewController.h"
#import "RHJXPassWordViewController.h"
#import "RHUnbundlingBankCardsViewController.h"

@interface RHBngkCardDetailViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    int secondsCountDown;
    NSTimer *countDownTimer;
}
// 没绑定快捷 但是绑定提现银行卡
@property (weak, nonatomic) IBOutlet UIView *threeView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *secondview;
@property (strong, nonatomic) IBOutlet UIView *firstview;
@property (weak, nonatomic) IBOutlet UILabel *chongzhikalab1;
@property (weak, nonatomic) IBOutlet UILabel *tixiankalab1;
@property (weak, nonatomic) IBOutlet UILabel *threelab;
@property (weak, nonatomic) IBOutlet UILabel *threelab2;
@property (weak, nonatomic) IBOutlet UILabel *threelab3;
@property (weak, nonatomic) IBOutlet UILabel *threelab4;
@property (weak, nonatomic) IBOutlet UILabel *banktishilab;
@property (weak, nonatomic) IBOutlet UILabel *banktishilab1;

//提现卡数组
@property(strong,nonatomic)NSMutableArray * cardArray;


//image
@property (weak, nonatomic) IBOutlet UIImageView *czimage;

@property (weak, nonatomic) IBOutlet UIImageView *tximage;

@property(nonatomic,copy)NSString * str;


//new
@property (weak, nonatomic) IBOutlet UILabel *lab1;
@property (weak, nonatomic) IBOutlet UILabel *lab2;
@property (weak, nonatomic) IBOutlet UILabel *lab3;
@property (weak, nonatomic) IBOutlet UILabel *lab4;
@property(nonatomic,assign)NSRange rang;
@property (weak, nonatomic) IBOutlet UIView *removealtert;

@property (weak, nonatomic) IBOutlet UIView *mengban;
@property (weak, nonatomic) IBOutlet UILabel *lab11;

@property (weak, nonatomic) IBOutlet UILabel *lab22;
@property (weak, nonatomic) IBOutlet UILabel *lab33;
@property (weak, nonatomic) IBOutlet UILabel *lab44;

//绑卡
@property (weak, nonatomic) IBOutlet UIImageView *bangkasucessimage;
@property (weak, nonatomic) IBOutlet UIImageView *jiebangimage;

@property (weak, nonatomic) IBOutlet UIView *bangkamengban;
@property (weak, nonatomic) IBOutlet UIView *bangkafailaltert;
@property (weak, nonatomic) IBOutlet UILabel *bankcardnumberlab;
@property (weak, nonatomic) IBOutlet UITextField *bankcardtf;
@property (weak, nonatomic) IBOutlet UITextField *yanzhengmatf;

@property (weak, nonatomic) IBOutlet UIImageView *banklogoimage;
@property (weak, nonatomic) IBOutlet UILabel *banknamestrlab;

@property (weak, nonatomic) IBOutlet UIButton *yanzhengmabtn;
@property (weak, nonatomic) IBOutlet UILabel *bangkashibailab;

@property(nonatomic,strong)NSDictionary * dic;

@property(nonatomic,copy)NSString * bankcardstring;
@property (weak, nonatomic) IBOutlet UILabel *phonenumbercard;


@property (weak, nonatomic) IBOutlet UIButton *huoqubtn;
@property (weak, nonatomic) IBOutlet UIImageView *jidunimgage;
@property (weak, nonatomic) IBOutlet UIImageView *jidunimgage1;
@property (weak, nonatomic) IBOutlet UILabel *jxcglab;
@property (weak, nonatomic) IBOutlet UILabel *jxcglab1;
@property (weak, nonatomic) IBOutlet UILabel *bankbacklab;
@property (weak, nonatomic) IBOutlet UIView *firstmengban;
@property (weak, nonatomic) IBOutlet UIView *passwordview;

@end

@implementation RHBngkCardDetailViewController
-(void)getmyjxpassword{
    
    [[RHNetworkService instance] POST:@"app/front/payment/appJxAccount/isSetPassword" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"----===============-1111---%@",responseObject);
        self.passwordress = [NSString stringWithFormat:@"%@",responseObject[@"setPwd"]];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
        DLog(@"%@",[[NSString alloc] initWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
        
    }];
    
}
- (IBAction)passwordgo:(id)sender {
    
    RHJXPassWordViewController * controller =[[RHJXPassWordViewController alloc]initWithNibName:@"RHJXPassWordViewController" bundle:nil];
    
    controller.urlstr = @"app/front/payment/appJxAccount/passwordSetJxData";
   
    self.passwordview.hidden = YES;
    self.firstmengban.hidden = YES;
    [self.navigationController pushViewController:controller animated:NO];
    
}

- (IBAction)hidenpassword:(id)sender {
    
    self.passwordview.hidden = YES;
    self.firstmengban.hidden = YES;
}

- (void)getupdata{
    
    NSString *str = [RHUserManager sharedInterface].telephone;
    
    NSString * laststr = [str substringFromIndex:str.length - 4];
    NSString * firststr = [str substringToIndex:3];
    self.phonenumbercard.text = [NSString stringWithFormat:@"%@****%@",firststr,laststr];
    //    self.phonelab.text = [RHUserManager sharedInterface].telephone;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    if([UIScreen mainScreen].bounds.size.width < 321){
//        self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, self.tableView.frame.size.width, 190);
//    }
    self.huoqubtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
 //   [self getcarddata];
   self.bangkasucessimage.hidden = YES;
     self.jiebangimage.hidden = YES;
    [self getupdata];
    [self configBackButton];
    [self configTitleWithString:@"我的银行卡"];
   
    [self getmyjxpassword];
    
    if ([UIScreen mainScreen].bounds.size.width<321) {
        self.lab1.font = [UIFont systemFontOfSize:13];
        self.lab2.font = [UIFont systemFontOfSize:13];
        self.lab3.font = [UIFont systemFontOfSize:13];
        self.lab4.font = [UIFont systemFontOfSize:13];
    }
    CGSize size = [self.lab1 sizeThatFits:CGSizeMake(self.lab1.frame.size.width, MAXFLOAT)];
    self.lab1.frame = CGRectMake(self.lab1.frame.origin.x, self.lab1.frame.origin.y, self.lab1.frame.size.width,      size.height);
    self.lab11.frame = CGRectMake(self.lab11.frame.origin.x, self.lab11.frame.origin.y, self.lab11.frame.size.width,      size.height);
    CGSize size1 = [self.lab2 sizeThatFits:CGSizeMake(self.lab2.frame.size.width, MAXFLOAT)];
    self.lab2.frame = CGRectMake(self.lab2.frame.origin.x, CGRectGetMaxY(self.lab1.frame)+5, self.lab2.frame.size.width,      size1.height);
    self.lab22.frame = CGRectMake(self.lab22.frame.origin.x, CGRectGetMaxY(self.lab11.frame)+5, self.lab22.frame.size.width,      size1.height);
    CGSize size2 = [self.lab3 sizeThatFits:CGSizeMake(self.lab3.frame.size.width, MAXFLOAT)];
    self.lab3.frame = CGRectMake(self.lab3.frame.origin.x, CGRectGetMaxY(self.lab2.frame)+5, self.lab3.frame.size.width,      size2.height);
    self.lab33.frame = CGRectMake(self.lab33.frame.origin.x, CGRectGetMaxY(self.lab22.frame)+5, self.lab33.frame.size.width,      size2.height);
    CGSize size3 = [self.lab4 sizeThatFits:CGSizeMake(self.lab4.frame.size.width, MAXFLOAT)];
    self.lab4.frame = CGRectMake(self.lab4.frame.origin.x, CGRectGetMaxY(self.lab3.frame)+5, self.lab4.frame.size.width,      size3.height);
    self.lab44.frame = CGRectMake(self.lab44.frame.origin.x, CGRectGetMaxY(self.lab33.frame)+5, self.lab44.frame.size.width,      size3.height);
    
//    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self.lab2.text];
//    [str addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(self.lab2.text.length-5,5)];
//    [str addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(self.lab22.text.length-5,5)];
//    
//  
//    
//    self.lab2.attributedText = str;
    
//
    
    /*
    NSDictionary *attributes = @{NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *netString = [[NSMutableAttributedString alloc] initWithString:self.lab2.text];
    NSMutableAttributedString *netString1 = [[NSMutableAttributedString alloc] initWithString:self.lab22.text];
    [netString addAttributes:attributes range:NSMakeRange(self.lab2.text.length-5,5)];
    [netString addAttribute:NSForegroundColorAttributeName value:[RHUtility colorForHex:@"#09AEB0"] range:NSMakeRange(self.lab2.text.length-5,5)];
    [netString1 addAttributes:attributes range:NSMakeRange(self.lab22.text.length-5,5)];
    [netString1 addAttribute:NSForegroundColorAttributeName value:[RHUtility colorForHex:@"#09AEB0"] range:NSMakeRange(self.lab22.text.length-5,5)];
    self.lab2.attributedText = netString;
    self.lab22.attributedText = netString;
     
     
     */
//    self.rang = NSMakeRange(self.lab2.text.length-5,5);
    
//    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didlab)];
    
    
//    [self.lab2 addGestureRecognizer:tap];
    NSMutableArray *actionStrs = [NSMutableArray array];
    
    self.secondview.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
     [self.view addSubview:self.secondview];
    self.firstview.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [self.view addSubview:self.firstview];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.mengban];
    [[UIApplication sharedApplication].keyWindow addSubview:self.removealtert];
   [[UIApplication sharedApplication].keyWindow addSubview:self.bangkamengban];
    [[UIApplication sharedApplication].keyWindow addSubview:self.bangkafailaltert];
     [[UIApplication sharedApplication].keyWindow addSubview:self.firstmengban];
     [[UIApplication sharedApplication].keyWindow addSubview:self.passwordview];
    self.mengban.hidden = YES;
    self.removealtert.hidden = YES;
    self.bangkamengban.hidden = YES;
    self.bangkafailaltert.hidden =YES;
     self.passwordview.hidden =YES;
     self.firstmengban.hidden =YES;
    
    self.secondview.hidden = YES;
    self.firstview.hidden = YES;
    
    [self getmyBankCard];
   //self.ress = @"notBank";
    if ([self.ress isEqualToString:@"notBank"]) {
        self.secondview.hidden = YES;
        self.firstview.hidden = NO;
        
    }else{
        
        self.firstview.hidden = YES;
        self.secondview.hidden = NO;
    }
    
    
    self.bankcardtf.delegate = self;
    
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
    
    self.jidunimgage.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width+5-self.jxcglab.frame.size.width)/2, self.jidunimgage.frame.origin.y, self.jidunimgage.frame.size.width, self.jidunimgage.frame.size.height);
    self.jxcglab.frame = CGRectMake(CGRectGetMaxX(self.jidunimgage.frame), self.jxcglab.frame.origin.y, self.jxcglab.frame.size.width, self.jxcglab.frame.size.height);
    self.jidunimgage1.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width+5-self.jxcglab1.frame.size.width)/2, self.jidunimgage1.frame.origin.y, self.jidunimgage1.frame.size.width, self.jidunimgage1.frame.size.height);
    self.jxcglab1.frame = CGRectMake(CGRectGetMaxX(self.jidunimgage1.frame), self.jxcglab1.frame.origin.y, self.jxcglab1.frame.size.width, self.jxcglab1.frame.size.height);
    
    if ([UIScreen mainScreen].bounds.size.width<321) {
        self.jxcglab.frame = CGRectMake(CGRectGetMaxX(self.jidunimgage.frame), self.jxcglab.frame.origin.y, self.jxcglab.frame.size.width, self.jxcglab.frame.size.height);
        self.jxcglab1.frame = CGRectMake(CGRectGetMaxX(self.jidunimgage1.frame), self.jxcglab1.frame.origin.y, self.jxcglab1.frame.size.width, self.jxcglab1.frame.size.height);
    }
    
    if ([UIScreen mainScreen].bounds.size.height>740) {
        self.jidunimgage.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width+5-self.jxcglab.frame.size.width)/2, self.jidunimgage.frame.origin.y-25, self.jidunimgage.frame.size.width, self.jidunimgage.frame.size.height);
        self.jxcglab.frame = CGRectMake(CGRectGetMaxX(self.jidunimgage.frame), self.jxcglab.frame.origin.y-25, self.jxcglab.frame.size.width, self.jxcglab.frame.size.height);
    }
    
    [self gettishistr];
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
   
    
    // 启动
    [ZCSobot startZCChatView:uiInfo with:self target:nil pageBlock:^(ZCUIChatController *object, ZCPageBlockType type) {
        // 点击返回
        if(type==ZCPageBlockGoBack){
            NSLog(@"点击了关闭按钮");
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [self.navigationController setNavigationBarHidden:NO];
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
-(void)getmyBankCard{
    
   // NSDictionary* parameters=@{@"idCard":self.nymbertf.text,@"name":self.nametf.text,@"mobile":[RHUserManager sharedInterface].telephone,@"cardNo":self.banknymtf.text,@"smsCode":self.yanzhengmatf.text};
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[RHNetworkService instance] POST:@"app/front/payment/appBankCardJx/isBindBankCard" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"----===============-1111---%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            if (![responseObject[@"bank"] isKindOfClass:[NSNull class]]&&responseObject[@"bank"]) {
               
                
                
                if (responseObject[@"bank"][@"bankNo"]&&![responseObject[@"bank"][@"bankNo"] isKindOfClass:[NSNull class]]) {
                    NSString *str = [NSString stringWithFormat:@"%@",responseObject[@"bank"][@"bankNo"]];
                    self.bankcardstring = [NSString stringWithFormat:@"%@",responseObject[@"bank"][@"bankNo"]];
                    
                    //NSString *str = [RHUserManager sharedInterface].telephone;
                    
                    NSString * laststr = [str substringFromIndex:str.length - 4];
                    NSString * firststr = [str substringToIndex:4];
                    self.bankcardnumberlab.text = [NSString stringWithFormat:@"%@ **** **** %@",firststr,laststr];
                }
                if (![responseObject[@"bank"][@"bankName"] isKindOfClass:[NSNull class]]&&responseObject[@"bank"][@"bankName"]) {
                    self.banknamestrlab.text =[NSString stringWithFormat:@"%@",responseObject[@"bank"][@"bankName"]];
                }
                if (![responseObject[@"bank"][@"bankLogo"] isKindOfClass:[NSNull class]]&&responseObject[@"bank"][@"bankLogo"]) {
                   
                     [self.banklogoimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@common/main/attachment/%@",[RHNetworkService instance].newdoMain,responseObject[@"bank"][@"bankLogo"]]]];
                }
            }
        }
          [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //        DLog(@"%@",error);
        DLog(@"%@",[[NSString alloc] initWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
          [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.view];
     [self.bankcardtf resignFirstResponder];
     [self.yanzhengmatf resignFirstResponder];
//    self.bankcardtf
    if (CGRectContainsPoint(self.lab2.frame, touchPoint)||CGRectContainsPoint(self.lab22.frame, touchPoint)) {
        if (self.rang.location != NSNotFound) {
           
        NSLog(@"11111");
            RHHFphonenumberViewController * vc = [[RHHFphonenumberViewController alloc]initWithNibName:@"RHHFphonenumberViewController" bundle:nil];
            NSLog(@"111");
            [self.navigationController pushViewController:vc animated:YES];
           
        }
    
       
    }
    
    
    
    
    
}
-(void)didlab{
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [DQViewController Sharedbxtabar].tarbar.hidden = YES;
}


- (void)getcarddata{
     [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[RHNetworkService instance] POST:@"app/front/payment/appAccount/appMyCashData" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            
            if (responseObject[@"qpCard"] == nil || [responseObject[@"qpCard"] isKindOfClass:[NSNull class]]) {
                ;
                if (responseObject[@"defaultCardId"]==nil || [responseObject[@"defaultCardId"] isKindOfClass:[NSNull class]]) {
                    self.secondview.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
                    [self.view addSubview:self.secondview];
                }else{
                    
                    self.cardArray = responseObject[@"cards"];
                    
                    [self.tableView reloadData];
                }
                
                NSLog(@"%@",responseObject);
                
            }else{
                
                self.firstview.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.threeView.frame.size.height);
                
                NSString *  str = responseObject[@"qpCard"][1];
                NSString * laststr = [str substringFromIndex:str.length - 4];
                NSString * firststr = [str substringToIndex:4];
                
                self.chongzhikalab1.text = [NSString stringWithFormat:@"  %@  ****  %@  ",firststr,laststr];
                
                
                str = responseObject[@"qpCard"][1];
                laststr = [str substringFromIndex:str.length - 4];
                firststr = [str substringToIndex:4];
                self.tixiankalab1.text = [NSString stringWithFormat:@"  %@  ****  %@  ",firststr,laststr];
                
               // NSString * str = [NSString stringWithFormat:@"%@assets/img/bankicon/%@",[RHNetworkService instance].newdoMain,responseObject[@"qpCard"][0]];
                [self.czimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@assets/img/bankicon/%@.jpg",[RHNetworkService instance].newdoMain,responseObject[@"qpCard"][0]]]];
                [self.tximage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@assets/img/bankicon/%@.jpg",[RHNetworkService instance].newdoMain,responseObject[@"qpCard"][0]]]];
                [self.view addSubview:self.firstview];
                
            }
        }
         [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSLog(@"%@---",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
        
        
    }];
    
}



- (NSMutableArray *)cardArray{
    
    if (!_cardArray) {
        _cardArray = [NSMutableArray array];
    }
    return _cardArray;
    
}
- (IBAction)bankcard:(id)sender {
    
  //  RHBankwebviewViewController * vc = [[RHBankwebviewViewController  alloc]initWithNibName:@"RHBankwebviewViewController" bundle:nil];
    
  //  [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)removebankcard:(UIButton *)sender{
    
    NSInteger pass = sender.tag-1314.0;
    NSLog(@"修改我的银行卡");
    
    UIAlertView* alertView=[[UIAlertView alloc]initWithTitle:nil
                                                     message:@"您确定要删除吗？"
                                                    delegate:self
                                           cancelButtonTitle:@"确定"
                                           otherButtonTitles:@"取消", nil];
    alertView.tag=9911;
    [alertView show];
    
    self.str = self.cardArray[pass][1];
    
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        if (alertView.tag==9911) {
            
            
            
            NSDictionary * parment = @{@"card":self.str};
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            [[RHNetworkService instance] POST:@"app/common/user/appUser/deleteCard" parameters:parment success:^(AFHTTPRequestOperation *operation, id responseObject) {
                //[MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                NSString *str = responseObject[@"RespDesc"];
                NSLog(@"%@",str);

                if ([str isEqualToString:@"默认取现卡不允许删除"]) {
                    UIAlertView* ertView=[[UIAlertView alloc]initWithTitle:nil
                                                                     message:@"默认取现卡不允许删除"
                                                                    delegate:self
                                                           cancelButtonTitle:@"关闭"
                                                           otherButtonTitles: nil];
                    [ertView show];
                }else{
                [RHUtility showTextWithText:str];
                }
                [self getcarddata];
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

//                [RHUtility showTextWithText:responseObject[@"RespDesc"]];


            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                ;
            }];
        }else{
            
        }
    }
}

-(void)setcolor:(UILabel *)lab{
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:lab.text];
    
    [str addAttribute:NSForegroundColorAttributeName value:[RHUtility colorForHex:@"#44bbc1"] range:NSMakeRange(lab.text.length-13,12)];
//    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-BoldItalicMT" size:30.0] range:NSMakeRange(0, 5)];
//    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:30.0] range:NSMakeRange(6, 12)];
//    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Courier-BoldOblique" size:30.0] range:NSMakeRange(19, 6)];
//    attrLabel.attributedText = str;
//    return str;
    
    lab.attributedText = str;
}
- (IBAction)removebankcardsure:(id)sender {
    
 //最新
    self.mengban.hidden = YES;
    self.removealtert.hidden = YES;
    RHUnbundlingBankCardsViewController * vc = [[RHUnbundlingBankCardsViewController alloc]initWithNibName:@"RHUnbundlingBankCardsViewController" bundle:nil];
    vc.cardnumstring = self.bankcardstring;
    
    [self.navigationController pushViewController:vc animated:YES];
    
    return;
    NSDictionary* parameters=@{@"cardNo":self.bankcardstring};
    
    [[RHNetworkService instance] POST:@"app/front/payment/appBankCardJx/bankCardUnBindJxData" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"----===============-1111---%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            //self.firstview.hidden = NO;
           // self.secondview.hidden = YES;
            self.mengban.hidden = YES;
            self.removealtert.hidden = YES;
           // [RHUtility showTextWithText:@"解绑成功"];
            self.jiebangimage.hidden = NO;
            NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(delayMethoddere) userInfo:nil repeats:NO];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //        DLog(@"%@",error);
        DLog(@"%@",[[NSString alloc] initWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
        
        self.dic=[NSJSONSerialization JSONObjectWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] options:NSJSONReadingMutableContainers error:nil];
        DLog(@"%@",[[NSString alloc] initWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
        if ([self.dic isKindOfClass:[NSDictionary class]]) {
            if (self.dic[@"msg"]&&![self.dic[@"msg"]isKindOfClass:[NSNull class]]) {
                
                self.mengban.hidden = YES;
                self.removealtert.hidden = YES;
                [RHUtility showTextWithText:self.dic[@"msg"]];
            }
        }
        
    }];
    
    
    
}
-(void)delayMethoddere{
    self.yanzhengmatf.text = @"";
    self.bankcardtf.text = @"";
    self.huoqubtn.enabled = YES;
    [self.huoqubtn setTitle:@"点击获取" forState:UIControlStateNormal];
    [countDownTimer invalidate];
    
    self.jiebangimage.hidden  = YES;
    
    self.firstview.hidden = NO;
    self.secondview.hidden = YES;
    
}
- (IBAction)hidenremovealtert:(id)sender {
    
    NSLog(@"取消删除");
    
    self.mengban.hidden = YES;
    self.removealtert.hidden = YES;
}


- (IBAction)hidebangkafailhiden:(id)sender {
    
    self.bangkafailaltert.hidden = YES;
    self.bangkamengban.hidden = YES;
}
- (IBAction)getphone:(id)sender {
    
    NSDictionary *parameters = @{@"mobile":[RHUserManager sharedInterface].telephone,@"srvAuthType":@"cardBindPlus"};
    NSLog(@"%@",[RHUserManager sharedInterface].telephone);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = [[RHNetworkService instance] customSecurityPolicy];
    manager.responseSerializer = [[AFCompoundResponseSerializer alloc]init];
    [manager POST:[NSString stringWithFormat:@"%@app/front/payment/appJxAccount/sendJxTelCaptcha",[RHNetworkService instance].newdoMain] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        DLog(@"result==%@ <<<",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        if ([responseObject isKindOfClass:[NSData class]]) {
            NSString *restult = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            if ([restult isEqualToString:@"{\"msg\":\"success\"}"]||[restult isEqualToString:@"success"]) {
                //短信发送成功
                [RHUtility showTextWithText:@"验证码已发送至您的手机"];
                [self reSendMessage];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //        DLog(@"%@",error);
    }];
    

}
- (void)reSendMessage {
    secondsCountDown = 60;
    [self.yanzhengmatf becomeFirstResponder];
    self.huoqubtn.enabled = NO;
    countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
}

- (void)timeFireMethod {
    secondsCountDown --;
    [self.huoqubtn setTitle:[NSString stringWithFormat:@"%dS后重新发送",secondsCountDown] forState:UIControlStateDisabled];
    if (secondsCountDown == 0) {
        self.huoqubtn.enabled = YES;
        [self.huoqubtn setTitle:@"点击获取" forState:UIControlStateNormal];
        [countDownTimer invalidate];
    }
}

- (IBAction)didbangding:(id)sender {
    ////////
    
    if (![self.passwordress isEqualToString:@"yes"]) {
        self.firstmengban.hidden = NO;
        self.passwordview.hidden = NO;
        return;
    }
    
    RHBKJXwebViewController * vc = [[RHBKJXwebViewController alloc]initWithNibName:@"RHBKJXwebViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (IBAction)jiebangyinhangka:(id)sender {
    
    self.mengban.hidden = NO;
    self.removealtert.hidden = NO;
}

-(void)delayMethod{
    
    self.bangkasucessimage.hidden  = YES;
    
    self.firstview.hidden = YES;
    self.secondview.hidden = NO;
    
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    if (self.bankcardtf == textField){
        //检测是否为纯数字
        if ([self isPureInt:string]) {
            //添加空格，每4位之后，4组之后不加空格，格式为xxxx xxxx xxxx xxxx xxxxxxxxxxxxxx
            if (textField.text.length % 5 == 4 && textField.text.length < 22) {
                textField.text = [NSString stringWithFormat:@"%@ ", textField.text];
            }
            //只要30位数字
            if ([toBeString length] >= 19+4+11)
            {
                toBeString = [toBeString substringToIndex:19+4+11];
                self.bankcardtf.text = toBeString;
                [self.bankcardtf resignFirstResponder];
                
                return NO;
            }
        }
        else if ([string isEqualToString:@""]) { // 删除字符
            if ((textField.text.length - 2) % 5 == 4 && textField.text.length < 22) {
                textField.text = [textField.text substringToIndex:textField.text.length - 1];
            }
            return YES;
        }
        else{
            return NO;
        }
        return YES;
    }
    return YES;
}

- (BOOL)isPureInt:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}
- (IBAction)xiane:(id)sender {
    
    RHMoreWebViewViewController * vc = [[RHMoreWebViewViewController alloc]initWithNibName:@"RHMoreWebViewViewController" bundle:nil];
    vc.namestr = @"支持银行";
    vc.urlstr = [NSString stringWithFormat:@"%@bindKJCard",[RHNetworkService instance].newdoMain];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)xianebtn:(id)sender {
    
    RHMoreWebViewViewController * vc = [[RHMoreWebViewViewController alloc]initWithNibName:@"RHMoreWebViewViewController" bundle:nil];
    vc.namestr = @"支持银行";
    vc.urlstr = [NSString stringWithFormat:@"%@bindKJCard",[RHNetworkService instance].newdoMain];
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)gettishistr{
    
    NSDictionary* parameters=@{@"type":@"mycard"};
    
    [[RHNetworkService instance] POST:@"app/front/payment/appJxAccount/getMsgByType" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        if (responseObject[@"msg"]&& ![responseObject[@"msg"] isKindOfClass:[NSNull class]]) {
            self.banktishilab.text = responseObject[@"msg"];
            CGSize sizetishi = [self.banktishilab sizeThatFits:CGSizeMake(self.banktishilab.frame.size.width, MAXFLOAT)];
            self.banktishilab.frame = CGRectMake(self.banktishilab.frame.origin.x, self.banktishilab.frame.origin.y, self.banktishilab.frame.size.width,      sizetishi.height);
            
            self.banktishilab1.text = responseObject[@"msg"];
            CGSize sizetishi1 = [self.banktishilab sizeThatFits:CGSizeMake(self.banktishilab.frame.size.width, MAXFLOAT)];
            self.banktishilab1.frame = CGRectMake(self.banktishilab1.frame.origin.x, self.banktishilab1.frame.origin.y, self.banktishilab1.frame.size.width,      sizetishi1.height);
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
        DLog(@"%@",[[NSString alloc] initWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
        
        
        
    }];
}

@end
