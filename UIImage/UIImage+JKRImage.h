//
//  UIImage+JKRImage.h
//  UINavDemo
//
//  Created by Lucky on 2015/8/17.
//  Copyright © 2015年 Lucky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (JKRImage)

+ (UIImage *)jkr_imageWithColor:(UIColor *)color;
+ (UIImage *)jkr_imageWithColor:(UIColor *)color size:(CGSize)size;

@end
