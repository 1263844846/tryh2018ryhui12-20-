//
//  RHIntroductionViewController.m
//  ryhui
//
//  Created by jufenghudong on 15/4/14.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHIntroductionViewController.h"
#import "RHOfficeNetAndWeiBoViewController.h"
@interface RHIntroductionViewController ()
@property (weak, nonatomic) IBOutlet UILabel *officeNetLabel;

@end

@implementation RHIntroductionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configBackButton];
    [self configTitleWithString:@"平台介绍"];
    
    NSDictionary *attributes = @{NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *netString = [[NSMutableAttributedString alloc] initWithString:_officeNetLabel.text];
    [netString addAttributes:attributes range:NSMakeRange(0, netString.length)];
    _officeNetLabel.attributedText = netString;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=NO;
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden=YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.view];
    
    if (CGRectContainsPoint(_officeNetLabel.frame, touchPoint)) {
        _officeNetLabel.textColor = [UIColor blueColor];
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.view];
    
    NSString *urlString;
    if (CGRectContainsPoint(_officeNetLabel.frame, touchPoint)) {
        _officeNetLabel.textColor = [UIColor colorWithRed:36.0/255 green:108.0/255 blue:161.0/255 alpha:1.0];
        urlString = [NSString stringWithFormat:@"http://%@",_officeNetLabel.text];
        RHOfficeNetAndWeiBoViewController *officeVc = [[RHOfficeNetAndWeiBoViewController alloc] initWithNibName:@"RHOfficeNetAndWeiBoViewController" bundle:nil];
        officeVc.Type = 0;
        officeVc.urlString = urlString;
        [self.navigationController pushViewController:officeVc animated:YES];
    }
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    _officeNetLabel.textColor = [UIColor colorWithRed:36.0/255 green:108.0/255 blue:161.0/255 alpha:1.0];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.view];
    
    if (!CGRectContainsPoint(_officeNetLabel.frame, touchPoint)) {
        _officeNetLabel.textColor = [UIColor colorWithRed:36.0/255 green:108.0/255 blue:161.0/255 alpha:1.0];
    }
}


@end
