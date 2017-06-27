//
//  NSString+JKRSize.m
//  JKRMVVMDemo
//
//  Created by Lucky on 2017/4/27.
//  Copyright © 2017年 Lucky. All rights reserved.
//

#import "NSString+JKRSize.h"

@implementation NSString (JKRSize)

- (CGSize)sizeWithWidth:(CGFloat)width font:(CGFloat)font {
    if (self.length == 0) return CGSizeZero;
    return [self boundingRectWithSize:CGSizeMake(width != 0 ? width : [UIScreen mainScreen].bounds.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font != 0 ? font : 14]} context:nil].size;
}

@end
