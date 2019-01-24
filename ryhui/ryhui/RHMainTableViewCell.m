//
//  RHMainTableViewCell.m
//  ryhui
//
//  Created by 糊涂虫 on 16/3/11.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import "RHMainTableViewCell.h"
#import "RHHelperCollectionViewCell.h"
#import "RHProjectCollectionViewCell.h"
#import "RHRNewShareWebViewController.h"
#import "RHOfficeNetAndWeiBoViewController.h"

@interface RHMainTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)NSMutableArray * array;
@end
@implementation RHMainTableViewCell
//@synthesize progressView;

- (void)awakeFromNib {
//    f",CGRectGetMaxX(self.insuranceMethodLabel.frame)+20);
    self.collectionview.showsHorizontalScrollIndicator = NO;
    self.collectionview.showsVerticalScrollIndicator = NO;
//    self.collectionview.backgroundColor = [UIColor redColor];
    self.collectionview.bounces = NO;
    self.collectionview.delegate = self;
    self.collectionview.dataSource = self;
    self.colleclayout.itemSize = CGSizeMake(375/3.1, 80);
     [self.collectionview registerNib:[UINib nibWithNibName:@"RHProjectCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"collcellid1"];
    self.colleclayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.colleclayout.minimumLineSpacing = 6;
    [super awakeFromNib];
}

   
//available = 0;
//fullTime = "2015-03-13 17:09:28";
//id = 36;
//insuranceId = 24;
//insuranceLogo = "pubNews/56b21a0f-4fa3-472d-bd5c-8c63453c9ba9.png";
//insuranceMethod = "\U4e91\U5357\U5408\U5174\U878d\U8d44\U62c5\U4fdd\U80a1\U4efd\U6709\U9650\U516c\U53f8";
//investorRate = 10;
//limitTime = 6;
//logo = "<null>";
//name = "\U755c\U4ea7\U54c1\U751f\U4ea7\U4f01\U4e1a\U6cd5\U4eba\U4ee3\U8868\U7ecf\U8425\U6027\U501f\U6b3e";
//paymentName = "\U6309\U6708\U4ed8\U606f\U3001\U5230\U671f\U8fd8\U672c";
//percent = 100;
//projectFund = 2000000;
//projectStatus = "repayment_normal";
//studentLoan = 0;
-(void)updateCell:(NSArray*)array
{
    self.array = [NSMutableArray arrayWithArray:array];
    [self.collectionview reloadData];
    
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    //    return 21;
    return self.array.count;
}




-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    RHProjectCollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"collcellid1" forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor redColor];
    //    cell.backgroundColor = [UIColor whiteColor];
//    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
//    [cell update:self.dataArray[indexPath.row]];
   
    [cell.imageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@common/main/attachment/%@",[RHNetworkService instance].newdoMain,self.array[indexPath.row][@"bg"]]]];
    return cell;

}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [RYHViewController Sharedbxtabar].tarbar.hidden = YES;
    [self.nav.navigationBar setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsDefault];
    self.nav.navigationBar.subviews.firstObject.alpha = 5.00;
    NSString *linkURl = self.array[indexPath.row][@"link"];
//    NSString *logoUrl = self.array[indexPath.row][@""];
//    NSString *naviTitle =self.array[indexPath.row][@""];
    
    NSString * buttonstr = self.array[indexPath.row][@"buttonIs"];;
    NSString * inviteCodeIsstr = self.array[indexPath.row][@"inviteCodeIs"];
    NSString * shareLinkIdstr = self.array[indexPath.row][@"shareLinkId"];
    
    if (linkURl.length > 2) {
        
        if ([buttonstr isEqualToString:@"true"]) {
            RHRNewShareWebViewController *office = [[RHRNewShareWebViewController alloc] initWithNibName:@"RHRNewShareWebViewController" bundle:nil];
//            office.NavigationTitle = naviTitle;
            office.Type = 3;
            office.pinjie = inviteCodeIsstr;
            office.shareid = shareLinkIdstr;
            if (([linkURl rangeOfString:@"https://"].location == NSNotFound)) {
                //            office.urlString = [NSString stringWithFormat:@"http://%@",linkURl];
                //        } else if (([linkURl rangeOfString:@"https://"].location == NSNotFound)) {
                //             office.urlString = [NSString stringWithFormat:@"https://%@",linkURl];
                NSArray * array = [linkURl componentsSeparatedByString:@"//"];
                
                office.urlString = [NSString stringWithFormat:@"https://%@",array[1]];
            } else{
                
                
                office.urlString =linkURl;
            }
            [self.nav pushViewController:office animated:YES];
        }else{
            RHOfficeNetAndWeiBoViewController *office = [[RHOfficeNetAndWeiBoViewController alloc] initWithNibName:@"RHOfficeNetAndWeiBoViewController" bundle:nil];
//            office.NavigationTitle = naviTitle;
            if (self.array[indexPath.row][@"title"] &&![self.array[indexPath.row][@"title"] isKindOfClass:[NSNull class]]) {
                office.NavigationTitle = self.array[indexPath.row][@"title"];
            }
            
            if (([linkURl rangeOfString:@"https://"].location == NSNotFound)) {
                //            office.urlString = [NSString stringWithFormat:@"http://%@",linkURl];
                //        } else if (([linkURl rangeOfString:@"https://"].location == NSNotFound)) {
                //             office.urlString = [NSString stringWithFormat:@"https://%@",linkURl];
                NSArray * array = [linkURl componentsSeparatedByString:@"//"];
                
                office.urlString = [NSString stringWithFormat:@"https://%@",array[1]];
            } else{
                
                
                office.urlString =linkURl;
            }
            [self.nav pushViewController:office animated:YES];
        }
    }else{
        
         [RYHViewController Sharedbxtabar].tarbar.hidden = NO;
    }
    
    NSLog(@"111");
}

@end
