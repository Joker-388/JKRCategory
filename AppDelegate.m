//
//  AppDelegate.m
//  ZHYQ
//
//  Created by Joker on 16/11/24.
//  Copyright © 2016年 Joker. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+JKRRootViewController.h"
#import "AppDelegate+JKRUMSocial.h"
#import "AppDelegate+JKRRCIM.h"
#import "AppDelegate+JKRJPUSH.h"
#import "AppDelegate+JKRADPage.h"
#import "AppDelegate+JKRWelcomeScreen.h"
 
@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    [self jkr_configRootViewController];
    [self jkr_configUMSocial];
    [self jkr_configRCIM];
    [self jkr_configJPushWithOptions:launchOptions];
    [self jkr_configADPage];
    [self jkr_configWelcomeScreen];

    return YES;
}


#pragma mark - JPush
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [self jkr_jpush_application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [self jkr_jpush_application:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [self jkr_jpush_application:application didReceiveRemoteNotification:userInfo];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [self jkr_jpush_applicationWillEnterForeground:application];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [self jkr_jpush_applicationDidEnterBackground:application];
}

#pragma mark - UMSocail
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [self jkr_umsocial_application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
}

@end
