//
//  UIColor+JKRColor.h
//  JKRColor
//
//  Created by Lucky on 2016/8/14.
//  Copyright © 2016年 Lucky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (JKRColor)

+ (UIColor *)jkr_colorWithHexString:(NSString *)hexString;
+ (UIColor *)jkr_colorWithRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue alpha:(CGFloat)alpha;

@end
