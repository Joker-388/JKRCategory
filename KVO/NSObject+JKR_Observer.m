//
//  NSObject+JKR_Observer.m
//  JKRUIViewDemo
//
//  Created by Lucky on 17/1/16.
//  Copyright © 2017年 Lucky. All rights reserved.
//

#import "NSObject+JKR_Observer.h"

@interface NSObject ()

@property NSMutableDictionary<NSString *, changeBlock> *blocks;
@property NSMutableArray<NSString *> *keyPaths;
@property NSObject *observerdObject;

@end

@implementation NSObject (JKR_Observer)

#pragma mark - 添加监听者
- (void)jkr_addObserver:(NSObject *)object forKeyPath:(NSString *)keyPath change:(changeBlock)change {
    // self:被监听的对象  object:监听者对象  keyPath:监听的key
    NSLog(@"%@ 添加监听者 %@ 被监听的值：%@", self, object, keyPath);
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        method_exchangeImplementations(class_getInstanceMethod([object class], NSSelectorFromString(@"dealloc")), class_getInstanceMethod([self class], @selector(jkr_dealloc)));
    });
    [self addObserver:object forKeyPath:keyPath options:NSKeyValueObservingOptionNew context:(__bridge void * _Nullable)([NSString stringWithFormat:@"%zd", self.blocks.count])];
    [self.blocks setObject:change forKey:[NSString stringWithFormat:@"%zd", self.blocks.count]];
    
    NSMutableArray *keyPaths = [object valueForKey:@"keyPaths"];
    [keyPaths addObject:keyPath];
    object.observerdObject = self;
}

#pragma mark - 接收到监听状态改变
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    // self:监听者对象  object:被监听的对象  keyPath:监听的key
    NSLog(@"监听者：%@ 监听到被监听者 %@ 的值 %@ 改变", self, object, keyPath);
    NSString *key = (__bridge NSString *)(context);
    NSMutableDictionary *dict = [object valueForKey:@"blocks"];
    if (!dict) return;
    changeBlock block = [dict valueForKey:key];
    if (block) {
        id newValue = [change valueForKey:NSKeyValueChangeNewKey];
        block(newValue);
    }
}

#pragma mark - runtime 添加属性
- (void)setBlocks:(NSMutableDictionary *)blocks {
    objc_setAssociatedObject(self, "blocks", blocks, OBJC_ASSOCIATION_RETAIN);
}

- (NSMutableDictionary *)blocks {
    NSMutableDictionary *blocks = objc_getAssociatedObject(self, "blocks");
    if (!blocks) {
        blocks = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, "blocks", blocks, OBJC_ASSOCIATION_RETAIN);
    }
    return blocks;
}

- (void)setKeyPaths:(NSMutableArray<NSString *> *)keyPaths {
    objc_setAssociatedObject(self, @"paths", keyPaths, OBJC_ASSOCIATION_RETAIN);
}

- (NSMutableArray<NSString *> *)keyPaths {
    NSMutableArray *keyPaths = objc_getAssociatedObject(self, @"paths");
    if (!keyPaths) {
        keyPaths = [NSMutableArray array];
        objc_setAssociatedObject(self, @"paths", keyPaths, OBJC_ASSOCIATION_RETAIN);
    }
    return keyPaths;
}

- (NSObject *)observerdObject {
    return objc_getAssociatedObject(self, @"observerdObject");
}

- (void)setObserverdObject:(NSObject *)observerdObject {
    objc_setAssociatedObject(self, @"observerdObject", observerdObject, OBJC_ASSOCIATION_ASSIGN);
}

#pragma mark - dealloc 移除监听
- (void)jkr_dealloc {
    NSMutableArray *paths = self.keyPaths;
    if (paths.count) {
        [paths enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            // self.observerdObject:被监听的对象  self:监听者对象  obj:监听的key
            NSLog(@"被监听者 %@ 移除监听者 %@ 被移除的监听值 %@", self.observerdObject, self, obj);
            [self.observerdObject removeObserver:self forKeyPath:paths[idx]];
        }];
    }
    NSLog(@"dealloc");
    [self jkr_dealloc];
}

@end
