//
//  RHAboutViewController.m
//  ryhui
//
//  Created by stefan on 15/3/15.
//  Copyright (c) 2015年 stefan. All rights reserved.
//

#import "RHAboutViewController.h"
#import "RHOfficeNetAndWeiBoViewController.h"
@interface RHAboutViewController ()

@property (weak, nonatomic) IBOutlet UILabel *officalNetLabel;
@property (weak, nonatomic) IBOutlet UILabel *officalWeiBoLabel;
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;

@end

@implementation RHAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configBackButton];
    [self configTitleWithString:@"关于"];
    
    NSDictionary *attributes = @{NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *netString = [[NSMutableAttributedString alloc] initWithString:_officalNetLabel.text];
    [netString addAttributes:attributes range:NSMakeRange(0, netString.length)];
    _officalNetLabel.attributedText = netString;
    
    NSMutableAttributedString *weiBoString = [[NSMutableAttributedString alloc] initWithString:_officalWeiBoLabel.text];
    [weiBoString addAttributes:attributes range:NSMakeRange(0, weiBoString.length)];
    _officalWeiBoLabel.attributedText = weiBoString;
    
    self.versionLabel.text = [NSString stringWithFormat:@"V%@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
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


- (IBAction)pushMain:(id)sender {
    [[[RHTabbarManager sharedInterface] selectTabbarMain] popToRootViewControllerAnimated:NO];
}

- (IBAction)pushUser:(id)sender {
    [[[RHTabbarManager sharedInterface] selectTabbarUser] popToRootViewControllerAnimated:NO];
}

- (IBAction)pushMore:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.view];

    if (CGRectContainsPoint(_officalNetLabel.frame, touchPoint)) {
        _officalNetLabel.textColor = [UIColor blueColor];
    }
    if (CGRectContainsPoint(_officalWeiBoLabel.frame, touchPoint)) {
        _officalWeiBoLabel.textColor = [UIColor blueColor];
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.view];
    
    RHOfficeNetAndWeiBoViewController *officeVc = [[RHOfficeNetAndWeiBoViewController alloc] initWithNibName:@"RHOfficeNetAndWeiBoViewController" bundle:nil];
    
    int type;
    NSString *urlString;
    if (CGRectContainsPoint(_officalNetLabel.frame, touchPoint)) {
        type = 0;
        _officalNetLabel.textColor = [UIColor colorWithRed:36.0/255 green:108.0/255 blue:161.0/255 alpha:1.0];
        urlString = [NSString stringWithFormat:@"http://%@",_officalNetLabel.text];
        [self.navigationController pushViewController:officeVc animated:YES];
    }
    if (CGRectContainsPoint(_officalWeiBoLabel.frame, touchPoint)) {
        type = 1;
        _officalWeiBoLabel.textColor = [UIColor colorWithRed:36.0/255 green:108.0/255 blue:161.0/255 alpha:1.0];
        urlString =  _officalWeiBoLabel.text;
        [self.navigationController pushViewController:officeVc animated:YES];
    }
    officeVc.Type = type;
    officeVc.urlString = urlString;
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    _officalNetLabel.textColor = [UIColor colorWithRed:36.0/255 green:108.0/255 blue:161.0/255 alpha:1.0];
    _officalWeiBoLabel.textColor = [UIColor colorWithRed:36.0/255 green:108.0/255 blue:161.0/255 alpha:1.0];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.view];
    
    if (!CGRectContainsPoint(_officalNetLabel.frame, touchPoint)) {
        _officalNetLabel.textColor = [UIColor colorWithRed:36.0/255 green:108.0/255 blue:161.0/255 alpha:1.0];
    }
    if (!CGRectContainsPoint(_officalWeiBoLabel.frame, touchPoint)) {
        _officalWeiBoLabel.textColor = [UIColor colorWithRed:36.0/255 green:108.0/255 blue:161.0/255 alpha:1.0];
    }
}
@end
