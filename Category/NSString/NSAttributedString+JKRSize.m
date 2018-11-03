//
//  NSAttributedString+JKRSize.m
//  JKRCategoryDemo
//
//  Created by Joker on 2017/10/3.
//  Copyright © 2018 Joker. All rights reserved.
//

#import "NSAttributedString+JKRSize.h"

@implementation NSAttributedString (JKRSize)

- (CGSize)jkr_sizeWithWidth:(CGFloat)width {
    if (self.string.length == 0) return CGSizeZero;
     return [self.string boundingRectWithSize:CGSizeMake(width > 0 ? width : [UIScreen mainScreen].bounds.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:[self attributesAtIndex:0 effectiveRange:NULL] context:nil].size;
}

@end
