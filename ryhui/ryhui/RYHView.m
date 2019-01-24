//
//
//  Created by  on 15/9/12.
//  Copyright (c) 2015年 . All rights reserved.
//

#import "RYHView.h"
//#import "ViewController.h"
#import "UIColor+ZXLazy.h"
#import "RHhelper.h"
#import "RHDBSJViewController.h"
@interface RYHView ()

@property (nonatomic, strong) UIButton *selectedButton;

@property(nonatomic,strong) UINavigationController* nav;
@end

@implementation RYHView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        // 添加按钮
        self.backgroundColor = [UIColor whiteColor];
        [self addBtns];
        
    }
    return self;
}

- (void)addBtns
{
    CGFloat btnW = [UIScreen mainScreen].bounds.size.width / 4;
    NSString *imageName = nil;
    
    NSString *selImageName = nil;
    
    NSArray * cbxarray =@[@"首页",@"项目列表",@"我的账户",@"更多"];
    for (int i = 0; i < 4; i++) {
        
        
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        // 绑定角标
        btn.tag = i;
       
        imageName = [NSString stringWithFormat:@"ICN_Nav-Home%d",i + 1];
        selImageName = [NSString stringWithFormat:@"ICN_Nav-Homehight%d",i + 1];
        
        UIImageView * aimageview = [[UIImageView alloc]init];
        aimageview.tag = 5+i;
       // NSLog(@"%f@@@@@@@@@@@@@@@@@@@",self.frame.size.width);
        aimageview.frame = CGRectMake(btnW/2-10, 6, 22, 22);
        
        UILabel * labxian = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, btnW*4, 1)];
        labxian.backgroundColor = [RHUtility colorForHex:@"#c6c6c6"];
        [btn addSubview:labxian];
        
        if (btn.selected == NO) {
             UIImage * image = [UIImage imageNamed:imageName];
            aimageview.image = image;
        }else{
            
            UIImage * image = [UIImage imageNamed:selImageName];
            aimageview.image = image;
        }
       
        UILabel * lab = [[UILabel alloc]init];
        lab.frame = CGRectMake(CGRectGetMinX(aimageview.frame)-10, CGRectGetMaxY(aimageview.frame), 45, 20);
        lab.tag = 15+i;
        lab.textAlignment = NSTextAlignmentCenter;
       
        lab.text =  cbxarray[i];
        lab.font = [UIFont systemFontOfSize:10];
        [lab setTextColor:[UIColor colorWithHexString:@"#6f6f6f"]];
        [btn addSubview:aimageview];
        [btn addSubview:lab];
        
        // 设置按钮的图片
//        [btn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
//        
//        [btn setBackgroundImage:[UIImage imageNamed:selImageName] forState:UIControlStateSelected];
        
        // 监听按钮的点击
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        
        
        [self addSubview:btn];
        
        // 默认选中第一个按钮
        if (i == 0) {
            [self btnClick:btn];
        }
    }
//    UILabel * labxian = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, btnW*4, 1)];
//    labxian.backgroundColor = [UIColor redColor];
////    [self addSubview:labxian];
}

// 点击按钮的时候调用
- (void)btnClick:(UIButton *)button
{
    
   
//    self
    if ([self.str isEqualToString:@"cbx"]) {
        button.tag = 1;
//        [self.delegate tabBar:self didSelectedIndex:button.tag];
    }
    self.str = @"dbx";
    // 取消之前选择按钮
    _selectedButton.selected = NO;
    // 选中当前按钮
    button.selected = YES;
    // 记录当前选中按钮
    _selectedButton = button;
    
    
    if (button.tag==1) {
        self.nav = [[RHTabbarManager sharedInterface] selectTabbarProject];
    }
    if (button.tag==3) {
        self.nav = [[RHTabbarManager sharedInterface] selectTabbarMore];
    }
    if (button.tag==2) {
        if ([[RHhelper ShraeHelp].dbsxstr isEqualToString:@"1"]) {
            
            UIAlertView* alertView=[[UIAlertView alloc]initWithTitle:@"提示"
                                                             message:@"您有待办事项未处理完毕，请尽快处理。"
                                                            delegate:self
                                                   cancelButtonTitle:@"确定"
                                                   otherButtonTitles:@"取消", nil];
            alertView.tag=8901;
            [alertView show];
            
            return;
        }
        
        
    }
    
    
//    dbxaimage = [button viewWithTag:5]
    if (self.delegate&&[self.delegate respondsToSelector:@selector(tabBar:didSelectedIndex:) ]) {
        [self.delegate tabBar:self didSelectedIndex:button.tag];
    }
    
    //UIImageView * dbxaimage = [[UIImageView alloc]init];
    if (button.tag==0) {
        if ([RHhelper ShraeHelp].resss ==10) {
            UINavigationController* nav = [[RHTabbarManager sharedInterface] selectTabbarMain];
            [nav popToRootViewControllerAnimated:NO];
        }
        UIImageView * dbxaimage = [[UIImageView alloc]init];
        
        dbxaimage = [self viewWithTag:5];
        dbxaimage.image = [UIImage imageNamed:[NSString stringWithFormat:@"ICN_Nav-Homehight11"]];
        UIImageView * dbxaimage1 = [[UIImageView alloc]init];
        dbxaimage1 = [self viewWithTag:6];
        dbxaimage1.image = [UIImage imageNamed:[NSString stringWithFormat:@"ICN_Nav-Home2"]];
        UIImageView * dbxaimage2 = [[UIImageView alloc]init];
        dbxaimage2 = [self viewWithTag:7];
        dbxaimage2.image = [UIImage imageNamed:[NSString stringWithFormat:@"ICN_Nav-Home3"]];
        UIImageView * dbxaimage3 = [[UIImageView alloc]init];
        dbxaimage3 = [self viewWithTag:8];
        dbxaimage3.image = [UIImage imageNamed:[NSString stringWithFormat:@"ICN_Nav-Home4"]];
        
        UILabel * lab = [self viewWithTag:15];
        lab.text = @"首页";
        [lab setTextColor:[UIColor colorWithHexString:@"#48bac0"]];
        
        UILabel * lab1 = [self viewWithTag:16];
        lab1.text = @"项目列表";
        
        [lab1 setTextColor:[UIColor colorWithHexString:@"#6f6f6f"]];
        UILabel * lab2 = [self viewWithTag:17];
        lab2.text = @"我的账户";
        [lab2 setTextColor:[UIColor colorWithHexString:@"#6f6f6f"]];
        UILabel * lab3 = [self viewWithTag:18];
        lab3.text = @"更多";
        [lab3 setTextColor:[UIColor colorWithHexString:@"#6f6f6f"]];
    }else if (button.tag==2){
        if ([RHhelper ShraeHelp].resss ==5) {
            UINavigationController* nav = [[RHTabbarManager sharedInterface] selectTabbarUser];
          //  [RYHViewController Sharedbxtabar].tarbar.hidden = YES;
            [nav popToRootViewControllerAnimated:NO];
        }
        
      //  [RYHViewController Sharedbxtabar].tarbar.hidden = YES;
        
        UIImageView * dbxaimage = [[UIImageView alloc]init];
        dbxaimage = [self viewWithTag:5];
        dbxaimage.image = [UIImage imageNamed:[NSString stringWithFormat:@"ICN_Nav-Home1"]];
        UIImageView * dbxaimage1 = [[UIImageView alloc]init];
        dbxaimage1 = [self viewWithTag:6];
        dbxaimage1.image = [UIImage imageNamed:[NSString stringWithFormat:@"ICN_Nav-Home2"]];
        UIImageView * dbxaimage2 = [[UIImageView alloc]init];
        dbxaimage2 = [self viewWithTag:7];
        dbxaimage2.image = [UIImage imageNamed:[NSString stringWithFormat:@"ICN_Nav-Homehight12"]];
        UIImageView * dbxaimage3 = [[UIImageView alloc]init];
        dbxaimage3 = [self viewWithTag:8];
        dbxaimage3.image = [UIImage imageNamed:[NSString stringWithFormat:@"ICN_Nav-Home4"]];
        UILabel * lab = [self viewWithTag:15];
        lab.text = @"首页";
        [lab setTextColor:[UIColor colorWithHexString:@"#6f6f6f"]];
        UILabel * lab1 = [self viewWithTag:16];
        lab1.text = @"项目列表";
        [lab1 setTextColor:[UIColor colorWithHexString:@"#6f6f6f"]];
        UILabel * lab2 = [self viewWithTag:17];
        lab2.text = @"我的账户";
        [lab2 setTextColor:[UIColor colorWithHexString:@"#48bac0"]];
        UILabel * lab3 = [self viewWithTag:18];
        lab3.text = @"更多";
        [lab3 setTextColor:[UIColor colorWithHexString:@"#6f6f6f"]];
    }else if (button.tag==3){
        UIImageView * dbxaimage = [[UIImageView alloc]init];
        dbxaimage = [self viewWithTag:5];
        dbxaimage.image = [UIImage imageNamed:[NSString stringWithFormat:@"ICN_Nav-Home1"]];
        UIImageView * dbxaimage1 = [[UIImageView alloc]init];
        dbxaimage1 = [self viewWithTag:6];
        dbxaimage1.image = [UIImage imageNamed:[NSString stringWithFormat:@"ICN_Nav-Home2"]];
        UIImageView * dbxaimage2 = [[UIImageView alloc]init];
        dbxaimage2 = [self viewWithTag:7];
        dbxaimage2.image = [UIImage imageNamed:[NSString stringWithFormat:@"ICN_Nav-Home3"]];
        UIImageView * dbxaimage3 = [[UIImageView alloc]init];
        dbxaimage3 = [self viewWithTag:8];
        dbxaimage3.image = [UIImage imageNamed:[NSString stringWithFormat:@"ICN_Nav-Homehight14"]];
        UILabel * lab = [self viewWithTag:15];
        lab.text = @"首页";
        [lab setTextColor:[UIColor colorWithHexString:@"#6f6f6f"]];
        UILabel * lab1 = [self viewWithTag:16];
        lab1.text = @"项目列表";
        [lab1 setTextColor:[UIColor colorWithHexString:@"#6f6f6f"]];
        UILabel * lab2 = [self viewWithTag:17];
        lab2.text = @"我的账户";
        [lab2 setTextColor:[UIColor colorWithHexString:@"#6f6f6f"]];
        UILabel * lab3 = [self viewWithTag:18];
        lab3.text = @"更多";
        [lab3 setTextColor:[UIColor colorWithHexString:@"#48bac0"]];
    }else if (button.tag==1){
        UIImageView * dbxaimage = [[UIImageView alloc]init];
        dbxaimage = [self viewWithTag:5];
        dbxaimage.image = [UIImage imageNamed:[NSString stringWithFormat:@"ICN_Nav-Home1"]];
        UIImageView * dbxaimage1 = [[UIImageView alloc]init];
        dbxaimage1 = [self viewWithTag:6];
        dbxaimage1.image = [UIImage imageNamed:[NSString stringWithFormat:@"ICN_Nav-Homehight13"]];
        UIImageView * dbxaimage2 = [[UIImageView alloc]init];
        dbxaimage2 = [self viewWithTag:7];
        dbxaimage2.image = [UIImage imageNamed:[NSString stringWithFormat:@"ICN_Nav-Home3"]];
        UIImageView * dbxaimage3 = [[UIImageView alloc]init];
        dbxaimage3 = [self viewWithTag:8];
        dbxaimage3.image = [UIImage imageNamed:[NSString stringWithFormat:@"ICN_Nav-Home4"]];
        UILabel * lab = [self viewWithTag:15];
        lab.text = @"首页";
        [lab setTextColor:[UIColor colorWithHexString:@"#6f6f6f"]];
        UILabel * lab1 = [self viewWithTag:16];
        lab1.text = @"项目列表";
        [lab1 setTextColor:[UIColor colorWithHexString:@"#48bac0"]];
        UILabel * lab2 = [self viewWithTag:17];
        lab2.text = @"我的账户";
        [lab2 setTextColor:[UIColor colorWithHexString:@"#6f6f6f"]];
        UILabel * lab3 = [self viewWithTag:18];
        lab3.text = @"更多";
        [lab3 setTextColor:[UIColor colorWithHexString:@"#6f6f6f"]];
    }
//
//        //ViewController * vc = [ViewController new];
//        
//        
//        NSLog(@"444444");
//    }else if (button.tag==4){
//        NSLog(@"55555");
//    }
    
}

#warning 设置按钮的位置
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    
    
    CGFloat btnW = self.bounds.size.width / self.subviews.count;
    CGFloat btnH = self.bounds.size.height ;
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    
    // 设置按钮的尺寸
    for (int i = 0; i < self.subviews.count; i++) {
        UIButton *btn = self.subviews[i];
        
        btnX = i * btnW ;
        
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }

}
+ (instancetype)Shareview{
    static RYHView * model = nil;
    
    static dispatch_once_t ttt;
    
    dispatch_once(&ttt, ^{
        model = [RYHView new];
    });
    
    return model;

}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 8901) {
        
        
        if (buttonIndex==0) {
            [RYHViewController Sharedbxtabar].tarbar.hidden = YES;
            RHDBSJViewController * vc = [[RHDBSJViewController alloc]initWithNibName:@"RHDBSJViewController" bundle:nil];
            //        vc.str = @"cbx";
            
//            UINavigationController* nav = [[RHTabbarManager sharedInterface] selectTabbarMain];
            if (!self.nav) {
                self.nav = [[RHTabbarManager sharedInterface] selectTabbarMain];
            }
            
            [self.nav pushViewController:vc animated:NO];
        }
    }
}
@end
