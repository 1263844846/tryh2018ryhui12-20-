//
//  SZCalentwoCell.m
//  极光推送
//
//  Created by 糊涂虫 on 15/12/29.
//  Copyright © 2015年 Light. All rights reserved.
//

#import "SZCalentwoCell.h"

@implementation SZCalentwoCell
- (UILabel *)dateLabel
{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(7, 10, 30, 20)];
        //[_dateLabel setTextAlignment:NSTextAlignmentCenter];
        [_dateLabel setFont:[UIFont systemFontOfSize:17]];
        _dateLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_dateLabel];
    }
    return _dateLabel;
}
@end
