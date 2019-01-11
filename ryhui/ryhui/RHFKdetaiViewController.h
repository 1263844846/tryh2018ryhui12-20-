//
//  RHFKdetaiViewController.h
//  ryhui
//
//  Created by 糊涂虫 on 16/4/11.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^myblock)() ;
@interface RHFKdetaiViewController : UIViewController
@property(nonatomic,copy)NSString * projectid;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,copy)NSString * type;
@property(nonatomic,strong)NSDictionary * datadic;
@property(nonatomic,strong)UINavigationController *nav;
@property(nonatomic,copy)NSString * nhstr;
@property(nonatomic,copy)NSString * mouthstr;
@property(nonatomic,copy)myblock myblock;

@property(nonatomic,assign)BOOL studentres;
@property(nonatomic,assign)BOOL xiaofeires;
@property(nonatomic,copy)NSString *oldnew;
@end
