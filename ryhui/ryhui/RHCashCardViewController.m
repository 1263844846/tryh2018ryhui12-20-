//
//  RHCashCardViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 15/11/20.
//  Copyright © 2015年 stefan. All rights reserved.
//

#import "RHCashCardViewController.h"
#import "RHMyGiftViewController.h"
#import "RHmainModel.h"
@interface RHCashCardViewController ()<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *cacahimage;
@property (weak, nonatomic) IBOutlet UITextField *CashCardtext;
@property (weak, nonatomic) IBOutlet UITextField *imagetext;
@property (weak, nonatomic) IBOutlet UIButton *mybutton;

@end

@implementation RHCashCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.navigationItem.titleView = 
    [self configBackButton];
    [self configTitleWithString:@"红包兑换卡"];
    
    [self.mybutton.layer  setMasksToBounds:YES];
    [self.mybutton.layer setCornerRadius:4.0];

    
    
   // self.view.backgroundColor = [UIColor grayColor];
    //self.view.backgroundColor = [UIColor colorWithRed:227/250 green:227/250 blue:227/250 alpha:1];
    
    
//    NSData * data = @"7b226d73 67223a22 e8afa5e5 8da1e5b7 b2e794b3 e8afb7e5 8591e68d a2efbc8c e6ada3e5 9ca8e5ae a1e6a0b8 efbc8ce8 afb7e58b bfe9878d e5a48de5 8591e68d a2227d";
//    
//    NSString * st = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//    NSLog(@"%@",st);
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeCaptcha)];
    
    self.cacahimage.userInteractionEnabled = YES;
    [self.cacahimage addGestureRecognizer:tap];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)duihuan:(id)sender {
    
   
    
    if (_CashCardtext.text.length < 1) {
        //[RHUtility showTextWithText:@"兑换码不能为空"];
        [RHMobHua showTextWithText:@"兑换码不能为空"];
        return;
    }
    if (_imagetext.text.length < 1) {
        [RHMobHua showTextWithText:@"验证码不能为空"];
        return;
    }
    
    NSDictionary *parameters = @{@"cardPasswd":self.CashCardtext.text,@"captcha":self.imagetext.text};
    
    
   

    
    

    [[RHNetworkService instance] POST:@"app/front/payment/appGift/appConvert" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
              DLog(@"%@",responseObject);

        if ([responseObject[@"type"]isEqualToString:@"convert"]) {
            UIAlertView * alter = [[UIAlertView alloc]initWithTitle:responseObject[@"msg"] message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            alter.delegate = self;
            
            [alter show];
            //[RHMobHua showTextWithText:responseObject[@"msg"]];
        }else{
            UIAlertView * alter = [[UIAlertView alloc]initWithTitle:responseObject[@"msg"] message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            alter.delegate = self;
            [alter show];
            //[RHMobHua showTextWithText:responseObject[@"msg"]];
        }
        
//        NSArray * array = self.navigationController.viewControllers;
//        for (UIViewController * contr in array) {
//            if ([contr isKindOfClass:[RHMyGiftViewController class] ]) {
//                 [self.navigationController popToViewController:contr animated:YES];
//            }
//        }
        
       
        
       // [RHUtility showTextWithText:@"兑换成功"];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //        DLog(@"%@",error);
        if ([error.userInfo.allKeys containsObject:@"com.alamofire.serialization.response.error.data"]) {
            NSDictionary* errorDic=[NSJSONSerialization JSONObjectWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] options:NSJSONReadingMutableContainers error:nil];
            if ([errorDic objectForKey:@"msg"]) {
                if ([[errorDic objectForKey:@"msg"] isEqualToString:@"验证码错误"]) {
         
                    [self changeCaptcha];
                }
                [RHMobHua showTextWithText:[errorDic objectForKey:@"msg"]];
            }
        }
    }];


    


}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    NSArray * array = self.navigationController.viewControllers;
    for (UIViewController * contr in array) {
        if ([contr isKindOfClass:[RHMyGiftViewController class] ]) {
            [RHmainModel ShareRHmainModel].hongbao = @"fresh";
            [self.navigationController popToViewController:contr animated:YES];
        }
    }
    
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    
    [self changeCaptcha];
    
}

-(void)changeCaptcha
{
    
    // NSString * str  = [[NSString stringWithFormat:@"%@%@",[RHNetworkService instance].doMain,@"common/user/general/captcha?type=CAPTCHA_FINANCIAL"]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager* manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[[AFImageResponseSerializer alloc]init];
    manager.securityPolicy = [[RHNetworkService instance] customSecurityPolicy];
    //NSString * str = [NSString stringWithFormat:@"%@%@",[RHNetworkService instance].doMain,@"common/user/general/captcha?type=CAPTCHA_FINANCIAL"] ;
    [manager POST:[NSString stringWithFormat:@"%@%@",[RHNetworkService instance].newdoMain,@"app/common/user/appGeneral/captcha?type=CAPTCHA_FINANCIAL"] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingMutableContainers)  error:nil];
        
        if ([responseObject isKindOfClass:[UIImage class]]) {
            self.cacahimage.image=responseObject;
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
