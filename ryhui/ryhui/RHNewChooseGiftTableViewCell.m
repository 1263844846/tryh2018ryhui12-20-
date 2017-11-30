//
//  RHNewChooseGiftTableViewCell.m
//  ryhui
//
//  Created by 糊涂虫 on 15/7/22.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHNewChooseGiftTableViewCell.h"
#import "ResultViewController.h"
@implementation RHNewChooseGiftTableViewCell
//@synthesize coinView;
- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    ResultViewController *primaryView = [[ResultViewController alloc] init
                                         ];
    
    //primaryView.view.backgroundColor = [UIColor redColor];
    self.profileView = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"红包页-15"]];
    
    
    //self.backgroundColor = [UIColor redColor];
    // self.coinView.backgroundColor = [UIColor redColor];
    
    [self.coinView setPrimaryView: primaryView.view];
    [self.coinView setSecondaryView: self.profileView];
    [self.coinView setSpinTime:1.0];
    self.mouthlab = [[UILabel alloc]init];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)updateCell:(NSDictionary*)dic {
    
    self.coinView.bigbtn.hidden = YES;
    float a;
    if ([UIScreen mainScreen].bounds.size.width >320) {
        a = 1;
    }else{
        
        a = 0;
    }
    if ([dic[@"giftType"] isEqualToString:@"投资现金"]){
         self.coinView.namelab1.textColor = [RHUtility colorForHex:@"7d7d7d"];
        self.coinView.threelab.hidden = YES;
        self.coinView.forlab.hidden = YES;
        NSString* money=@"";
        if (![[dic objectForKey:@"money"] isKindOfClass:[NSNull class]]) {
            if ([[dic objectForKey:@"money"] isKindOfClass:[NSNumber class]]) {
                money=[NSString stringWithFormat:@"%@",[[dic objectForKey:@"money"] stringValue]];
            }else{
                money=[NSString stringWithFormat:@"%@",[dic objectForKey:@"money"]];
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
        self.coinView.fourlab.text = [NSString stringWithFormat:@"有效期至：%@",dic[@"exp"]];
        //self.coinView.monerylab.text = money;
//        self.coinView.timelab.text =[NSString stringWithFormat:@"有效期至：%@",dic[@"exp"]];
        self.coinView.monerylab.textColor = [RHUtility colorForHex:@"878787"];
        self.coinView.takelab.text = [NSString stringWithFormat:@"[%@]",dic[@"activityName"]];
//        self.coinView.addlab.text =[NSString stringWithFormat:@"3.限%@个月(含)以上项目",dic[@"limitTime"]];
        self.coinView.timelab.text =[NSString stringWithFormat:@"单笔投资满%@元可用",dic[@"threshold"]];
        self.coinView.twolab.text =@"2.每笔投资仅可使用一张";
        self.coinView.button.hidden = YES;
        
//        self.coinView.timelab.text =[NSString stringWithFormat:@"有效期至：%@",dic[@"exp"]];
        if ([[NSString stringWithFormat:@"%@",dic[@"activityId"]] isEqualToString:@"0"]) {
            NSLog(@"%@----",dic[@"voteActName"]);
            self.coinView.takelab.text =[NSString stringWithFormat:@"[%@]",dic[@"voteActName"]];
        }else{
            
            self.coinView.takelab.text =[NSString stringWithFormat:@"[%@]",dic[@"activityName"]];
        }
//        self.coinView.takelab.text = [NSString stringWithFormat:@"使用条件：单笔投资满%@元",dic[@"threshold"]];
//        //self.coinView.button.tag = 10;
//        self.coinView.twolab.text =[NSString stringWithFormat:@"2.单笔投资满%@元可用;",dic[@"threshold"]];
        self.coinView.takelab.textColor = [RHUtility colorForHex:@"7d7d7d"];
//        self.coinView.addlab.textColor = [RHUtility colorForHex:@"7d7d7d"];
//        self.coinView.timelab.textColor = [RHUtility colorForHex:@"7d7d7d"];
        self.coinView.namelab1.textColor = [RHUtility colorForHex:@"7d7d7d"];
        self.coinView.timelab.textColor = [RHUtility colorForHex:@"4b4b4b"];
        self.coinView.addlab.textColor = [RHUtility colorForHex:@"4b4b4b"];
        
        self.coinView.fourlab.textColor = [RHUtility colorForHex:@"4b4b4b"];
        double limitTime;
        if (!dic[@"limitTime"]||![dic[@"limitTime"] isKindOfClass:[NSNull class]]) {
            //self.coinView.threelab.text = [NSString stringWithFormat:@"3.限%@个月(含)以上项目",dic[@"limitTime"]];
             self.coinView.addlab.text =[NSString stringWithFormat:@"限%@个月(含)以上项目",dic[@"limitTime"]];
            limitTime = [dic[@"limitTime"] doubleValue];
        }else{
            
             self.coinView.addlab.text =[NSString stringWithFormat:@"限1个月(含)以上项目"];
           // self.coinView.threelab.text = [NSString stringWithFormat:@"3.限1个月(含)以上项目"];
            limitTime = 1;
        }
        
        // int limitTime;
        NSArray *array = [money componentsSeparatedByString:@"."];
        self.coinView.monerylab.text = array[0];
        CGSize size = [self.coinView.monerylab.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:self.coinView.monerylab.font,NSFontAttributeName, nil]];
        CGFloat nameW = size.width;
        //    self.coinView.namelab.font = [UIFont fontWithName:@"Helvetica Neue Bold" size:25+a*3];
        
        self.coinView.monerylab.frame = CGRectMake(self.coinView.monerylab.frame.origin.x, self.coinView.monerylab.frame.origin.y, nameW, self.coinView.monerylab.frame.size.height);
        //self.coinView.monerylab.backgroundColor = [UIColor redColor];
        
        self.coinView.secondmonry.text = [NSString stringWithFormat:@".%@",array[1]];
        self.coinView.secondmonry.frame = CGRectMake(CGRectGetMaxX(self.coinView.monerylab.frame), CGRectGetMinY(self.coinView.monerylab.frame)+15, 50, 20);
        
        //        self.mouthlab.text = [NSString stringWithFormat:@".%@",array[1]];
        //        [self.coinView addSubview:self.mouthlab];
        if ([self.monthorday isEqualToString:@"day"]) {
            limitTime = limitTime*30;
        }
        if (self.investNum >= [dic[@"threshold"] floatValue]&& self.mouthNum >= limitTime) {
            self.coinView.shiyolab.text = @"可使用";
            self.coinView.bximage.userInteractionEnabled = YES;
            self.coinView.monerylab.textColor = [RHUtility colorForHex:@"F89779"];
            self.coinView.secondmonry.textColor = [RHUtility colorForHex:@"F89779"];
            self.coinView.shiyolab.textColor = [RHUtility colorForHex:@"F89779"];
        }else{
            self.profileView.image= [UIImage imageNamed:@"红包页-23"];
            self.coinView.shiyolab.text = @"不可用";
            self.coinView.shiyolab.textColor = [RHUtility colorForHex:@"bcbcbc"];
            self.coinView.namelab.textColor = [RHUtility colorForHex:@"bcbcbc"];
            self.coinView.namelab1.textColor = [RHUtility colorForHex:@"bcbcbc"];
            self.coinView.monerylab.textColor = [RHUtility colorForHex:@"bcbcbc"];
            self.coinView.takelab.textColor = [RHUtility colorForHex:@"bcbcbc"];
            self.coinView.addlab.textColor = [RHUtility colorForHex:@"bcbcbc"];
            self.coinView.timelab.textColor = [RHUtility colorForHex:@"bcbcbc"];
            self.coinView.secondmonry.textColor = [RHUtility colorForHex:@"bcbcbc"];
             self.coinView.fourlab.textColor = [RHUtility colorForHex:@"bcbcbc"];
            
            //        self.coinView.namelab.textColor = [RHUtility colorForHex:@"bcbcbc"];
            //        self.coinView.namelab.textColor = [RHUtility colorForHex:@"bcbcbc"];
            self.coinView.bximage.image =[UIImage imageNamed:@"红包页-22"] ;
            //            self.coinView.button.hidden = YES;
            
        }
        //   money = [NSString stringWithFormat:@" ¥ %.2f",[money floatValue]];
        
    }else if ([dic[@"giftTypeId"] isEqualToString:@"add_interest_voucher"]){
        NSString* money=@"";
        if (![[dic objectForKey:@"rate"] isKindOfClass:[NSNull class]]) {
            if ([[dic objectForKey:@"money"] isKindOfClass:[NSNumber class]]) {
                money=[NSString stringWithFormat:@"%@",[[dic objectForKey:@"rate"] stringValue]];
            }else{
                money=[NSString stringWithFormat:@"%@",[dic objectForKey:@"rate"]];
            }
        }
         self.coinView.namelab1.textColor = [RHUtility colorForHex:@"7d7d7d"];
        self.profileView.image = [UIImage imageNamed:@"红包页-14"];
        self.coinView.fourlab.text = [NSString stringWithFormat:@"有效期至：%@",dic[@"exp"]];
        self.coinView.monerylab.textColor =  [RHUtility colorForHex:@"#4abac0"];
       
        self.coinView.bximage.image = [UIImage imageNamed:@"红包页-07"];
        self.coinView.secondmonry.textColor = [RHUtility colorForHex:@"#f89779"];
//        self.coinView.namelab.text = @"加息券";
        self.coinView.namelab.text = dic[@"giftType"];
        self.coinView.monerylab.text = [NSString stringWithFormat:@"%@ %%",money];
        NSString *str = [NSString stringWithFormat:@"%@",dic[@"upperDays"]];
        if ([dic[@"upperDays"] isKindOfClass:[NSNull class]]) {
            str = @"360";
        }
        self.coinView.namelab1.text = [NSString stringWithFormat:@" 加息%@天",str];
        //            NSDictionary *attributes = @{NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]};
        NSMutableAttributedString *netString = [[NSMutableAttributedString alloc] initWithString:self.coinView.namelab1.text];
        //            [netString addAttributes:attributes range:NSMakeRange(4, 2)];
//        [netString addAttribute:NSForegroundColorAttributeName value:[UIColor yellowColor] range:NSMakeRange(4,2)];
        if (str.length==1) {
            [netString addAttribute:NSForegroundColorAttributeName value:[RHUtility colorForHex:@"#4abac0"] range:NSMakeRange(3,1)];
        }else if (str.length ==2){
            
            [netString addAttribute:NSForegroundColorAttributeName value:[RHUtility colorForHex:@"#4abac0"] range:NSMakeRange(3,2)];
        }else if(str.length ==3){
            
            [netString addAttribute:NSForegroundColorAttributeName value:[RHUtility colorForHex:@"#4abac0"] range:NSMakeRange(3,3)];
        }
        self.coinView.namelab1.attributedText = netString;
//        self.coinView.timelab.text =[NSString stringWithFormat:@"有效期至：%@",dic[@"exp"]];
        self.coinView.monerylab.textColor = [RHUtility colorForHex:@"878787"];
//        self.coinView.addlab.text =[NSString stringWithFormat:@"红包来源：%@",dic[@"activityName"]];
//        self.coinView.takelab.text = [NSString stringWithFormat:@"使用条件：单笔投资满%@元",dic[@"threshold"]];
        self.coinView.button.hidden = YES;
        self.coinView.fourlab.text = [NSString stringWithFormat:@"有效期至：%@",dic[@"exp"]];
        self.coinView.takelab.text = [NSString stringWithFormat:@"[%@]",dic[@"activityName"]];
//        self.coinView.addlab.text =[NSString stringWithFormat:@"限%@个月(含)以上项目",dic[@"limitTime"]];
//        self.coinView.timelab.text =[NSString stringWithFormat:@"加息本金上限%@元",dic[@"upperMoney"]];
         self.coinView.timelab.text =[NSString stringWithFormat:@"参与加息的本金最大%@元",dic[@"upperMoney"]];
//        self.coinView.timelab.text =[NSString stringWithFormat:@"有效期至：%@",dic[@"exp"]];
        self.coinView.firlab.text = @"1.投资时选择此红包可增加年化收益";
        self.coinView.twolab.text = @"2.每笔投资仅可使用一张";
//        self.coinView.threelab.text = @"3.加息上限为参与加息的本金最大金额";
         self.coinView.threelab.text = [NSString stringWithFormat:@"3.参与加息的投资本金最大为%@元",dic[@"upperMoney"]];
        self.coinView.forlab.text = [NSString stringWithFormat:@"4.单笔投资满%@元可用",dic[@"threshold"]];
        if ([[NSString stringWithFormat:@"%@",dic[@"activityId"]] isEqualToString:@"0"]) {
            NSLog(@"%@----",dic[@"voteActName"]);
            self.coinView.takelab.text = [NSString stringWithFormat:@"[%@]",dic[@"voteActName"]];
//            self.coinView.addlab.text =[NSString stringWithFormat:@"红包来源：%@",dic[@"voteActName"]];
        }else{
            
            self.coinView.takelab.text =[NSString stringWithFormat:@"[%@]",dic[@"activityName"]];
        }
//        self.coinView.takelab.text = [NSString stringWithFormat:@"使用条件：单笔投资满%@元",dic[@"threshold"]];
//        //self.coinView.button.tag = 10;
//        self.coinView.twolab.text =[NSString stringWithFormat:@"2.单笔投资满%@元可用;",dic[@"threshold"]];
        self.coinView.takelab.textColor = [RHUtility colorForHex:@"7d7d7d"];
      
//        self.coinView.namelab1.textColor = [RHUtility colorForHex:@"7d7d7d"];
        self.coinView.timelab.textColor = [RHUtility colorForHex:@"4b4b4b"];
        self.coinView.addlab.textColor = [RHUtility colorForHex:@"4b4b4b"];
        
        self.coinView.fourlab.textColor = [RHUtility colorForHex:@"4b4b4b"];
        double limitTime;
        if (!dic[@"limitTime"]||![dic[@"limitTime"] isKindOfClass:[NSNull class]]) {
            self.coinView.addlab.text = [NSString stringWithFormat:@"限%@个月(含)以上项目",dic[@"limitTime"]];
            limitTime = [dic[@"limitTime"] doubleValue];
        }else{
            
            self.coinView.addlab.text = [NSString stringWithFormat:@"限1个月(含)以上项目"];
            limitTime = 1;
        }
        
        if (self.investNum >= [dic[@"threshold"] floatValue]&& self.mouthNum >= limitTime) {
            self.coinView.shiyolab.text = @"可使用";
            self.coinView.bximage.userInteractionEnabled = YES;
            self.coinView.monerylab.textColor = [RHUtility colorForHex:@"4abac0"];
            self.coinView.secondmonry.textColor = [RHUtility colorForHex:@"F89779"];
            self.coinView.shiyolab.textColor = [RHUtility colorForHex:@"4abac0"];
        }else{
            self.profileView.image= [UIImage imageNamed:@"红包页-23"];
            self.coinView.shiyolab.text = @"不可用";
            self.coinView.shiyolab.textColor = [RHUtility colorForHex:@"bcbcbc"];
            self.coinView.namelab.textColor = [RHUtility colorForHex:@"bcbcbc"];
            self.coinView.namelab1.textColor = [RHUtility colorForHex:@"bcbcbc"];
            self.coinView.monerylab.textColor = [RHUtility colorForHex:@"bcbcbc"];
            self.coinView.takelab.textColor = [RHUtility colorForHex:@"bcbcbc"];
            self.coinView.addlab.textColor = [RHUtility colorForHex:@"bcbcbc"];
            self.coinView.timelab.textColor = [RHUtility colorForHex:@"bcbcbc"];
            self.coinView.secondmonry.textColor = [RHUtility colorForHex:@"bcbcbc"];
            self.coinView.fourlab.textColor = [RHUtility colorForHex:@"bcbcbc"];
            //        self.coinView.namelab.textColor = [RHUtility colorForHex:@"bcbcbc"];
            //        self.coinView.namelab.textColor = [RHUtility colorForHex:@"bcbcbc"];
            self.coinView.bximage.image =[UIImage imageNamed:@"红包页-22"] ;
            //            self.coinView.button.hidden = YES;
            
        }

    }
}
@end
