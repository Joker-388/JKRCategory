//
//  NSString+JKRSubNumber.h
//  JKRCategoryDemo
//
//  Created by Joker on 2016/10/2.
//  Copyright © 2018 Joker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JKRFilter)

/// 截取金钱字符串，保留最多4位小数切去末尾0, 1984.110033 => 1984.11  78,688.200 => 78,688.2
- (NSString *)jkr_filter_subNumberString;
/// 过滤字符串中的emoji表情
- (NSString *)jkr_filter_emoji;

@end

