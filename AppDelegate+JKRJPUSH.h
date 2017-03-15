//
//  AppDelegate+JKRJPUSH.h
//  ZHYQ
//
//  Created by tronsis_ios on 17/3/15.
//  Copyright © 2017年 tronsis_ios. All rights reserved.
//

#import "AppDelegate.h"
#import "JPUSHService.h"
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
#import <AdSupport/AdSupport.h>
#import "JKRMessageListViewController.h"


/**
 配置极光推送
 */
@interface AppDelegate (JKRJPUSH)<JPUSHRegisterDelegate>

- (void)jkr_configJPushWithOptions:(NSDictionary *)launchOptions;
- (void)jkr_jpush_application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler;
- (void)jkr_jpush_application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo;
- (void)jkr_jpush_applicationWillEnterForeground:(UIApplication *)application;
- (void)jkr_jpush_application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;
- (void)jkr_jpush_applicationDidEnterBackground:(UIApplication *)application;

@end
