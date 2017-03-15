//
//  AppDelegate+JKRRootViewController.m
//  ZHYQ
//
//  Created by tronsis_ios on 17/3/15.
//  Copyright © 2017年 tronsis_ios. All rights reserved.
//

#import "AppDelegate+JKRRootViewController.h"

@implementation AppDelegate (JKRRootViewController)

- (void)jkr_configRootViewController {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    JKRTabBarViewController *rootViewController = [JKRTabBarViewController new];
    self.window.rootViewController = rootViewController;
    [self.window makeKeyAndVisible];
}

@end
