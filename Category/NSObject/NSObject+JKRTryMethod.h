//
//  NSObject+JKRTryMethod.h
//  LuckyRocket
//
//  Created by Joker on 2018/11/4.
//  Copyright © 2018 Joker. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (JKRTryMethod)

- (void)jkr_tryWithBlock:(nullable void(^)(void))block catchBlock:(nullable void(^)(NSException *exception))catchBlock finallyBlock:(nullable void(^)(void))finallyBlock;

@end

NS_ASSUME_NONNULL_END
