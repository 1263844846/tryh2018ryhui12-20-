//
//  RHMyNewGiftTableViewCell.m
//  ryhui
//
//  Created by 糊涂虫 on 15/7/20.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHMyNewGiftTableViewCell.h"
#import "RHProjectListViewController.h"
@implementation RHMyNewGiftTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)updateCell:(NSDictionary*)dic with:(NSString*)type {
    //    DLog(@"%@",dic);
//
    
//    @property (weak, nonatomic) IBOutlet UILabel *RMBLabel;   //人民币小图标
//    @property (weak, nonatomic) IBOutlet UILabel *moneyLabel;   //红包金额
//    @property (weak, nonatomic) IBOutlet UILabel *typeLabel;   //  红包类型（投资现金。。。）
//    @property (weak, nonatomic) IBOutlet UILabel *effectNoticeLabel;    //用途
//    @property (weak, nonatomic) IBOutlet UILabel *validTimeLabel;    // 有效期／使用时间／过期时间
//    @property (weak, nonatomic) IBOutlet UILabel *conditionLabel;    // 使用条件
//    @property (weak, nonatomic) IBOutlet UILabel *sourceLabel;    // 红包来源
//    @property (weak, nonatomic) IBOutlet UIImageView *backGroundImage;    // 背景图片
//    @property (weak, nonatomic) IBOutlet UIButton *giftTypeButton;    //投资／兑换按钮
//    @property (weak, nonatomic) IBOutlet UIButton *clickButton;
    
    //可以使用
    if ([type isEqualToString:@"front/payment/account/myInitGiftListData"]) {
        
        self.giftTypeButton.hidden=NO;
        if (![dic[@"giftType"] isEqualToString:@"抵现卷"]) {
//            投资
            self.backGroundImage.image=[UIImage imageNamed:@"giftChooseInvest"];
            [self.giftTypeButton setBackgroundImage:[UIImage imageNamed:@"giftInvestButton"] forState:UIControlStateNormal];
            self.clickButton.tag = 10;
            self.moneyLabel.textColor=[RHUtility colorForHex:@"ff4a1f"];
            self.RMBLabel.textColor = [RHUtility colorForHex:@"ff4a1f"];
        } else {
//            兑换
            self.moneyLabel.textColor=[RHUtility colorForHex:@"ffb618"];
            self.RMBLabel.textColor = [RHUtility colorForHex:@"ffb618"];
            self.backGroundImage.image=[UIImage imageNamed:@"giftChooseCharge"];
            self.clickButton.tag = [dic[@"id"] integerValue];
             [self.giftTypeButton setBackgroundImage:[UIImage imageNamed:@"giftChargeButton"] forState:UIControlStateNormal];
        }
        
        self.typeLabel.textColor = [RHUtility colorForHex:@"555555"];
        self.effectNoticeLabel.textColor = [RHUtility colorForHex:@"555555"];
        [self.clickButton addTarget:self action:@selector(chooseCellButton:) forControlEvents:UIControlEventTouchUpInside];
        self.validTimeLabel.text=[NSString stringWithFormat:@"有效期：%@至%@",[dic objectForKey:@"pd"],[dic objectForKey:@"exp"]];

    }
    
    //已使用
    if ([type isEqualToString:@"front/payment/account/myUsedGiftListData"]) {
        self.backGroundImage.image=[UIImage imageNamed:@"giftUsed"];
        self.giftTypeButton.hidden=YES;
        self.clickButton.hidden = YES;
        self.moneyLabel.textColor=[RHUtility colorForHex:@"878787"];
        self.RMBLabel.textColor = [RHUtility colorForHex:@"878787"];
        self.typeLabel.textColor = [RHUtility colorForHex:@"878787"];
        self.effectNoticeLabel.textColor = [RHUtility colorForHex:@"878787"];
        NSString *useTime = [dic objectForKey:@"usingTime"];
        useTime = [useTime componentsSeparatedByString:@" "][0];
        self.validTimeLabel.text= [NSString stringWithFormat:@"%@已使用",useTime];
    }
    
    //已过期
    if ([type isEqualToString:@"front/payment/account/myPastGiftListData"]) {
        self.backGroundImage.image=[UIImage imageNamed:@"giftInvalid"];
        self.giftTypeButton.hidden=YES;
        self.clickButton.hidden = YES;
        self.moneyLabel.textColor=[RHUtility colorForHex:@"878787"];
        self.RMBLabel.textColor = [RHUtility colorForHex:@"878787"];
        self.typeLabel.textColor = [RHUtility colorForHex:@"878787"];
        self.effectNoticeLabel.textColor = [RHUtility colorForHex:@"878787"];
        self.validTimeLabel.text=[NSString stringWithFormat:@"有效期：%@至%@",[dic objectForKey:@"pd"],[dic objectForKey:@"exp"]];
    }
    
    if ([dic[@"giftType"] isEqualToString:@"抵现卷"]) {
        self.typeLabel.text = @"返利现金";
        self.effectNoticeLabel.text = @" [可直接兑现为余额]";
        self.conditionLabel.text = [NSString stringWithFormat:@"红包来源：%@",dic[@"activityName"]];
        self.sourceLabel.text = @"";
    } else {
        self.effectNoticeLabel.text = @" [投资时使用]";
        self.typeLabel.text = @"投资现金";
        NSString* threshold=@"";
        if (![[dic objectForKey:@"threshold"] isKindOfClass:[NSNull class]]) {
            if ([[dic objectForKey:@"threshold"] isKindOfClass:[NSNumber class]]) {
                threshold=[NSString stringWithFormat:@"使用条件：单笔投资满%@元",[[dic objectForKey:@"threshold"] stringValue]];
            }else{
                threshold=[NSString stringWithFormat:@"使用条件：单笔投资满%@元",[dic objectForKey:@"threshold"]];
            }
        }
        self.conditionLabel.text=threshold;
        
        self.sourceLabel.text = [NSString stringWithFormat:@"红包来源：%@",dic[@"activityName"]];
    }
    
    NSString* money=@"";
    if (![[dic objectForKey:@"money"] isKindOfClass:[NSNull class]]) {
        if ([[dic objectForKey:@"money"] isKindOfClass:[NSNumber class]]) {
            money=[NSString stringWithFormat:@"%@",[[dic objectForKey:@"money"] stringValue]];
        }else{
            money=[NSString stringWithFormat:@"%@",[dic objectForKey:@"money"]];
        }
    }
    self.moneyLabel.text=money;
}

-(void)chooseCellButton:(UIButton *)btn {
    if (btn.tag == 10) {
        //投资
        RHProjectListViewController* controller=[[RHProjectListViewController alloc]initWithNibName:@"RHProjectListViewController" bundle:nil];
        controller.type= @"0";
        [[[RHTabbarManager sharedInterface] selectTabbarMain] pushViewController:controller animated:YES];
        
        
    } else {
        //兑换
        NSDictionary* parameters=@{@"giftId":[NSString stringWithFormat:@"%d",btn.tag]};
        AFHTTPRequestOperationManager* manager=[AFHTTPRequestOperationManager manager];
        manager.responseSerializer=[[AFCompoundResponseSerializer alloc]init];
        NSString* session=[[NSUserDefaults standardUserDefaults] objectForKey:@"RHSESSION"];
        NSLog(@"------------------%@",session);
        if (session&&[session length]>0) {
            [manager.requestSerializer setValue:session forHTTPHeaderField:@"cookie"];
        }
        [manager POST:[NSString stringWithFormat:@"%@/front/payment/account/useRebateGift",[RHNetworkService instance].doMain] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"------------------%@",responseObject);
            if ([responseObject isKindOfClass:[NSData class]]) {
                NSDictionary* dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                NSLog(@"------------------%@",dic);
                if ([dic[@"msg"] isEqualToString:@"成功"]) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"兑换成功！现金已充入您的账户余额，可到【我的账户】查询." delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                    [alert show];
                } else {
                    [RHUtility showTextWithText:@"兑换现金失败"];
                }
              
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            DLog(@"%@",[[NSString alloc] initWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
            
            [RHUtility showTextWithText:@"兑换现金失败"];
        }];

    }
}

@end
