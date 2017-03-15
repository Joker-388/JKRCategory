//
//  AppDelegate+JKRRCIM.h
//  ZHYQ
//
//  Created by tronsis_ios on 17/3/15.
//  Copyright © 2017年 tronsis_ios. All rights reserved.
//

#import "AppDelegate.h"
#import <RongIMKit/RongIMKit.h>

/**
 配置融云
 */
@interface AppDelegate (JKRRCIM)<RCIMReceiveMessageDelegate, RCIMUserInfoDataSource>

- (void)jkr_configRCIM;

@end
