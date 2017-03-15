//
//  AppDelegate+JKRUMSocial.h
//  ZHYQ
//
//  Created by Joker on 14/10/15.
//  Copyright © 2014年 Joker. All rights reserved.
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
