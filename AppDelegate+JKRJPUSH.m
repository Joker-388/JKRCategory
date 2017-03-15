//
//  AppDelegate+JKRJPUSH.m
//  ZHYQ
//
//  Created by tronsis_ios on 17/3/15.
//  Copyright © 2017年 tronsis_ios. All rights reserved.
//

#import "AppDelegate+JKRJPUSH.h"

static NSString *const JKPUSH_APPKEY = @"ad600aaa7634f46bb414570c";
static NSString *const JKPUSH_SECRET = @"b8f606d5e7cd0b7cf791e0e6";
static NSString * const JPushChannel=@"app";
static BOOL const JPushIsProduction=NO;

@implementation AppDelegate (JKRJPUSH)

- (void)jkr_configJPushWithOptions:(NSDictionary *)launchOptions {
    
    NSDictionary *remoteNotification = [launchOptions objectForKey: UIApplicationLaunchOptionsRemoteNotificationKey];
    
    if (remoteNotification)
    {
        if([remoteNotification isKindOfClass:[UNPushNotificationTrigger class]]) {
            [JPUSHService handleRemoteNotification:remoteNotification];
            [self pushToMessagePage:remoteNotification];
        }
    }
    
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        [JPUSHService registerForRemoteNotificationTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert categories:nil];}
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    [JPUSHService setupWithOption:launchOptions appKey:JKPUSH_APPKEY channel:JPushChannel apsForProduction:JPushIsProduction advertisingIdentifier:advertisingId];
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(networkDidLoginNotification:) name:kJPFNetworkDidLoginNotification object:nil];
}

#pragma mark -jpush注册完成
-(void)networkDidLoginNotification:(NSNotification*)notification{
    [JPUSHService setTags:nil alias:UserInfo.username? :@"" fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias){}];
}

#pragma mark -JPUSHRegisterDelegate
// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        [self pushToMessagePage:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert);
}
// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        [self pushToMessagePage:userInfo];
    }
    completionHandler();
}

#pragma mark - AppDelegate
- (void)jkr_jpush_application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)jkr_jpush_application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [JPUSHService handleRemoteNotification:userInfo];
    [self pushToMessagePage:userInfo];
}

- (void)jkr_jpush_application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [JPUSHService handleRemoteNotification:userInfo];
    [self pushToMessagePage:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)jkr_jpush_applicationWillEnterForeground:(UIApplication *)application {
    [application setApplicationIconBadgeNumber:0];
    [[UNUserNotificationCenter alloc] removeAllPendingNotificationRequests];
}

- (void)jkr_jpush_applicationDidEnterBackground:(UIApplication *)application {
    [[UIApplication alloc] setApplicationIconBadgeNumber:0];
}

#pragma mark - 跳转
- (void)pushToMessagePage:(NSDictionary *)info {
    NSUserDefaults *UD = [NSUserDefaults standardUserDefaults];
    
    if ([info[@"type"] isEqualToString:@"like"])[UD setValue:@"1" forKey:@"favourNum"];
    if ([info[@"type"] isEqualToString:@"comment"])[UD setValue:@"1" forKey:@"messageNum"];
    if ([info[@"type"] isEqualToString:@"system"])[UD setValue:@"1" forKey:@"systemNum"];
    UITabBarController *tabbatVC = (UITabBarController *)self.window.rootViewController;
    [tabbatVC setSelectedIndex:3];
    UINavigationController *nav =tabbatVC.viewControllers[3];
    if (nav.viewControllers.count>1) [nav popToRootViewControllerAnimated:NO];
    [nav pushViewController:[JKRMessageListViewController new] animated:NO];
}

@end
