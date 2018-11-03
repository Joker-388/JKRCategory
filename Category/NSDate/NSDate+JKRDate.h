//
//  NSDate+JKRDate.h
//  CALayerDemo
//
//  Created by Lucky on 2017/6/14.
//  Copyright © 2017年 Lucky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (JKRDate)

@property (nonatomic, assign, readonly) NSInteger year;       ///< 年
@property (nonatomic, assign, readonly) NSInteger month;      ///< 月
@property (nonatomic, assign, readonly) NSInteger day;        ///< 日
@property (nonatomic, assign, readonly) NSInteger hour;       ///< 时
@property (nonatomic, assign, readonly) NSInteger minute;     ///< 分
@property (nonatomic, assign, readonly) NSInteger second;     ///< 秒

/// 时间字符串 yyyy-MM-dd HH:mm:ss
- (NSString *)string;
/// 时间字符串 自定义格式
- (NSString *)stringWithFormatString:(NSString *)string;

@end
