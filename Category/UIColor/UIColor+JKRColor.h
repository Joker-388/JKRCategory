//
//  UIColor+JKRColor.h
//  JKRColor
//
//  Created by Lucky on 2016/8/14.
//  Copyright © 2016年 Lucky. All rights reserved.
//

#import <UIKit/UIKit.h>

#define JKRColor(r,g,b,a) [UIColor jkr_colorWithRed:r green:g blue:b alpha:a]
#define JKRColorHex(_hex_) [UIColor jkr_colorWithHexString:((__bridge NSString *)CFSTR(#_hex_))]
#define JKRColorTest(x) JKRColor(x,x,x,1)
#define JKRColorGray(x) ({\
    NSInteger __color = (x);\
    JKRColor(__color,__color,__color,1);\
})\

@interface UIColor (JKRColor)

/// 通过hex返回颜色，支持四种格式：RGB、RGBA、RRGGBB、RRGGBBAA，根据传入自负长度自动判断用那种格式
+ (UIColor *)jkr_colorWithHexString:(NSString *)hexString;
/// 通过rgba返回颜色，不需要除255
+ (UIColor *)jkr_colorWithRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue alpha:(CGFloat)alpha;

@end
