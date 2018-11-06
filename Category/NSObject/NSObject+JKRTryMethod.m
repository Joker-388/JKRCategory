//
//  NSObject+JKRTryMethod.m
//  LuckyRocket
//
//  Created by Joker on 2018/11/4.
//  Copyright © 2018 Joker. All rights reserved.
//

#import "NSObject+JKRTryMethod.h"

@implementation NSObject (JKRTryMethod)

- (void)jkr_tryWithBlock:(void (^)(void))block catchBlock:(void (^)(NSException * _Nonnull))catchBlock finallyBlock:(void (^)(void))finallyBlock {
    @try {
        if (block) block();
    } @catch (NSException *exception) {
        if (catchBlock) catchBlock(exception);
    } @finally {
        if (finallyBlock) finallyBlock();
    }
}

@end
