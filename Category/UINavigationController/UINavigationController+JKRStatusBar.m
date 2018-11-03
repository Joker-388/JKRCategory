//
//  UINavigationController+JKRStatusBar.m
//  RongCloudDemo
//
//  Created by Lucky on 2017/5/4.
//  Copyright © 2017年 KaiHei. All rights reserved.
//

#import "UINavigationController+JKRStatusBar.h"
#import <objc/runtime.h>

@implementation UINavigationController (JKRStatusBar)

+ (void)load {
    method_exchangeImplementations(class_getInstanceMethod([UINavigationController class], @selector(childViewControllerForStatusBarStyle)), class_getInstanceMethod([UINavigationController class], @selector(jkr_childViewControllerForStatusBarStyle)));
}

- (UIViewController *)jkr_childViewControllerForStatusBarStyle {
    return self.childViewControllers.firstObject;
}

@end
