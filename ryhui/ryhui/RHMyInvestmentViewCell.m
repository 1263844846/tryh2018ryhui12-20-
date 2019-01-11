//
//  RHMyInvestmentViewCell.m
//  ryhui
//
//  Created by stefan on 15/3/15.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHMyInvestmentViewCell.h"
#import "RHContractViewContoller.h"
#import "RHInvestDetailViewController.h"
#import "RHXMJWebXQViewController.h"
#import "RHXMJxqjhViewController.h"
#import "RHXYWebviewViewController.h"
@implementation RHMyInvestmentViewCell
@synthesize nav;
@synthesize projectId;

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
   
    
}

-(void)updateCell:(NSDictionary*)dic
{
//    DLog(@"%@",dic);
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(regist)];
    self.nameLabel.text=[dic objectForKey:@"name"];
    self.projectId=[dic objectForKey:@"id"];
    
    NSString* investMoney=@"0.00";
    if (![[dic objectForKey:@"investMoney"] isKindOfClass:[NSNull class]]) {
        investMoney=[NSString stringWithFormat:@"%.2f",[[dic objectForKey:@"investMoney"] doubleValue]];
    }
    self.investMoneyLabel.text=investMoney;
    NSString* backMoney=@"0.00";
    if (![[dic objectForKey:@"backMoney"] isKindOfClass:[NSNull class]]) {
        backMoney=[NSString stringWithFormat:@"%.2f",[[dic objectForKey:@"backMoney"] doubleValue]];
    }
    self.backMoneyLabel.text=backMoney;
    
    self.profitMoneyLabel.text=[NSString stringWithFormat:@"%.2f",[[dic objectForKey:@"waitMoney"] doubleValue]];
}

//合同
- (IBAction)contractAction:(id)sender {
    NSDictionary *parameters = @{@"projectId":self.projectId};
    [[RHNetworkService instance] POST:@"front/payment/agreement/judgeBaoquanContractGenerate" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        DLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            if ([responseObject[@"msg"] isEqualToString:@"loading"]) {
                
                [RHUtility showTextWithText:responseObject[@"content"]];
                return ;
                
            }else if([responseObject[@"msg"] isEqualToString:@"init"]){
                
//                RHContractViewContoller* controller=[[RHContractViewContoller alloc]initWithNibName:@"RHContractViewContoller" bundle:nil];
//                controller.isAgreen=YES;
//
//               controller.projectId=self.projectId;
//
                
                RHXYWebviewViewController * controller = [[RHXYWebviewViewController alloc]initWithNibName:@"RHXYWebviewViewController" bundle:nil];
//                if([self.xmjres isEqualToString:@"xmj"]){
//                    controller.projectid = self.xmjfirst;
//                }else{
                    controller.projectid = self.projectId;
//                }
                controller.namestr = @"借款协议范本";
               
                
                [nav pushViewController:controller animated:YES];
                
                // [self.textFiled resignFirstResponder];
//                [self.touzitextfFiled resignFirstResponder];
                
            }else{
                
                RHContractViewContoller* controller=[[RHContractViewContoller alloc]initWithNibName:@"RHContractViewContoller" bundle:nil];
                controller.projectId=self.projectId;
                [nav pushViewController:controller animated:YES];
            }
           
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       
    }];
    
    
    
}

//还款计划
- (IBAction)pushInvestDetail:(id)sender {
    RHInvestDetailViewController* controller=[[RHInvestDetailViewController alloc] initWithNibName:@"RHInvestDetailViewController" bundle:nil];
    if ([self.type isEqualToString:@"{\"groupOp\":\"AND\",\"rules\":[{\"field\":\"project.project_status\",\"op\":\"in\",\"data\":[\"full\",\"loans\",\"published\",\"loans_audit\"]}]}"]) {
        controller.res = 3;
    }
    controller.projectId=self.projectId;
//    controller.myblock();
    [nav pushViewController:controller animated:YES];
}

- (IBAction)xmjpush:(id)sender {
    
    RHXMJxqjhViewController * vc = [[RHXMJxqjhViewController alloc]initWithNibName:@"RHXMJxqjhViewController" bundle:nil];
    vc.projectid = self.projectId;
    [self.nav pushViewController:vc animated:YES];
    return;
    
    
//    NSDictionary *parameters = @{@"projectId":self.projectId};
    RHXMJWebXQViewController* controller=[[RHXMJWebXQViewController alloc]initWithNibName:@"RHXMJWebXQViewController" bundle:nil];
    controller.projectid=self.projectId;
    [nav pushViewController:controller animated:YES];
}

@end
