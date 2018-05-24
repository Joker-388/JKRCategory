//
//  UINavigationBar+JKRBottomLine.m
//  BaoJiDianJing
//
//  Created by Lucky on 2018/5/24.
//  Copyright © 2018年 KaiHei. All rights reserved.
//

#import "UINavigationBar+JKRBottomLine.h"

@implementation UINavigationBar (JKRBottomLine)

- (void)jkr_hideBottomLine {
    UIView *line;
    for (UIView *subView in self.subviews) {
        UIView *result = [self jkr_findline:subView];
        if (result) {
            line = result;
        }
    }
    if (line) {
        line.hidden = YES;
    }
}

- (UIView *)jkr_findline:(UIView *)view {
    if ([view isKindOfClass:[UIImageView class]] && view.frame.size.height <= 1.0) {
        return view;
    } else {
        for (UIView *subView in view.subviews) {
            UIView *result = [self jkr_findline:subView];
            if (result) {
                return result;
            }
        }
    }
    return nil;
}

@end
