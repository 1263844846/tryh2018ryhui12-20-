//
//  RHProjectDetailViewController.m
//  ryhui
//
//  Created by stefan on 15/3/14.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHProjectDetailViewController.h"
#import "RHALoginViewController.h"
#import "RHRegisterWebViewController.h"
#import <ShareSDK/ShareSDK.h>
#import "WXApi.h"
#import "WeiboSDK.h"
#import "AITableFooterVew.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
@interface RHProjectDetailViewController ()<UIScrollViewDelegate,UIAlertViewDelegate>
{
    int available;
    CGRect tempRect;
    int page;
    AITableFooterVew *footerView;
    BOOL isSegment2Click;
}
@property(nonatomic,strong)NSMutableArray* array1;
@property(nonatomic,strong)NSMutableArray* array2;
@property(nonatomic,strong)NSString* projectId;
@property (nonatomic,strong)NSMutableArray* dataArray;
@property (weak, nonatomic) IBOutlet UIButton *investmentButton;
@property (weak, nonatomic) IBOutlet UILabel *limitTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *investorRateLabel;
@property (weak, nonatomic) IBOutlet UILabel *insuranceMethodLabel;
@property (weak, nonatomic) IBOutlet UILabel *projectFundLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *paymentNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *availableLabel;
@property (weak, nonatomic) IBOutlet UIImageView *progressImageView;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *segment2ContentView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *footView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView1;
@property (weak, nonatomic) IBOutlet UILabel *projectDetail;
@property (weak, nonatomic) IBOutlet UIView *segmentView1;
@property (weak, nonatomic) IBOutlet UIView *segmentView2;
@property (strong, nonatomic) IBOutlet UIView *segmentView3;
@property (weak, nonatomic) IBOutlet UIScrollView *projectScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *insuranceScrollView;
@property (weak, nonatomic) IBOutlet UILabel *projectImageLabel1;
@property (weak, nonatomic) IBOutlet UILabel *projectImageLabel;
@property (weak, nonatomic) IBOutlet UILabel *studentNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *studentCityLabel;
@property (weak, nonatomic) IBOutlet UILabel *studentSchoolLabel;
@property (weak, nonatomic) IBOutlet UILabel *studentGenderLabel;
@property (weak, nonatomic) IBOutlet UILabel *studentNationLabel;
@property (weak, nonatomic) IBOutlet UILabel *studentProfessionLabel;
@property (weak, nonatomic) IBOutlet UILabel *studentAgeLabel;
@property (weak, nonatomic) IBOutlet UILabel *studentEducationLabel;
@property (weak, nonatomic) IBOutlet UILabel *partnerInfoLabel;

@end

@implementation RHProjectDetailViewController
@synthesize projectId;
@synthesize dataDic;
@synthesize dataArray;
@synthesize getType;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.dataArray=[[NSMutableArray alloc] initWithCapacity:0];
    
    page = 1 ;
    isSegment2Click = NO;
    [self configBackButton];
    [self setRightItemButton];
    [self configTitleWithString:@"项目详情"];
    
    [self setupWithDic:self.dataDic];
    
    [self projectInvestmentList];
    if ([getType isEqualToString:@"0"]) {
        [self appShangDetailData];
    }else{
        [self appXueDetailData];
    }
    
    self.array1=[[NSMutableArray alloc]initWithCapacity:0];
    self.array2=[[NSMutableArray alloc]initWithCapacity:0];
    
    self.scrollView.frame=CGRectMake(0, 35, self.segmentView1.frame.size.width, [UIScreen mainScreen].applicationFrame.size.height-self.navigationController.navigationBar.frame.size.height-280);
    
    self.scrollView.contentSize=CGSizeMake(self.segmentView1.frame.size.width,267);
    
    self.scrollView1.frame=CGRectMake(0, 35,self.segmentView1.frame.size.width, [UIScreen mainScreen].applicationFrame.size.height-self.navigationController.navigationBar.frame.size.height-280);
    
    self.scrollView1.contentSize=CGSizeMake(self.segmentView1.frame.size.width,267);
    
    footerView = [[AITableFooterVew alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width,50.0)];
    [footerView.footerButton addTarget:self action:@selector(showMoreInfomationForApp:) forControlEvents:UIControlEventTouchUpInside];
    [footerView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    self.tableView.tableFooterView = footerView;
    footerView.hidden = YES;
}

- (void)showMoreInfomationForApp:(UIButton *)btn {
    page ++;
    [self projectInvestmentList];
    footerView.hidden = NO;
    [footerView.activityIndicatorView startAnimating];
}

- (void)setRightItemButton {
    UIButton* button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(shareTheAppInfomation:) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[UIImage imageNamed:@"shareIcon.png"] forState:UIControlStateNormal];
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    button.frame=CGRectMake(0, 0, 21, 16);
    self.navigationItem.rightBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)shareTheAppInfomation:(UIButton *)btn {
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"GestureIcon" ofType:@"png"];
    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:@"全国唯一由国家级金融组织和国家级信息科技组织共同打造的互联网金融平台，投资理财“容易会”！http://www.ryhui.com" defaultContent:nil
                                                image:[ShareSDK imageWithPath:imagePath]
                                                title:@"权威专业的投资理财平台“融益汇”，快来下载客户端吧～"
                                                  url:@"http://www.ryhui.com/appDownload"
                                          description:nil
                                            mediaType:SSPublishContentMediaTypeNews | SSPublishContentMediaTypeText];
    //创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];
    [container setIPhoneContainerWithViewController:self];
    //弹出分享菜单
    [ShareSDK showShareActionSheet:container
                         shareList:nil
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions:nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                if (state == SSResponseStateSuccess) {
                                    if (type == ShareTypeWeixiFav) {
                                        [RHUtility showTextWithText:@"收藏成功!"];
                                    } else {
                                        [RHUtility showTextWithText:@"分享成功!"];
                                    }
                                } else if (state == SSResponseStateFail) {
                                    [RHUtility showTextWithText:[NSString stringWithFormat:@"%@",[error errorDescription]]];
                                }
                            }];

}

-(void)setupWithDic:(NSDictionary*)dic
{
    self.segmentView1.frame=CGRectMake(8, 170, [UIScreen mainScreen].bounds.size.width-16, [UIScreen mainScreen].applicationFrame.size.height-self.navigationController.navigationBar.frame.size.height-75);
    self.scrollView.frame=CGRectMake(0, 35, self.segmentView1.frame.size.width, self.segmentView1.frame.size.height-35);
    self.scrollView1.frame=CGRectMake(0, 35, self.segmentView1.frame.size.width, self.segmentView1.frame.size.height-35);

    self.segmentView2.frame=CGRectMake(8, 170, [UIScreen mainScreen].bounds.size.width-16, [UIScreen mainScreen].applicationFrame.size.height-self.navigationController.navigationBar.frame.size.height-75-170);
    self.segmentView3.frame=CGRectMake(8, 170, [UIScreen mainScreen].bounds.size.width-16, [UIScreen mainScreen].applicationFrame.size.height-self.navigationController.navigationBar.frame.size.height-75-170);

    
    self.segment2ContentView.frame=CGRectMake(0, 35, self.segmentView2.frame.size.width, self.segmentView2.frame.size.height-35);
    
    self.tableView.frame=CGRectMake(0, 40, self.segmentView2.frame.size.width, self.segment2ContentView.frame.size.height-40);
    
    if ([getType isEqualToString:@"0"]) {
        self.segmentView1.hidden=NO;
        self.segmentView3.hidden=YES;
    }else{
        self.segmentView1.hidden=YES;
        self.segmentView3.hidden=NO;
    }
    self.segmentView2.hidden=YES;
    [self didSelectSegmentAtIndex:0];
    
    if ([[dic objectForKey:@"id"] isKindOfClass:[NSNull class]]) {
        self.projectId=@"";
    }else{
        self.projectId=[dic objectForKey:@"id"];
    }
    
    if ([[dic objectForKey:@"name"] isKindOfClass:[NSNull class]]) {
        self.nameLabel.text=@"";
    }else{
        self.nameLabel.text=[dic objectForKey:@"name"];
    }
    
    if ([[dic objectForKey:@"paymentName"] isKindOfClass:[NSNull class]]) {
        self.paymentNameLabel.text=@"";
    }else{
        self.paymentNameLabel.text=[dic objectForKey:@"paymentName"];
    }

    if ([[dic objectForKey:@"investorRate"] isKindOfClass:[NSNull class]]) {
        self.investorRateLabel.text=@"";
    }else{
        self.investorRateLabel.text=[[dic objectForKey:@"investorRate"] stringValue];
    }
    if ([[dic objectForKey:@"limitTime"] isKindOfClass:[NSNull class]]) {
        self.limitTimeLabel.text=@"";
    }else{
        self.limitTimeLabel.text=[[dic objectForKey:@"limitTime"] stringValue];

    }
    self.projectFundLabel.text=[NSString stringWithFormat:@"%.2f",([[dic objectForKey:@"projectFund"] floatValue]/10000.0)];
    
    if ([[dic objectForKey:@"insuranceMethod"] isKindOfClass:[NSNull class]]) {
        self.insuranceMethodLabel.text=@"";
    }else{
        self.insuranceMethodLabel.text=[dic objectForKey:@"insuranceMethod"];
    }
    
 
    
    CGFloat percent=[[dic objectForKey:@"percent"] floatValue]/100.0;
    
    self.progressImageView.frame=CGRectMake(0, self.progressImageView.frame.origin.y, ([UIScreen mainScreen].bounds.size.width-40-16)*percent, self.progressImageView.frame.size.height);
    self.progressLabel.text=[NSString stringWithFormat:@"%d%%",[[dic objectForKey:@"percent"] intValue]];
    self.progressLabel.frame=CGRectMake(self.progressImageView.frame.size.width+1, 130,34, 14);

    if ([self.progressLabel.text isEqualToString:@"100%"]) {
        [self.investmentButton setTitle:@"已满标" forState:UIControlStateNormal];
        self.investmentButton.enabled=NO;
        [self.investmentButton setBackgroundColor:[UIColor lightGrayColor]];
    }else{
        if (![RHUserManager sharedInterface].username) {
            [self.investmentButton setTitle:@"请先登录" forState:UIControlStateNormal];
        }else{
            if (![RHUserManager sharedInterface].custId) {
                [self.investmentButton setTitle:@"请先开户" forState:UIControlStateNormal];
            }
        }
    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    page ++;
    [self projectInvestmentList];
    footerView.hidden = NO;
    [footerView.activityIndicatorView startAnimating];
}

-(void)projectInvestmentList
{
    NSDictionary* parameters=@{@"projectId":self.projectId,@"_search":@"true",@"rows":@"10",@"page":[NSString stringWithFormat:@"%d",page],@"sidx":@"investTime",@"sord":@"desc",@"filters":@"{\"groupOp\":\"AND\",\"rules\":[]}"};
    [[RHNetworkService instance] POST:@"common/main/projectInvestmentList" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"---responseObjectresponseObject----------%@",[responseObject objectForKey:@"rows"]);
        
//        DLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSArray* array=[responseObject objectForKey:@"rows"];
            
            if ([array isKindOfClass:[NSArray class]]) {
                
                if (array.count == 0) {
                    [footerView.activityIndicatorView stopAnimating];
                    [footerView.activityIndicatorView removeFromSuperview];
                    footerView.hidden = NO;
                     footerView.footerButton.enabled = NO;
                } else {
                    for (NSDictionary* dic in array) {
                        if ([dic objectForKey:@"cell"]&&!([[dic objectForKey:@"cell"] isKindOfClass:[NSNull class]])) {
                            [self.dataArray addObject:[dic objectForKey:@"cell"]];
                        }
                    }
                }
            }
            [self.tableView reloadData];
            
            NSString* records=[responseObject objectForKey:@"records"];
            if (records&&[records intValue]<10) {
                //已经到底了
                [footerView.activityIndicatorView stopAnimating];
                [footerView.activityIndicatorView removeFromSuperview];
                footerView.hidden = NO;
                footerView.footerButton.enabled = NO;
            }

            if (self.dataArray.count < 10) {
                [footerView removeFromSuperview];
            }
            if (isSegment2Click) {
                isSegment2Click = NO;
                if (self.dataArray.count > 0) {
                    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
                }
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        DLog(@"%@",error);
        [RHUtility showTextWithText:@"请求失败"];
    }];
    [self.tableView reloadData];
}
//project =     {
//    available = 0;
//    available2 = "0.00";
//    class = "view.ProjectStudentDetailView";
//    id = 310;
//    insuranceMethod = "\U5c31\U4e1a\U62c5\U4fdd\U4e0e\U98ce\U9669\U4fdd\U8bc1\U91d1\U53cc\U91cd\U672c\U606f\U4fdd\U969c";
//    investorRate = 10;
//    limitTime = "6.0";
//    name = "\U7231\U59d1\U5a18\U4eec\U554a\U4e24\U4e2a\U4f60";
//    partnerInfo = fdsfa;
//    paymentName = "\U6309\U6708\U4ed8\U606f\U3001\U5230\U671f\U8fd8\U672c";
//    paymentType = 04;
//    percent = 100;
//    projectFund = "16,800.00";
//    projectStatus = finished;
//    studentAge = 0;
//    studentCity = "\U5e02\U8f96\U533a";
//    studentEducation = "\U7855\U58eb\U7814\U7a76\U751f";
//    studentGender = "\U5973";
//    studentName = "\U5b66**";
//    studentNation = "\U8499\U53e4\U65cf";
//    studentProfession = "\U8f6f\U4ef6\U5de5\U7a0b";
//    studentSchool = "\U534e\U7535";
//    version = 13;
//};
-(void)appXueDetailData
{
    NSDictionary* parameters=@{@"id":projectId};
    
    [[RHNetworkService instance] POST:@"common/main/appXueDetailData" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        DLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary* project=[responseObject objectForKey:@"project"];
//            DLog(@"%@",project);
            self.studentNameLabel.text=[project objectForKey:@"studentName"];
            self.studentCityLabel.text=[project objectForKey:@"studentCity"];
            self.studentSchoolLabel.text=[project objectForKey:@"studentSchool"];
            self.studentGenderLabel.text=[project objectForKey:@"studentGender"];
            self.studentNationLabel.text=[project objectForKey:@"studentNation"];
            self.studentProfessionLabel.text=[project objectForKey:@"studentProfession"];
            self.studentAgeLabel.text=[[project objectForKey:@"studentAge"] stringValue];
            self.studentEducationLabel.text=[project objectForKey:@"studentEducation"];
            self.partnerInfoLabel.text=[project objectForKey:@"partnerInfo"];
            
            
            CGRect rect1=self.partnerInfoLabel.frame;
            rect1.size.height=[[project objectForKey:@"partnerInfo"] sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(self.partnerInfoLabel.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping].height+5;
            self.partnerInfoLabel.frame=rect1;

            self.scrollView1.contentSize=CGSizeMake(self.scrollView1.frame.size.width,self.partnerInfoLabel.frame.origin.y+self.partnerInfoLabel.frame.size.height+10);

            if ([[project objectForKey:@"available2"] isKindOfClass:[NSNull class]]) {
                self.availableLabel.text=@"";
            }else{
                self.availableLabel.text=[project objectForKey:@"available2"];
            }
            available=[[project objectForKey:@"available"] intValue];


        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [RHUtility showTextWithText:@"请求失败"];
    }];
}

-(void)appShangDetailData
{
    NSDictionary* parameters=@{@"id":projectId};
    
    [[RHNetworkService instance] POST:@"common/main/appShangDetailData" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        DLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSArray* insuranceImages=[responseObject objectForKey:@"insuranceImages"];
            if (insuranceImages.count > 0) {
                for (NSDictionary* insuranceDic in insuranceImages) {
                    int index=[[NSNumber numberWithInteger:[insuranceImages indexOfObject:insuranceDic]] intValue];
                    
                    UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(index*(45+10),4, 45, 45)];
                    imageView.userInteractionEnabled=YES;
                    [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@common/main/attachment/%@",[RHNetworkService instance].doMain,[insuranceDic objectForKey:@"filepath"]]]];
                    UIButton* button=[UIButton buttonWithType:UIButtonTypeCustom];
                    button.frame=imageView.bounds;
                    button.tag = index;
                    [button addTarget:self action:@selector(touch1:) forControlEvents:UIControlEventTouchUpInside];
                    [imageView addSubview:button];
                    [self.array1 addObject:[NSString stringWithFormat:@"%@common/main/attachment/%@",[RHNetworkService instance].doMain,[insuranceDic objectForKey:@"filepath"]]];
                    [self.insuranceScrollView addSubview:imageView];
                }

            }
            self.insuranceScrollView.contentSize=CGSizeMake([insuranceImages count]*55,53);
            
            NSDictionary* projectDic=[responseObject objectForKey:@"project"];
            NSString *detailString = [NSString stringWithFormat:@"%@",[projectDic objectForKey:@"projectInfo"]];
            
            CGRect rect1=self.projectDetail.frame;
            
            NSLog(@"---------------%@",detailString);
            
            if (detailString && detailString.length > 0 && ![detailString isKindOfClass:[NSNull class]] && detailString != nil && ![detailString isEqualToString:@"<null>"]) {
                self.projectDetail.text = detailString;
                rect1.size.height=[detailString sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(self.projectDetail.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping].height+5;
            }
            self.projectDetail.frame=rect1;
            
            self.projectImageLabel.frame=CGRectMake(self.projectImageLabel.frame.origin.x, self.projectDetail.frame.origin.y+self.projectDetail.frame.size.height+5, self.projectImageLabel.frame.size.width, self.projectImageLabel.frame.size.height);
            self.projectScrollView.frame=CGRectMake(self.projectScrollView.frame.origin.x, self.projectImageLabel.frame.origin.y+self.projectImageLabel.frame.size.height+5, self.projectScrollView.frame.size.width, self.projectScrollView.frame.size.height);
            
            self.projectImageLabel1.frame=CGRectMake(self.projectImageLabel1.frame.origin.x, self.projectScrollView.frame.origin.y+self.projectScrollView.frame.size.height+5, self.projectImageLabel1.frame.size.width, self.projectImageLabel1.frame.size.height);
            self.insuranceScrollView.frame=CGRectMake(self.insuranceScrollView.frame.origin.x, self.projectImageLabel1.frame.origin.y+self.projectImageLabel1.frame.size.height+5, self.insuranceScrollView.frame.size.width, self.insuranceScrollView.frame.size.height);
            self.scrollView.contentSize=CGSizeMake(self.scrollView.frame.size.width, self.insuranceScrollView.frame.origin.y+self.insuranceScrollView.frame.size.height+10);
            
            NSArray* projectImages=[responseObject objectForKey:@"projectImages"];
            
            if (projectImages.count > 0) {
                for (NSDictionary* projectImagesDic in projectImages) {
                    int index=[[NSNumber numberWithInteger:[projectImages indexOfObject:projectImagesDic]] intValue];
                    UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(index*(45+10),4, 45, 45)];
                    imageView.userInteractionEnabled=YES;
                    [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@common/main/attachment/%@",[RHNetworkService instance].doMain,[projectImagesDic objectForKey:@"filepath"]]]];
                    UIButton* button=[UIButton buttonWithType:UIButtonTypeCustom];
                    button.frame=imageView.bounds;
                    button.tag = index;
                    [button addTarget:self action:@selector(touch2:) forControlEvents:UIControlEventTouchUpInside];
                    [imageView addSubview:button];
                    [self.array2 addObject:[NSString stringWithFormat:@"%@common/main/attachment/%@",[RHNetworkService instance].doMain,[projectImagesDic objectForKey:@"filepath"]]];
                    [self.projectScrollView addSubview:imageView];
                }

            }
           //            if ([[projectDic objectForKey:@"available2"] isKindOfClass:[NSNull class]]) {
//                self.availableLabel.text=@"";
//            }else{
//                self.availableLabel.text=[projectDic objectForKey:@"available2"];
//            }
            self.availableLabel.text=[NSString stringWithFormat:@"%d",[[projectDic objectForKey:@"available"] intValue]];
            available=[[projectDic objectForKey:@"available"] intValue];

            self.projectScrollView.contentSize=CGSizeMake([projectImages count]*55,53);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [RHUtility showTextWithText:@"请求失败"];
    }];
}

-(void)touch1:(id)sender
{
    UIButton* button=sender;
    
    int count = (int)self.array1.count;
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        // 替换为中等尺寸图片
        NSString *url = self.array1[i];
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString:url]; // 图片路径
//        photo.srcImageView = self.view.subviews[i]; // 来源于哪个UIImageView
        [photos addObject:photo];
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = button.tag; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];
    
    
}
-(void)touch2:(id)sender
{
    UIButton* button=sender;
    int count = (int)self.array2.count;
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        // 替换为中等尺寸图片
        NSString *url = self.array2[i];
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString:url]; // 图片路径
        //        photo.srcImageView = self.view.subviews[i]; // 来源于哪个UIImageView
        [photos addObject:photo];
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = button.tag; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];}

- (IBAction)pushMain:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)pushUserCenter:(id)sender {
    
    [[[RHTabbarManager sharedInterface] selectTabbarUser] popToRootViewControllerAnimated:NO];
}

- (IBAction)pushMore:(id)sender {
    [[[RHTabbarManager sharedInterface] selectTabbarMore] popToRootViewControllerAnimated:NO];
}



- (IBAction)segment1Action:(id)sender {
    if (self.segmentView1.hidden) {
        if ([getType isEqualToString:@"0"]) {
            self.segmentView1.hidden=NO;
            self.segmentView3.hidden=YES;
        }else{
            self.segmentView1.hidden=YES;
            self.segmentView3.hidden=NO;
        }
        self.segmentView2.hidden=YES;
        [self didSelectSegmentAtIndex:0];
    }
    
}

- (IBAction)segment2Action:(id)sender {
    
        if ([RHUserManager sharedInterface].username&&[[RHUserManager sharedInterface].username length]>0) {
            if (self.segmentView2.hidden) {
                self.segmentView2.hidden=NO;
                self.segmentView1.hidden=YES;
                self.segmentView3.hidden=YES;
                
                [self didSelectSegmentAtIndex:1];
                [self.dataArray removeAllObjects];
                isSegment2Click = YES;
                page = 1;
                [self projectInvestmentList];
                
            }
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"登录后才可查看投标记录,请先登录" delegate:self cancelButtonTitle:@"登录" otherButtonTitles:@"取消", nil];
            [alert show];
        }
    }

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [alertView removeFromSuperview];
    if (buttonIndex == 0) {
        RHALoginViewController* controller=[[RHALoginViewController alloc] initWithNibName:@"RHALoginViewController" bundle:nil];
        [self.navigationController pushViewController:controller animated:YES];
    }
}

-(void)didSelectSegmentAtIndex:(int)index
{
    switch (index) {
        case 0:

            break;
        case 1:
  
            break;
        default:
            break;
    }
}

#pragma mark-TableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    
    RHProjectDetailViewCell *cell = (RHProjectDetailViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"RHProjectDetailViewCell" owner:nil options:nil] objectAtIndex:0];
    }
    if (self.dataArray.count > 0) {
       NSDictionary* getDataDic =[self.dataArray objectAtIndex:indexPath.row];
        [cell updateCell:getDataDic];
    }
    
    
    
    
    return cell;
}
- (IBAction)Investment:(id)sender {
    UIButton* button=sender;
    if ([button.titleLabel.text isEqualToString:@"请先登录"]) {
        RHALoginViewController* controller=[[RHALoginViewController alloc] initWithNibName:@"RHALoginViewController" bundle:nil];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if ([button.titleLabel.text isEqualToString:@"请先开户"]) {
        RHRegisterWebViewController* controller=[[RHRegisterWebViewController alloc]initWithNibName:@"RHRegisterWebViewController" bundle:nil];
        [self.navigationController pushViewController:controller animated:YES];

    }
    if ([button.titleLabel.text isEqualToString:@"投资"]) {
        RHInvestmentViewController* contoller=[[RHInvestmentViewController alloc]initWithNibName:@"RHInvestmentViewController" bundle:nil];
        contoller.projectFund=available;
        contoller.dataDic=self.dataDic;
        [self.navigationController pushViewController:contoller animated:YES];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    for (UIView *subView in [UIApplication sharedApplication].keyWindow.subviews) {
        if (subView.tag == 1000) {
            [subView removeFromSuperview];
        }
    }
    [super viewWillDisappear:animated];
}
@end
