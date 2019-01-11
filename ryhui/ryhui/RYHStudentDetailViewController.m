//
//  RYHStudentDetailViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 16/10/26.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import "RYHStudentDetailViewController.h"

@interface RYHStudentDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *school;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *sex;
@property (weak, nonatomic) IBOutlet UILabel *age;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *minzu;
@property (weak, nonatomic) IBOutlet UILabel *xueli;

@property (weak, nonatomic) IBOutlet UILabel *zhuanye;
@end

@implementation RYHStudentDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self getpoststu];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)getpoststu{
    
    NSDictionary* parameters=@{@"id":self.projectid};
    
    
    [[RHNetworkService instance] POST:@"app/common/appDetails/appProjectDetailData" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        DLog(@"%@",responseObject);
        // [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            
            [self setupdata:responseObject[@"project"]];
//            [self setupdata:responseObject];
            // [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [RHUtility showTextWithText:@"请求失败"];
    }];
}


- (void)setupdata:(NSDictionary *)dic{
    if (dic[@"studentName"]) {
        self.name.text =[NSString stringWithFormat:@"%@",dic[@"studentName"]];
    }
    if (dic[@"studentGender"]) {
        self.sex.text =[NSString stringWithFormat:@"%@",dic[@"studentGender"]];
    }
    if (dic[@"studentAge"]) {
        self.age.text =[NSString stringWithFormat:@"%@",dic[@"studentAge"]];
    }
    
    if (dic[@"studentCity"]) {
        self.address.text =[NSString stringWithFormat:@"%@",dic[@"studentCity"]];
    }
    if (dic[@"studentNation"]) {
        self.minzu.text =[NSString stringWithFormat:@"%@",dic[@"studentNation"]];
    }
    if (dic[@"studentSchool"]) {
        self.school.text =[NSString stringWithFormat:@"%@",dic[@"studentSchool"]];
    }
    if (dic[@"studentEducation"]) {
        self.xueli.text =[NSString stringWithFormat:@"%@",dic[@"studentEducation"]];
    }
    if (dic[@"studentProfession"]) {
        self.zhuanye.text =[NSString stringWithFormat:@"%@",dic[@"studentProfession"]];
    }
    
}

@end
