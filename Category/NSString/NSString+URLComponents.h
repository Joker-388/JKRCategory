//
//  NSString+URLComponents.h
//  URLDemo
//
//  Created by Lucky on 2017/8/24.
//  Copyright © 2017年 Lucky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (URLComponents)

/// 返回URL格式字符串携带的参数
- (NSDictionary *)jkr_urlStringGetURLComponents;

@end
