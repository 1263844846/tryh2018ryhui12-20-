//
//  RHHelperCollectionViewCell.h
//  ryhui
//
//  Created by 糊涂虫 on 16/5/5.
//  Copyright © 2016年 stefan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RHHelperCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *namelab;

- (void)update:(NSString *)str;
@end
