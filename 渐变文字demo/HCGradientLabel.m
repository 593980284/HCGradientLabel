//
//  HCGradientLabel.m
//  绘图
//
//  Created by 胡超 on 2017/12/21.
//  Copyright © 2017年 胡超. All rights reserved.
//

#import "HCGradientLabel.h"

@implementation HCGradientLabel
{
    NSMutableArray *gradientColors;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGImageRef imageRef = CGBitmapContextCreateImage(context);//获得倒置的图片
    CGContextClearRect(context, rect);
    /*
    为什么会发生倒置问题
    究其原因是因为Core Graphics源于Mac OS X系统，在Mac OS X中，坐标原点在左下方并且正y坐标是朝上的，而在iOS中，原点坐标是在左上方并且正y坐标是朝下的。在大多数情况下，这不会出现任何问题，因为图形上下文的坐标系统是会自动调节补偿的。但是创建和绘制一个CGImage对象时就会暴露出倒置问题。
     */
    //下面的两行代码将：原点在左下方并且正y坐标是朝上的
    CGContextTranslateCTM(context, 0, height);
    CGContextScaleCTM(context, 1.0f, -1.0f);
    //下面的context 原点在左下 并且 正y坐标是朝上的
    CGContextClipToMask(context, rect, imageRef);//将图片设置为mark
    
    //划渐变色图层
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradientRef = CGGradientCreateWithColors(colorSpaceRef, (__bridge CFArrayRef)gradientColors, NULL);
    CGPoint startPoint = CGPointZero;
    CGPoint endPoint = CGPointZero;
    switch (self.gradientDirection) {
        case HCGradientDirectionLeftToRight:
        {
            endPoint = CGPointMake(width, 0);
        }
            break;
            
        case HCGradientDirectionTopLeftToBottomRight:
        {
           
            startPoint = CGPointMake(0, height);
            endPoint = CGPointMake(width, 0);
        }
            break;
            
        case HCGradientDirectionBottomLeftToTopRight:
        {
            endPoint = CGPointMake(width, height);
        }
            break;
            
            case HCGradientDirectionTopToTopBottom:
        {
            startPoint = CGPointMake(0, height);
            endPoint = CGPointZero;
        }
        default:
            break;
    }
   
    CGContextDrawLinearGradient(context, gradientRef, startPoint, endPoint,  kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    
    CGColorSpaceRelease(colorSpaceRef);
    CGImageRelease(imageRef);
    CGGradientRelease(gradientRef);
}

- (instancetype)initWithColors:(NSArray<UIColor *> *)colors
{
   return  [self initWithColors:colors gradientDirection:HCGradientDirectionLeftToRight];
}

- (instancetype)initWithColors:(NSArray<UIColor *> *)colors gradientDirection:(HCGradientDirection)gradientDirection
{
    self = [super init];
    if (self) {
        gradientColors  = [NSMutableArray new];
        self.colors = colors;
        self.gradientDirection = gradientDirection;
    }
    return self;
}


//
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        gradientColors  = [NSMutableArray new];
        self.colors = @[[UIColor blackColor],[UIColor whiteColor]];
        self.gradientDirection = HCGradientDirectionLeftToRight;
    }
    return self;
}

- (void)setGradientDirection:(HCGradientDirection)gradientDirection
{
    _gradientDirection = gradientDirection;
    [self setNeedsDisplay];
}

- (void)setColors:(NSArray<UIColor *> *)colors
{
    _colors = colors;
    [gradientColors removeAllObjects];
    for (UIColor *color in _colors) {
        [gradientColors addObject:(__bridge id)color.CGColor];
    }
     [self setNeedsDisplay];
}

@end
