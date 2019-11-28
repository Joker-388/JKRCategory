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

@property (nonatomic, strong) UIImage *preImage;
@property (nonatomic, strong) dispatch_source_t timer;

@end

@implementation UIImageView (JKRImagesAnimation)

- (void)jkr_startAnimationWithDuration:(NSTimeInterval)duration images:(NSArray *)images completion:(void (^)(BOOL))completion {
    if (!images || images.count < 2) return;
    [self jkr_finishAnimation];
    CGFloat idx = duration / images.count;
    __block int i = 0;
    __weak typeof(self) weakSelf = self;
    self.preImage = self.image;
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(self.timer, DISPATCH_TIME_NOW, idx * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(self.timer, ^{
        if (i >= images.count) {
            dispatch_source_cancel(weakSelf.timer);
            weakSelf.timer = nil;
            weakSelf.image = weakSelf.preImage;
            completion(YES);
        } else {
            weakSelf.image = images[i++];
        }
    });
    dispatch_resume(self.timer);
}

- (void)jkr_startRepeatAnimationWithDuration:(NSTimeInterval)duration images:(NSArray *)images {
    if (!images || images.count < 2) return;
    [self jkr_finishAnimation];
    CGFloat idx = duration / images.count;
    __block int i = 0;
    __weak typeof(self) weakSelf = self;
    self.preImage = self.image;
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(self.timer, DISPATCH_TIME_NOW, idx * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(self.timer, ^{
        if (i >= images.count) {
            i = 0;
            weakSelf.image = images[i++];
        } else {
            weakSelf.image = images[i++];
        }
    });
    dispatch_resume(self.timer);
}

- (void)jkr_finishAnimation {
    if (!self.timer) return;
    dispatch_source_cancel(self.timer);
    self.timer = nil;
    self.image = self.preImage;
}

- (BOOL)jkr_isPlayingAnimation {
    return self.timer;
}

- (void)setPreImage:(UIImage *)preImage {
    objc_setAssociatedObject(self, @selector(preImage), preImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImage *)preImage {
    return objc_getAssociatedObject(self, @selector(preImage));
}

- (void)setTimer:(dispatch_source_t)timer {
    objc_setAssociatedObject(self, @selector(timer), timer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (dispatch_source_t)timer {
    return objc_getAssociatedObject(self, @selector(timer));
}

- (void)dealloc {
    [self jkr_finishAnimation];
}

@end
