//
//  NSObject+JKR_Observer.h
//  JKRUIViewDemo
//
//  Created by Lucky on 16/7/16.
//  Copyright © 2016年 Lucky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

typedef void (^changeBlock)(id newValue);

@interface NSObject (JKR_Observer)

/// 给当前对象快速添加一个监听并在block中响应，默认是NSKeyValueObservingOptionNew
- (void)jkr_addObserver:(NSObject *)object forKeyPath:(NSString *)keyPath change:(changeBlock)change;

@end
