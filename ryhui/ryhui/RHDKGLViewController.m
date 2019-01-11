//
//  RHDKGLViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 2018/5/15.
//  Copyright © 2018年 stefan. All rights reserved.
//

#import "RHDKGLViewController.h"

@interface RHDKGLViewController ()
@property (weak, nonatomic) IBOutlet UILabel *zjyylab;
@property (weak, nonatomic) IBOutlet UILabel *jyqklab;
@property (weak, nonatomic) IBOutlet UILabel *hknllab;
@property (weak, nonatomic) IBOutlet UILabel *yqqklab;
@property (weak, nonatomic) IBOutlet UILabel *ssqklab;
@property (weak, nonatomic) IBOutlet UILabel *cfqklab;
@property (weak, nonatomic) IBOutlet UILabel *zdxxlab;

@end

@implementation RHDKGLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setmydata];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setmydata{
    
    
     NSDictionary* parameters=@{@"projectId":self.projectid};
    
    [[RHNetworkService instance] POST:@"common/main/getLoanAfterData" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            if (responseObject[@"publishData"]&& ![responseObject[@"publishData"] isKindOfClass:[NSNull class]] ) {
                if ([responseObject[@"publishData"] isEqualToString:@"yes"]) {
                    
                    if (responseObject[@"fundOperation"]&& ![responseObject[@"fundOperation"] isKindOfClass:[NSNull class]] ) {
                        
                        self.zjyylab.text = [NSString stringWithFormat:@"%@",responseObject[@"fundOperation"]];
                    }
                    
                    if (responseObject[@"financialCondition"]&& ![responseObject[@"financialCondition"] isKindOfClass:[NSNull class]] ) {
                        
                        self.jyqklab.text = [NSString stringWithFormat:@"%@",responseObject[@"financialCondition"]];
                    }
                    if (responseObject[@"repayChange"]&& ![responseObject[@"repayChange"] isKindOfClass:[NSNull class]] ) {
                        
                        self.hknllab.text = [NSString stringWithFormat:@"%@",responseObject[@"repayChange"]];
                    }
                    if (responseObject[@"abnormalCondition"]&& ![responseObject[@"abnormalCondition"] isKindOfClass:[NSNull class]] ) {
                        
                        self.yqqklab.text = [NSString stringWithFormat:@"%@",responseObject[@"abnormalCondition"]];
                        self.yqqklab.textAlignment = NSTextAlignmentRight;
                    }
                    
                    
                    if (responseObject[@"lawCondition"]&& ![responseObject[@"lawCondition"] isKindOfClass:[NSNull class]] ) {
                        
                        self.ssqklab.text = [NSString stringWithFormat:@"%@",responseObject[@"lawCondition"]];
                    }
                    
                    
                    if (responseObject[@"penaltyCondition"]&& ![responseObject[@"penaltyCondition"] isKindOfClass:[NSNull class]] ) {
                        
                        self.cfqklab.text = [NSString stringWithFormat:@"%@",responseObject[@"penaltyCondition"]];
                    }
                    
                    if (responseObject[@"affectInformation"]&& ![responseObject[@"affectInformation"] isKindOfClass:[NSNull class]] ) {
                        
                        self.zdxxlab.text = [NSString stringWithFormat:@"%@",responseObject[@"affectInformation"]];
                    }
                }
            }
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       
        
    }];
    
}


@end
