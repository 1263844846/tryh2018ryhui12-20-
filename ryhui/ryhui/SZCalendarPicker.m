//
//  SZCalendarPicker.m
//  SZCalendarPicker
//
//  Created by Stephen Zhuang on 14/12/1.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "SZCalendarPicker.h"
#import "SZCalendarCell.h"
#import "UIColor+ZXLazy.h"
#import "SZCalentwoCell.h"
#import "MBProgressHUD.h"

NSString *const SZCalendarCellIdentifier = @"celltext";

@interface SZCalendarPicker ()
@property (nonatomic , weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic , weak) IBOutlet UILabel *monthLabel;
@property (nonatomic , weak) IBOutlet UIButton *previousButton;
@property (nonatomic , weak) IBOutlet UIButton *nextButton;
@property (nonatomic , strong) NSArray *weekDayArray;
@property (nonatomic , strong) UIView *mask;
@property(nonatomic,assign)int ssssss;
@property(nonatomic,assign)BOOL res;

@property(nonatomic,strong)NSString * todaystr;
@property(nonatomic,assign)NSInteger didinter;
@property(nonatomic,strong)NSMutableArray * didarray;
@property(nonatomic,copy)NSString * strmonth;

@end

@implementation SZCalendarPicker


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
-(NSMutableArray *)didarray{
    
    if (!_didarray) {
        _didarray  = [NSMutableArray array];
    }
    return _didarray;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    _ssssss = 0;
    [self addTap];
    [self addSwipe];
    [self show];
    
    [self loaddata];
}
-(void)loaddata{
//    NSDictionary *parameters = @{@"monthDate":@"2016-06"};
    NSDictionary *parameters = @{@"monthDate":self.strmonth};
//    [self.datearray removeAllObjects];
    NSLog(@"=======%@",parameters);
//    [MBProgressHUD showHUDAddedTo:self.mask animated:YES];
    [[RHNetworkService instance] POST:@"app/common/user/appGatheringCalendar/monthGathering" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            for (NSDictionary * datedic in responseObject[@"dayGathers"]) {
                
               NSString * string = [NSString stringWithFormat:@"%d",[[datedic[@"payDate"] substringFromIndex:8] intValue]];
                [self.datearray addObject:string];
                
            }
            
            
        }
//
        [self.collectionView reloadData];

        self.myblock(self.strmonth);
       // NSLog(@"%@",responseObject);
        self.previousButton.userInteractionEnabled = YES;
        self.nextButton.userInteractionEnabled = YES;
        [MBProgressHUD hideAllHUDsForView:self animated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
        self.previousButton.userInteractionEnabled = YES;
        self.nextButton.userInteractionEnabled = YES;
         [MBProgressHUD hideAllHUDsForView:self animated:YES];
        self.myblock(self.strmonth);
    }];
    
    
}

- (void)awakeFromNib
{
    [_collectionView registerClass:[SZCalendarCell class] forCellWithReuseIdentifier:SZCalendarCellIdentifier];
    [_collectionView registerClass:[SZCalentwoCell class] forCellWithReuseIdentifier:@"666"];
     _weekDayArray = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    self.backgroundColor = [UIColor redColor];
    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"dd"];
    
    self.todaystr =[dateformatter stringFromDate:senddate];
}

- (void)customInterface
{
    CGFloat itemWidth = _collectionView.frame.size.width / 7;
    CGFloat itemHeight = _collectionView.frame.size.height / 7;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    [_collectionView setCollectionViewLayout:layout animated:YES];
    
    
}
- (NSMutableArray *)datearray{
    
    if (!_datearray) {
        _datearray = [NSMutableArray array];
    }
    return _datearray;
}

- (NSMutableArray *)timearray{
    
    if (!_timearray) {
        _timearray = [NSMutableArray array];
    }
    return _timearray;
    
}

- (void)setDate:(NSDate *)date
{
    _date = date;
//    [_monthLabel setText:[NSString stringWithFormat:@"%.2ld-%li",(long)[self month:date],(long)[self year:date]]];
   [_monthLabel setText:[NSString stringWithFormat:@"%li年%.2ld月",(long)[self year:date],(long)[self month:date]]];
    self.strmonth = [NSString stringWithFormat:@"%li-%.2ld",(long)[self year:date],(long)[self month:date]];
    
    [_collectionView reloadData];
    
}

#pragma mark - date

- (NSInteger)day:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components day];
}


- (NSInteger)month:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components month];
}

- (NSInteger)year:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components year];
}


- (NSInteger)firstWeekdayInThisMonth:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar setFirstWeekday:1];//1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    
    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    return firstWeekday - 1;
}

- (NSInteger)totaldaysInThisMonth:(NSDate *)date{
    NSRange totaldaysInMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return totaldaysInMonth.length;
}

- (NSInteger)totaldaysInMonth:(NSDate *)date{
    NSRange daysInLastMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return daysInLastMonth.length;
}

- (NSDate *)lastMonth:(NSDate *)date{
    [MBProgressHUD showHUDAddedTo:self.mask animated:YES];
    [self.didarray removeAllObjects];
     self.didinter= -1;
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = -1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}

- (NSDate*)nextMonth:(NSDate *)date{
    [MBProgressHUD showHUDAddedTo:self.mask animated:YES];
     self.didinter= -1;
    [self.didarray removeAllObjects];
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = +1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}

#pragma -mark collectionView delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        
        return _weekDayArray.count;
        
    } else {
        return 42;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SZCalendarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SZCalendarCellIdentifier forIndexPath:indexPath];
    SZCalentwoCell * cel = [collectionView dequeueReusableCellWithReuseIdentifier:@"666" forIndexPath:indexPath];
    cell.testlab.hidden = YES;
    if (indexPath.section == 0) {
        [cel.dateLabel setText:_weekDayArray[indexPath.row]];
//        [cel.dateLabel setTextColor:[UIColor colorWithHexString:@"#15cc9c"]];
        [cel.dateLabel setTextColor:[UIColor colorWithHexString:@"#6f6f6f"]];
        cel.backgroundColor = [UIColor whiteColor];
        cel.userInteractionEnabled = NO;
        return cel;
    } else {
        NSInteger daysInThisMonth = [self totaldaysInMonth:_date];
        NSInteger firstWeekday = [self firstWeekdayInThisMonth:_date];
        
        NSInteger day = 0;
        NSInteger i = indexPath.row;
        
        if (i < firstWeekday) {
            [cell.dateLabel setText:@""];
            cell.backgroundColor = [UIColor whiteColor];
            
        }else if (i > firstWeekday + daysInThisMonth - 1){
            [cell.dateLabel setText:@""];
            cell.backgroundColor = [UIColor whiteColor];
//            cell.dateLabel.backgroundColor = [UIColor whiteColor];
        }else{
            
            day = i - firstWeekday + 1;
            [cell.dateLabel setText:[NSString stringWithFormat:@"%li",(long)day]];
            [cell.dateLabel setTextColor:[UIColor colorWithHexString:@"#6f6f6f"]];
            CGFloat hue = ( arc4random() % 256 / 256.0 ); //0.0 to 1.0
            CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0,away from white
            CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5; //0.5 to 1.0,away from black
            cell.backgroundColor = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];

            cell.backgroundColor = [UIColor whiteColor];
//            for (NSDate * dada in _datearray) {
//                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            
                
                
                //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
                
//                [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//                
//                
//                
//                NSString *destDateString = [dateFormatter stringFromDate:dada];
//                cell.testlab.backgroundColor =[UIColor whiteColor];
//               destDateString = [destDateString substringFromIndex:8];
//                NSLog(@"%@",destDateString);
//            cell.testlab.backgroundColor = [UIColor whiteColor];
                if ([self.datearray containsObject:cell.dateLabel.text] ) {
//                    cell.backgroundColor = [UIColor colorWithHexString:@"#f89779"];
                    
                    [self.didarray addObject:cell.dateLabel.text];
                    [cell setlablarly];
//                    cell.testlab.backgroundColor = [UIColor redColor];
                    NSLog(@"%@------",cell.dateLabel.text);
                    NSLog(@"%@===",cell.testlab.backgroundColor);
//                    NSLog(@"%@----",self.datearray);
//                    if ([self.todaystr integerValue] > day) {
//                        
//                        [cell setlablarlye];
//                        
//                    }
                }
            
           
                
//            }
            

            if ([_today isEqualToDate:_date]) {
                if (day == [self day:_date]) {
                   // [cell.dateLabel setTextColor:[UIColor redColor]];
                   // cell.backgroundColor = [UIColor orangeColor];
                } else if (day > [self day:_date]) {
                   // [cell.dateLabel setTextColor:[UIColor colorWithHexString:@"#cbcbcb"]];
                }
            } else if ([_today compare:_date] == NSOrderedAscending) {
               // [cell.dateLabel setTextColor:[UIColor colorWithHexString:@"#cbcbcb"]];
                //cell.backgroundColor = [UIColor greenColor];
            }
            
            if (day ==self.didinter) {
                NSLog(@"-----%d",day);
                cell.testlab.backgroundColor = [UIColor colorWithHexString:@"#44BBC1"];
                [cell.dateLabel setTextColor:[UIColor whiteColor]];
                
                // xuanzhong
            }
            
       }
    }
   
    return cell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        NSInteger daysInThisMonth = [self totaldaysInMonth:_date];
        NSInteger firstWeekday = [self firstWeekdayInThisMonth:_date];
        
        NSInteger day = 0;
        NSInteger i = indexPath.row;
        
        if (i >= firstWeekday && i <= firstWeekday + daysInThisMonth - 1) {
            day = i - firstWeekday + 1;
            
            //this month
            if ([_today isEqualToDate:_date]) {
                if (day <= [self day:_date]) {
                    return YES;
                }
            } else if ([_today compare:_date] == NSOrderedDescending) {
                return YES;
            }
        }
    }
    return NO;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self.date];
    NSInteger firstWeekday = [self firstWeekdayInThisMonth:_date];
    
    NSInteger day = 0;
    NSInteger i = indexPath.row;
    day = i - firstWeekday + 1;
    if (self.calendarBlock) {
        self.calendarBlock(day, [comp month], [comp year]);
    }
    
   // NSLog(@"这是%ld",(long)day);
    //[self hide];
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([collectionView isKindOfClass:[SZCalentwoCell class]]) {
        return;
    }
    
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self.date];
    NSInteger firstWeekday = [self firstWeekdayInThisMonth:_date];
    
    NSInteger day = 0;
    NSInteger i = indexPath.row;
    day = i - firstWeekday + 1;
    NSString * string = [NSString stringWithFormat:@"%ld",(long)day];
    BOOL isbool = [self.didarray containsObject:string];
    if (!isbool) {
        return;
    }
    
    if (self.calendarBlock) {
        self.calendarBlock(day, [comp month], [comp year]);
    }
   // self.myblock(self.monthLabel.text);
    if (day <32 &&day>0) {
         NSLog(@"这是%ld",(long)day);
        
        NSString * str = [NSString stringWithFormat:@"%@-%02ld",_strmonth,(long)day];
        self.dayblock(str);
    }
    self.didinter =day;
   
    [self.collectionView reloadData];
}

- (void)loadtableviewdata{
    
    
    self.myblock(self.strmonth);
    
}

- (IBAction)previouseAction:(UIButton *)sender
{
     //self.myblock(self.monthLabel.text);
    [self.datearray removeAllObjects];
    
    [MBProgressHUD showHUDAddedTo:self animated:YES];
  
    self.previousButton.userInteractionEnabled = NO;
    [UIView transitionWithView:self duration:0.5 options:UIViewAnimationOptionTransitionCurlDown animations:^(void) {
        self.date = [self lastMonth:self.date];
          [self loaddata];
//        [_collectionView reloadData];
    } completion:nil];
}

- (IBAction)nexAction:(UIButton *)sender
{
    self.nextButton.userInteractionEnabled = NO;
//    _ssssss++;
//    NSString* timeStr = [NSString stringWithFormat:@"2016-%2d-26",_ssssss];
//    NSLog(@"%@",timeStr);
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateStyle:NSDateFormatterMediumStyle];
//    [formatter setTimeStyle:NSDateFormatterShortStyle];
//    [formatter setDateFormat:@"YYYY-MM-dd"];
//    NSDate * adate = [formatter dateFromString:timeStr];
//    NSString* timeStr1 = [NSString stringWithFormat:@"2016-%2d-25",_ssssss];
//    NSLog(@"%@",timeStr1);
//    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
//    [formatter1 setDateStyle:NSDateFormatterMediumStyle];
//    [formatter1 setTimeStyle:NSDateFormatterShortStyle];
//    [formatter1 setDateFormat:@"YYYY-MM-dd"];
//    NSDate * adate1 = [formatter dateFromString:timeStr1];
//
    
    
    
//    self.myblock(self.monthLabel.text);
     [self.datearray removeAllObjects];
//    [self.datearray addObject:adate];
//    [self.datearray addObject:adate1];
   [MBProgressHUD showHUDAddedTo:self animated:YES];
    [UIView transitionWithView:self duration:0.5 options:UIViewAnimationOptionTransitionCurlUp animations:^(void) {
        self.date = [self nextMonth:self.date];
//        [_collectionView reloadData];
         [self loaddata];
    } completion:nil];
}

+ (instancetype)showOnView:(UIView *)view
{
    SZCalendarPicker *calendarPicker = [[[NSBundle mainBundle] loadNibNamed:@"SZCalendarPicker" owner:self options:nil] firstObject];
    calendarPicker.mask = [[UIView alloc] initWithFrame:view.bounds];
    calendarPicker.mask.backgroundColor = [UIColor blackColor];
    calendarPicker.mask.alpha = 0.3;
    [view addSubview:calendarPicker.mask];
    [view addSubview:calendarPicker];
    return calendarPicker;
}

- (void)show
{
    self.transform = CGAffineTransformTranslate(self.transform, 0, - self.frame.size.height);
    [UIView animateWithDuration:0.5 animations:^(void) {
        self.transform = CGAffineTransformIdentity;
    } completion:^(BOOL isFinished) {
        [self customInterface];
    }];
}

- (void)hide
{
//    [UIView animateWithDuration:0.5 animations:^(void) {
//        self.transform = CGAffineTransformTranslate(self.transform, 0, - self.frame.size.height);
//        self.mask.alpha = 0;
//    } completion:^(BOOL isFinished) {
//        [self.mask removeFromSuperview];
//        [self removeFromSuperview];
//    }];
}


- (void)addSwipe
{
    UISwipeGestureRecognizer *swipLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(nexAction:)];
    swipLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self addGestureRecognizer:swipLeft];
    
    UISwipeGestureRecognizer *swipRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(previouseAction:)];
    swipRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self addGestureRecognizer:swipRight];
}

- (void)addTap
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    [self.mask addGestureRecognizer:tap];
}
@end
