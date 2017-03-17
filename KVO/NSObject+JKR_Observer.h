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

- (void)jkr_addObserver:(NSObject *)object forKeyPath:(NSString *)keyPath change:(changeBlock)change;

@end
