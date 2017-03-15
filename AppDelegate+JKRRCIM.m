//
//  AppDelegate+JKRRCIM.m
//  ZHYQ
//
//  Created by tronsis_ios on 17/3/15.
//  Copyright © 2017年 tronsis_ios. All rights reserved.
//

#import "AppDelegate+JKRRCIM.h"

static NSString *const DEV_APPKEY = @"6tnym1br6t7g7";
static NSString *const PRO_APPKEY = @"cpj2xarlcpk4n";

@implementation AppDelegate (JKRRCIM)

- (void)jkr_configRCIM {
#ifdef DEBUG
    [[RCIM sharedRCIM] initWithAppKey:DEV_APPKEY];
#else
    [[RCIM sharedRCIM] initWithAppKey:PRO_APPKEY];
#endif
    [[RCIM sharedRCIM] setReceiveMessageDelegate:self];
    [[RCIM sharedRCIM] setUserInfoDataSource:self];
}

///融云代理方法  通过调用服务器请求头像昵称  融云进行本地存储
- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *))completion
{
    [MeNetwork getOtherUserInfoWithToken:nil user_id:userId success:^(id responseObject) {
        JKRUserResult *result = [JKRUserResult modelWithJSON:responseObject];
        if (result.header.status == 1000) {
            RCUserInfo *user = [RCUserInfo new];
            user.userId = userId;
            user.name = result.data.displayName?:@"";
            NSString *iconUrl = [NSString stringWithFormat:@"%@%@",imageBaseUrl,result.data.displayPhoto?:@""];
            NSLog(@"%@",iconUrl);
            user.portraitUri = iconUrl;
            completion(user);
        }else{
            
        }
    } failure:^(NSError *error) {
        
    }];
}

///融云消息监听 = 在前台和后台活动状态时收到任何消息都会执行
- (void)onRCIMReceiveMessage:(RCMessage *)message
                        left:(int)left
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RCIMHasReceiveMessage" object:nil];
}

@end
