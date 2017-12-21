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
    
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    CGContextClearRect(context, rect);
    CGContextTranslateCTM(context, 0, height);
    CGContextScaleCTM(context, 1.0f, -1.0f);
    CGContextClipToMask(context, rect, imageRef);
    
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
            //endPoint = CGPointMake(width, height);
            startPoint = CGPointMake(0, height);
            endPoint = CGPointMake(width, 0);
        }
            break;
            
        case HCGradientDirectionBottomLeftToTopRight:
        {
//            startPoint = CGPointMake(0, height);
//            endPoint = CGPointMake(width, 0);
            endPoint = CGPointMake(width, height);
        }
            break;
            
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
