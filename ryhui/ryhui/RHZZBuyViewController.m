//
//  RHZZBuyViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 16/4/1.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import "RHZZBuyViewController.h"
#import "AppDelegate.h"
#import "RYHViewController.h"

@interface RHZZBuyViewController ()
@property (weak, nonatomic) IBOutlet UIButton *tesbutton;
@property (weak, nonatomic) IBOutlet UITextField *moneyfild;
@property (weak, nonatomic) IBOutlet UILabel *testlab;
@property (weak, nonatomic) IBOutlet UILabel *rengoulab;
@property (weak, nonatomic) IBOutlet UILabel *yuelab;
@property (weak, nonatomic) IBOutlet UILabel *shifujinelab;

@end

@implementation RHZZBuyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if ([UIScreen mainScreen].bounds.size.height < 570) {
        self.tesbutton.frame = CGRectMake(10, [UIScreen mainScreen].bounds.size.height-69+15, [UIScreen mainScreen].bounds.size.width-20, 40);
    }else{
        
        self.tesbutton.hidden = YES;
    }
    
    [RYHViewController Sharedbxtabar].tarbar.hidden =YES;
    [self configBackButton];
    [self configTitleWithString:@"我要认购"];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"1");
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    if ([UIScreen mainScreen].bounds.size.height < 570) {
        [[UIApplication sharedApplication].keyWindow addSubview:self.tesbutton];
    }else{
        self.tesbutton.hidden = YES;
    }
    
}

-(void)dealloc{
    self.tesbutton.hidden = YES;
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)buyproject:(id)sender {
    NSLog(@"ccccbbbbbxxxxx");
    
    
}
- (IBAction)xieyi:(id)sender {
    
    
}
- (IBAction)jisuan:(id)sender {
    
    
}
- (IBAction)quangou:(id)sender {
    
    
    
}

@end
