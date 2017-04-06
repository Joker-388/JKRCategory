//
//  UIImage+JKRRender.h
//  JKRImageDemo
//
//  Created by Lucky on 14-3-4.
//  Copyright (c) 2014年 Lucky. All rights reserved.
//

#import "UIImage+JKRCircleImage.h"

@implementation UIImage (JKRCircleImage)

+ (instancetype)image:(UIImage *)image withBorder:(CGFloat)borderWidth withColor:(UIColor *)borderColor
{
    CGRect mframe = CGRectMake(0, 0, image.size.width + borderWidth * 2, image.size.height + borderWidth * 2);
    UIGraphicsBeginImageContextWithOptions(mframe.size, NO, 0.0f);
    UIBezierPath *pathCir = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, mframe.size.width, mframe.size.height)];
    CGContextRef ctr = UIGraphicsGetCurrentContext();
    [borderColor setFill];
    CGContextAddPath(ctr, pathCir.CGPath);
    CGContextFillPath(ctr);
    UIBezierPath *pathClip = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(borderWidth, borderWidth, image.size.width, image.size.height)];
    [pathClip addClip];
    [image drawAtPoint:CGPointMake(borderWidth, borderWidth)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
