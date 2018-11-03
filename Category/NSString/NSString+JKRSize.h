//
//  NSString+JKRSize.m
//  JKRMVVMDemo
//
//  Created by Lucky on 2017/4/27.
//  Copyright © 2017年 Lucky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (JKRSize)

/// 根据宽度和系统字体尺寸获取字符串的宽度,不传字体默认14号，不传宽度默认屏幕宽度
- (CGSize)jkr_sizeWithWidth:(CGFloat)width fontSize:(CGFloat)fontSize;

/// 根据宽度和字体获取字符串的宽度
- (CGSize)jkr_sizeWithWidth:(CGFloat)width font:(UIFont *)font;

@end
