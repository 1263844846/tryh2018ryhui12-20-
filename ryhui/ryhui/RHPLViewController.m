//
//  RHPLViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 2018/4/18.
//  Copyright © 2018年 stefan. All rights reserved.
//

#import "RHPLViewController.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "RHXYWebviewViewController.h"
#import "RHDetailseconddetailViewController.h"

#import "RHALoginViewController.h"
@interface RHPLViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;

@property(nonatomic,strong)NSMutableArray * array2;

@property(nonatomic,copy)NSString * hzfstr;
@end

@implementation RHPLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    [self getdata];
    
    
    NSDictionary* parameters1=@{@"id":self.projectid};
    
    
    
    
    [[RHNetworkService instance] POST:@"app/common/appDetails/projectDetails" parameters:parameters1 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        
       
        [self CreatDetailsView:responseObject];
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

}

- (void)CreatDetailsView:(NSDictionary *)dic{
    
//    for (NSDictionary * dic1  in dic) {
////        NSLog(@"%@",dic1);
//        NSArray * key = dic1.allKeys;
//        for (NSString * key1 in key) {
//            NSLog(@"%@---%@",key1,[NSString stringWithFormat:@"%@",dic1[key1]]);
//        }
//        
//        
//    }
    
    NSArray * array = [dic allKeys];
    
    NSArray * array1 = dic[array[0]];
    NSArray * array2 = dic[array[1]];
    NSDictionary * array3 ;
    if (array.count>2) {
        array3 = dic[array[2]];
    }
    
    int i = 20;
    int j = 20;
    
    UILabel * firstlab = [[UILabel alloc]init];
    firstlab.frame  = CGRectMake(20, i, 160, 20);
    firstlab.text = array[0];
    [self.scrollview addSubview:firstlab];
    UILabel * heixianlab = [[UILabel alloc]init];
    heixianlab.frame  = CGRectMake(20, i+23,RHScreeWidth-40, 1);
    heixianlab.backgroundColor = [RHUtility colorForHex:@"DEE0E0"];;
    [self.scrollview addSubview:heixianlab];
    
    i = i+40;
    for (NSDictionary * dic in array1) {
        
        for (NSString * keystr in dic.allKeys) {
            UILabel * lab = [[UILabel alloc]init];
            
            if (keystr.length> 12) {
                lab.frame = CGRectMake(26, i, 170, 20);
                
                i = i + 40;
            }else{
                lab.frame = CGRectMake(26, i, 170, 20);
            }
            lab.text = keystr;
            
            [lab setTextColor:[RHUtility colorForHex:@"44BBC1"]];
            
            lab.font = [UIFont systemFontOfSize:14];
            NSString * valuestr = dic[keystr];
            
            
            UILabel * lab1 = [[UILabel alloc]init];
            lab1.numberOfLines = 0;
            [self.scrollview addSubview:lab];
            [self.scrollview addSubview:lab1];
            
            if ([keystr isEqualToString:@"合作机构"]) {
                
                if (dic[keystr][1]&& ![dic[keystr][1] isKindOfClass:[NSNull class]] ) {
                     lab1.text = dic[keystr][1];
                }
               
                lab1.font = [UIFont systemFontOfSize:15];
                [lab1 setTextColor:[RHUtility colorForHex:@"666666"]];
                UIImageView * iamgeview = [[UIImageView alloc]init];
                iamgeview.frame = CGRectMake(120,i+3, 15, 15);
                [iamgeview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@common/main/attachment/%@",[RHNetworkService instance].newdoMain,dic[keystr][0]]]];
                
                [self.scrollview addSubview:iamgeview];
                    lab1.frame =CGRectMake(138,i, 300, 20);
                    i = i+15+20;
                UIButton * btn = [[UIButton alloc]init];
                btn.frame = lab1.frame;
                [btn addTarget:self action:@selector(hezuofangjianjie) forControlEvents:UIControlEventTouchUpInside];
                [self.scrollview addSubview:btn];
                
                
            }else if([keystr isEqualToString:@"相关协议"]){
                NSArray * btnarray = dic[keystr];
                
                
//                for (NSString * str  in btnarray) {
//                    UIButton * btn = [[UIButton alloc]init];
//                    [btn setTitle:str forState:UIControlStateNormal];
////                    btn.backgroundColor=[UIColor redColor];
//
//
//                    btn.frame = CGRectMake(26,i+30, 200, 20);
//
//
//                    if (str.length>10) {
//                         btn.frame = CGRectMake(8,i+30, 360, 20);
//                    }else{
//                    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//                    }
//                    [btn addTarget:self action:@selector(didxieyi:) forControlEvents:UIControlEventTouchUpInside];
//                    [btn setTitleColor:[RHUtility colorForHex:@"44bbc1"] forState:UIControlStateNormal];
//                    [self.scrollview addSubview:btn];
//                    i = i+30+10;
                
                    for (int xieyi =0; xieyi<btnarray.count; xieyi++) {
                        UIButton * btn = [[UIButton alloc]init];
                        [btn setTitle:[NSString stringWithFormat:@"《%@》",btnarray[xieyi]] forState:UIControlStateNormal];
                        //                    btn.backgroundColor=[UIColor redColor];
                        btn.titleLabel.font = [UIFont systemFontOfSize:13];
                        int testxieyi = xieyi+1;
                        btn.titleLabel.lineBreakMode = 0 ;
//                        btn.frame = CGRectMake(26,i+30, 200, 20);
                        if (testxieyi%2==0) {
                            btn.frame = CGRectMake(RHScreeWidth/2+4,i+30, RHScreeWidth/2-26, 20);
                            i = i+30+10;
                        }else{
                            btn.frame = CGRectMake(26,i+30, RHScreeWidth/2-26, 20);
                        }
                        
//                        if (str.length>10) {
//                            btn.frame = CGRectMake(8,i+30, 360, 20);
//                        }else{
//                            btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//                        }
                        [btn addTarget:self action:@selector(didxieyi:) forControlEvents:UIControlEventTouchUpInside];
                        [btn setTitleColor:[RHUtility colorForHex:@"44bbc1"] forState:UIControlStateNormal];
                        [self.scrollview addSubview:btn];
                        
                    }
                int yu =(int) btnarray.count;
                if (yu%2!=0) {
                    i = i+30+10;
                }
                
//                }
            }else{
                
                if ([keystr isEqualToString:@"项目评级"]) {
                    if (!valuestr || [valuestr isKindOfClass:[NSNull class]]) {
                         i = i+15+20;
                    }else{
                    CGFloat xingtest = [valuestr floatValue];
                    for (int a = 0; a < 5; a ++) {
                        UIImageView * iamgeview = [[UIImageView alloc]init];
                        iamgeview.frame = CGRectMake(120+(a*20)+5,i, 20, 20);
                        
                        iamgeview.image = [UIImage imageNamed:@"空心星星"];
                        if (xingtest >a) {
                            iamgeview.image = [UIImage imageNamed:@"星星"];
                            
                        }
                        
                        [self.scrollview addSubview:iamgeview];
                    }
                    
                    i = i+15+20;
                    }
                }else{
                    if (!valuestr||[valuestr isKindOfClass:[NSNull class]]) {
                        return;
                    }
                lab1.text = valuestr;
                    lab1.font = [UIFont systemFontOfSize:15];
                    [lab1 setTextColor:[RHUtility colorForHex:@"666666"]];
                if (valuestr.length<=10) {
                    
                    if (lab.text.length>7) {
//                        lab1.text = @"就是一个内嵌浏览器控";
                        lab1.frame =CGRectMake(160,i, 160, 20);
                        i = i+15+20;
                        j = i ;
                    }else{
                       lab1.frame =CGRectMake(120,i, 300, 20);
                        i = i+15+20;
                        j = i ;
                    }
                }else{
                    
                    lab1.frame =CGRectMake(26,i+40,RHScreeWidth -60, 20);
//                    [lab1 setTextColor:[RHUtility colorForHex:@"44BBC1"]];
                    CGSize size = [lab1 sizeThatFits:CGSizeMake(lab1.frame.size.width, MAXFLOAT)];
                    lab1.frame = CGRectMake(26, i+40, lab1.frame.size.width,      size.height);
                    
                    i = i+8+20+size.height+15+10;
                }
              }
            }
            
        }
    }
   
    i = i + 40;
    UILabel * secondlab = [[UILabel alloc]init];
    secondlab.frame  = CGRectMake(20, i, 160, 20);
    secondlab.text = array[1];
    [self.scrollview addSubview:secondlab];
    UILabel * heixianlab1 = [[UILabel alloc]init];
    heixianlab1.frame  = CGRectMake(20, i+23,RHScreeWidth-40, 1);
    heixianlab1.backgroundColor = [RHUtility colorForHex:@"DEE0E0"];;
    [self.scrollview addSubview:heixianlab1];
    
    
    i = i+40;
    for (NSDictionary * dic in array2) {
        
       for (NSString * keystr in dic.allKeys) {
           UILabel * lab = [[UILabel alloc]init];
           if (keystr.length> 7) {
               lab.frame = CGRectMake(26, i, 170, 20);
              
               i = i + 40;
           }else{
               lab.frame = CGRectMake(26, i, 90, 20);
           }
           lab.font = [UIFont systemFontOfSize:14];
           lab.text = keystr;
           [lab setTextColor:[RHUtility colorForHex:@"44BBC1"]];
           NSString * valuestr = dic[keystr];
           
           
           UILabel * lab1 = [[UILabel alloc]init];
           lab1.numberOfLines = 0;
           [self.scrollview addSubview:lab];
           [self.scrollview addSubview:lab1];
           
         
           if ([keystr isEqualToString:@"信用状况"]) {
               i = i+30;
               NSArray * xydic = dic[keystr];
               
               UILabel * xianlab1 = [[UILabel alloc]init];
               xianlab1.backgroundColor = [UIColor blackColor];
               xianlab1.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2, i , 1,120 );
               
               [self.scrollview addSubview:xianlab1];
               UILabel * xianlab2 = [[UILabel alloc]init];
               xianlab2.backgroundColor = [UIColor blackColor];
               xianlab2.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-26,i , 1,120 );
               [self.scrollview addSubview:xianlab2];
               UILabel * xianlab3 = [[UILabel alloc]init];
               xianlab3.backgroundColor = [UIColor blackColor];
               xianlab3.frame = CGRectMake(26, i , 1,120 );
               [self.scrollview addSubview:xianlab3];
               
               
//               NSArray * kearr = xydic.allKeys;
                 int trmp = i;
               for (NSDictionary * str  in xydic) {
                   
                   UILabel * xianlab = [[UILabel alloc]init];
                   xianlab.backgroundColor = [UIColor blackColor];
                   xianlab.frame = CGRectMake(26, i , [UIScreen mainScreen].bounds.size.width-52, 1);
                   
                   UILabel * xinlab1 =  [[UILabel alloc]init];
                   
                   
                   xinlab1.text = str.allKeys[0];
                   xinlab1.numberOfLines = 0;
                   xinlab1.font = [UIFont systemFontOfSize:15];
                   [xinlab1 setTextColor:[RHUtility colorForHex:@"666666"]];
                   xinlab1.frame = CGRectMake(26, i+5 , ([UIScreen mainScreen].bounds.size.width-52)/2-3, 20);
                   CGSize size = [xinlab1 sizeThatFits:CGSizeMake(([UIScreen mainScreen].bounds.size.width-52)/2-3, MAXFLOAT)];
                   xinlab1.frame = CGRectMake(xinlab1.frame.origin.x, i+5, ([UIScreen mainScreen].bounds.size.width-52)/2-3,      size.height);
//                   int height1 = i + size.height ;
                   
//
                   
                   
                   UILabel * xinlab2 =  [[UILabel alloc]init];
                   xinlab2.font = [UIFont systemFontOfSize:15];
                   [xinlab2 setTextColor:[RHUtility colorForHex:@"666666"]];
                   xinlab2.text = str[str.allKeys[0]];
                   xinlab2.numberOfLines = 0;
                   xinlab2.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2, i+5 , ([UIScreen mainScreen].bounds.size.width-52)/2-3, 20);
                   CGSize size1 = [xinlab2 sizeThatFits:CGSizeMake(([UIScreen mainScreen].bounds.size.width-52)/2-3, MAXFLOAT)];
                   xinlab2.frame = CGRectMake(xinlab2.frame.origin.x+3, i+5, ([UIScreen mainScreen].bounds.size.width-52)/2-3,      size1.height);
//                   int height2 = i + size1.height ;
//
                 
                   if (size.height>size1.height) {
                        i = i+ size.height+10;
                   }else{
                       i = i+size1.height+10;
                   }
                   
                  
                   [self.scrollview addSubview:xinlab1];
                   [self.scrollview addSubview:xinlab2];
                   [self.scrollview addSubview:xianlab];
               }
              
               trmp = i -trmp;
              
               xianlab1.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2, xianlab1.frame.origin.y , 1,trmp );
                xianlab2.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-26,xianlab2.frame.origin.y , 1,trmp );
               xianlab3.frame = CGRectMake(26, xianlab3.frame.origin.y , 1,trmp );
               
               UILabel * downlab = [[UILabel alloc]init];
               
               downlab.frame = CGRectMake(26, i, RHScreeWidth -52, 1);
               downlab.backgroundColor = [UIColor blackColor];
               [self.scrollview addSubview:downlab];
               
           }else{
               if (!valuestr || [valuestr isKindOfClass:[NSNull class]]){
                   
                   i = i+15+20;
                    }else{
                        
               
               lab1.text = valuestr;
               lab1.frame =CGRectMake(120,i, 300, 20);
               i = i+15+20;
               lab1.font = [UIFont systemFontOfSize:15];
               [lab1 setTextColor:[RHUtility colorForHex:@"666666"]];
                    }
           }
           
           
      }
    }
    
    if (array.count<3) {
         self.scrollview.contentSize=CGSizeMake([UIScreen mainScreen].bounds.size.width,i+100);
        return;
    }
    i = i+40 ;
    
    UILabel * imagelab = [[UILabel alloc]init];
    imagelab.frame  = CGRectMake(20, i, 160, 20);
    imagelab.text = array[2];
    [self.scrollview addSubview:imagelab];
    UILabel * heixianlab2 = [[UILabel alloc]init];
    heixianlab2.frame  = CGRectMake(20, i+23,RHScreeWidth-40, 1);
    heixianlab2.backgroundColor = [RHUtility colorForHex:@"DEE0E0"];
    [self.scrollview addSubview:heixianlab2];
    i = i+ 90;
    NSArray* projectImages = array3[array[2]];
//    for (NSDictionary * imdic in array3) {
//
//        NSArray * strkey = imdic.allKeys;
//        projectImages = imdic[strkey[0]];
//    }
//    NSArray* projectImages = array3[0];
    
    int b = 0;
    
    CGFloat with = ([UIScreen mainScreen].bounds.size.width/375)*58;
    for (int a  = 0; a < projectImages.count; a++) {
        
        if (a%5==0&& a!=0) {
            b++;
        }
//        NSDictionary* projectImagesDic = [NSDictionary dictionaryWithDictionary:projectImages[a]];
        
        int test = a - b*5;
        UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(test*(with+10)+25,b*60 +CGRectGetMaxY(imagelab.frame)+10, with, 55)];
        
        imageView.userInteractionEnabled=YES;
        [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@common/main/attachment/%@",[RHNetworkService instance].newdoMain,projectImages[a]]]];
        UIButton* button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=imageView.bounds;
        button.tag = a;
//        button.backgroundColor = [UIColor redColor];
        [button addTarget:self action:@selector(touch2:) forControlEvents:UIControlEventTouchUpInside];
        [imageView addSubview:button];
        [self.array2 addObject:[NSString stringWithFormat:@"%@common/main/attachment/%@",[RHNetworkService instance].newdoMain,projectImages[a]]];
        
        [self.scrollview addSubview:imageView];
//        self.newscrool.contentSize=CGSizeMake([UIScreen mainScreen].bounds.size.width,CGRectGetMaxY(imageView.frame)+101);
    }
    
    
    self.scrollview.contentSize=CGSizeMake([UIScreen mainScreen].bounds.size.width,i+100);
    
    NSLog(@"%f",[UIScreen mainScreen].bounds.size.height);
    self.scrollview.bounces = NO;
}


-(NSMutableArray *)array2{
    
    if (!_array2) {
        _array2 = [NSMutableArray array];
    }
    return _array2;
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
-(void)didxieyi:(UIButton *)btn{
    if ([btn.titleLabel.text isEqualToString:@"《借款协议范本》"]  ) {
        
        if (![RHUserManager sharedInterface].username) {
            RHALoginViewController* controller=[[RHALoginViewController alloc] initWithNibName:@"RHALoginViewController" bundle:nil];
            [self.nav pushViewController:controller animated:YES];
            return;
        }
    }
    
    RHXYWebviewViewController * controller = [[RHXYWebviewViewController alloc]initWithNibName:@"RHXYWebviewViewController" bundle:nil];
    
    NSString * str = btn.titleLabel.text;
    
    NSString *stringWithoutQuotation = [str
                                        stringByReplacingOccurrencesOfString:@"《" withString:@""];
    str =  [stringWithoutQuotation stringByReplacingOccurrencesOfString:@"》" withString:@""];
    controller.namestr = str;
    controller.projectid = self.projectid;
    self.myblock();
    [self.nav pushViewController:controller animated:YES];
    NSLog(@"%@",btn.titleLabel.text);
}
-(void)hezuofangjianjie{
    NSString * str =[RHUserManager sharedInterface].username;
  
   
    
    RHDetailseconddetailViewController *vc =[[RHDetailseconddetailViewController alloc]initWithNibName:@"RHDetailseconddetailViewController" bundle:nil];
    vc.namestr = @"合作方简介";
    vc.deatial = self.hzfstr;
    self.myblock();
    [self.nav pushViewController:vc animated:YES];
    
}

-(void)getdata{
    
    NSDictionary* parameters=@{@"id":self.projectid};
    
    [[RHNetworkService instance] POST:@"app/common/appDetails/appProjectDetailData" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
        
        if (responseObject[@"cooperatesInfo"]&&![responseObject[@"cooperatesInfo"] isKindOfClass:[NSNull class]]) {
            self.hzfstr = responseObject[@"cooperatesInfo"];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [RHUtility showTextWithText:@"请求失败"];
    }];
    
    
}


@end
