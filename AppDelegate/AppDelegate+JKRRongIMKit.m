//
//  AppDelegate+JKRRongIMKit.m
//  RongCloudDemo
//
//  Created by 蓝洪明 on 2017/5/2.
//  Copyright © 2017年 KaiHei. All rights reserved.
//

#import "AppDelegate+JKRRongIMKit.h"
#import <RongIMKit/RongIMKit.h>
#import "JKRRongIMKitManager.h"
#import "JKRMessageContent.h"
#import "CleanDataUtil.h"
#import "PushCommonVC.h"

//static NSString *const DEV_APPKEY = @"p5tvi9dspjp74";
static NSString *const DEV_APPKEY = @"n19jmcy5ndn29";
static NSString *const PRO_APPKEY = @"n19jmcy5ndn29";

@interface AppDelegate ()

@end

@implementation AppDelegate (JKRRongIMKit)

- (void)jkr_configRongIMKit {
    
#ifdef DEBUG
    [[RCIM sharedRCIM] initWithAppKey:DEV_APPKEY];
#else
    [[RCIM sharedRCIM] initWithAppKey:PRO_APPKEY];
#endif
    [[RCIM sharedRCIM] setReceiveMessageDelegate:[JKRRongIMKitManager sharedManager]];
    [[RCIM sharedRCIM] setConnectionStatusDelegate:[JKRRongIMKitManager sharedManager]];
    [[RCIM sharedRCIM] setUserInfoDataSource:[JKRRongIMKitManager sharedManager]];
    
//    [[RCIM sharedRCIM] setEnableMessageAttachUserInfo:YES];
    [[RCIM sharedRCIM] setEnablePersistentUserInfoCache:YES];
    [[RCIM sharedRCIM] setEnableTypingStatus:YES];
    [[RCIM sharedRCIM] setEnabledReadReceiptConversationTypeList:@[@(ConversationType_PRIVATE)]];
       [[RCIM sharedRCIM] registerMessageType:[JKRMessageContent class]];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"NSUD_Auth_token"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"rcloud_token"]) {
        [[RCIM sharedRCIM] connectWithToken:[[NSUserDefaults standardUserDefaults] objectForKey:@"rcloud_token"] success:^(NSString *userId) {
            NSLog(@"Rong connect success! : %@", userId);
            
            [[RCIMClient sharedRCIMClient] removeFromBlacklist:@"0cfdf512#fd4546" success:^{
                NSLog(@"remove success");
            } error:^(RCErrorCode status) {
                NSLog(@"errorcode %zd", status);
            }];
            
        } error:^(RCConnectErrorCode status) {
            [self _loginFailed];
        } tokenIncorrect:^{
            [self _loginFailed];
        }];
    }
}

- (void)jkr_setIconBadgeNumber {
    RongRefreshBadge;
}

- (void)jkr_registerRongIMWithDeviceToken:(NSData *)deviceToken {
    NSString *token =
    [[[[deviceToken description] stringByReplacingOccurrencesOfString:@"<"
                                                           withString:@""]
      stringByReplacingOccurrencesOfString:@">"
      withString:@""]
     stringByReplacingOccurrencesOfString:@" "
     withString:@""];
    [[RCIMClient sharedRCIMClient] setDeviceToken:token];
}

- (void)_loginFailed {
    [[RCIM sharedRCIM] logout];
    [[RCIM sharedRCIM] clearUserInfoCache];
    [NetRequestClass NetRequestPOSTWithRequestURL:POST_AuthLogout WithParameter:nil WithReturnValeuBlock:^(id returnValue) {
        
    } WithErrorCodeBlock:^(id errorCode) {
        
    } WithFailureBlock:^(NSString *errorStr) {
        NSLog(@"用户注销 失败");
    }];
    [CleanDataUtil cleanDataAction];
    [UIView transitionWithView:[UIApplication sharedApplication].keyWindow
                      duration:0.25
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        [UIApplication sharedApplication].keyWindow.rootViewController = [PushCommonVC pushLoginViewController];
                    }
                    completion:^(BOOL finished) {
                        extern CustomerTabBarVC *tabBarController;
                        [tabBarController.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                            if ([obj isKindOfClass:[UINavigationController class]]) {
                                UINavigationController *navigationController = (UINavigationController *)obj;
                                [navigationController popToRootViewControllerAnimated:NO];
                            }
                        }];
                        tabBarController.selectedIndex = 1;
                    }];
}

@end
