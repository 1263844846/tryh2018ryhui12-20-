//
//  RHMyNewGiftTableViewCell.m
//  ryhui
//
//  Created by 糊涂虫 on 15/7/20.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHMyNewGiftTableViewCell.h"
#import "ResultViewController.h"
@implementation RHMyNewGiftTableViewCell
@synthesize coinView;


- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    ResultViewController *primaryView = [[ResultViewController alloc] init
                                         ];
    
    //primaryView.view.backgroundColor = [UIColor redColor];
    self.profileView = [[UIImageView alloc] init];;
    
    NSLog(@"%@",self.imagestr);
    
    self.profileView.image= [UIImage imageNamed:@"红包页-15"];
    
    [coinView setPrimaryView: primaryView.view];
    [coinView setSecondaryView: self.profileView];
    [coinView setSpinTime:1.0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


-(void)updateCell:(NSDictionary*)dic with:(NSString*)type {
    //可以使用
    float a;
    UILabel * mouthlab = [[UILabel alloc]init];
    if ([UIScreen mainScreen].bounds.size.width >320) {
        a = 1;
    }else{
        
        a = 0;
    }
    if ([type isEqualToString:@"app/front/payment/appGift/appMyInitGiftListData"]) {
        
        NSString * giftTypeId = dic[@"giftTypeId"];
        
        if ([giftTypeId isEqualToString:@"add_interest_voucher"]) {
             self.coinView.namelab1.textColor = [RHUtility colorForHex:@"7d7d7d"];
            self.coinView.namelab.text = dic[@"giftType"];
            NSString *str = [NSString stringWithFormat:@"%@",dic[@"upperDays"]];
            if ([dic[@"upperDays"] isKindOfClass:[NSNull class]]) {
                str = @"360";
            }
            self.coinView.namelab1.text = [NSString stringWithFormat:@" 加息%@天",str];
            
//            NSDictionary *attributes = @{NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]};
            NSMutableAttributedString *netString = [[NSMutableAttributedString alloc] initWithString:self.coinView.namelab1.text];
//            [netString addAttributes:attributes range:NSMakeRange(4, 2)];
            
            if (str.length==1) {
                [netString addAttribute:NSForegroundColorAttributeName value:[RHUtility colorForHex:@"#4abac0"] range:NSMakeRange(3,1)];
            }else if (str.length ==2){
                
                [netString addAttribute:NSForegroundColorAttributeName value:[RHUtility colorForHex:@"#4abac0"] range:NSMakeRange(3,2)];
            }else if(str.length ==3){
                
                [netString addAttribute:NSForegroundColorAttributeName value:[RHUtility colorForHex:@"#4abac0"] range:NSMakeRange(3,3)];
            }
//            [netString addAttribute:NSForegroundColorAttributeName value:[UIColor yellowColor] range:NSMakeRange(4,2)];
            
            self.coinView.namelab1.attributedText = netString;
            
            self.coinView.button.tag = 10;
            self.coinView.monerylab.textColor =  [RHUtility colorForHex:@"#4abac0"];
            [self.coinView.button setImage:[UIImage imageNamed:@"红包页-11"] forState:UIControlStateNormal];
             self.coinView.bximage.image = [UIImage imageNamed:@"红包页-07"];
            self.coinView.secondmonry.textColor = [RHUtility colorForHex:@"#f89779"];
           // self.coinView.timelab.text =[NSString stringWithFormat:@"有效期至：%@",dic[@"exp"]];
            self.coinView.fourlab.text = [NSString stringWithFormat:@"有效期至：%@",dic[@"exp"]];
            self.coinView.takelab.text = [NSString stringWithFormat:@"[%@]",dic[@"activityName"]];
            self.coinView.addlab.text =[NSString stringWithFormat:@"限%@个月(含)以上项目",dic[@"limitTime"]];
            self.coinView.timelab.text =[NSString stringWithFormat:@"参与加息的本金最大%@元",dic[@"upperMoney"]];
            /*
            self.coinView.addlab.text =[NSString stringWithFormat:@"红包来源：%@",dic[@"activityName"]];
            self.coinView.takelab.text = [NSString stringWithFormat:@"使用条件：单笔投资满%@元",dic[@"threshold"]];
            self.coinView.button.tag = 10;
            self.coinView.twolab.text =[NSString stringWithFormat:@"2.单笔投资满%@元可用;",dic[@"threshold"]];
             */
            self.profileView.image = [UIImage imageNamed:@"红包页-14"];
            self.coinView.firlab.text = @"1.投资时选择此红包可增加年化收益";
            self.coinView.twolab.text = @"2.每笔投资仅可使用一张";
            self.coinView.threelab.text = [NSString stringWithFormat:@"3.参与加息的投资本金最大为%@元",dic[@"upperMoney"]];
            self.coinView.forlab.text = [NSString stringWithFormat:@"4.单笔投资满%@元可用",dic[@"threshold"]];
            if (!dic[@"limitTime"]||![dic[@"limitTime"] isKindOfClass:[NSNull class]]) {
//                self.coinView.threelab.text = [NSString stringWithFormat:@"3.限%@个月(含)以上项目",dic[@"limitTime"]];
                self.coinView.addlab.text =[NSString stringWithFormat:@"限%@个月(含)以上项目",dic[@"limitTime"]];
            }else{
                self.coinView.addlab.text =[NSString stringWithFormat:@"限1个月(含)以上项目"];
//                self.coinView.threelab.text = [NSString stringWithFormat:@"3.限1个月(含)以上项目"];
            }
             
        }else{
        self.giftTypeButton.hidden=NO;
        if ([dic[@"giftType"] isEqualToString:@"投资现金"]) {
             self.coinView.button.tag = 10;
            self.coinView.threelab.hidden = YES;
            self.coinView.forlab.hidden = YES;
            ////            投资
            //            self.backGroundImage.image=[UIImage imageNamed:@"giftChooseInvest"];
            //            [self.giftTypeButton setBackgroundImage:[UIImage imageNamed:@"giftInvestButton"] forState:UIControlStateNormal];
            //            self.clickButton.tag = 10;
            //            self.moneyLabel.textColor=[RHUtility colorForHex:@"ff4a1f"];
            //            self.RMBLabel.textColor = [RHUtility colorForHex:@"ff4a1f"];
            //            self.validTimeLabel.text=[NSString stringWithFormat:@"有效期：%@至%@",[dic objectForKey:@"pd"],[dic objectForKey:@"exp"]];
            
            self.coinView.secondmonry.textColor = [RHUtility colorForHex:@"#f89779"];
            self.coinView.fourlab.text = [NSString stringWithFormat:@"有效期至：%@",dic[@"exp"]];
            self.coinView.takelab.text = [NSString stringWithFormat:@"[%@]",dic[@"activityName"]];
            self.coinView.addlab.text =[NSString stringWithFormat:@"限%@个月(含)以上项目",dic[@"limitTime"]];
            self.coinView.timelab.text =[NSString stringWithFormat:@"单笔投资满%@元可用",dic[@"threshold"]];
            self.coinView.namelab1.textColor = [RHUtility colorForHex:@"7d7d7d"];
            self.coinView.twolab.text =@"2.每笔投资仅可使用一张";
            /*
             self.coinView.addlab.text =[NSString stringWithFormat:@"红包来源：%@",dic[@"activityName"]];
             self.coinView.takelab.text = [NSString stringWithFormat:@"使用条件：单笔投资满%@元",dic[@"threshold"]];
             self.coinView.button.tag = 10;
             self.coinView.twolab.text =[NSString stringWithFormat:@"2.单笔投资满%@元可用;",dic[@"threshold"]];
             */
            
            if (!dic[@"limitTime"]||![dic[@"limitTime"] isKindOfClass:[NSNull class]]) {
               // self.coinView.threelab.text = [NSString stringWithFormat:@"3.限%@个月(含)以上项目",dic[@"limitTime"]];
                self.coinView.addlab.text =[NSString stringWithFormat:@"限%@个月(含)以上项目",dic[@"limitTime"]];
            }else{
                self.coinView.addlab.text =[NSString stringWithFormat:@"限1个月(含)以上项目"];
              //  self.coinView.threelab.text = [NSString stringWithFormat:@"3.限1个月(含)以上项目"];
            }
            
        } else {
            
            //兑换
            self.coinView.fourlab.hidden = YES;
            [self.coinView.button setImage:[UIImage imageNamed:@"红包页-10"] forState:UIControlStateNormal];
            self.coinView.button.tag = [dic[@"id"] integerValue];
            self.coinView.takelab.hidden  =YES;
//            self.coinView.timelab.hidden = YES;
            self.coinView.namelab.text = @"返利现金";
             self.coinView.addlab.text =[NSString stringWithFormat:@"[%@]",dic[@"activityName"]];
            self.coinView.namelab1.text = @"可直接兑换";
            self.coinView.bximage.image = [UIImage imageNamed:@"红包页-08"];
            self.profileView.image = [UIImage imageNamed:@"红包页-13"];
            
            
            self.coinView.monerylab.frame = CGRectMake(70 +a *20+15, 30, 140+a *10,40);
            self.coinView.monerylab.textColor =  [RHUtility colorForHex:@"#ffb618"];
            
            self.coinView.secondmonry.textColor = [RHUtility colorForHex:@"#ffb618"];
            self.coinView.twolab.text =[NSString stringWithFormat:@"1.可直接兑换为账户余额，"];
            self.coinView.twolab.frame = CGRectMake(30 , 40, 240, 20);
            self.coinView.threelab.text = [NSString stringWithFormat:@"2.兑换后的余额可用于投资或提现。"];
            self.coinView.timelab.text =[NSString stringWithFormat:@"发放时间：%@",dic[@"pd"]];
            
            self.coinView.firlab.hidden = YES;
            self.coinView.forlab.hidden = YES;
            //self.coinView.addlab.frame =CGRectMake(70 +a *20+15, 65, 140+a *10, 20);
            self.coinView.namelab1.textColor = [RHUtility colorForHex:@"7d7d7d"];
        }
        }
        self.typeLabel.textColor = [RHUtility colorForHex:@"303030"];
        self.effectNoticeLabel.textColor = [RHUtility colorForHex:@"303030"];
        self.coinView.shiyolab.hidden = YES;
        
        self.coinView.namelab.textColor = [RHUtility colorForHex:@"3c3c3c"];
//        self.coinView.namelab1.textColor = [RHUtility colorForHex:@"7d7d7d"];
        self.coinView.timelab.textColor = [RHUtility colorForHex:@"4b4b4b"];
        if ([dic[@"giftType"] isEqualToString:@"返利现金"]) {
            self.coinView.addlab.textColor = [RHUtility colorForHex:@"7d7d7d"];
        }else{
        self.coinView.addlab.textColor = [RHUtility colorForHex:@"4b4b4b"];
        }
        self.coinView.takelab.textColor = [RHUtility colorForHex:@"7d7d7d"];
        self.coinView.fourlab.textColor = [RHUtility colorForHex:@"4b4b4b"];
    }
    
    //已使用
    if ([type isEqualToString:@"app/front/payment/appGift/appMyUsedGiftListData"]) {
        
        self.coinView.bigbtn.hidden = YES;
        self.coinView.secondmonry.textColor = [RHUtility colorForHex:@"bcbcbc"] ;
        self.coinView.shiyolab.textColor = [RHUtility colorForHex:@"bcbcbc"] ;
        self.coinView.namelab.textColor = [RHUtility colorForHex:@"bcbcbc"];
        self.coinView.namelab1.textColor = [RHUtility colorForHex:@"bcbcbc"];
        self.coinView.monerylab.textColor = [RHUtility colorForHex:@"bcbcbc"];
        self.coinView.takelab.textColor = [RHUtility colorForHex:@"bcbcbc"];
        self.coinView.addlab.textColor = [RHUtility colorForHex:@"bcbcbc"];
        self.coinView.timelab.textColor = [RHUtility colorForHex:@"bcbcbc"];
        self.coinView.fourlab.textColor = [RHUtility colorForHex:@"bcbcbc"];
        
        //        self.coinView.namelab.textColor = [RHUtility colorForHex:@"bcbcbc"];
        //        self.coinView.namelab.textColor = [RHUtility colorForHex:@"bcbcbc"];
        self.coinView.bximage.hidden = YES;
        self.coinView.button.hidden = YES;
        if ([dic[@"giftType"] isEqualToString:@"投资现金"]){
       self.coinView.fourlab.text = [NSString stringWithFormat:@"有效期至：%@",dic[@"exp"]];
//            self.coinView.takelab.text = [NSString stringWithFormat:@"[%@]",dic[@"activityName"]];
            
            self.coinView.fourlab.text = [NSString stringWithFormat:@"有效期至：%@",dic[@"exp"]];
            self.coinView.takelab.text = [NSString stringWithFormat:@"[%@]",dic[@"activityName"]];
            
            if (!dic[@"limitTime"]||![dic[@"limitTime"] isKindOfClass:[NSNull class]]) {
                // self.coinView.threelab.text = [NSString stringWithFormat:@"3.限%@个月(含)以上项目",dic[@"limitTime"]];
                self.coinView.addlab.text =[NSString stringWithFormat:@"限%@个月(含)以上项目",dic[@"limitTime"]];
            }else{
                self.coinView.addlab.text =[NSString stringWithFormat:@"限1个月(含)以上项目"];
                //  self.coinView.threelab.text = [NSString stringWithFormat:@"3.限1个月(含)以上项目"];
            }
            self.coinView.timelab.text =[NSString stringWithFormat:@"单笔投资满%@元可用",dic[@"threshold"]];
            
        }else{
            if ([dic[@"giftTypeId"] isEqualToString:@"add_interest_voucher"]) {
//                self.coinView.namelab.text = @"加息券";
                self.coinView.namelab.text = dic[@"giftType"];
                self.coinView.fourlab.text = [NSString stringWithFormat:@"有效期至：%@",dic[@"exp"]];
                NSString *str = [NSString stringWithFormat:@"%@",dic[@"upperDays"]];
                if ([dic[@"upperDays"] isKindOfClass:[NSNull class]]) {
                    str = @"360";
                }
                self.coinView.namelab1.text = [NSString stringWithFormat:@" 加息%@天",str];
                self.coinView.takelab.text = [NSString stringWithFormat:@"[%@]",dic[@"activityName"]];
                self.coinView.addlab.text =[NSString stringWithFormat:@"限%@个月(含)以上项目",dic[@"limitTime"]];
                self.coinView.timelab.text =[NSString stringWithFormat:@"参与加息的本金最大%@元",dic[@"upperMoney"]];
                
                
                
                if (!dic[@"limitTime"]||![dic[@"limitTime"] isKindOfClass:[NSNull class]]) {
                    //                self.coinView.threelab.text = [NSString stringWithFormat:@"3.限%@个月(含)以上项目",dic[@"limitTime"]];
                    self.coinView.addlab.text =[NSString stringWithFormat:@"限%@个月(含)以上项目",dic[@"limitTime"]];
                }else{
                    self.coinView.addlab.text =[NSString stringWithFormat:@"限1个月(含)以上项目"];
                    //                self.coinView.threelab.text = [NSString stringWithFormat:@"3.限1个月(含)以上项目"];
                }
                
            }else{
                self.coinView.namelab.text = @"返利现金";
            self.coinView.fourlab.hidden = YES;
            self.coinView.bigbtn.hidden = YES;
    //        self.coinView.namelab.text = dic[@""];
            self.coinView.namelab1.text = @"可直接兑换";
            self.coinView.takelab.hidden  =YES;
//            self.coinView.timelab.hidden = YES;
            self.coinView.timelab.text =[NSString stringWithFormat:@"发放时间：%@",dic[@"pd"]];
            self.coinView.monerylab.frame = CGRectMake(70 +a *20+15, 30, 140+a *10, 40);
                self.coinView.addlab.text = dic[@"activityName"];
            // self.coinView.monerylab.textColor =  [RHUtility colorForHex:@"#ffb618"];
            
            //self.coinView.addlab.frame =CGRectMake(70 +a *20+15, 65, 140+a *10, 20);
            //            self.coinView.monerylab.textColor =  [RHUtility colorForHex:@"#ffb618"];
                
            }
        }
        self.coinView.shiyolab.text = @"已使用";
    }
    
    //已过期
    if ([type isEqualToString:@"app/front/payment/appGift/appMyPastGiftListData"]) {
        
        self.coinView.bigbtn.hidden = YES;
        self.coinView.secondmonry.textColor = [RHUtility colorForHex:@"bcbcbc"];
        self.coinView.namelab.textColor = [RHUtility colorForHex:@"bcbcbc"];
        self.coinView.namelab1.textColor = [RHUtility colorForHex:@"bcbcbc"];
        self.coinView.monerylab.textColor = [RHUtility colorForHex:@"bcbcbc"];
        self.coinView.takelab.textColor = [RHUtility colorForHex:@"bcbcbc"];
        self.coinView.addlab.textColor = [RHUtility colorForHex:@"bcbcbc"];
        self.coinView.timelab.textColor = [RHUtility colorForHex:@"bcbcbc"];
          self.coinView.fourlab.textColor = [RHUtility colorForHex:@"bcbcbc"];
        //        self.coinView.namelab.textColor = [RHUtility colorForHex:@"bcbcbc"];
        //        self.coinView.namelab.textColor = [RHUtility colorForHex:@"bcbcbc"];
        self.coinView.bximage.hidden = YES;
        self.coinView.button.hidden = YES;
        
        if ([dic[@"giftType"] isEqualToString:@"投资现金"]){
//            self.coinView.fourlab.text = [NSString stringWithFormat:@"有效期至：%@",dic[@"exp"]];
            self.coinView.fourlab.text = [NSString stringWithFormat:@"有效期至：%@",dic[@"exp"]];
            self.coinView.takelab.text = [NSString stringWithFormat:@"[%@]",dic[@"activityName"]];
           
            if (!dic[@"limitTime"]||![dic[@"limitTime"] isKindOfClass:[NSNull class]]) {
                // self.coinView.threelab.text = [NSString stringWithFormat:@"3.限%@个月(含)以上项目",dic[@"limitTime"]];
                self.coinView.addlab.text =[NSString stringWithFormat:@"限%@个月(含)以上项目",dic[@"limitTime"]];
            }else{
                self.coinView.addlab.text =[NSString stringWithFormat:@"限1个月(含)以上项目"];
                //  self.coinView.threelab.text = [NSString stringWithFormat:@"3.限1个月(含)以上项目"];
            }
            self.coinView.timelab.text =[NSString stringWithFormat:@"单笔投资满%@元可用",dic[@"threshold"]];
        }else{
            if ([dic[@"giftTypeId"] isEqualToString:@"add_interest_voucher"]) {
//                self.coinView.namelab.text = @"加息券";
                self.coinView.namelab.text = dic[@"giftType"];
                self.coinView.fourlab.text = [NSString stringWithFormat:@"有效期至：%@",dic[@"exp"]];
                NSString *str = [NSString stringWithFormat:@"%@",dic[@"upperDays"]];
                if ([dic[@"upperDays"] isKindOfClass:[NSNull class]]) {
                    str = @"360";
                }
                self.coinView.namelab1.text = [NSString stringWithFormat:@" 加息%@天",str];
                 self.coinView.timelab.text =[NSString stringWithFormat:@"发放时间：%@",dic[@"pd"]];
                self.coinView.takelab.text = [NSString stringWithFormat:@"[%@]",dic[@"activityName"]];
               
                if (!dic[@"limitTime"]||![dic[@"limitTime"] isKindOfClass:[NSNull class]]) {
                    // self.coinView.threelab.text = [NSString stringWithFormat:@"3.限%@个月(含)以上项目",dic[@"limitTime"]];
                    self.coinView.addlab.text =[NSString stringWithFormat:@"限%@个月(含)以上项目",dic[@"limitTime"]];
                }else{
                    self.coinView.addlab.text =[NSString stringWithFormat:@"限1个月(含)以上项目"];
                    //  self.coinView.threelab.text = [NSString stringWithFormat:@"3.限1个月(含)以上项目"];
                }
                self.coinView.timelab.text =[NSString stringWithFormat:@"参与加息的本金最大%@元",dic[@"upperMoney"]];
                
                
                
                if (!dic[@"limitTime"]||![dic[@"limitTime"] isKindOfClass:[NSNull class]]) {
                    //                self.coinView.threelab.text = [NSString stringWithFormat:@"3.限%@个月(含)以上项目",dic[@"limitTime"]];
                    self.coinView.addlab.text =[NSString stringWithFormat:@"限%@个月(含)以上项目",dic[@"limitTime"]];
                }else{
                    self.coinView.addlab.text =[NSString stringWithFormat:@"限1个月(含)以上项目"];
                    //                self.coinView.threelab.text = [NSString stringWithFormat:@"3.限1个月(含)以上项目"];
                }
                
                
            }else{
            self.coinView.fourlab.hidden = YES;
            self.coinView.bigbtn.hidden = YES;
            self.coinView.namelab.text = dic[@"giftType"];
            self.coinView.namelab1.text = @"可直接兑换";
            self.coinView.takelab.hidden  =YES;
            self.coinView.timelab.hidden = YES;
            float a;
            
            if ([UIScreen mainScreen].bounds.size.width >320) {
                a = 1;
            }else{
                
                a = 0;
            }
            self.coinView.monerylab.frame = CGRectMake(70 +a *20+15, 30, 140+a *10, 40);
            }
            //self.coinView.monerylab.textColor =  [RHUtility colorForHex:@"#ffb618"];
            
            //self.coinView.addlab.frame =CGRectMake(70 +a *20+15, 65, 140+a *10, 20);
        }
        self.coinView.shiyolab.text = @"已过期";
        self.coinView.shiyolab.textColor = [RHUtility colorForHex:@"bcbcbc"] ;
    }
    
//    if ([dic[@"giftType"] isEqualToString:@"投资现金"]) {
//        self.effectNoticeLabel.text = @" [投资时使用]";
//        self.coinView.namelab.text = dic[@"giftType"];
//        NSString* threshold=@"";
//        if (![[dic objectForKey:@"threshold"] isKindOfClass:[NSNull class]]) {
//            if ([[dic objectForKey:@"threshold"] isKindOfClass:[NSNumber class]]) {
//                threshold=[NSString stringWithFormat:@"使用条件：单笔投资满%@元",[[dic objectForKey:@"threshold"] stringValue]];
//            }else{
//                threshold=[NSString stringWithFormat:@"使用条件：单笔投资满%@元",[dic objectForKey:@"threshold"]];
//            }
//        }
//        self.conditionLabel.text=threshold;
//        
//        if ([[NSString stringWithFormat:@"%@",dic[@"activityId"]] isEqualToString:@"0"]) {
//            NSLog(@"%@----",dic[@"voteActName"]);
//            self.coinView.addlab.text =[NSString stringWithFormat:@"红包来源：%@",[NSString stringWithFormat:@"%@",dic[@"voteActName"]]];
//        }else{
//            
//            self.coinView.addlab.text =[NSString stringWithFormat:@"红包来源：%@",dic[@"activityName"]];
//        };
//    } else {
//        self.coinView.namelab.text = dic[@"giftType"];
//        self.effectNoticeLabel.text = @" [可直接兑现为余额]";
//        self.conditionLabel.text = [NSString stringWithFormat:@"红包来源：%@",dic[@"activityName"]];
//        self.sourceLabel.text = @"";
//    }
    
    NSString* money=@"";
    NSString * jiaxi = @"";
    if (![[dic objectForKey:@"money"] isKindOfClass:[NSNull class]]) {
        if ([[dic objectForKey:@"money"] isKindOfClass:[NSNumber class]]) {
            money=[NSString stringWithFormat:@"%@",[[dic objectForKey:@"money"] stringValue]];
        }else{
            money=[NSString stringWithFormat:@"%@",[dic objectForKey:@"money"]];
           
            
            
        }
    }
    if (![[dic objectForKey:@"giftTypeId"] isKindOfClass:[NSNull class]]) {
       if ([dic[@"giftTypeId"] isEqualToString:@"add_interest_voucher"]) {
          if (![[dic objectForKey:@"rate"] isKindOfClass:[NSNull class]]) {
              if ([[dic objectForKey:@"rate"] isKindOfClass:[NSNumber class]]) {
                  jiaxi=[NSString stringWithFormat:@"%@",[[dic objectForKey:@"rate"] stringValue]];
              }else{
                  jiaxi=[NSString stringWithFormat:@"%@",[dic objectForKey:@"rate"]];
                  
                  
                  
              }
          }
        }
    }
    
    money = [NSString stringWithFormat:@" ¥ %.2f",[money floatValue]];
    NSLog(@"=========%lu",(unsigned long)money.length);
    if (money.length >= 7) {
        self.moneyLabel.font = [UIFont fontWithName:@"Helvetica Neue Bold" size:14.0];
    } else if (money.length >= 6) {
        self.moneyLabel.font = [UIFont fontWithName:@"Helvetica Neue Bold" size:19.0];
    } else if (money.length >= 5) {
        self.moneyLabel.font = [UIFont fontWithName:@"Helvetica Neue Bold" size:22.0];
    } else {
        self.moneyLabel.font = [UIFont fontWithName:@"Helvetica Neue Bold" size:22.0];
    }
    
    
    // NSString * first;
    NSArray *array = [money componentsSeparatedByString:@"."];
    
    
    self.coinView.monerylab.text = array[0];
//    self.coinView.timelab.text =[NSString stringWithFormat:@"有效期至：%@",dic[@"exp"]];
//    if ([[NSString stringWithFormat:@"%@",dic[@"activityId"]] isEqualToString:@"0"]) {
//        NSLog(@"%@----",dic[@"voteActName"]);
//        self.coinView.addlab.text =[NSString stringWithFormat:@"红包来源：%@",[NSString stringWithFormat:@"%@",dic[@"voteActName"]]];
//    }else{
//        
//        self.coinView.addlab.text =[NSString stringWithFormat:@"红包来源：%@",dic[@"activityName"]];
//    };
//    self.coinView.takelab.text = [NSString stringWithFormat:@"使用条件：单笔投资满%@元",dic[@"threshold"]];
    
    CGSize size = [self.coinView.monerylab.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:self.coinView.monerylab.font,NSFontAttributeName, nil]];
    CGFloat nameW = size.width;
    //    self.coinView.namelab.font = [UIFont fontWithName:@"Helvetica Neue Bold" size:25+a*3];
    if ([dic[@"giftTypeId"] isEqualToString:@"add_interest_voucher"]) {
        
        self.coinView.monerylab.text = [NSString stringWithFormat:@"%@ %%",jiaxi];
        
    }else{
    self.coinView.monerylab.frame = CGRectMake(self.coinView.monerylab.frame.origin.x, self.coinView.monerylab.frame.origin.y, nameW, self.coinView.monerylab.frame.size.height);
    //self.coinView.monerylab.backgroundColor = [UIColor redColor];
    
    
    self.coinView.secondmonry.text = [NSString stringWithFormat:@".%@",array[1]];
    self.coinView.secondmonry.frame = CGRectMake(CGRectGetMaxX(self.coinView.monerylab.frame), CGRectGetMinY(self.coinView.monerylab.frame)+15, 50, 20);
    //    [self.coinView addSubview:mouthlab];
    }
}



@end
