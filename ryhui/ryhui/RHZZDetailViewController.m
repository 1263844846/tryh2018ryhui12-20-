//
//  RHZZDetailViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 16/3/28.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import "RHZZDetailViewController.h"
#import "CircleProgressView.h"
#import "RHZZBuyViewController.h"

@interface RHZZDetailViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property(nonatomic,strong)CircleProgressView* progressView;

@property (weak, nonatomic) IBOutlet UIView *yuanhuanView;
@property (weak, nonatomic) IBOutlet UILabel *nianhualab;
@property (weak, nonatomic) IBOutlet UILabel *timelab;
@property (weak, nonatomic) IBOutlet UILabel *kerengoulab;
@property (weak, nonatomic) IBOutlet UILabel *zongelab;
@property (weak, nonatomic) IBOutlet UILabel *namelab;
@property (weak, nonatomic) IBOutlet UILabel *dbflab;
@property (weak, nonatomic) IBOutlet UIImageView *dbfimage;
@property (weak, nonatomic) IBOutlet UILabel *hkfslab;
@property (weak, nonatomic) IBOutlet UILabel *yxtimelab;
@property (weak, nonatomic) IBOutlet UIButton *zzgoumaibtn;
@property (weak, nonatomic) IBOutlet UIImageView *jsqimage;

@end

@implementation RHZZDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.scrollView.contentSize=CGSizeMake(self.view.frame.size.width,554);
    
    NSLog(@"%f",[UIScreen mainScreen].bounds.size.height);
    self.scrollView.bounces = NO;

    if ([UIScreen mainScreen].bounds.size.height < 570) {
        self.zzgoumaibtn.hidden = YES;
        self.jsqimage.hidden = YES;
        UIButton * btn  = [[UIButton alloc]init];
        btn.frame = CGRectMake(80, 520, [UIScreen mainScreen].bounds.size.width-40-60, 35);
       [self.scrollView addSubview:btn];
       if ([RHUserManager sharedInterface].username) {
           [btn setTitle:@"立即投标" forState:UIControlStateNormal];
        }else{
            [btn setTitle:@"马上登录" forState:UIControlStateNormal];
            
        }
        btn.backgroundColor = [RHUtility colorForHex:@"#44bbc1"];
        [btn addTarget:self action:@selector(goumai:) forControlEvents:UIControlEventTouchUpInside];
        UIImageView * jsqimage = [[UIImageView alloc]init];
        jsqimage.frame = CGRectMake(20, 520, 35, 35);
        jsqimage.backgroundColor = [UIColor redColor];
        [self.scrollView addSubview:jsqimage];
        jsqimage.image = [UIImage imageNamed:@"jsq.png"];
        
    }
    [self configBackButton];
    [self configTitleWithString:@"转让详情"];
    [self creat];
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


-(void)creat{
    
    
    
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    height = height- 69-44;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    CGFloat w = width/4.0;
    NSString * str = [NSString stringWithFormat:@"%.1f",w];
    int ww = [str floatValue];
    //NSLog(@"%f",ww);
    int www = ww-20;
    if (ww < 85) {
        www = 40;
        //self.progressView.str = @"cbx";
    }
    
    self.progressView = [[CircleProgressView alloc]
                         initWithFrame:CGRectMake(0, 0,60, 60)
                         withCenter:CGPointMake(60/ 2.0, 60/ 2.0)
                         Radius:55.0 / 2.0
                         lineWidth:6];
    self.progressView.backgroundColor = [UIColor clearColor];
    [self.yuanhuanView addSubview:_progressView];
    self.progressView.str = @"cbx";
    [self.progressView setProgress:0.5];
    
//        UIButton * btn  = [[UIButton alloc]init];
//        btn.frame = CGRectMake(80, [UIScreen mainScreen].bounds.size.height-20-69-20+4, [UIScreen mainScreen].bounds.size.width-40-60, 35);
//        [self.view addSubview:btn];
//        if ([RHUserManager sharedInterface].username) {
//            [btn setTitle:@"立即投标" forState:UIControlStateNormal];
//        }else{
//            [btn setTitle:@"马上登录" forState:UIControlStateNormal];
//        }
//        btn.backgroundColor = [RHUtility colorForHex:@"#44bbc1"];
//       // [btn addTarget:self action:@selector(toubiao:) forControlEvents:UIControlEventTouchUpInside];
//        UIImageView * jsqimage = [[UIImageView alloc]init];
//        jsqimage.frame = CGRectMake(20, [UIScreen mainScreen].bounds.size.height-20-69-20+4, 35, 35);
//    
//        jsqimage.backgroundColor = [RHUtility colorForHex:@"#44bbc1"];
//        jsqimage.image = [UIImage imageNamed:@"jsq"];
//        [self.view addSubview:jsqimage];
    
    
}
- (IBAction)goumai:(id)sender {
    NSLog(@"bxznmlbkdyhsa");
    RHZZBuyViewController * vc= [[RHZZBuyViewController alloc]initWithNibName:@"RHZZBuyViewController" bundle:nil];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
