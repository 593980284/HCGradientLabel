//
//  ViewController.m
//  渐变文字demo
//
//  Created by 胡超 on 2017/12/21.
//  Copyright © 2017年 胡超. All rights reserved.
//

#import "ViewController.h"
#import "HCGradientLabel.h"
@interface ViewController ()

@end

@implementation ViewController
{
    HCGradientLabel *label1;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    label1 = [UILabel new];
    label1.backgroundColor = [UIColor redColor];
     label1.text = @"渐变文字从左->右,渐变文字从左->右,渐变文字从左->右,渐变文字从左->右,渐变文字从左->右,渐变文字从左->右,渐变文字从左->右,渐变文字从左->右,渐变文字从左->右,渐变文字从左->右,渐变文字从左->右,渐变文字从左->右";
       label1.numberOfLines = 0;
       label1.font = [UIFont systemFontOfSize:12];
       label1.frame = CGRectMake(200, 64, 200, 200);
       [self.view addSubview:label1];
    
    label1 = [[HCGradientLabel alloc]initWithColors:@[[UIColor redColor],[UIColor greenColor]]];
    label1.text = @"渐变文字从左->右,渐变文字从左->右,渐变文字从左->右,渐变文字从左->右,渐变文字从左->右,渐变文字从左->右,渐变文字从左->右,渐变文字从左->右,渐变文字从左->右,渐变文字从左->右,渐变文字从左->右,渐变文字从左->右";
    label1.numberOfLines = 0;
    label1.font = [UIFont systemFontOfSize:12];
    label1.frame = CGRectMake(0, 64, 200, 200);
    [self.view addSubview:label1];
    

    
 
    
    UIButton *btn = [UIButton new];
    [btn setTitle:@"富文本" forState:0];
    btn.backgroundColor = [UIColor blueColor];
    btn.frame = CGRectMake(30, 600, 150, 40);
    [btn addTarget:self action:@selector(btnTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    btn = [UIButton new];
    [btn setTitle:@"改变颜色" forState:0];
    btn.backgroundColor = [UIColor blueColor];
    btn.frame = CGRectMake(200, 600, 150, 40);
    [btn addTarget:self action:@selector(btn2Tap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    btn = [UIButton new];
    [btn setTitle:@"改变渐变方向" forState:0];
    btn.backgroundColor = [UIColor blueColor];
    btn.frame = CGRectMake(30, 700, 150, 40);
    [btn addTarget:self action:@selector(btn3Tap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    btn = [UIButton new];
    [btn setTitle:@"改变文字对齐方式" forState:0];
    btn.backgroundColor = [UIColor blueColor];
    btn.frame = CGRectMake(200, 700, 150, 40);
    [btn addTarget:self action:@selector(btn4Tap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

- (void)btnTap:(UIButton *)sender
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:label1.text attributes:@{NSUnderlineStyleAttributeName:@1}];
    label1.attributedText = str;
}

- (void)btn2Tap:(UIButton *)sender
{
    label1.colors = @[[UIColor blackColor],[UIColor orangeColor]];
}

- (void)btn3Tap:(UIButton *)sender
{
    label1.gradientDirection = (++label1.gradientDirection)%4;
}

- (void)btn4Tap:(UIButton *)sender
{
    label1.textAlignment = (++label1.textAlignment)%3;
}









@end
