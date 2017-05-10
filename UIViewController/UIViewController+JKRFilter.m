//
//  UIViewController+JKRFilter.m
//  RongCloudDemo
//
//  Created by Lucky on 2017/5/4.
//  Copyright © 2017年 KaiHei. All rights reserved.
//

#import "UIViewController+JKRFilter.h"
#import <objc/runtime.h>
#import <RongIMKit/RCLocationViewController.h>
#import <RongIMKit/RCLocationPickerViewController.h>
#import "JKRMessageViewController.h"
#import "JKRTabBar.h"
#import "NSObject+JKR_Observer.h"

@implementation UIViewController (JKRFilter)

+ (void)load {
    method_exchangeImplementations(class_getInstanceMethod([UIViewController class], @selector(viewWillAppear:)), class_getInstanceMethod([UIViewController class], @selector(jkr_viewWillAppear:)));
    method_exchangeImplementations(class_getInstanceMethod([UIViewController class], @selector(viewWillDisappear:)), class_getInstanceMethod([UIViewController class], @selector(jkr_viewWillDisappear:)));
    
}

- (void)jkr_viewWillAppear:(BOOL)animated {
    if ([self isKindOfClass:[UITabBarController class]]) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [self setValue:[JKRTabBar sharedTabBar] forKey:@"tabBar"];
            [self jkr_addObserver:[JKRTabBar sharedTabBar] forKeyPath:@"selectedIndex" change:^(id newValue) {
                [[JKRTabBar sharedTabBar] refreshSelectedIndex];
            }];
        });
        RongRefreshBadge;
        return;
    }
    if ([self isKindOfClass:[JKRMessageViewController class]]) {
        RongRefreshBadge;
    }
    if ([self isKindOfClass:[UINavigationController class]]) {
        
    }
    if ([self isKindOfClass:[RCLocationViewController class]]) {
        self.jkr_lightStatusBar = YES;
    }
    if ([self isKindOfClass:[RCLocationPickerViewController class]]) {
        self.jkr_lightStatusBar = YES;
    }
    [self jkr_viewWillAppear:animated];
    [MobClick beginLogPageView:NSStringFromClass([self class])];
}

- (void)jkr_viewWillDisappear:(BOOL)animated {
    if ([self isKindOfClass:[UITabBarController class]]) return;
    [self jkr_viewWillAppear:animated];
    [MobClick endLogPageView:NSStringFromClass([self class])];
}

@end
