//
//  RHHFphonenumberViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 16/3/2.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import "RHHFphonenumberViewController.h"
#import "RHHFPhonexiugaiViewController.h"
#import "RHPFnumberwebViewController.h"
@interface RHHFphonenumberViewController (){
    
    int secondsCountDown;
    NSTimer* countDownTimer;
}
@property (weak, nonatomic) IBOutlet UIButton *nextbtn;
@property (weak, nonatomic) IBOutlet UIButton *yanzhengmabutton;
@property (weak, nonatomic) IBOutlet UIImageView *aimage;
@property (weak, nonatomic) IBOutlet UILabel *phonelab;
@property (weak, nonatomic) IBOutlet UITextField *imagecatchfild;
@property (weak, nonatomic) IBOutlet UITextField *phonecatchfild;
@property (weak, nonatomic) IBOutlet UILabel *mytestlab;
@property (weak, nonatomic) IBOutlet UIWebView *webview;

@property(nonatomic,copy)NSString *phoneSwitch;

@end

@implementation RHHFphonenumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    [self.nextbtn.layer setMasksToBounds:YES];
    [self.nextbtn.layer setCornerRadius:2.0];
    
    [self configBackButton];
    [self configTitleWithString:@"修改手机号"];
   
    
    self.webview.hidden = YES;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"shoujihao.html" ofType:nil];
    NSURL* url = [NSURL  fileURLWithPath:path];//创建URL
    
    
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
//    [self.webview loadRequest:request];//加载
    
    
    
//    NSString *mainBundlePath = [[NSBundle mainBundle] bundlePath];//文件根路径
//    NSString *basePath = [NSString stringWithFormat:@"%@/html",mainBundlePath];//获取目标html文件夹路径
//    NSURL *baseUrl = [NSURL fileURLWithPath:basePath isDirectory:YES];//转换成url
//    NSString *htmlPath = [NSString stringWithFormat:@"%@/start.html",basePath];//目标 文件路径
    NSString *htmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];//把html文件转换成string类型
    [self.webview loadHTMLString:htmlString baseURL:url];//加载
    
 
    
    
    [self getphoneswitch];
}


    
    
- (void)getupdata{
    
    NSString *str = [RHUserManager sharedInterface].telephone;
    
    NSString * laststr = [str substringFromIndex:str.length - 4];
    NSString * firststr = [str substringToIndex:3];
    self.phonelab.text = [NSString stringWithFormat:@"%@******%@",firststr,laststr];
//    self.phonelab.text = [RHUserManager sharedInterface].telephone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)getphoneswitch
{
    
    [[RHNetworkService instance] POST:@"app/common/appMain/updateTelephoneSwitch" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        DLog(@"%@",responseObject);
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            if ([responseObject[@"phoneSwitch"] isEqualToString:@"ON"]) {
                
                self.webview.hidden = YES;
                
            }else{
                
                self.webview.hidden = NO;
            }
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                DLog(@"%@",error);
        
       
    }];
    
}


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
     [self getupdata];
    
}

- (IBAction)next:(id)sender {
    
    
    RHPFnumberwebViewController *vc = [[RHPFnumberwebViewController alloc]initWithNibName:@"RHPFnumberwebViewController" bundle:nil];
    
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed = NO;
    
}
-(void)setcolor:(UILabel *)lab{
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:lab.text];
    
    [str addAttribute:NSForegroundColorAttributeName value:[RHUtility colorForHex:@"#44bbc1"] range:NSMakeRange(lab.text.length-13-11,12)];
   
    
    lab.attributedText = str;
}

@end
