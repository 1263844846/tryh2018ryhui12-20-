//
//  RHDetaisecondViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 16/4/8.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import "RHDetaisecondViewController.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "RHALoginViewController.h"
#import "RHJsqViewController.h"
#import "RHInvestmentViewController.h"
#import "MBProgressHUD.h"
#import "RHDetailseconddetailViewController.h"

@interface RHDetaisecondViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *projectScrollView1;
@property (weak, nonatomic) IBOutlet UIView *hidenView;

@property (weak, nonatomic) IBOutlet UIScrollView *projectScrollView;
@property(nonatomic,strong)NSMutableArray * array2;
@property (weak, nonatomic) IBOutlet UILabel *loanname;
@property (weak, nonatomic) IBOutlet UILabel *archivesAddressName;
@property (weak, nonatomic) IBOutlet UILabel *archivesTradesName;
//经营
@property (weak, nonatomic) IBOutlet UILabel *loanInfo;
//用途
@property (weak, nonatomic) IBOutlet UILabel *fundPurpose;
//保障
@property (weak, nonatomic) IBOutlet UILabel *riskSuggestion;
@property (weak, nonatomic) IBOutlet UILabel *jingyinlab;

@property(nonatomic,strong)UIButton * hidenbtn;
@property(nonatomic,strong)UIImageView *hidenimage;
@property(nonatomic,strong)NSDictionary * newdatadic;
- (IBAction)jingying:(id)sender;
- (IBAction)yongtu:(id)sender;
- (IBAction)benxi:(id)sender;

@end

@implementation RHDetaisecondViewController
-(NSDictionary *)newdatadic{
    
    if (!_newdatadic) {
        _newdatadic = [NSDictionary dictionary];
    }
    return _newdatadic;
    
}

- (IBAction)jingying:(id)sender {
    
    RHDetailseconddetailViewController *vc =[[RHDetailseconddetailViewController alloc]initWithNibName:@"RHDetailseconddetailViewController" bundle:nil];
    
    vc.deatial = self.loanInfo.text;
    vc.namestr = @"经营状况";
    self.myblock();
//    self.hidenbtn.hidden = YES;
    [self.nav pushViewController:vc animated:YES];
    NSLog(@"2222%@",vc.deatial);
}

- (IBAction)yongtu:(id)sender {
    
    
    RHDetailseconddetailViewController *vc =[[RHDetailseconddetailViewController alloc]initWithNibName:@"RHDetailseconddetailViewController" bundle:nil];
    vc.namestr = @"借款用途";
    vc.deatial = self.fundPurpose.text;
    self.myblock();
    [self.nav pushViewController:vc animated:YES];
}

- (IBAction)benxi:(id)sender {
    if (self.newpeo) {
        return;
    }
    RHDetailseconddetailViewController *vc =[[RHDetailseconddetailViewController alloc]initWithNibName:@"RHDetailseconddetailViewController" bundle:nil];
    self.myblock();
    vc.namestr = @"本息保障";
    vc.deatial = self.riskSuggestion.text;
    
    [self.nav pushViewController:vc animated:YES];
}



-(NSDictionary *)datadic{
    if (!_datadic) {
        _datadic = [NSDictionary dictionary];
    }
    return _datadic;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.sess = YES;
    self.array2 = [NSMutableArray array];
  
   
    NSDictionary* parameters1=@{@"id":self.projectid};
    
    [[RHNetworkService instance] POST:@"app/common/appDetails/projectDetails" parameters:parameters1 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        
        self.newdatadic = responseObject;
        
        NSDictionary *dic  = responseObject;
        
        NSArray * array = [dic allKeys];
        
        NSArray * array1 = dic[array[0]];
        NSArray * array2 = dic[array[1]];
//        NSArray * array3 = dic[array[2]];
        NSLog(@"%@",array);
//        NSLog(@"%@",array1);
        NSLog(@"%@",array2);
        
        for (NSDictionary * str in array1) {
            for (NSString* str1  in str.allKeys) {
                NSLog(@"%@",str1);
            }
        }
//        NSLog(@"%@",array3[0]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if ([error.userInfo.allKeys containsObject:@"com.alamofire.serialization.response.error.data"]) {
            NSDictionary* errorDic=[NSJSONSerialization JSONObjectWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] options:NSJSONReadingMutableContainers error:nil];
            
        }
        
    }];

    
    NSDictionary* parameters=@{@"id":self.projectid};
    
    [[RHNetworkService instance] POST:@"app/common/appDetails/appProjectDetailData" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        DLog(@"%@",responseObject);
        [MBProgressHUD showHUDAddedTo:self.newscrool animated:YES];
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            
            NSArray* projectImages=[responseObject objectForKey:@"projectImages"];

            
            [self setupdata:responseObject];
          [MBProgressHUD hideAllHUDsForView:self.newscrool animated:YES];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [RHUtility showTextWithText:@"请求失败"];
    }];
    if (self.newpeo) {
        self.firsthidenlab.hidden = YES;
        self.secondhidenlab.hidden = YES;
        self.threehidenlab.hidden = YES;
        self.fourhidenlab.hidden = YES;
        self.riskSuggestion.hidden = YES;
    }
    
    
    self.newscrool.delegate = self;
    
 
    
}
- (void)CreatDetailsView:(NSDictionary *)dic{
    
    NSArray * array = [dic allKeys];
    
    NSArray * array1 = dic[array[0]];
    NSArray * array2 = dic[array[1]];
    NSArray * array3 = dic[array[2]];
    int i = 20;
    int j = 20;
    for (NSDictionary * dic in array1) {
       
        for (NSString * keystr in dic.allKeys) {
            UILabel * lab = [[UILabel alloc]init];
            lab.frame = CGRectMake(26, i, 70, 20);
            if (keystr.length> 7) {
                lab.frame = CGRectMake(26, i, 170, 20);
            }
            lab.text = keystr;
            
            NSString * valuestr = dic[keystr];
            
            
            UILabel * lab1 = [[UILabel alloc]init];
            lab1.text = valuestr;
            if (valuestr.length<=10) {
               
                lab1.frame =CGRectMake(120,i, 100, 20);
                i = i+15;
                j = i ;
            }else{
                
                lab1.frame =CGRectMake(26,i+8, 100, 20);
                
            }
            
            
            
//            CGSize size = [self.yongtustr sizeThatFits:CGSizeMake(self.yongtustr.frame.size.width, MAXFLOAT)];
//            self.yongtustr.frame = CGRectMake(self.yongtu.frame.origin.x, CGRectGetMaxY(self.yongtu.frame)+5, self.yongtustr.frame.size.width,      size.height);
            
        }
    }
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
   
    if (scrollView.contentOffset.y <1) {
         NSLog(@"---");
        self.scroolblock();
    }
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
    [browser show];
}

//- (void)drawRect:(CGRect)rect {
//
//
//}

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

- (IBAction)lijitoubiao:(id)sender {
    


}
- (IBAction)jisuanqi:(id)sender {
    RHJsqViewController * vc = [[RHJsqViewController alloc]initWithNibName:@"RHJsqViewController" bundle:nil];
    vc.nianStr = self.nhstr;
    
    vc.mouthStr = self.mouthstr;
    [self.nav pushViewController:vc animated:YES];
    NSLog(@"jsq");
}
-(void)setupdata:(NSDictionary * )dic{
    
    if (!dic[@"loanName"]|| ![dic[@"loanName"] isKindOfClass:[NSNull class]]) {
        
        if ([dic[@"project"][@"realLoanObjType"] isEqualToString:@"LoanCompanyArchives"]) {
            NSString *str = [NSString stringWithFormat:@"%@",dic[@"loanName"]];
            
            NSString * laststr = [str substringFromIndex:str.length - 1];
            NSString * firststr = [str substringToIndex:1];
            self.loanname.text = [NSString stringWithFormat:@"%@******%@",firststr,laststr];
        }else{
            NSString *str = [NSString stringWithFormat:@"%@",dic[@"loanName"]];
            
            NSString * laststr = [str substringFromIndex:str.length - 1];
            NSString * firststr = [str substringToIndex:1];
            self.loanname.text = [NSString stringWithFormat:@"%@**",firststr];
        }
    }
    if (!dic[@"project"][@"loanInfo"]|| ![dic[@"project"][@"loanInfo"] isKindOfClass:[NSNull class]]) {
        self.loanInfo.text = dic[@"project"][@"loanInfo"];
    }
    if (!dic[@"project"][@"fundPurpose"]|| ![dic[@"project"][@"fundPurpose"] isKindOfClass:[NSNull class]]) {
        self.fundPurpose.text = dic[@"project"][@"fundPurpose"];
    }
    if (!dic[@"project"][@"riskSuggestion"]|| ![dic[@"project"][@"riskSuggestion"] isKindOfClass:[NSNull class]]) {
        self.riskSuggestion.text = dic[@"project"][@"riskSuggestion"];
    }
    if (!dic[@"archivesTradesName"]|| ![dic[@"archivesTradesName"] isKindOfClass:[NSNull class]]) {
        self.archivesTradesName.text = dic[@"archivesTradesName"];
    }
    if (!dic[@"archivesAddressName"]|| ![dic[@"archivesAddressName"] isKindOfClass:[NSNull class]]) {
        self.archivesAddressName.text = dic[@"archivesAddressName"];
    }
//    if (!dic[@"archivesTradesName"]|| ![dic[@"archivesTradesName"] isKindOfClass:[NSNull class]]) {
//        self.archivesTradesName.text = dic[@"archivesTradesName"];
//    }
    
//    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(150, 50, 150, 0)];
//    label3.font = [UIFont systemFontOfSize:15];
    
//    self.loanInfo.backgroundColor = [UIColor yellowColor];

    CGSize size = [self.loanInfo sizeThatFits:CGSizeMake(self.loanInfo.frame.size.width, MAXFLOAT)];
    self.loanInfo.frame = CGRectMake(self.loanInfo.frame.origin.x, CGRectGetMaxY(self.jingyinlab.frame)+10, self.loanInfo.frame.size.width,      size.height);

    self.yongtu.frame = CGRectMake(self.yongtu.frame.origin.x, CGRectGetMaxY(self.loanInfo.frame)+10, self.yongtu.frame.size.width, self.yongtu.frame.size.height);
    
    
//    self.fundPurpose.backgroundColor = [UIColor yellowColor];
    CGSize size1 = [self.fundPurpose sizeThatFits:CGSizeMake(self.fundPurpose.frame.size.width, MAXFLOAT)];
    self.fundPurpose.frame = CGRectMake(self.fundPurpose.frame.origin.x, CGRectGetMaxY(self.yongtu.frame)+10, self.fundPurpose.frame.size.width,      size1.height);
    
    self.baozhang.frame = CGRectMake(self.baozhang.frame.origin.x, CGRectGetMaxY(self.fundPurpose.frame)+10, self.baozhang.frame.size.width, self.baozhang.frame.size.height);
    
    
//    self.riskSuggestion.backgroundColor = [UIColor yellowColor];
    CGSize size2 = [self.riskSuggestion sizeThatFits:CGSizeMake(self.riskSuggestion.frame.size.width, MAXFLOAT)];
    self.riskSuggestion.frame = CGRectMake(self.riskSuggestion.frame.origin.x, CGRectGetMaxY(self.baozhang.frame)+10, self.riskSuggestion.frame.size.width,      size2.height);
    
    self.tupian.frame = CGRectMake(self.tupian.frame.origin.x, CGRectGetMaxY(self.riskSuggestion.frame)+10, self.tupian.frame.size.width, self.tupian.frame.size.height);
    
    self.newscrool.contentSize=CGSizeMake([UIScreen mainScreen].bounds.size.width,CGRectGetMaxY(self.tupian.frame)+100);
    
    NSLog(@"%f",[UIScreen mainScreen].bounds.size.height);
    self.newscrool.bounces = NO;
    
    
    
    NSArray* projectImages=[dic objectForKey:@"projectImages"];
    
    int j = 0;
    
    CGFloat with = ([UIScreen mainScreen].bounds.size.width/375)*58;
    for (int i = 0; i < projectImages.count; i++) {
        
        if (i%5==0&& i!=0) {
            j++;
        }
        NSDictionary* projectImagesDic = [NSDictionary dictionaryWithDictionary:projectImages[i]];
        
        int a = i - j*5;
        UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(a*(with+10)+25,j*60 +CGRectGetMaxY(self.tupian.frame)+5, with, 55)];
        
        imageView.userInteractionEnabled=YES;
        [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@common/main/attachment/%@",[RHNetworkService instance].newdoMain,[projectImagesDic objectForKey:@"filepath"]]]];
        UIButton* button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=imageView.bounds;
        button.tag = i;
        [button addTarget:self action:@selector(touch2:) forControlEvents:UIControlEventTouchUpInside];
        [imageView addSubview:button];
        [self.array2 addObject:[NSString stringWithFormat:@"%@common/main/attachment/%@",[RHNetworkService instance].newdoMain,[projectImagesDic objectForKey:@"filepath"]]];
        
        [self.newscrool addSubview:imageView];
        self.newscrool.contentSize=CGSizeMake([UIScreen mainScreen].bounds.size.width,CGRectGetMaxY(imageView.frame)+101);
    }
    
    
//    if (projectImages.count > 0) {
//        for (NSDictionary* projectImagesDic in projectImages) {
//            int index=[[NSNumber numberWithInteger:[projectImages indexOfObject:projectImagesDic]] intValue];
//            UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(index*(45+10),4, 45, 45)];
//            
//            imageView.userInteractionEnabled=YES;
//            [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@common/main/attachment/%@",[RHNetworkService instance].newdoMain,[projectImagesDic objectForKey:@"filepath"]]]];
//            UIButton* button=[UIButton buttonWithType:UIButtonTypeCustom];
//            button.frame=imageView.bounds;
//            button.tag = index;
//            [button addTarget:self action:@selector(touch2:) forControlEvents:UIControlEventTouchUpInside];
//            [imageView addSubview:button];
//            [self.array2 addObject:[NSString stringWithFormat:@"%@common/main/attachment/%@",[RHNetworkService instance].newdoMain,[projectImagesDic objectForKey:@"filepath"]]];
//            // if ([UIScreen mainScreen].bounds.size.width >320) {
//            [self.projectScrollView addSubview:imageView];
//            
//        }
//        
//    }
    
}


@end
