//
//  UIView+JKR_HitTest.m
//  JKRUIResponderDemo
//
//  Created by Lucky on 17/3/24.
//  Copyright © 2017年 Lucky. All rights reserved.
//

#import "UIView+JKR_HitTest.h"

@implementation UIView (JKR_HitTest)

- (UIView *)jkr_hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (self.alpha <= 0.01 || self.userInteractionEnabled == false || self.hidden == YES) {
        return nil;
    }
    UIView *lastResultView = nil;
    if ([self pointInside:point withEvent:event]) {
        lastResultView = self;
        NSArray *subViews = [[self.subviews reverseObjectEnumerator] allObjects];
        if (subViews.count) {
            for (id view in subViews) {
                CGPoint convertPoint = [self convertPoint:point toView:view];
                UIView *currentResultView = [view hitTest:convertPoint withEvent:event];
                if (currentResultView) {
                    lastResultView = currentResultView;
                    break;
                }
            }
            return lastResultView;
        } else {
            return lastResultView;
        }
    }
    return nil;
}

@end
