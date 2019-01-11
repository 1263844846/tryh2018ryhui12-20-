//
//  AGAlertListView.m
//  AlertListView
//
//  Created by Angelo on 17/2/23.
//  Copyright © 2017年 Angelo. All rights reserved.
//

#import "AGAlertListView.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width

#define kScreenHeight [UIScreen mainScreen].bounds.size.height


@interface AGAlertListView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic , strong)UIPickerView *dataPickerView;

@property (nonatomic , strong)NSArray<NSString*> *dataArray;

@end

@implementation AGAlertListView

+ (void)showWithOptions:(NSArray<NSString *> *)options delegate:(id<AGAlertListDelegate>)delegate{
    AGAlertListView *listView = [[AGAlertListView alloc] initWithOptions:options];
    listView.delegate = delegate;
    [[[UIApplication sharedApplication].delegate window] addSubview:listView];
}

+ (void)showWithOptions:(NSArray<NSString *> *)options selected:(NSInteger)index delegate:(id<AGAlertListDelegate>)delegate{
    AGAlertListView *listView = [[AGAlertListView alloc] initWithOptions:options selected:index];
    listView.delegate = delegate;
    [[[UIApplication sharedApplication].delegate window] addSubview:listView];
}


- (instancetype)initWithOptions:(NSArray<NSString *> *)options{
    if (self = [super init]) {
        self.dataArray = options;
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, (kScreenHeight / 3)*2-30 , kScreenWidth , kScreenHeight / 3)];
        bgView.backgroundColor = [UIColor grayColor];
        bgView.layer.masksToBounds = YES;
        bgView.layer.cornerRadius = 5;
        [self addSubview:bgView];
        [bgView addSubview:self.dataPickerView];

        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.frame = CGRectMake(0, CGRectGetMinY(self.dataPickerView.frame) - 1, kScreenWidth * 0.5, 43);
        [cancelBtn setTitle:@"     取消" forState: UIControlStateNormal];
        cancelBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
        [cancelBtn setBackgroundColor:[UIColor whiteColor]];
        [cancelBtn addTarget:self action:@selector(ag_cancelClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:cancelBtn];
        
        UIButton *trueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        trueBtn.frame = CGRectMake(kScreenWidth -100, CGRectGetMinY(self.dataPickerView.frame) - 1, 80, 43);
        UILabel * lab = [[UILabel alloc]init];
        lab.frame = CGRectMake(kScreenWidth *0.5, CGRectGetMinY(self.dataPickerView.frame) - 1, kScreenWidth *0.5, 43);
        lab.backgroundColor = [UIColor whiteColor];
        [trueBtn setTitle:@"确定" forState: UIControlStateNormal];
        trueBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [trueBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [trueBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
        [trueBtn setBackgroundColor:[UIColor whiteColor]];
        [trueBtn addTarget:self action:@selector(ag_trueClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:lab];
        [bgView addSubview:trueBtn];
        
        UITapGestureRecognizer *removeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ag_dismiss)];
        [self addGestureRecognizer:removeTap];
        
    }
    return self;
}

- (instancetype)initWithOptions:(NSArray<NSString *> *)options selected:(NSInteger)index{
    if (self = [self initWithOptions:options]) {
        [self.dataPickerView selectRow:index inComponent:0 animated:YES];
    }
    return self;
}

- (UIPickerView *)dataPickerView{
    if (!_dataPickerView) {
        _dataPickerView = [[UIPickerView alloc] init];
        _dataPickerView.frame = CGRectMake(0, 0, kScreenWidth , kScreenHeight / 3 );
        _dataPickerView.delegate = self;
        _dataPickerView.dataSource = self;
        _dataPickerView.backgroundColor = [RHUtility colorForHex:@"#F0F0F0"];;
    }
    return _dataPickerView;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.dataArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.dataArray[row];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 35;
}

- (void)ag_dismiss{
    [self removeFromSuperview];
}

- (void)ag_cancelClickAction:(UIButton*)sender{
    [self ag_dismiss];
}

- (void)ag_trueClickAction:(UIButton*)sender{
    NSInteger index = [_dataPickerView selectedRowInComponent:0];
    __weak typeof(self) wearkSelf = self;
    if ([self.delegate respondsToSelector:@selector(ag_selectWithListView:indes:option:)]) {
        [self.delegate ag_selectWithListView:wearkSelf indes:index option:wearkSelf.dataArray[index]];
    }
    [self ag_dismiss];
}


- (NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSArray array];
    }
    return _dataArray;
}





@end
