//
//  NSObject+JKR_Observer.h
//  JKRUIViewDemo
//
//  Created by tronsis_ios on 17/3/16.
//  Copyright © 2017年 tronsis_ios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

typedef void (^changeBlock)(id newValue);

@interface NSObject (JKR_Observer)


/**
 添加KVO监听并用block回调

 @param object 添加的监听者
 @param keyPath 监听的key
 @param change 监听到改变回调的block,参数为newValue
 */
- (void)jkr_addObserver:(NSObject *)object forKeyPath:(NSString *)keyPath change:(changeBlock)change;

@end
