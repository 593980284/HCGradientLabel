//
//  HCGradientLabel.h
//  绘图
//
//  Created by 胡超 on 2017/12/21.
//  Copyright © 2017年 胡超. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, HCGradientDirection) {//渐变色的方向
    HCGradientDirectionLeftToRight = 0,          //左 --> 右
    HCGradientDirectionTopLeftToBottomRight = 1, //左上 --> 右下
    HCGradientDirectionBottomLeftToTopRight = 2  //左下 --> 右上
};
@interface HCGradientLabel : UILabel

-(instancetype)initWithColors:(NSArray <UIColor *>*)colors;

-(instancetype)initWithColors:(NSArray <UIColor *>*)colors
            gradientDirection:(HCGradientDirection)gradientDirection;

@property(nonatomic, strong)NSArray <UIColor *>* colors;
@property(nonatomic, assign)HCGradientDirection gradientDirection;

@end
