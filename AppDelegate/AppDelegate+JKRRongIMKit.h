//
//  AppDelegate+JKRRongIMKit.h
//  RongCloudDemo
//
//  Created by 蓝洪明 on 2017/5/2.
//  Copyright © 2017年 KaiHei. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (JKRRongIMKit)

/**
 配置融云
 @discussion didFinishLaunchingWithOptions 中调用
 */
- (void)jkr_configRongIMKit;
/**
 设置桌面图标角标数
 @discussion applicationWillResignActive 中调用
 */
- (void)jkr_setIconBadgeNumber;
/**
 注册消息推送
 @discussion didRegisterForRemoteNotificationsWithDeviceToken 中调用
 */
- (void)jkr_registerRongIMWithDeviceToken:(NSData *)deviceToken;

@end
