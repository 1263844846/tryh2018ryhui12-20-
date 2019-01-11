//
//  RHHelpCenterViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 16/5/4.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import "RHHelpCenterViewController.h"
#import "RHMoreWebViewViewController.h"
#import "RHHelperCollectionViewCell.h"

@interface RHHelpCenterViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collection;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *laoutcollec;
@property(nonatomic,strong)NSMutableArray *urlArray;
@end

@implementation RHHelpCenterViewController

-(NSMutableArray *)dataArray{
    
    if (!_dataArray ) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
-(NSMutableArray *)urlArray{
    
    if (!_urlArray ) {
        _urlArray = [NSMutableArray array];
    }
    return _urlArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
    
    
    [self.dataArray addObject:@"关于融益汇"];
    [self.dataArray addObject:@"益友须知"];
    [self.dataArray addObject:@"登录注册"];
    [self.dataArray addObject:@"资金托管"];
    [self.dataArray addObject:@"充   值"];
    [self.dataArray addObject:@"提   现"];
    [self.dataArray addObject:@"收益费用"];
    [self.dataArray addObject:@"红包返现"];
//    [self.dataArray addObject:@"安全保障"];
    [self.dataArray addObject:@"名词解释"];
    [self.dataArray addObject:@"收益计算器"];
    [self.dataArray addObject:@" "];
    [self.dataArray addObject:@" "];
    
    
    
    
    [self.urlArray addObject:@"http://www.ryhui.com/common/helpCenterView/newHelpQuery?type=platform"];
    [self.urlArray addObject:@"http://www.ryhui.com/common/helpCenterView/newHelpQuery?type=invest"];
    [self.urlArray addObject:@"http://www.ryhui.com/common/helpCenterView/newHelpQuery?type=login"];
    [self.urlArray addObject:@"http://www.ryhui.com/common/helpCenterView/newHelpQuery?type=custody"];
    [self.urlArray addObject:@"http://www.ryhui.com/common/helpCenterView/newHelpQuery?type=recharge"];
    [self.urlArray addObject:@"http://www.ryhui.com/common/helpCenterView/newHelpQuery?type=cash"];
    [self.urlArray addObject:@"http://www.ryhui.com/common/helpCenterView/newHelpQuery?type=income"];
    [self.urlArray addObject:@"http://www.ryhui.com/common/helpCenterView/newHelpQuery?type=gift"];
//    [self.urlArray addObject:@"http://www.ryhui.com/common/helpCenterView/newHelpQuery?type=safety"];
    [self.urlArray addObject:@"http://www.ryhui.com/common/helpCenterView/newHelpQuery?type=glossary"];
    [self.urlArray addObject:@"http://www.ryhui.com/common/helpCenterView/helpCalcula"];
    
    
    
    [self configBackBut];
    [self configTitleWithString:@"帮助中心"];
    self.laoutcollec.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width/3, 75);
   
    self.collection.showsHorizontalScrollIndicator = NO;
    self.collection.showsVerticalScrollIndicator = NO;
    self.collection.backgroundColor = [UIColor whiteColor];
    self.collection.bounces = NO;
    self.collection.delegate = self;
    self.collection.dataSource = self;
//    [self.collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"collcellid"];
//    [self.collection registerNib:[UINib nibWithNibName:@"RHHelperCollectionViewCell" bundle:nil] forSupplementaryViewOfKind:nil withReuseIdentifier:@"collcellid"];
    [self.collection registerNib:[UINib nibWithNibName:@"RHHelperCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"collcellid"];
}
- (void)configBackBut
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
-(void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=NO;
    [self.navigationController.navigationBar setBarTintColor:[RHUtility colorForHex:@"#44bbc1"]];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    //UIImageView * cbximage = [[UIImageView alloc]init];
    //cbximage.backgroundColor = [RHUtility colorForHex:@"#44bbc1"];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    self.navigationController.navigationBar.translucent = NO;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    //titleLabel.backgroundColor = [UIColor grayColor];
    
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    
    titleLabel.textColor = [UIColor whiteColor];
    
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    
    titleLabel.text = @"帮助中心";
    
    
    self.navigationItem.titleView = titleLabel;

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    self.navigationController.navigationBar.hidden=NO;
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    //self.abtn.frame = self.btn.frame;
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
//    return 21;
    return self.dataArray.count;
}




-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    RHHelperCollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"collcellid" forIndexPath:indexPath];
    
//    cell.backgroundColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    [cell update:self.dataArray[indexPath.row]];
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.row == self.dataArray.count-1||indexPath.row == self.dataArray.count-2) {
        NSLog(@"sykztshxct");
        return;
    }
    RHMoreWebViewViewController * vc = [[RHMoreWebViewViewController alloc]initWithNibName:@"RHMoreWebViewViewController" bundle:nil];
    vc.namestr = self.dataArray[indexPath.row];
    vc.urlstr = self.urlArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
   
    NSLog(@"%ld",(long)indexPath.row);
}

- (IBAction)punshnew:(id)sender {
    
    RHMoreWebViewViewController * vc = [[RHMoreWebViewViewController alloc]initWithNibName:@"RHMoreWebViewViewController" bundle:nil];
    
    [self.navigationController pushViewController:vc animated:YES];
}



- (IBAction)project:(id)sender {
    
    NSLog(@"产品介绍");
    
}


- (IBAction)registandlogin:(id)sender {
    NSLog(@"注册／登录");
}


- (IBAction)tuoguan:(id)sender {
    NSLog(@"托管开户");
}


- (IBAction)chongzhi:(id)sender {
    
    NSLog(@"充值");
}


- (IBAction)tixian:(id)sender {
    
    NSLog(@"提现");
}


- (IBAction)touzi:(id)sender {
    
    NSLog(@"投资");
}


- (IBAction)zhaiquanzhuanrang:(id)sender {
    
    NSLog(@"拽权转让");
}


- (IBAction)shouyi:(id)sender {
    
    NSLog(@"收费／费用");
}


- (IBAction)hongbaofanxian:(id)sender {
    
    NSLog(@"红包返现");
}


- (IBAction)mingcijieshi:(id)sender {
    
    NSLog(@"名词解释");
}

@end
