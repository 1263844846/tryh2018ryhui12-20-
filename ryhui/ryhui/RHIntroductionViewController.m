//
//  RHIntroductionViewController.m
//  ryhui
//
//  Created by jufenghudong on 15/4/14.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHIntroductionViewController.h"
#import "RHOfficeNetAndWeiBoViewController.h"
@interface RHIntroductionViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *officeNetLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *Scrolview;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation RHIntroductionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.webView.hidden = YES;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    //titleLabel.backgroundColor = [UIColor grayColor];
    
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    
    titleLabel.textColor = [UIColor whiteColor];
    
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    
    
    titleLabel.text = @"平台介绍";
    self.navigationItem.titleView = titleLabel;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@ryhPlatform",[RHNetworkService instance].newdoMain]];
    
    self.webView.scalesPageToFit =YES;
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url];
    
    
    NSString* session=[[NSUserDefaults standardUserDefaults] objectForKey:@"RHSESSION"];
    NSString* session1=[[NSUserDefaults standardUserDefaults] objectForKey:@"RHNEWMYSESSION"];
    
    if (session1.length>12) {
        session = [NSString stringWithFormat:@"%@,%@",session,session1];
    }
    if (session&&[session length]>0) {
        [request setValue:session forHTTPHeaderField:@"cookie"];
        
        
    }
    
    self.webView.scalesPageToFit = YES;
    //  [request setHTTPMethod:@"GET"];
    [self.webView loadRequest: request];
    
//    NSDictionary *attributes = @{NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]};
//    NSMutableAttributedString *netString = [[NSMutableAttributedString alloc] initWithString:_officeNetLabel.text];
//    [netString addAttributes:attributes range:NSMakeRange(0, netString.length)];
//    _officeNetLabel.attributedText = netString;
//    self.Scrolview.bounces = NO;
//    if ([UIScreen mainScreen].bounds.size.width >375) {
//        self.Scrolview.contentSize=CGSizeMake(320,1400);
//
//    }else if ([UIScreen mainScreen].bounds.size.width <321){
//
//        self.Scrolview.contentSize=CGSizeMake(320,1250);
//
//    }else{
//        self.Scrolview.contentSize=CGSizeMake(320,1350);
//
//    }
//
//    self.Scrolview.showsHorizontalScrollIndicator = NO;
//    self.Scrolview.showsVerticalScrollIndicator = NO;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=NO;
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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.view];
    
    if (CGRectContainsPoint(_officeNetLabel.frame, touchPoint)) {
        _officeNetLabel.textColor = [UIColor blueColor];
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.view];
    
    NSString *urlString;
    if (CGRectContainsPoint(_officeNetLabel.frame, touchPoint)) {
        _officeNetLabel.textColor = [UIColor colorWithRed:36.0/255 green:108.0/255 blue:161.0/255 alpha:1.0];
        urlString = [NSString stringWithFormat:@"http://%@",_officeNetLabel.text];
        RHOfficeNetAndWeiBoViewController *officeVc = [[RHOfficeNetAndWeiBoViewController alloc] initWithNibName:@"RHOfficeNetAndWeiBoViewController" bundle:nil];
        officeVc.Type = 0;
        officeVc.urlString = urlString;
        [self.navigationController pushViewController:officeVc animated:YES];
    }
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    _officeNetLabel.textColor = [UIColor colorWithRed:36.0/255 green:108.0/255 blue:161.0/255 alpha:1.0];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.view];
    
    if (!CGRectContainsPoint(_officeNetLabel.frame, touchPoint)) {
        _officeNetLabel.textColor = [UIColor colorWithRed:36.0/255 green:108.0/255 blue:161.0/255 alpha:1.0];
    }
}


@end
