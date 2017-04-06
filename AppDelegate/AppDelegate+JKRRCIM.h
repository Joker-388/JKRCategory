//
//  AppDelegate+JKRRCIM.h
//  ZHYQ
//
//  Created by Joker on 14/12/15.
//  Copyright © 2014年 Joker. All rights reserved.
//

#import "AppDelegate.h"
#import <RongIMKit/RongIMKit.h>

/**
 配置融云
 */
@interface AppDelegate (JKRRCIM)<RCIMReceiveMessageDelegate, RCIMUserInfoDataSource>

- (void)jkr_configRCIM;

@end
