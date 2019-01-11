//
//  RHZQZRViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 16/3/17.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import "RHZQZRViewController.h"
//#import "RHMyGiftContentViewController.h"
#import "RHZZCONViewController.h"

@interface RHZQZRViewController ()
@property(nonatomic,strong)RHSegmentContentView* segmentContentView;
@property(nonatomic,strong)NSMutableArray* viewControllers;
@property (weak, nonatomic) IBOutlet UIView *segmentView1;
@property (weak, nonatomic) IBOutlet UIView *segmentView2;
@property (weak, nonatomic) IBOutlet UIView *segmentView3;

@property (weak, nonatomic) IBOutlet UILabel *cashcardlab;
@property (weak, nonatomic) IBOutlet UIImageView *cashcardimage;
@property (weak, nonatomic) IBOutlet UIButton *CashCardbutton;
@end

@implementation RHZQZRViewController

@synthesize segmentContentView=_segmentContentView;
@synthesize viewControllers=_viewControllers;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configBackButton];
    [self configTitleWithString:@"债权转让"];
    
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
      
    _viewControllers = [NSMutableArray array];
    
    self.cashcardimage.frame = CGRectMake(w/ 2 -60, 41, 21, 18);
    self.CashCardbutton.frame = CGRectMake(0, 41, w, 18);
    self.segmentContentView = [[RHSegmentContentView alloc] initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].applicationFrame.size.height-50-30-self.navigationController.navigationBar.frame.size.height)];
    //    DLog(@"%f----%f",[UIScreen mainScreen].applicationFrame.size.height-50-40-self.navigationController.navigationBar.frame.size.height,self.navigationController.navigationBar.frame.size.height);
    [_segmentContentView setDelegate:self];
    [self.view addSubview:_segmentContentView];
    _segmentContentView.backgroundColor = [UIColor grayColor];
    
    
    RHZZCONViewController* controller1=[[RHZZCONViewController alloc]init];
    controller1.nav=self.navigationController;
    controller1.type=@"front/payment/account/myInitGiftListData";
    controller1.test = @"0";
    [_viewControllers addObject:controller1];
    
    RHZZCONViewController* controller2=[[RHZZCONViewController alloc]init];
    controller2.nav=self.navigationController;
    controller2.type=@"front/payment/account/myUsedGiftListData";
    controller2.test = @"1";
    [_viewControllers addObject:controller2];
    
    RHZZCONViewController* controller3=[[RHZZCONViewController alloc]init];
    controller3.nav=self.navigationController;
    controller3.type=@"front/payment/account/myPastGiftListData";
    controller3.test = @"2";
    [_viewControllers addObject:controller3];
    
    [_segmentContentView setViews:_viewControllers];
    
    [self segmentContentView:_segmentContentView selectPage:0];
    
    
    //    NSDictionary *attributes = @{NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    //    NSMutableAttributedString *netString = [[NSMutableAttributedString alloc] initWithString:_cashcardlab.text];
    //    [netString addAttributes:attributes range:NSMakeRange(0, netString.length)];
    //    _cashcardlab.attributedText = netString;
    
    self.cashcardimage.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2 - 65, 41, 21, 18);
    self.cashcardlab.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2 - 29, 41, 97, 18);
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.view];
    
    if (CGRectContainsPoint(_cashcardlab.frame, touchPoint)) {
        _cashcardlab.textColor = [UIColor whiteColor];
    }
    _cashcardlab.textColor = [UIColor colorWithRed:57/255.0 green:109/255.0 blue:185/255.0 alpha:1];
    
}

//-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
//
//
//    RHCashCardViewController * CashCardVC = [[RHCashCardViewController alloc]initWithNibName:@"RHCashCardViewController" bundle:nil];
//    CashCardVC.res = YES;
//
//    [self.navigationController pushViewController:CashCardVC animated:YES];
//
//}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //[self.view removeFromSuperview];
    
//    if ([[RHmainModel ShareRHmainModel].maintest isEqualToString:@"hehe"]) {
//        
//        [self.navigationController popToRootViewControllerAnimated:NO];
//    }
    
    self.navigationController.navigationBar.hidden=NO;
    [self initData];
    [self segmentAction1:nil];
    //[self viewDidLoad];
    
    // [self viewDidAppear:YES];
    [self segmentContentView:_segmentContentView selectPage:0];
}

-(void)initData
{
    self.segmentView1.hidden=NO;
    self.segmentView2.hidden=YES;
    self.segmentView3.hidden=YES;
}


- (IBAction)segmentAction1:(id)sender {
    
//    self.segmentContentView.frame = CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].applicationFrame.size.height-50 - 30 -self.navigationController.navigationBar.frame.size.height);
    self.segmentView1.hidden=NO;
    self.segmentView2.hidden=YES;
    self.segmentView3.hidden=YES;
    [self didSelectSegmentAtIndex:0];
}

- (IBAction)segmentAction2:(id)sender {
//    self.segmentContentView.frame = CGRectMake(0, 30, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].applicationFrame.size.height-50-self.navigationController.navigationBar.frame.size.height);
    self.segmentView1.hidden=YES;
    self.segmentView2.hidden=NO;
    self.segmentView3.hidden=YES;
    [self didSelectSegmentAtIndex:1];
}

- (IBAction)segmentAction3:(id)sender {
//    self.segmentContentView.frame = CGRectMake(0, 30, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].applicationFrame.size.height-50-self.navigationController.navigationBar.frame.size.height);
    self.segmentView1.hidden=YES;
    self.segmentView2.hidden=YES;
    self.segmentView3.hidden=NO;
    [self didSelectSegmentAtIndex:2];
}

- (IBAction)pushMain:(id)sender {
    [[[RHTabbarManager sharedInterface] selectTabbarMain] popToRootViewControllerAnimated:NO];
}

- (IBAction)pushUser:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)pushMore:(id)sender {
    [[[RHTabbarManager sharedInterface] selectTabbarMore] popToRootViewControllerAnimated:NO];
}

- (void)didSelectSegmentAtIndex:(int)index
{
    [_segmentContentView setSelectPage:index];
    
}

- (void)segmentContentView:(RHSegmentContentView *)segmentContentView selectPage:(NSUInteger)page{
    switch (page) {
        case 0:
            [self segmentAction1:nil];
            break;
        case 1:
            [self segmentAction2:nil];
            break;
        case 2:
            [self segmentAction3:nil];
            break;
        default:
            break;
    }
    
    
    RHZZCONViewController* controller=[_viewControllers objectAtIndex:page];
    
    [controller.dataArray removeAllObjects];
    if ([[NSNumber numberWithInteger:[controller.dataArray count]] intValue]<=0) {
        [controller startPost];
    }
}





@end
