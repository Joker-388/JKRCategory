//
//  AppDelegate+JKRRootViewController.m
//  ZHYQ
//
//  Created by Joker on 14/3/15.
//  Copyright © 2014年 Joker. All rights reserved.
//

#import "AppDelegate+JKRRootViewController.h"

@implementation AppDelegate (JKRRootViewController)

- (void)jkr_configRootViewController {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UITabBarController *rootViewController = [UITabBarController new];
    self.window.rootViewController = rootViewController;
    [self.window makeKeyAndVisible];
}

@end
