//
//  RHProjectdetailthreeViewController.h
//  ryhui
//
//  Created by 糊涂虫 on 16/3/3.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import "RHBaseViewController.h"
#import "RHSegmentContentView.h"
typedef void(^myblock)() ;

@interface RHProjectdetailthreeViewController : RHBaseViewController<RHSegmentContentViewDelegate>


@property(nonatomic,strong)NSString* getType;
@property(nonatomic,strong)NSDictionary* dataDic;

@property(nonatomic,assign)int panduan;

@property(nonatomic,strong)NSString * lilv;
@property (weak, nonatomic) IBOutlet UIImageView *zzimage;
@property (weak, nonatomic) IBOutlet UIImageView *zztimelogoiamge;
@property (weak, nonatomic) IBOutlet UILabel *zzlasttimelab;
@property (weak, nonatomic) IBOutlet UILabel *zzlasttimeminlab;

@property(nonatomic,assign)BOOL  newpeopletype;
@property(nonatomic,assign)BOOL  postnewpeopletype;
@property(nonatomic,copy)NSString * zhaungtaistr;
@property(nonatomic,strong)NSString* projectId;
@property(nonatomic,assign)int myinsertres;
@property(nonatomic,copy)myblock myblock;
@property(nonatomic,assign)int insert;


@property(nonatomic,copy)NSString * xmjid;
@end
