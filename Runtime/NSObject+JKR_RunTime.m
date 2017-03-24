//
//  NSObject+JKR_RunTime.m
//  JKRDemo
//
//  Created by Lucky on 16/2/12.
//  Copyright © 2016年 Lucky. All rights reserved.
//

#import "NSObject+JKR_RunTime.h"
#import <objc/runtime.h>

@implementation NSObject (JKR_RunTime)

- (NSArray<NSString *> *)jkr_ivarList {
    NSMutableArray *result = [NSMutableArray array];
    
    unsigned int outCount = 0;
    Ivar *ivars = class_copyIvarList([self class], &outCount);
    for (unsigned int i = 0; i < outCount; i++) {
        Ivar ivar = ivars[i];
        const char *ivarName = ivar_getName(ivar);
        const char *ivarEndoer = ivar_getTypeEncoding(ivar);
        NSString *name = [NSString stringWithUTF8String:ivarName];
        NSString *type = [NSString stringWithUTF8String:ivarEndoer];
        if ([type hasPrefix:@"@\""]) {
            type = [type substringFromIndex:2];
        }
        if ([type hasSuffix:@"\""]) {
            type = [type substringToIndex:type.length - 1];
        }
        //type = [type substringWithRange:NSMakeRange(2, type.length - 3)];
        name = [name substringFromIndex:1];
        NSString *value = [NSString stringWithFormat:@"%@ : %@", name, type];
        [result addObject:value];
    }
    free(ivars);
    return result;
}

@end
