
//
//  UIImageView+CCImagesAnimation.m
//  LuckyRocket
//
//  Created by chenfanfang on 2018/10/24.
//  Copyright © 2018年 ShenYu. All rights reserved.
//

#import "UIImageView+JKRImagesAnimation.h"

@interface UIImageView ()

@end

@implementation UIImageView (JKRImagesAnimation)

static dispatch_source_t timer;

- (void)jkr_startAnimationWithDuration:(NSTimeInterval)duration images:(NSArray *)images completion:(void (^)(BOOL))completion {
    if (timer) [self jkr_finishAnimation];
    CGFloat idx = duration / images.count;
    __block int i = 0;
    timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, idx * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        if (i >= images.count) {
            dispatch_source_cancel(timer);
            completion(YES);
        } else {
            self.image = images[i++];
        }
    });
    dispatch_resume(timer);
}

- (void)jkr_startRepeatAnimationWithDuration:(NSTimeInterval)duration images:(NSArray *)images {
    if (timer) [self jkr_finishAnimation];
    CGFloat idx = duration / images.count;
    __block int i = 0;
    timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, idx * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        if (i >= images.count) {
            i = 0;
            self.image = images[i++];
        } else {
            self.image = images[i++];
        }
    });
    dispatch_resume(timer);
}

- (void)jkr_finishAnimation {
    if (timer) dispatch_source_cancel(timer);
    self.image = nil;
}

@end
