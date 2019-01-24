//
//  mytestsyViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 16/6/14.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import "mytestsyViewController.h"
#import "SHLineGraphView.h"
#import "SHPlot.h"
@interface mytestsyViewController ()
@property (weak, nonatomic) IBOutlet UILabel *testsycbxlab;

@end

@implementation mytestsyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationController.navigationBar setBarTintColor:[RHUtility colorForHex:@"#4ABAC0"]];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    //UIImageView * cbximage = [[UIImageView alloc]init];
    //cbximage.backgroundColor = [RHUtility colorForHex:@"#44bbc1"];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    self.navigationController.navigationBar.translucent = NO;
    
    [self creat];
    

//    for (int i = 0; i< 100000; i++) {
//        self.testsycbxlab.text = [NSString stringWithFormat:@"%d",i];
//    }
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_sync(queue, ^{
//            NSLog(@"下载图片1----%@",[NSThread currentThread]);
//            });
//        dispatch_sync(queue, ^{
//                NSLog(@"下载图片2----%@",[NSThread currentThread]);
//    });
//        dispatch_sync(queue, ^{
//                NSLog(@"下载图片3----%@",[NSThread currentThread]);
//        });
//    dispatch_async(queue, ^{
//        NSLog(@"下载图片11----%@",[NSThread currentThread]);
//    });
//    dispatch_async(queue, ^{
//        NSLog(@"下载图片12----%@",[NSThread currentThread]);
//    });
//    dispatch_async(queue, ^{
//        NSLog(@"下载图片13----%@",[NSThread currentThread]);
//    });
//    dispatch_async(queue, ^{
//        NSLog(@"下载图片14----%@",[NSThread currentThread]);
//    });
//    dispatch_async(queue, ^{
//        NSLog(@"下载图片15----%@",[NSThread currentThread]);
//    });
//    dispatch_async(queue, ^{
//        NSLog(@"下载图片16----%@",[NSThread currentThread]);
//    });
//    dispatch_async(queue, ^{
//        NSLog(@"下载图片17----%@",[NSThread currentThread]);
//    });
//    dispatch_async(queue, ^{
//        NSLog(@"下载图片18----%@",[NSThread currentThread]);
//    });
//    dispatch_async(queue, ^{
//        NSLog(@"下载图片19----%@",[NSThread currentThread]);
//    });
//     NSLog(@"主线程----%@",[NSThread mainThread]);
    
    
    dispatch_queue_t q2=dispatch_queue_create("com.hellocation.gcdDemo", DISPATCH_QUEUE_CONCURRENT);
   // dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    for (int i=0; i<10; i++) {
        dispatch_async(queue, ^{
            NSLog(@"%@---------%d",[NSThread currentThread],i);
        });
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
-(void)awakeFromNib{
    
    
    self.testsycbxlab.frame = CGRectMake(0, 0, 100, 100);
}

-(void)viewDidAppear:(BOOL)animated{
//    self.testsycbxlab.frame = CGRectMake(0, 0, 100, 100);
    [super viewDidAppear:animated];
}
- (void)viewWillAppear:(BOOL)animated
{
     self.testsycbxlab.frame = CGRectMake(0, 0, 100, 100); // 刷新评论列表（请求数据方法）
    
    //self.testsycbxlab.lineBreakMode = NSLineBreakByWordWrapping;
    
        self.testsycbxlab.text = @"本店于十一期间特推出一系列优惠，限时限量敬请选购！沙发：钻石品质，首领风范！床垫：";
   
   
//        CGSize size = [self.testsycbxlab sizeThatFits:CGSizeMake(self.testsycbxlab.frame.size.width,)];
 
//       self.testsycbxlab.frame =CGRectMake(10, 100, 100, size.height);
    
//      self.testsycbxlab.font = [UIFont systemFontOfSize:14];
    CGSize size = CGSizeMake(300,2000);
    CGSize size1 = [self.testsycbxlab.text sizeWithFont:self.testsycbxlab.font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
//    size1 = [self.testsycbxlab.text sizeWithFont:<#(UIFont *)#> constrainedToSize:<#(CGSize)#> lineBreakMode:<#(NSLineBreakMode)#>]
    self.testsycbxlab.frame = CGRectMake(0, 0, size1.width, size1.height);
       //[self.view addSubview:label];
    [super viewDidAppear:animated];
}




-(void)creat{
    
    
    CGFloat with = [UIScreen mainScreen].bounds.size.width*(330.0/375.0);
    SHLineGraphView *_lineGraph = [[SHLineGraphView alloc] initWithFrame:CGRectMake(20, 350, with, 160)];
    
    if ([UIScreen mainScreen].bounds.size.width <321) {
        _lineGraph.testA = 0;
        _lineGraph.testB = 0;
        _lineGraph.testC = 8;
        _lineGraph.testD = 7;
    }else if ([UIScreen mainScreen].bounds.size.width >378){
        
        _lineGraph.testA = 7;
        _lineGraph.testB = 4;
        _lineGraph.testC = -2;
        _lineGraph.testD = -3;
    }
    
    NSString * dog = @"dog";
    NSString * cat = @"BitClave";
    NSLog(@"%@---%@----%f",dog,cat,RHScreeWidth);
    
    //set the main graph area theme attributes
    
    /**
     *  theme attributes dictionary. you can specify graph theme releated attributes in this dictionary. if this property is
     *  nil, then a default theme setting is applied to the graph.
     */
    NSDictionary *_themeAttributes = @{
                                       //月
                                       kXAxisLabelColorKey : [UIColor colorWithRed:0.9 green:0.1 blue:0.1 alpha:0.4],
                                       kXAxisLabelFontKey : [UIFont fontWithName:@"TrebuchetMS" size:15],
                                       //万
                                       kYAxisLabelColorKey : [UIColor colorWithRed:0.1 green:0.48 blue:0.49 alpha:0.4],
                                       kYAxisLabelFontKey : [UIFont fontWithName:@"TrebuchetMS" size:15],
                                       kYAxisLabelSideMarginsKey : @20,
                                       //线
                                       kPlotBackgroundLineColorKey : [UIColor colorWithRed:0.9 green:0.1 blue:0.49 alpha:0.4],
                                       kDotSizeKey : @6
                                       };
    _lineGraph.themeAttributes = _themeAttributes;
    
    //set the line graph attributes
    
    /**
     *  the maximum y-value possible in the graph. make sure that the y-value is not in the plotting points is not greater
     *  then this number. otherwise the graph plotting will show wrong results.
     */
    _lineGraph.yAxisRange = @(50000);
    
    /**
     *  y-axis values are calculated according to the yAxisRange passed. so you do not have to pass the explicit labels for
     *  y-axis, but if you want to put any suffix to the calculated y-values, you can mention it here (e.g. K, M, Kg ...)
     */
    _lineGraph.yAxisSuffix = @"";
    
    /**
     *  an Array of dictionaries specifying the key/value pair where key is the object which will identify a particular
     *  x point on the x-axis line. and the value is the label which you want to show on x-axis against that point on x-axis.
     *  the keys are important here as when plotting the actual points on the graph, you will have to use the same key to
     *  specify the point value for that x-axis point.
     */
    _lineGraph.xAxisValues = @[
                               @{ @1 : @"   19月" },
                               @{ @2 : @"    2月" },
                               @{ @3 : @"    3月" },
                               @{ @4 : @"    4月" },
                               @{ @5 : @"    5月" },
                               @{ @6 : @"    6月" },
                               ];
    
    //create a new plot object that you want to draw on the `_lineGraph`
    SHPlot *_plot1 = [[SHPlot alloc] init];
    
    //set the plot attributes
    
    /**
     *  Array of dictionaries, where the key is the same as the one which you specified in the `xAxisValues` in `SHLineGraphView`,
     *  the value is the number which will determine the point location along the y-axis line. make sure the values are not
     *  greater than the `yAxisRange` specified in `SHLineGraphView`.
     */
    _plot1.plottingValues = @[
                              @{ @1 : @30000 },
                              @{ @2 : @20000 },
                              @{ @3 : @23000 },
                              @{ @4 : @29000 },
                              @{ @5 : @260 },
                              @{ @6 : @230 },
                              ];
    
    /**
     *  this is an optional array of `NSString` that specifies the labels to show on the particular points. when user clicks on
     *  a particular points, a popover view is shown and will show the particular label on for that point, that is specified
     *  in this array.
     */
    NSArray *arr = @[@"17547547", @"2", @"3", @"4", @"5", @"6" ];
    _plot1.plottingPointsLabels = arr;
    
    //set plot theme attributes
    
    /**
     *  the dictionary which you can use to assing the theme attributes of the plot. if this property is nil, a default theme
     *  is applied selected and the graph is plotted with those default settings.
     */
    NSArray * myarray = @[@"cbx",@"cyn",@"cjw",@"cnm"];
    NSString * cbb = @"elewpyuchengfenggyiquyoukongqionglouyuyiugaochubuchenghanqiwunongqiyinghesizairenjiaandeguangshaqianwanjiadabitianxiahanshijuhanyan";
    NSDictionary *_plotThemeAttributes = @{
                                           //mengban
                                           kPlotFillColorKey : [UIColor colorWithRed:0.9 green:0.75 blue:0.78 alpha:0],
                                           kPlotStrokeWidthKey : @2,
                                           //中间线
                                           kPlotStrokeColorKey : [UIColor colorWithRed:0.9 green:0.36 blue:0.41 alpha:1],
                                           //点
                                           kPlotPointFillColorKey : [UIColor colorWithRed:0.9 green:0.36 blue:0.41 alpha:1],
                                           kPlotPointValueFontKey : [UIFont fontWithName:@"TrebuchetMS" size:18]
                                           };
    
    _plot1.plotThemeAttributes = _plotThemeAttributes;
    [_lineGraph addPlot:_plot1];
    
    //You can as much `SHPlots` as you can in a `SHLineGraphView`
    
    [_lineGraph setupTheView];
    
    [self.view addSubview:_lineGraph];

}
@end
