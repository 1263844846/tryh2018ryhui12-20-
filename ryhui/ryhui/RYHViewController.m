//
//  Created by  on 15/9/12.
//  Copyright (c) . All rights reserved.
//

#import "RYHViewController.h"

#import "RHmainModel.h"

@interface RYHViewController ()<RYHviewDelegate>

@end

@implementation RYHViewController

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
   //  [self.tabBar removeFromSuperview];
    [self.tabBar setHidden:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    NSDate *  senddate=[NSDate date];
//    
//    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
//    
//    [dateformatter setDateFormat:@"YYYYMMdd"];
//    
//    NSString *  locationString=[dateformatter stringFromDate:senddate];
//    
//    NSLog(@"locationString:%@",locationString);
    
    // 移除自带的tabBar
    [self.tabBar removeFromSuperview];
    
    NSLog(@"%@",self.tabBar);
    // 创建tabBar
    self.tarbar = [RYHView Shareview];
    
   

    self.tarbar.delegate = self;
    
    
    if ([UIScreen mainScreen].bounds.size.height >740) {
    self.tarbar.frame = CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y-35, self.tabBar.frame.size.width, self.tabBar.frame.size.height+35);
    }else{
        self.tarbar.frame = self.tabBar.frame;
    }
    [self.view addSubview:self.tarbar];
    self.view.backgroundColor = [UIColor clearColor];
    
   // tabBar.hidden = YES;
    //self.view.hidden = YES;
    
}
- (void)tabBar:(RYHView *)tabBar didSelectedIndex:(int)index
{

    
  //  UITabBarController * tab ;
    
    self.selectedIndex = index;
    
    
   // tabBar.str = nil;
    
    
    NSLog(@"%d--=-=-=-=-=-=",index);
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
+(instancetype)Sharedbxtabar{
    
    static RYHViewController * model = nil;
    
    static dispatch_once_t ttt;
    
    dispatch_once(&ttt, ^{
        model = [[RYHViewController alloc]init];
    });
    
    return model;
}



@end
