//
//  NSString+JKRSize.m
//  JKRMVVMDemo
//
//  Created by Lucky on 2017/4/27.
//  Copyright © 2017年 Lucky. All rights reserved.
//

#import "NSString+JKRSize.h"

@implementation NSString (JKRSize)

- (CGSize)jkr_sizeWithWidth:(CGFloat)width fontSize:(CGFloat)fontSize {
    if (fontSize == 0) fontSize = 14.f;
    return [self jkr_sizeWithWidth:width font:[UIFont systemFontOfSize:fontSize]];
}

- (CGSize)jkr_sizeWithWidth:(CGFloat)width font:(UIFont *)font {
    if (self.length == 0) return CGSizeZero;
    return [self boundingRectWithSize:CGSizeMake(width > 0 ? width : [UIScreen mainScreen].bounds.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font ? font : [UIFont systemFontOfSize:14]} context:nil].size;
}

@end
