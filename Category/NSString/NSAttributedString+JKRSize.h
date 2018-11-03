//
//  NSAttributedString+JKRSize.h
//  JKRCategoryDemo
//
//  Created by Joker on 2017/10/3.
//  Copyright © 2018 Joker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSAttributedString (JKRSize)

/// 根据宽度返回带格式字符串的高度，只支持同一字体尺寸的字符串
- (CGSize)jkr_sizeWithWidth:(CGFloat)width;

@end

