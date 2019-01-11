//
//  RHFeedbackViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 16/6/21.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import "RHFeedbackViewController.h"
#import "RHTextVIew.h"
@interface RHFeedbackViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phonelab;

@property(nonatomic,strong)RHTextVIew * textView;
@end

@implementation RHFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self settextfild];
//    [self configTitleWithString:@"意见反馈"];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    //titleLabel.backgroundColor = [UIColor grayColor];
    
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    
    titleLabel.textColor = [UIColor whiteColor];
    
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    
    
    titleLabel.text = @"意见反馈";
    self.navigationItem.titleView = titleLabel;
//    [self configBackButton];
   
    self.phonelab.delegate = self;
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.textView resignFirstResponder];
    [self.phonelab resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
    
}

- (void)settextfild{
    
    self.textView=[[RHTextVIew alloc]initWithFrame:CGRectMake(15, CGRectGetMinY(self.view.frame)+15, [UIScreen mainScreen].bounds.size.width-30, 180)];
    self.textView.placeholder=@"温馨提示：\n如您对融益汇有优化建议或新功能需求，请在此提交；如您使用中遇到问题，请联系在线客服或拨打400-010-4001，我们将尽快为您解决。";
    self.textView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.textView.layer.borderWidth=1.0;
    self.textView.scrollEnabled = YES;
//    self.textView.autoresizingMask =
//    UIViewAutoresizingFlexibleHeight; //自适应高度
    self.textView.returnKeyType = UIReturnKeyDefault; //返回键的类型
    
    self.textView.keyboardType = UIKeyboardTypeDefault; //键盘类型
    
    
    [self.view addSubview:self.textView];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden=YES;
}
-(void)viewWillAppear:(BOOL)animated{
    
//    [super viewWillAppear:animated];
     self.navigationController.navigationBar.hidden=NO;
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

    

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)yijianfankuibtn:(id)sender {
    
//    if (![RHUserManager sharedInterface].username) {
//        [RHUtility showTextWithText:@"请先登录"];
//        return;
//    }
    if (self.textView.text.length <12) {
        [RHUtility showTextWithText:@"请输入12字以上意见"];
        return;
    }
//    if (self.phonelab.text.length <11 || self.phonelab.text.length>12) {
//        [RHUtility showTextWithText:@"请输入正确手机号"];
//        return;
//    }
     NSDictionary* parameters=@{@"username":[NSString stringWithFormat:@"%@",[RHUserManager sharedInterface].username],@"suggestion":self.textView.text,@"phone":self.phonelab.text};
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    //    [manager.operationQueue cancelAllOperations];
    manager.securityPolicy = [[RHNetworkService instance] customSecurityPolicy];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    [manager POST:[NSString stringWithFormat:@"%@app/back/archives/appSuggest/saveSuggest",[RHNetworkService instance].newdoMain ] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        
        [RHUtility showTextWithText:@"提交成功，感谢您的宝贵建议"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
//        [RHUtility showTextWithText:@"您的意见我们会及时采纳"];
        NSLog(@"%@",error);
        ;
    }];
    
    NSLog(@"%@---dddbbbxxx---%@",self.textView.text,self.phonelab.text);
}

@end
