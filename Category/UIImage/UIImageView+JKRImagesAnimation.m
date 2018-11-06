//
//  UIImageView+JKRImagesAnimation.m
//  JKRCategoryDemo
//
//  Created by Joker on 2018/10/24.
//  Copyright © 2018年 Joker. All rights reserved.
//

#import "UIImageView+JKRImagesAnimation.h"
#import <objc/runtime.h>

@interface UIImageView ()

@property (nonatomic, strong) dispatch_source_t timer;

@end

@implementation UIImageView (JKRImagesAnimation)

- (void)jkr_startAnimationWithDuration:(NSTimeInterval)duration images:(NSArray *)images completion:(void (^)(BOOL))completion {
    if (self.timer) [self jkr_finishAnimation];
    CGFloat idx = duration / images.count;
    __block int i = 0;
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(self.timer, DISPATCH_TIME_NOW, idx * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(self.timer, ^{
        if (i >= images.count) {
            dispatch_source_cancel(self.timer);
            self.timer = nil;
            completion(YES);
        } else {
            self.image = images[i++];
        }
    });
    dispatch_resume(self.timer);
}

- (void)jkr_startRepeatAnimationWithDuration:(NSTimeInterval)duration images:(NSArray *)images {
    if (self.timer) [self jkr_finishAnimation];
    CGFloat idx = duration / images.count;
    __block int i = 0;
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(self.timer, DISPATCH_TIME_NOW, idx * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(self.timer, ^{
        if (i >= images.count) {
            i = 0;
            self.image = images[i++];
        } else {
            self.image = images[i++];
        }
    });
    dispatch_resume(self.timer);
}

- (void)jkr_finishAnimation {
    if (self.timer) {
        dispatch_source_cancel(self.timer);
        self.timer = nil;
        self.image = nil;
    }
}

- (void)setTimer:(dispatch_source_t)timer {
    objc_setAssociatedObject(self, @selector(timer), timer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (dispatch_source_t)timer {
    return objc_getAssociatedObject(self, @selector(timer));
}

@end
