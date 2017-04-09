//
//  UIView+JKRTapGestureRecognizer.m
//  JKRTouch
//
//  Created by Lucky on 2016/8/9.
//  Copyright © 2016年 Lucky. All rights reserved.
//

#import "UIView+JKRTapGestureRecognizer.h"
#import <objc/runtime.h>

@interface UIView ()

@property (nonatomic, strong) tapGestureRecognizerBlock tapBlock;

@end

@implementation UIView (JKRTapGestureRecognizer)

static const char * TAP_BLOCK_KEY = "JKR_TAP_BLOCK_KEY";

- (void)jkr_addTapGestureRecognizerWithBlock:(void (^)(UIGestureRecognizer *))block {
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    self.tapBlock = block;
    [self addGestureRecognizer:tapGestureRecognizer];
}

- (void)handleTapGesture:(UIGestureRecognizer *)gestureRecognizer {
    self.tapBlock(gestureRecognizer);
}

- (tapGestureRecognizerBlock)tapBlock {
    return objc_getAssociatedObject(self, TAP_BLOCK_KEY);
}

- (void)setTapBlock:(tapGestureRecognizerBlock)tapBlock {
    objc_setAssociatedObject(self, TAP_BLOCK_KEY, tapBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
