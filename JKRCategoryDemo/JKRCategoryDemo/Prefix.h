//
//  Prefix.h
//  JKRCategoryDemo
//
//  Created by Joker on 2018/11/3.
//  Copyright © 2018 Joker. All rights reserved.
//

#ifndef Prefix_h
#define Prefix_h

#import "UIColor+JKRColor.h"
#define JKRColor(r,g,b,a) [UIColor jkr_colorWithRed:r green:g blue:b alpha:a]
#define JKRColorHex(_hex_) [UIColor jkr_colorWithHexString:((__bridge NSString *)CFSTR(#_hex_))]

#define JKRColorGray(x) \
({\
NSInteger __color = (x);\
UIColor *color = [UIColor jkr_colorWithRed:__color green:__color blue:__color alpha:1];\
(color);\
})\

#import "UIView+JKRFrame.h"
#import "UIView+JKRViewController.h"
#import "UIImage+JKRImage.h"
#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

#endif /* Prefix_h */
