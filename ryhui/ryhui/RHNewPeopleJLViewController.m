//
//  RHNewPeopleJLViewController.m
//  ryhui
//
//  Created by 糊涂虫 on 16/10/27.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import "RHNewPeopleJLViewController.h"
#import "RHDetailJLTableViewCell.h"
@interface RHNewPeopleJLViewController ()
{
    RHDetailJLTableViewCell* cell;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation RHNewPeopleJLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSSet * set = [NSSet setWithArray:self.dataArray];
    [self.dataArray removeAllObjects];
    NSArray * aa = [set allObjects];
    self.dataArray = [NSMutableArray arrayWithArray:aa];
    
    NSMutableArray * array = [NSMutableArray array];
    
    
    for (NSDictionary * dicc in self.dataArray) {
        
        //[array addObject:@1];
        if (dicc[@"freezeId"]) {
            [array addObject:dicc[@"freezeId"] ];
        }
        
    }
    NSArray * arrr = [array sortedArrayUsingSelector:@selector(compare:)];
    
    //NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
    NSMutableArray * dataarray = [NSMutableArray array];
    
    for (int i = 0 ; i < arrr.count; i ++) {
        for (int j = 0 ; j < arrr.count; j ++) {
            
            if ([arrr[array.count-i-1] isEqualToString:self.dataArray[j][@"freezeId"]] ) {
                
                [dataarray addObject:self.dataArray[j]];
                
            }
            
        }
    }
    
    
    [self.dataArray removeAllObjects];
    
    self.dataArray = dataarray;
    
    
    //    for (NSDictionary * diccc in self.dataArray) {
    //
    //    }
    
    //    NSMutableArray * array = [NSMutableArray array];
    //    for (NSDictionary * dic in self.dataArray) {
    //
    //        [array addObject:dic[@"freezeId"]];
    //    }
    
    
    
    // [self.tableView reloadData];
    return self.dataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //[self.tableView reloadData];
    static NSString *CellIdentifier = @"jlCellIdentifier";
    
    cell = (RHDetailJLTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"RHDetailJLTableViewCell" owner:nil options:nil] objectAtIndex:0];
    }
    if (self.dataArray.count > 0) {
        NSDictionary* getDataDic =[self.dataArray objectAtIndex:indexPath.row];
        [cell updateCell:getDataDic];
        //        NSLog(@"1-----%f",cell.priceLabel.frame.origin.x);
        // CGFloat a = self.touzijinerlable.frame.origin.x;
        //        NSLog(@"2------%f",a);
        //        NSLog(@"%f",self.touzijinerlable.frame.size.width);
        //        CGRect rect = cell.priceLabel.frame;
        //CGFloat b = cell.nameLabel.frame.origin.y;
        //        CGFloat w = rect.size.width;
        //        CGFloat h = rect.size.height;
        //        cell.priceLabel.frame = CGRectMake(a, b, 95, h);
        //
        //        NSLog(@"3------%f",cell.priceLabel.frame.origin.x);
        //        CGFloat b = self.touzijinerlable.frame.origin.x;
        //        NSLog(@"%f",cell.nameLabel.frame.origin.x) ;
        //        NSLog(@"%f",a);
        // cell.priceLabel.hidden = YES;
        // UILabel *lab= [[UILabel alloc]initWithFrame:CGRectMake(a+10, b, 95, 21)];
        
        //        lab.text = cell.priceLabel.text;
        //        lab.font = [UIFont fontWithName:cell.priceLabel.text size:13];
        //[cell addSubview:lab];
    }
    
    
    
    
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
