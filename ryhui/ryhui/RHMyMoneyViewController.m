//
//  RHMyMoneyViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 17/3/7.
//  Copyright © 2017年 stefan. All rights reserved.
//

#import "RHMyMoneyViewController.h"
#import "PNChart.h"
#import "CONST.h"
#import "MBProgressHUD.h"
#import "SHLineGraphView.h"
#import "SHPlot.h"


@interface RHMyMoneyViewController ()<UIActionSheetDelegate>
@property (nonatomic,strong) PNPieChart *pieChart;
@property (weak, nonatomic) IBOutlet UIButton *MoneyButton;
@property (weak, nonatomic) IBOutlet UIButton *SyButton;
@property (weak, nonatomic) IBOutlet UIView *MyView1;

@property (weak, nonatomic) IBOutlet UIView *MyView2;

@property(nonatomic,strong)UILabel * moneylab;
@property(nonatomic,strong)UILabel * zclab;

@property (weak, nonatomic) IBOutlet UILabel *yuelab;
@property (weak, nonatomic) IBOutlet UILabel *dongjielab;
@property (weak, nonatomic) IBOutlet UILabel *benjinlab;
@property (weak, nonatomic) IBOutlet UILabel *lixilab;
@property (weak, nonatomic) IBOutlet UILabel *shenglibaolab;

@property (weak, nonatomic) IBOutlet UIView *testView;
@property (weak, nonatomic) IBOutlet UILabel *testlab;
@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;

@property (weak, nonatomic) IBOutlet UILabel *leijilab;

@property (weak, nonatomic) IBOutlet UILabel *yzlxlab;
@property (weak, nonatomic) IBOutlet UILabel *tzxjlab;

@property (weak, nonatomic) IBOutlet UILabel *flxjlab;
@property (weak, nonatomic) IBOutlet UILabel *slbsylab;
@property (weak, nonatomic) IBOutlet UILabel *bybxlab;
@property(nonatomic,copy)NSString * moneystr;
@property(nonatomic,strong)NSMutableArray * moneyArray;
@property(nonatomic,strong)NSMutableArray * keyArray;
@property(nonatomic,copy)NSString * keystring;
@end

@implementation RHMyMoneyViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
    [RYHViewController Sharedbxtabar].tarbar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.moneyArray = [NSMutableArray array];
    [self configTitleWithString:@"资产总览"];
    [self configBackButton];
    self.SyButton.backgroundColor = [RHUtility colorForHex:@"#efefef"];
    [self.SyButton setTitleColor:[RHUtility colorForHex:@"#707070"] forState:UIControlStateNormal];
  //  [self createPieView2];
    self.pieChart.userInteractionEnabled = NO;
     [self getdata];
   
    self.MyView2.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createPieView1
{
    //设置图内饼的颜色，饼对应的百分比和饼内外的描述
    
//   NSString * str =  [self positiveFormat:self.yuelab.text];
    CGFloat one = [[self positiveFormat:self.yuelab.text] floatValue];
    CGFloat two = [[self positiveFormat:self.dongjielab.text] floatValue];
    CGFloat three = [[self positiveFormat:self.benjinlab.text] floatValue];
    CGFloat four = [[self positiveFormat:self.lixilab.text] floatValue];
    CGFloat five = [[self positiveFormat:self.shenglibaolab.text] floatValue];
    
    CGFloat sum = (one +two +three +four +five);
  //  19307   22 67 9 0.4
    if (one==0) {
        one = 0;
    }else{
    one = one/sum *100;
    }
    if (two==0) {
        two = 0;
    }else{
        two = two/sum *100;
    }
    if (three==0) {
        three = 0;
    }else{
        three = three/sum *100;
    }
    if (four==0) {
        four = 0;
    }else{
        four = four/sum *100;
    }
    if (five==0) {
        five = 0;
    }else{
        five = five/sum *100;
    }
    
    if (one==0&&two==0&&three==0&&four==0&&five==0) {
        one = 25;
        two = 25;
        three = 25;
        four = 25;
        five = 0;
    }
    NSArray *items = @[[PNPieChartDataItem dataItemWithValue:one color:[RHUtility colorForHex:@"#09aeb0"] description:@
                        ""],
                       [PNPieChartDataItem dataItemWithValue:0.1 color:[UIColor whiteColor] description:@
                        ""],
                       [PNPieChartDataItem dataItemWithValue:two color:[RHUtility colorForHex:@"#f7cd5f"] description:@""],
                       [PNPieChartDataItem dataItemWithValue:0.1 color:[UIColor whiteColor] description:@
                        ""],
                       [PNPieChartDataItem dataItemWithValue:three color:[RHUtility colorForHex:@"#43c38b"] description:@""],
                       [PNPieChartDataItem dataItemWithValue:0.1 color:[UIColor whiteColor] description:@
                        ""],
                       [PNPieChartDataItem dataItemWithValue:four color:[RHUtility colorForHex:@"#d3b588"] description:@""],
                       [PNPieChartDataItem dataItemWithValue:0.1 color:[UIColor whiteColor] description:@
                        ""],
                       [PNPieChartDataItem dataItemWithValue:five color:[RHUtility colorForHex:@"#75baea"] description:@""],
                       [PNPieChartDataItem dataItemWithValue:0.1 color:[UIColor whiteColor] description:@
                        ""]
                       ];
    CGFloat a ;
    CGFloat b = [UIScreen mainScreen].bounds.size.width;
    if ([UIScreen mainScreen].bounds.size.width<321) {
        a = 70;
    }else if ([UIScreen mainScreen].bounds.size.width>321&&[UIScreen mainScreen].bounds.size.width<378){
        a = 80;
    }else{
        a = 90;
    }
    self.pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(a, 23, b-a-a, b-a-a) items:items];
    
    self.moneylab = [[UILabel alloc]initWithFrame:CGRectMake(a +27, (b-a-a)/2+25-30-2, (b-a-a)-54, 60)];
//    self.moneylab.backgroundColor = [UIColor redColor];
    self.moneylab.text = self.moneystr;
    self.moneylab.textAlignment = NSTextAlignmentCenter;
    self.moneylab.font = [UIFont systemFontOfSize:22];
    [self.MyView1 addSubview:self.moneylab];
    UILabel * zichanglab =[[UILabel alloc]initWithFrame:CGRectMake(a+27, CGRectGetMaxY(self.moneylab.frame)-10, (b-a-a)-54, 20)];
    zichanglab.text = @"总资产(元)";
    zichanglab.textAlignment = NSTextAlignmentCenter;
    zichanglab.textColor = [RHUtility colorForHex:@"#bcbcbc"];
    zichanglab.font = [UIFont systemFontOfSize:15];
    [self.MyView1 addSubview:zichanglab];
    UIButton * btn = [[UIButton alloc]init];
    btn.frame = CGRectMake( b/2 + 40, CGRectGetMaxY(self.moneylab.frame)-9, 18, 18);
    [btn setImage:[UIImage imageNamed:@"PNG_问号.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(didshuoming) forControlEvents:UIControlEventTouchUpInside];
    
    [self.MyView1 addSubview:btn];
    //背景色
//    self.pieChart.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.2];
    //图内描述文字颜色
    self.pieChart.descriptionTextColor = [UIColor redColor];
    //图内文字字体大小
    self.pieChart.descriptionTextFont  = [UIFont fontWithName:@"Avenir-Medium" size:0.0];
    //饼内文字阴影颜色
    self.pieChart.descriptionTextShadowColor = [UIColor blueColor];
    //饼内是否不显示 %
    self.pieChart.showAbsoluteValues = YES;
    //是否饼图内只显示数值不显示文字
    self.pieChart.showOnlyValues = YES;
    
    //设置饼半径及粗细
    self.pieChart.outerCircleRadius = CGRectGetWidth(self.pieChart.bounds) / 2;//外圈大半径
    self.pieChart.innerCircleRadius = CGRectGetWidth(self.pieChart.bounds) / 2 - 25;//内圈小半径
    
    //显示
    [self.pieChart strokeChart];
    
    self.pieChart.legendStyle = PNLegendItemStyleStacked;
    //底部提示框文字字体大小
    self.pieChart.legendFont = [UIFont boldSystemFontOfSize:12.0f];
    
    //文字描述的view
    //参数：限制最大宽度，满了自动换行
    UIView *legend = [self.pieChart getLegendWithMaxWidth:100];
    [legend setFrame:CGRectMake(270 , 50, 110.0, 200.0)];
    legend.backgroundColor = [UIColor blueColor];
    self.pieChart.userInteractionEnabled = NO;
    //设置父视图
    //    [self.view addSubview:legend];
    [self.MyView1 addSubview:self.pieChart];
//    self.MyView2.hidden = YES;
    
   
}
-(void)didshuoming{
    
    UIAlertView* alertView=[[UIAlertView alloc]initWithTitle:@"总资产增加说明："
                                                    message:@"进行充值、出借、回款、提现等交易时，平台与银行的交易传输时段或导致总资产短时间显示波动，等平台接收交易返回后显示正确总资产金额"
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles: nil];
    alertView.tag=2029;
    [alertView show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
       
        if (alertView.tag==2019) {
          
        }
    }
}
- (IBAction)zongzichan:(id)sender {
    self.MyView2.hidden = YES;
    self.MyView1.hidden = NO;
    self.SyButton.backgroundColor = [RHUtility colorForHex:@"#efefef"];
    self.MoneyButton.backgroundColor = [UIColor whiteColor];
     [self.MoneyButton setTitleColor:[RHUtility colorForHex:@"#40bac0"] forState:UIControlStateNormal];
     [self.SyButton setTitleColor:[RHUtility colorForHex:@"#707070"] forState:UIControlStateNormal];
}
- (IBAction)shouyi:(id)sender {
    self.MyView1.hidden = YES;
    self.MyView2.hidden = NO;
    self.SyButton.backgroundColor = [UIColor whiteColor];
    self.MoneyButton.backgroundColor = [RHUtility colorForHex:@"#efefef"];
     [self.MoneyButton setTitleColor:[RHUtility colorForHex:@"#707070"] forState:UIControlStateNormal];
     [self.SyButton setTitleColor:[RHUtility colorForHex:@"#40bac0"] forState:UIControlStateNormal];
}
-(void)getdata{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[RHNetworkService instance] POST:@"app/front/payment/appJxAccount/appMyAssetOverview" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            [self setdatato:responseObject];
            
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        DLog(@"%@",[[NSString alloc] initWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
        
        
    }];
    
//    NSDictionary* parameters=@{@"requestUserId":[RHUserManager sharedInterface].userId};
//    NSString * str = @"https://60.205.154.45/";
    
        NSString * str = [RHNetworkService instance].newdoMain;
    AFHTTPRequestOperationManager* manager=[AFHTTPRequestOperationManager manager];
    
    manager.securityPolicy = [[RHNetworkService instance] customSecurityPolicy];
    [manager.operationQueue cancelAllOperations];
    
    
    [manager.securityPolicy setAllowInvalidCertificates:YES];
    
    [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    
    NSString* session=[[NSUserDefaults standardUserDefaults] objectForKey:@"RHSESSION"];
    NSLog(@"------------------%@",session);
    NSString* session1=[[NSUserDefaults standardUserDefaults] objectForKey:@"RHNEWMYSESSION"];
    
    if (session1.length>12) {
        session = [NSString stringWithFormat:@"%@,%@",session,session1];
    }
    if (session&&[session length]>0) {
        [manager.requestSerializer setValue:session forHTTPHeaderField:@"cookie"];
    }
    
    [manager POST:[NSString stringWithFormat:@"%@ryhuiBoot/app/front/account/userIncomesCurrent6",str]parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
    
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
   
            if (responseObject[@"nowShould"]&&![responseObject[@"nowShould"] isKindOfClass:[NSNull class]]) {
                self.bybxlab.text = [NSString stringWithFormat:@"%@",responseObject[@"nowShould"]];
            }
            NSArray * array = [NSArray array];
            array = responseObject[@"months"];
            self.keyArray = [NSMutableArray arrayWithArray:array];
            self.keystring = responseObject[@"maxInterest"];
            for (NSString * str  in array) {
                
                if (responseObject[@"interests"][str] && ![responseObject[@"interests"][str] isKindOfClass:[NSNull class]]) {
                    [self.moneyArray addObject:responseObject[@"interests"][str]];
                }
                
            }
             [self CreatSecondView];
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if ([error.userInfo.allKeys containsObject:@"com.alamofire.serialization.response.error.data"]) {
            NSDictionary* errorDic=[NSJSONSerialization JSONObjectWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] options:NSJSONReadingMutableContainers error:nil];
            if ([errorDic objectForKey:@"msg"]) {
               
                [RHUtility showTextWithText:[errorDic objectForKey:@"msg"]];
            }
        }
        
        
    }];
    
    
}

- (void)setdatato:(NSDictionary *)dic{
   
    if (dic[@"total"]&&![dic[@"total"] isKindOfClass:[NSNull class]]) {
        self.moneystr = [NSString stringWithFormat:@"%@",dic[@"total"]];
//        self.smallzzc.text = [NSString stringWithFormat:@"%@",dic[@"total"]];
    }
    if (dic[@"earnedInRYH"]&&![dic[@"earnedInRYH"] isKindOfClass:[NSNull class]]) {
//        self.zongshouyilab.text = [NSString stringWithFormat:@"%@",dic[@"earnedInRYH"]];
//        self.smallzsy.text = [NSString stringWithFormat:@"%@",dic[@"earnedInRYH"]];
        //        self.smallzsy.text = dic[@"earnedInRYH"];
    }
    
        self.leijilab.text = dic[@"earnedInRYH"];
    self.yuelab.text = dic[@"AvlBal"];
    self.dongjielab.text = dic[@"FrzBal"];
    self.benjinlab.text = dic[@"collectCapital"];
    self.lixilab.text = dic[@"collectInterest"];
    self.yzlxlab.text = dic[@"earnInterest"];
    self.tzxjlab.text = dic[@"insteadCash"];
    self.flxjlab.text = dic[@"rebateCash"];
    self.shenglibaolab.text = dic[@"totalAsset"];
    self.slbsylab.text = dic[@"currentInterest"];
     [self createPieView1];
    
}
-(NSString *)positiveFormat:(NSString *)text{
    
//    if(!text || [text floatValue] == 0){
//        return @"0.00";
//    }else{
//        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
//        
////        [numberFormatter setPositiveFormat:@".00;"];
//        return [numberFormatter stringFromNumber:[NSNumber numberWithDouble:[text doubleValue]]];
//    }
//    return @"";
    NSString *strUrl = [text stringByReplacingOccurrencesOfString:@"," withString:@""];
    return strUrl;
    
}

-(void)CreatSecondView{
    if (self.keyArray.count<6) {
        return;
    }
    if (self.moneyArray.count<6) {
        return;
    }
    if ([UIScreen mainScreen].bounds.size.width < 321){
        
        
        self.ScrollView.contentSize =  CGSizeMake([UIScreen mainScreen].bounds.size.width,550);
    }
    //是否显示滚动条
    NSLog(@"%f",[UIScreen mainScreen].bounds.size.height);
    self.ScrollView .showsHorizontalScrollIndicator =NO ;
    
    
    CGFloat with = [UIScreen mainScreen].bounds.size.width*(330.0/375.0);
    SHLineGraphView *_lineGraph = [[SHLineGraphView alloc] initWithFrame:CGRectMake(10, 370, with, 160)];
    
    //set the main graph area theme attributes
    
    /**
     *  theme attributes dictionary. you can specify graph theme releated attributes in this dictionary. if this property is
     *  nil, then a default theme setting is applied to the graph.
     */
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
    NSDictionary *_themeAttributes = @{
                                       //月
                                       kXAxisLabelColorKey : [RHUtility colorForHex:@"#bcbcbc"],
                                       kXAxisLabelFontKey : [UIFont fontWithName:@"TrebuchetMS" size:14],
                                       //万
                                       kYAxisLabelColorKey : [RHUtility colorForHex:@"#bcbcbc"],
                                       kYAxisLabelFontKey : [UIFont fontWithName:@"TrebuchetMS" size:14],
                                       kYAxisLabelSideMarginsKey : @20,
                                       //线
                                       kPlotBackgroundLineColorKey : [RHUtility colorForHex:@"#efefef"],
                                       kDotSizeKey : @6
                                       };
    _lineGraph.themeAttributes = _themeAttributes;
    
    //set the line graph attributes
    
    /**
     *  the maximum y-value possible in the graph. make sure that the y-value is not in the plotting points is not greater
     *  then this number. otherwise the graph plotting will show wrong results.
     */
//    CGFloat max = [self.keystring floatValue];
//    _lineGraph.yAxisRange = @(max*1.3+10);
    
//    NSString * ssss = @"232A32";
    NSArray *array = [self.keystring componentsSeparatedByString:@"."];
    
    NSString * maxstr = [NSString stringWithFormat:@"%@",array[0]];
    
     NSString * str = [maxstr substringToIndex:1];//截取掉下标2之前的字符串
    
    CGFloat ma = [str floatValue];
    ma = ma+1;
    for (int i = 1; i < maxstr.length; i++) {
        ma = ma * 10;
    }
    
    if (ma<5) {
        ma = 5;
    }
    _lineGraph.yAxisRange = @(ma);
//    NSRange range = [ssss rangeOfString:@"&my_type=\""];
//    NSString *subStr = [ssss substringToIndex:range.location];
//    NSLog(@"%@",subStr);
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
    
    if ([UIScreen mainScreen].bounds.size.width > 321) {
        _lineGraph.xAxisValues = @[
                                   @{ @1 : [NSString stringWithFormat:@"     %@月",self.keyArray[5]] },
                                   @{ @2 : [NSString stringWithFormat:@"     %@月",self.keyArray[4]] },
                                   @{ @3 : [NSString stringWithFormat:@"     %@月",self.keyArray[3]] },
                                   @{ @4 : [NSString stringWithFormat:@"     %@月",self.keyArray[2]] },
                                   @{ @5 : [NSString stringWithFormat:@"     %@月",self.keyArray[1]] },
                                   @{ @6 : [NSString stringWithFormat:@"     %@月",self.keyArray[0]] },
                                   ];
    }else{
        _lineGraph.xAxisValues = @[
                                   @{ @1 : [NSString stringWithFormat:@"   %@月",self.keyArray[5]] },
                                   @{ @2 : [NSString stringWithFormat:@"   %@月",self.keyArray[4]] },
                                   @{ @3 : [NSString stringWithFormat:@"   %@月",self.keyArray[3]] },
                                   @{ @4 : [NSString stringWithFormat:@"   %@月",self.keyArray[2]] },
                                   @{ @5 : [NSString stringWithFormat:@"   %@月",self.keyArray[1]] },
                                   @{ @6 : [NSString stringWithFormat:@"   %@月",self.keyArray[0]] },
                                   ];
    }
   
    
    //create a new plot object that you want to draw on the `_lineGraph`
    SHPlot *_plot1 = [[SHPlot alloc] init];
    
    //set the plot attributes
    
    /**
     *  Array of dictionaries, where the key is the same as the one which you specified in the `xAxisValues` in `SHLineGraphView`,
     *  the value is the number which will determine the point location along the y-axis line. make sure the values are not
     *  greater than the `yAxisRange` specified in `SHLineGraphView`.
     */
    
    
    _plot1.plottingValues = @[
                              @{ @1 : self.moneyArray[5] },
                              @{ @2 : self.moneyArray[4] },
                              @{ @3 : self.moneyArray[3] },
                              @{ @4 : self.moneyArray[2] },
                              @{ @5 : self.moneyArray[1] },
                              @{ @6 : self.moneyArray[0] },
                              ];
//    self.bybxlab.text = [NSString stringWithFormat:@"%@元",self.moneyArray[0]];
    
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
    
    NSDictionary *_plotThemeAttributes = @{
                                           //mengban
                                           kPlotFillColorKey : [UIColor colorWithRed:0.9 green:0.75 blue:0.78 alpha:0],
                                           kPlotStrokeWidthKey : @2,
                                           //中间线
                                           kPlotStrokeColorKey : [RHUtility colorForHex:@"#09aeb0"],
                                           //点
                                           kPlotPointFillColorKey : [RHUtility colorForHex:@"#09aeb0"],
                                           kPlotPointValueFontKey : [UIFont fontWithName:@"TrebuchetMS" size:18]
                                           };
    
    _plot1.plotThemeAttributes = _plotThemeAttributes;
    [_lineGraph addPlot:_plot1];
    
    //You can as much `SHPlots` as you can in a `SHLineGraphView`
    
    [_lineGraph setupTheView];
    
    [self.ScrollView addSubview:_lineGraph];
    
    UIImageView * aimageview = [[UIImageView alloc]init];
    aimageview.frame = _lineGraph.frame;
    UILabel * mylab = [[UILabel alloc]init];
    mylab.frame = CGRectMake(CGRectGetMinX(_lineGraph.frame), CGRectGetMinY(_lineGraph.frame), [UIScreen mainScreen].bounds.size.width, _lineGraph.frame.size.height+100);
    
    mylab.backgroundColor = [UIColor clearColor];
//    aimageview.backgroundColor = [UIColor redColor];
    [self.ScrollView addSubview:aimageview];
    [self.ScrollView addSubview:mylab];

    
}

@end
