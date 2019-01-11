//
//  RHXFDZRViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 17/7/12.
//  Copyright © 2017年 stefan. All rights reserved.
//

#import "RHXFDZRViewController.h"

@interface RHXFDZRViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *yongtu;
@property (weak, nonatomic) IBOutlet UILabel *yongtustr;

@property (weak, nonatomic) IBOutlet UILabel *benxi;
@property (weak, nonatomic) IBOutlet UILabel *benxistr;
@property (weak, nonatomic) IBOutlet UILabel *shuoming;

@property (weak, nonatomic) IBOutlet UILabel *shuominglab;

@end

@implementation RHXFDZRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sess = YES;
    // Do any additional setup after loading the view from its nib.
    NSDictionary* parameters=@{@"id":self.projectid};
    
    
    [[RHNetworkService instance] POST:@"app/common/appDetails/appProjectDetailData" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        DLog(@"%@",responseObject);
        // [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            
            
            [self setupdata:responseObject];
            // [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [RHUtility showTextWithText:@"请求失败"];
    }];// Do any additional setup after loading the view from its nib.
    
    self.scrollview.delegate  = self;
}
-(void)setupdata:(NSDictionary * )dic{
    if (!dic[@"project"][@"fundPurpose"]|| ![dic[@"project"][@"fundPurpose"] isKindOfClass:[NSNull class]]) {
        self.yongtustr.text = dic[@"project"][@"fundPurpose"];
    }
    if (!dic[@"project"][@"riskSuggestion"]|| ![dic[@"project"][@"riskSuggestion"] isKindOfClass:[NSNull class]]) {
        self.benxistr.text = dic[@"project"][@"riskSuggestion"];
    }
    
    if (!dic[@"project"][@"loanInfo"]|| ![dic[@"project"][@"loanInfo"] isKindOfClass:[NSNull class]]) {
        self.shuominglab.text = dic[@"project"][@"loanInfo"];
    }
    CGSize size = [self.yongtustr sizeThatFits:CGSizeMake(self.yongtustr.frame.size.width, MAXFLOAT)];
    self.yongtustr.frame = CGRectMake(self.yongtu.frame.origin.x, CGRectGetMaxY(self.yongtu.frame)+5, self.yongtustr.frame.size.width,      size.height);
    
    self.benxi.frame = CGRectMake(self.benxi.frame.origin.x, CGRectGetMaxY(self.yongtustr.frame)+10, self.benxi.frame.size.width, self.benxi.frame.size.height);
    CGSize size1 = [self.benxistr sizeThatFits:CGSizeMake(self.benxistr.frame.size.width, MAXFLOAT)];
    self.benxistr.frame = CGRectMake(self.yongtu.frame.origin.x, CGRectGetMaxY(self.benxi.frame)+5, self.benxistr.frame.size.width,      size1.height);
    
//    self.benxi.frame = CGRectMake(self.benxi.frame.origin.x, CGRectGetMaxY(self.yongtustr.frame)+10, self.benxi.frame.size.width, self.benxi.frame.size.height);
    
    self.shuoming.frame = CGRectMake(self.benxistr.frame.origin.x, CGRectGetMaxY(self.benxistr.frame)+10, self.shuoming.frame.size.width, self.shuoming.frame.size.height);
    CGSize size2 = [self.shuominglab sizeThatFits:CGSizeMake(self.shuominglab.frame.size.width, MAXFLOAT)];
    self.shuominglab.frame = CGRectMake(self.yongtu.frame.origin.x, CGRectGetMaxY(self.shuoming.frame)+5, self.shuominglab.frame.size.width,      size2.height);
    self.scrollview.contentSize=CGSizeMake([UIScreen mainScreen].bounds.size.width,CGRectGetMaxY(self.shuominglab.frame)+90);
   
    NSLog(@"%f",[UIScreen mainScreen].bounds.size.height);
    self.scrollview.bounces = NO;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
        if (scrollView.contentOffset.y <1) {
            NSLog(@"---");
            self.scroolblock();
        }
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
