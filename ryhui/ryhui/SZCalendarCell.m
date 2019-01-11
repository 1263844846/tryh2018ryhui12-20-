//
//  SZCalendarCell.m
//  SZCalendarPicker
//
//  Created by Stephen Zhuang on 14/12/1.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "SZCalendarCell.h"
#import "UIColor+ZXLazy.h"
@implementation SZCalendarCell
- (UILabel *)dateLabel
{
    if (!_dateLabel) {
        
        self.testlab = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 30, 30)];
        [self addSubview:self.testlab];
        
//        self.testlab.hidden = YES;
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 30, 30)];
        
        //[_dateLabel setTextAlignment:NSTextAlignmentCenter];
        [_dateLabel setFont:[UIFont systemFontOfSize:17]];
        [self addSubview:_dateLabel];
        _dateLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _dateLabel;
}
- (void)setlablarly{
    self.testlab.hidden = NO;
    self.testlab.backgroundColor = [UIColor colorWithHexString:@"#E4E6E6"];
    [self.testlab.layer  setMasksToBounds:YES];
    [self.testlab.layer setCornerRadius:15.0];
}
- (void)setlablarlye{
    self.testlab.hidden = NO;
    self.testlab.backgroundColor = [UIColor colorWithHexString:@"#bcbcbc"];
    [self.testlab.layer  setMasksToBounds:YES];
    [self.testlab.layer setCornerRadius:15.0];
}
@end
