//
//  RHSegmentView.m
//  ryhui
//
//  Created by stefan on 15/3/14.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHSegmentView.h"

@implementation RHSegmentView

@synthesize delegate;
@synthesize selectedIndex;

-(void)initData
{
    self.segmentView1.hidden=NO;
    self.segmentView2.hidden=YES;
    [delegate didSelectSegmentAtIndex:0];
    
    self.contentLabel.text=@"借款方为经营良好的中小微企业及个体工商户。为保障投资人权益，融益汇通过评级严格筛选合作机构。所有借款项目均由合作机构评审后推荐，并经融益汇多轮在评审后发布。所有项目均由合作机构提供全额本息担保。";
    self.contentLabel1.text=@"借款方为接受就业培训的在读学生，贷款用于支付就业培训费用。培训机构承诺为学生就业提供保障，并承担未就业学生的全部还款本息；同时融益汇从每笔助学贷款的服务费中提取一定比例的资金作为助学贷专项风险保障金以备代偿。通过就业担保和风险保障金双重本息保障机制为您的投资保驾护航。";
}

- (IBAction)segment1Action:(id)sender {
    if (self.segmentView1.hidden) {
        self.segmentView1.hidden=NO;
        self.segmentView2.hidden=YES;
        [delegate didSelectSegmentAtIndex:0];
    }

}

- (IBAction)segment2Action:(id)sender {
    if (self.segmentView2.hidden) {
        self.segmentView2.hidden=NO;
        self.segmentView1.hidden=YES;
        [delegate didSelectSegmentAtIndex:1];
    }
}

- (IBAction)pushInvestment:(id)sender {
    [delegate didSelectInvestment];
}
@end
