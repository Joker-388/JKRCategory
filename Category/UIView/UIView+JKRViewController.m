//
//  UIView+JKRViewController.m
//  JKRSearchDemo
//
//  Created by Joker on 2016/5/16.
//  Copyright © 2016年 Lucky. All rights reserved.
//

#import "UIView+JKRViewController.h"

@implementation UIView (JKRViewController)

- (UIViewController *)jkr_viewController {
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    return nil;
}

@end
