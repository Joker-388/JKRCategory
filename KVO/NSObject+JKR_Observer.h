//
//  NSObject+JKR_Observer.h
//  JKRUIViewDemo
//
//  Created by Lucky on 17/1/16.
//  Copyright © 2017年 Lucky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

typedef void (^changeBlock)(id newValue);

@interface NSObject (JKR_Observer)

- (void)jkr_addObserver:(NSObject *)object forKeyPath:(NSString *)keyPath change:(changeBlock)change;

@end
