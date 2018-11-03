//
//  NSObject+JKR_RunTime.h
//  JKRDemo
//
//  Created by Lucky on 16/2/12.
//  Copyright © 2016年 Lucky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (JKR_RunTime)

/// 返回对象属性列表
- (NSArray<NSString *> *)jkr_ivarList;

@end
