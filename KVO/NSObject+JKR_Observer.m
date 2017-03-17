//
//  NSObject+JKR_Observer.m
//  JKRUIViewDemo
//
//  Created by tronsis_ios on 17/3/16.
//  Copyright © 2017年 tronsis_ios. All rights reserved.
//

#import "NSObject+JKR_Observer.h"

@interface NSObject ()

@property NSMutableDictionary<NSString *, changeBlock> *jkr_observer_blocks;
@property NSMutableArray<NSString *> *jkr_observer_keyPaths;
@property NSObject *jkr_observer_observerdObject;

@end

@implementation NSObject (JKR_Observer)

- (void)jkr_addObserver:(NSObject *)object forKeyPath:(NSString *)keyPath change:(changeBlock)change {
    NSLog(@"%@ 添加监听者 %@ 被监听的值：%@", self, object, keyPath);
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        method_exchangeImplementations(class_getInstanceMethod([object class], NSSelectorFromString(@"dealloc")), class_getInstanceMethod([self class], @selector(jkr_dealloc)));
    });
    [self addObserver:object forKeyPath:keyPath options:NSKeyValueObservingOptionNew context:(__bridge void * _Nullable)([NSString stringWithFormat:@"%zd", self.jkr_observer_blocks.count])];
    [self.jkr_observer_blocks setObject:change forKey:[NSString stringWithFormat:@"%zd", self.jkr_observer_blocks.count]];
    
    NSMutableArray *keyPaths = [object valueForKey:@"jkr_observer_keyPaths"];
    [keyPaths addObject:keyPath];
    object.jkr_observer_observerdObject = self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"监听者：%@ 监听到被监听者 %@ 的值 %@ 改变", self, object, keyPath);
    NSString *key = (__bridge NSString *)(context);
    NSMutableDictionary *dict = [object valueForKey:@"jkr_observer_blocks"];
    if (!dict) return;
    changeBlock block = [dict valueForKey:key];
    if (block) {
        id newValue = [change valueForKey:NSKeyValueChangeNewKey];
        block(newValue);
    }
}

- (void)setJkr_observer_blocks:(NSMutableDictionary<NSString *,changeBlock> *)jkr_observer_blocks {
    objc_setAssociatedObject(self, "jkr_observer_blocks", jkr_observer_blocks, OBJC_ASSOCIATION_RETAIN);
}

- (NSMutableDictionary *)jkr_observer_blocks {
    NSMutableDictionary *blocks = objc_getAssociatedObject(self, "jkr_observer_blocks");
    if (!blocks) {
        blocks = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, "jkr_observer_blocks", blocks, OBJC_ASSOCIATION_RETAIN);
    }
    return blocks;
}

- (void)setJkr_observer_keyPaths:(NSMutableArray<NSString *> *)jkr_observer_keyPaths {
    objc_setAssociatedObject(self, @"jkr_observer_keyPaths", jkr_observer_keyPaths, OBJC_ASSOCIATION_RETAIN);
}

- (NSMutableArray<NSString *> *)jkr_observer_keyPaths {
    NSMutableArray *keyPaths = objc_getAssociatedObject(self, @"jkr_observer_keyPaths");
    if (!keyPaths) {
        keyPaths = [NSMutableArray array];
        objc_setAssociatedObject(self, @"jkr_observer_keyPaths", keyPaths, OBJC_ASSOCIATION_RETAIN);
    }
    return keyPaths;
}

- (NSObject *)jkr_observer_observerdObject {
    return objc_getAssociatedObject(self, @"jkr_observer_observerdObject");
}

- (void)setJkr_observer_observerdObject:(NSObject *)jkr_observer_observerdObject {
    objc_setAssociatedObject(self, @"jkr_observer_observerdObject", jkr_observer_observerdObject, OBJC_ASSOCIATION_ASSIGN);
}

- (void)jkr_dealloc {
    NSMutableArray *paths = self.jkr_observer_keyPaths;
    if (paths.count) {
        [paths enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSLog(@"被监听者 %@ 移除监听者 %@ 被移除的监听值 %@", self.jkr_observer_observerdObject, self, obj);
            [self.jkr_observer_observerdObject removeObserver:self forKeyPath:paths[idx]];
        }];
    }
    NSLog(@"dealloc");
    [self jkr_dealloc];
}

@end
