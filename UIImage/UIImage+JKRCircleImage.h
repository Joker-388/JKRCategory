//
//  UIImage+JKRRender.h
//  JKRImageDemo
//
//  Created by Lucky on 14-3-4.
//  Copyright (c) 2014年 Lucky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (JKRCircleImage)


/**
 返回带边框的圆形图片

 @param image 要裁剪的图片
 @param borderWidth 图片边框宽度
 @param borderColor 图片边框的颜色
 @return 返回裁剪并添加边框的图片
 */
+ (instancetype)image:(UIImage *)image withBorder:(CGFloat)borderWidth withColor:(UIColor *)borderColor;

@end
