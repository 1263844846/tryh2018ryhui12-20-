//
//  RHJsqViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 16/2/23.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import "RHJsqViewController.h"

@interface RHJsqViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *cbxjsqView;
@property (weak, nonatomic) IBOutlet UILabel *topyearlab;
@property (weak, nonatomic) IBOutlet UILabel *nianhualab;
@property (weak, nonatomic) IBOutlet UITextField *textfild;
@property (weak, nonatomic) IBOutlet UIImageView *aimage;
@property (weak, nonatomic) IBOutlet UILabel *shouyilab;
@property (weak, nonatomic) IBOutlet UILabel *nianhuanshouyi;
@property (weak, nonatomic) IBOutlet UIButton *jisuanbtn;

@end

@implementation RHJsqViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self configTitleWithString:@"收益计算器"];
    [self configBackButton];
    self.cbxjsqView.backgroundColor = [RHUtility colorForHex:@"#44bbc1"];
    self.nianhuanshouyi.text = self.mouthStr;
    self.topyearlab.text = self.nianStr;
    
    self.nianhualab.hidden = YES;
    [self creatimage];
    self.textfild.delegate = self;
   
    
    [self.shouyilab setTextColor:[RHUtility colorForHex:@"#44bbc1"]];
    
    self.jisuanbtn.backgroundColor = [RHUtility colorForHex:@"#44bbc1"];
    
}

-(void)textFieldDidChange :(UITextField *)theTextField{
    
    NSLog(@"121121121121c121121bx");
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
    
}
- (IBAction)jisuan:(id)sender {
    
    [self.textfild resignFirstResponder];
    if (self.textfild.text.length < 1) {
        [RHUtility showTextWithText:@"出借金额不能为空"];
        return;
    }
    if ([self.textfild.text doubleValue]>[self.monery doubleValue]*10000) {
        [RHUtility showTextWithText:@"出借金额大于项目总金额"];
        return;
    }
    int a = [self.textfild.text doubleValue];
    if (a%100 !=0) {
        [RHUtility showTextWithText:@"出借金额需为100的整数倍"];
        return;
    }
    
    NSDictionary* parameters=@{@"calMoney":self.textfild.text,@"projectId":self.projectid};
    
    [[RHNetworkService instance] POST:@"app/front/payment/appAccount/appProdictIncome" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"%@",responseObject);
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            self.shouyilab.text = [NSString stringWithFormat:@"%@",responseObject[@"interest"]];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    //计算收益
//    double money = [self.textfild.text floatValue];
//    
//    money = money *[ self.nianStr floatValue]*0.01;
//    
//    money = money /12;
//    money = money * [self.mouthStr floatValue];
//    
//    self.shouyilab.text = [NSString stringWithFormat:@"%.2f",money];
//    
    

//    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)creatimage{
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    UIImageView * image = [[UIImageView alloc]init];
    
    image.frame = CGRectMake(width/2, 3, 1, self.cbxjsqView.frame.size.height-6);
    image.image = [UIImage imageNamed:@"jsqsx"];
    //image.backgroundColor = [RHUtility colorForHex:@"#e4e6e6"];
    [self.cbxjsqView addSubview:image];
    
    
}

@end
