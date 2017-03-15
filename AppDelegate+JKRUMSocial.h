//
//  AppDelegate+JKRUMSocial.h
//  ZHYQ
//
//  Created by tronsis_ios on 17/3/15.
//  Copyright © 2017年 tronsis_ios. All rights reserved.
//

#import "AppDelegate.h"
#import <RongIMKit/RongIMKit.h>

/**
 配置友盟第三方登录和分享
 */
@interface AppDelegate (JKRUMSocial)

- (void)jkr_configUMSocial;
- (BOOL)jkr_umsocial_application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;

@end
