//
//  RHAboutViewController.m
//  ryhui
//
//  Created by stefan on 15/3/15.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHAboutViewController.h"
#import "RHOfficeNetAndWeiBoViewController.h"
#import "MBProgressHUD.h"
@interface RHAboutViewController ()

@property (weak, nonatomic) IBOutlet UILabel *officalNetLabel;
@property (weak, nonatomic) IBOutlet UILabel *officalWeiBoLabel;
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;
@property (weak, nonatomic) IBOutlet UILabel *versionlab;


@property (weak, nonatomic) IBOutlet UIImageView *erwweimaimage;


@property(nonatomic,strong)UILongPressGestureRecognizer *tap;
@property(nonatomic,strong)NSTimer * timer;
@end

@implementation RHAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self configBackButton];
//    [self configTitleWithString:@"关于"];
    
    NSDictionary *attributes = @{NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *netString = [[NSMutableAttributedString alloc] initWithString:_officalNetLabel.text];
    [netString addAttributes:attributes range:NSMakeRange(0, netString.length)];
    _officalNetLabel.attributedText = netString;
    
    NSMutableAttributedString *weiBoString = [[NSMutableAttributedString alloc] initWithString:_officalWeiBoLabel.text];
    [weiBoString addAttributes:attributes range:NSMakeRange(0, weiBoString.length)];
    _officalWeiBoLabel.attributedText = weiBoString;
    
    self.versionlab.text = [NSString stringWithFormat:@"版本：V%@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    //titleLabel.backgroundColor = [UIColor grayColor];
    
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    
    titleLabel.textColor = [UIColor whiteColor];
    
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    
    
    titleLabel.text = @"关于";
    self.navigationItem.titleView = titleLabel;
    
    self.tap = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(dealLongPress:)];
    self.erwweimaimage.userInteractionEnabled = YES;
   // [self.erwweimaimage addGestureRecognizer:self.tap];
    
}

-(void)viewWillAppear:(BOOL)animated
{
//    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=NO;
    
    [[RHNetworkService instance] POST:@"front/payment/account/countUnReadMessage" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        DLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSString* numStr=nil;
            if (![[responseObject objectForKey:@"msgCount"] isKindOfClass:[NSNull class]]) {
                if ([[responseObject objectForKey:@"msgCount"] isKindOfClass:[NSNumber class]]) {
                    numStr=[[responseObject objectForKey:@"msgCount"] stringValue];
                }else{
                    numStr=[responseObject objectForKey:@"msgCount"];
                }
            }
            if (numStr) {
                [[NSUserDefaults standardUserDefaults] setObject:numStr forKey:@"RHMessageNumSave"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"RHMessageNum" object:numStr];
            }
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBarTintColor:[RHUtility colorForHex:@"#44bbc1"]];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    //UIImageView * cbximage = [[UIImageView alloc]init];
    //cbximage.backgroundColor = [RHUtility colorForHex:@"#44bbc1"];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    self.navigationController.navigationBar.translucent = NO;
    [self toback];
}

- (void)toback
{
    UIButton* button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    //    UIImage * image = [UIImage imageNamed:@"back.png"];
    
    NSString *version = [UIDevice currentDevice].systemVersion;
    if ([version doubleValue]>=11) {
        UIImage *theImage = [self imageWithImageSimple:[UIImage imageNamed:@"back1.png"] scaledToSize:CGSizeMake(11, 17)];
        // [self imageWithImageSimple:imageview1.image scaledToSize:CGSizeMake(12, 12)];
        
        //NSData * imageData = UIImageJPEGRepresentation(imageview1.image, 0.1);
        [button setImage:theImage forState:UIControlStateNormal];
    }else{
        [button setImage:[UIImage imageNamed:@"back1.png"] forState:UIControlStateNormal];
    }
    
    
    button.frame=CGRectMake(0, 0, 11, 17);
    
    // button.backgroundColor = [UIColor colorWithHexString:@"44bbc1"];
    self.navigationItem.leftBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:button];
}
- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize {
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
}

#pragma mark 保存图片到document
- (void)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName {
    NSData* imageData = UIImagePNGRepresentation(tempImage);
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    // Now we get the full path to the file
    NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:imageName];
    // and then we write it out
    [imageData writeToFile:fullPathToFile atomically:NO];
}

#pragma mark 从文档目录下获取Documents路径
- (NSString *)documentFolderPath {
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
}
- (void)back{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden=YES;
}


- (IBAction)pushMain:(id)sender {
    [[[RHTabbarManager sharedInterface] selectTabbarMain] popToRootViewControllerAnimated:NO];
}

- (IBAction)pushUser:(id)sender {
    [[[RHTabbarManager sharedInterface] selectTabbarUser] popToRootViewControllerAnimated:NO];
}

- (IBAction)pushMore:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    UITouch *touch = [touches anyObject];
//    CGPoint touchPoint = [touch locationInView:self.view];
//
//    if (CGRectContainsPoint(_officalNetLabel.frame, touchPoint)) {
//        _officalNetLabel.textColor = [UIColor blueColor];
//    }
//    if (CGRectContainsPoint(_officalWeiBoLabel.frame, touchPoint)) {
//        _officalWeiBoLabel.textColor = [UIColor blueColor];
//    }
//}

//-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    UITouch *touch = [touches anyObject];
//    CGPoint touchPoint = [touch locationInView:self.view];
//    
//    RHOfficeNetAndWeiBoViewController *officeVc = [[RHOfficeNetAndWeiBoViewController alloc] initWithNibName:@"RHOfficeNetAndWeiBoViewController" bundle:nil];
//    
//    int type;
//    NSString *urlString;
//    if (CGRectContainsPoint(_officalNetLabel.frame, touchPoint)) {
//        type = 0;
//        _officalNetLabel.textColor = [UIColor colorWithRed:36.0/255 green:108.0/255 blue:161.0/255 alpha:1.0];
//        urlString = [NSString stringWithFormat:@"http://%@",_officalNetLabel.text];
//        [self.navigationController pushViewController:officeVc animated:YES];
//    }
//    if (CGRectContainsPoint(_officalWeiBoLabel.frame, touchPoint)) {
//        type = 1;
//        _officalWeiBoLabel.textColor = [UIColor colorWithRed:36.0/255 green:108.0/255 blue:161.0/255 alpha:1.0];
//        urlString =  _officalWeiBoLabel.text;
//        [self.navigationController pushViewController:officeVc animated:YES];
//    }
//    officeVc.Type = type;
//    officeVc.urlString = urlString;
//}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    _officalNetLabel.textColor = [UIColor colorWithRed:36.0/255 green:108.0/255 blue:161.0/255 alpha:1.0];
    _officalWeiBoLabel.textColor = [UIColor colorWithRed:36.0/255 green:108.0/255 blue:161.0/255 alpha:1.0];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.view];
    
    if (!CGRectContainsPoint(_officalNetLabel.frame, touchPoint)) {
        _officalNetLabel.textColor = [UIColor colorWithRed:36.0/255 green:108.0/255 blue:161.0/255 alpha:1.0];
    }
    if (!CGRectContainsPoint(_officalWeiBoLabel.frame, touchPoint)) {
        _officalWeiBoLabel.textColor = [UIColor colorWithRed:36.0/255 green:108.0/255 blue:161.0/255 alpha:1.0];
    }
}
- (IBAction)weibo:(id)sender {
    
    RHOfficeNetAndWeiBoViewController *officeVc = [[RHOfficeNetAndWeiBoViewController alloc] initWithNibName:@"RHOfficeNetAndWeiBoViewController" bundle:nil];
    
//    int type;
    NSString *urlString;
//    if (CGRectContainsPoint(_officalNetLabel.frame, touchPoint)) {
//        type = 0;
//        _officalNetLabel.textColor = [UIColor colorWithRed:36.0/255 green:108.0/255 blue:161.0/255 alpha:1.0];
        urlString = [NSString stringWithFormat:@"https://%@",_officalNetLabel.text];
//        [self.navigationController pushViewController:officeVc animated:YES];
//    }
//    if (CGRectContainsPoint(_officalWeiBoLabel.frame, touchPoint)) {
//        type = 1;
//        _officalWeiBoLabel.textColor = [UIColor colorWithRed:36.0/255 green:108.0/255 blue:161.0/255 alpha:1.0];
        urlString =  _officalWeiBoLabel.text;
        [self.navigationController pushViewController:officeVc animated:YES];
//    }
    officeVc.Type = 1;
    officeVc.urlString = urlString;
}
- (IBAction)guanwang:(id)sender {
    
    RHOfficeNetAndWeiBoViewController *officeVc = [[RHOfficeNetAndWeiBoViewController alloc] initWithNibName:@"RHOfficeNetAndWeiBoViewController" bundle:nil];
    
    //    int type;
    NSString *urlString;
    //    if (CGRectContainsPoint(_officalNetLabel.frame, touchPoint)) {
    //        type = 0;
    //        _officalNetLabel.textColor = [UIColor colorWithRed:36.0/255 green:108.0/255 blue:161.0/255 alpha:1.0];
    urlString = [NSString stringWithFormat:@"https://%@",_officalNetLabel.text];
    //        [self.navigationController pushViewController:officeVc animated:YES];
    //    }
    //    if (CGRectContainsPoint(_officalWeiBoLabel.frame, touchPoint)) {
    //        type = 1;
    //        _officalWeiBoLabel.textColor = [UIColor colorWithRed:36.0/255 green:108.0/255 blue:161.0/255 alpha:1.0];
//    urlString =  _officalWeiBoLabel.text;
    [self.navigationController pushViewController:officeVc animated:YES];
    //    }
    officeVc.Type = 0;
    officeVc.urlString = urlString;
}

- (IBAction)getappstore:(id)sender {
    NSString *str = [NSString stringWithFormat:
                     @"itms-apps://itunes.apple.com/app/id977505438"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
}

-(void)dealLongPress:(UIGestureRecognizer*)gesture{
    
    if(self.tap.state==UIGestureRecognizerStateBegan){
        
        _timer.fireDate=[NSDate distantFuture];
        
        UIImageView*tempImageView=self.erwweimaimage;
        if(tempImageView.image){
            //1. 初始化扫描仪，设置设别类型和识别质量
            CIDetector*detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{ CIDetectorAccuracy : CIDetectorAccuracyHigh }];
            //2. 扫描获取的特征组
            NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:tempImageView.image.CGImage]];
            //3. 获取扫描结果
            CIQRCodeFeature *feature = [features objectAtIndex:0];
            NSString *scannedResult = feature.messageString;
            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"扫描结果" message:scannedResult delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }else {
            
            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"扫描结果" message:@"您还没有生成二维码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }
        
        
    }else if (self.tap.state==UIGestureRecognizerStateEnded){
        
        
        _timer.fireDate=[NSDate distantPast];
    }
    
    
}

@end
