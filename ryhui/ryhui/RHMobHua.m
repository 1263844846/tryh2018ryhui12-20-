//
//  RHMobHua.m
//  ryhui
//
//  Created by 糊涂虫 on 15/11/25.
//  Copyright © 2015年 stefan. All rights reserved.
//

#import "RHMobHua.h"

@implementation RHMobHua

+ (UIColor *)colorForHex:(NSString *)hexColor
{
    // String should be 6 or 7 characters if it includes '#'
    if ([hexColor length]  < 6)
        return nil;
    
    // strip # if it appears
    if ([hexColor hasPrefix:@"#"])
        hexColor = [hexColor substringFromIndex:1];
    
    // if the value isn't 6 characters at this point return
    // the color black
    if ([hexColor length] != 6)
        return nil;
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    NSString *rString = [hexColor substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [hexColor substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [hexColor substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
    
}

+(void)showTextWithText:(NSString*)text
{
    //    UIView* customView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, [text sizeWithFont:[UIFont boldSystemFontOfSize:18] forWidth:100 lineBreakMode:NSLineBreakByCharWrapping].height)];
    
    BDKNotifyHUD* hud=[BDKNotifyHUD notifyHUDWithView:nil text:text];
    hud.center = CGPointMake([UIApplication sharedApplication].keyWindow.center.x, [UIApplication sharedApplication].keyWindow.center.y - 70);
    hud.tag = 1212;
    [[UIApplication sharedApplication].keyWindow addSubview:hud];
    [hud presentWithDuration:2.0f speed:0.5f inView:[UIApplication sharedApplication].keyWindow completion:^{
        [hud removeFromSuperview];
    }];
}

+(void)tabMainViewConntroller
{
    
}


@end
