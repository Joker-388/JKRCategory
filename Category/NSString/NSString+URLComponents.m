//
//  NSString+URLComponents.m
//  URLDemo
//
//  Created by Lucky on 2017/8/24.
//  Copyright © 2017年 Lucky. All rights reserved.
//

#import "NSString+URLComponents.h"

@implementation NSString (URLComponents)

- (NSDictionary *)jkr_urlStringGetURLComponents {
    if (self == nil || self.length == 0) return nil;
    NSURLComponents *urlComponents = [NSURLComponents componentsWithString:self];
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    NSArray *queryItems = urlComponents.queryItems;
    for (NSURLQueryItem *item in queryItems) {
        if (item.name && item.value) {
            [dictionary setObject:item.value forKey:item.name];
        }
    }
    return dictionary;
}

@end
