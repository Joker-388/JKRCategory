//
//  AppDelegate+JKRUMSocial.m
//  ZHYQ
//
//  Created by Joker on 14/10/15.
//  Copyright © 2014年 Joker. All rights reserved.
//

#import "AppDelegate+JKRUMSocial.h"

static NSString *const USHARE_APPKEY = @"58994bce3eae255da4000248";
static NSString *const WECHAT_APPKEY = @"wxeb5eedddd717efcf";
static NSString *const WECHAT_APPSECRET = @"33ebde29f29924cfe3182b3346c407ae";
static NSString *const WECHAT_REDIRECTURL = @"mobile.umeng.com";
static NSString *const QQ_APPKEY = @"1105821097";
static NSString *const QQ_WECHAT_APPSECRET = @"";
static NSString *const QQ_REDIRECTURL = @"http://mobile.umeng.com/social";
static NSString *const SINA_APPKEY = @"3921700954";
static NSString *const SINA_APPSECRET = @"04b48b094faeb16683c32669824ebdad";
static NSString *const SINA_REDIRECTURL = @"https://sns.whalecloud.com/sina2/callback";

@implementation AppDelegate (JKRUMSocial)

- (void)jkr_configUMSocial {
    [[UMSocialManager defaultManager] openLog:YES];
    [[UMSocialManager defaultManager] setUmSocialAppkey:USHARE_APPKEY];
    [self configUSharePlatforms];
    [self confitUShareSettings];
}

#pragma mark - 友盟第三方登录和分享配置
- (void)confitUShareSettings
{
    /*
     * 打开图片水印
     */
    //[UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    
    /*
     * 关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
     <key>NSAppTransportSecurity</key>
     <dict>
     <key>NSAllowsArbitraryLoads</key>
     <true/>
     </dict>
     */
    //[UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
}

- (void)configUSharePlatforms
{
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WECHAT_APPKEY appSecret:WECHAT_APPSECRET redirectURL:WECHAT_REDIRECTURL];
    /*
     * 移除相应平台的分享，如微信收藏
     */
    //[[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:QQ_APPKEY/*设置QQ平台的appID*/  appSecret:nil redirectURL:QQ_REDIRECTURL];
    
    /* 设置新浪的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:SINA_APPKEY  appSecret:SINA_APPSECRET redirectURL:SINA_REDIRECTURL];
}

- (BOOL)jkr_umsocial_application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

@end
