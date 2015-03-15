//
//  RHProjectDetailViewController.h
//  ryhui
//
//  Created by stefan on 15/3/14.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHBaseViewController.h"
#import "RHProjectDetailViewCell.h"

@interface RHProjectDetailViewController : RHBaseViewController


@property(nonatomic,strong)NSString* projectId;

@property(nonatomic,strong)NSDictionary* dataDic;

@property (nonatomic,strong)NSMutableArray* dataArray;

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

- (IBAction)pushMain:(id)sender;
- (IBAction)pushUserCenter:(id)sender;
- (IBAction)pushMore:(id)sender;

-(void)setupWithDic:(NSDictionary*)dic;

@property (weak, nonatomic) IBOutlet UIView *segmentView1;
@property (weak, nonatomic) IBOutlet UIView *segmentView2;
- (IBAction)segment1Action:(id)sender;
- (IBAction)segment2Action:(id)sender;

@property (weak, nonatomic) IBOutlet UIScrollView *projectScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *insuranceScrollView;

@property (weak, nonatomic) IBOutlet UILabel *projectDetail;

@end
