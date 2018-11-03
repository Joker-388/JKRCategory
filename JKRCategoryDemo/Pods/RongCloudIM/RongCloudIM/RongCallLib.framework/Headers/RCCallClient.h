//
//  RCCallClient.h
//  RongCallLib
//
//  Created by 岑裕 on 16/2/28.
//  Copyright © 2016年 RongCloud. All rights reserved.
//

#import "RCCallCommonDefine.h"
#import "RCCallSession.h"
#import "RCCallClientSignalServer.h"
#import <Foundation/Foundation.h>

/*!
 CallLib全局通话呼入的监听器
 */
@protocol RCCallReceiveDelegate <NSObject>

/*!
 接收到通话呼入的回调

 @param callSession 呼入的通话实体
 */
- (void)didReceiveCall:(RCCallSession *)callSession;

/*!
 接收到通话呼入的远程通知的回调

 @param callId        呼入通话的唯一值
 @param inviterUserId 通话邀请者的UserId
 @param mediaType     通话的媒体类型
 @param userIdList    被邀请者的UserId列表
 @param userDict      远程推送包含的其他扩展信息
 */
- (void)didReceiveCallRemoteNotification:(NSString *)callId
                           inviterUserId:(NSString *)inviterUserId
                               mediaType:(RCCallMediaType)mediaType
                              userIdList:(NSArray *)userIdList
                                userDict:(NSDictionary *)userDict;

/*!
 接收到取消通话的远程通知的回调

 @param callId        呼入通话的唯一值
 @param inviterUserId 通话邀请者的UserId
 @param mediaType     通话的媒体类型
 @param userIdList    被邀请者的UserId列表
 */
- (void)didCancelCallRemoteNotification:(NSString *)callId
                          inviterUserId:(NSString *)inviterUserId
                              mediaType:(RCCallMediaType)mediaType
                             userIdList:(NSArray *)userIdList;

@end

/*!
 融云CallLib核心类
 */
@interface RCCallClient : NSObject

/*!
 获取融云通话能力库CallLib的核心类单例

 @return 融云通话能力库CallLib的核心类单例

 @discussion 您可以通过此方法，获取CallLib的单例，访问对象中的属性和方法.
 */
+ (instancetype)sharedRCCallClient;

/*!
 设置全局通话呼入的监听器

 @param delegate CallLib全局通话呼入的监听器
 */
- (void)setDelegate:(id<RCCallReceiveDelegate>)delegate;

/*!
 发起一个通话

 @param conversationType 会话类型
 @param targetId         目标会话ID
 @param userIdList       邀请的用户ID列表
 @param type             发起的通话媒体类型
 @param delegate         通话监听
 @param extra            附件信息

 @return 呼出的通话实体
 */
- (RCCallSession *)startCall:(RCConversationType)conversationType
                    targetId:(NSString *)targetId
                          to:(NSArray *)userIdList
                   mediaType:(RCCallMediaType)type
             sessionDelegate:(id<RCCallSessionDelegate>)delegate
                       extra:(NSString *)extra;

/*!
 当前会话类型是否支持音频通话

 @param conversationType 会话类型

 @return 是否支持音频通话
 */
- (BOOL)isAudioCallEnabled:(RCConversationType)conversationType;

/*!
 当前会话类型是否支持视频通话

 @param conversationType 会话类型

 @return 是否支持视频通话
 */
- (BOOL)isVideoCallEnabled:(RCConversationType)conversationType;

/**
 * 设置本地视频属性，可用此接口设置本地视频分辨率。
 *
 * @param profile profile
 */
- (void)setVideoProfile:(RCVideoProfile)profile;

/**
 设置本地视频属性，可用此接口设置本地视频分辨率，设置宽和高替换

 @param profile profile
 @param swapWidthAndHeight 是否交换宽和高  (默认不交换)
 */
- (void)setVideoProfile:(RCVideoProfile)profile swapWidthAndHeight:(BOOL)swapWidthAndHeight;

/*!
 设置外部信令服务器代理
 
 @param signalServerDelegate 外部信令服务器代理
 
 @discussion
 默认情况下 app 使用融云消息作为信令即可，不需要设置此代理，此时有个限制就是所有的通话必须在某一个会话中进行，比如群组。如果您需要摆脱会话的限制，请使用 server api 服务实现本代理，然后 startCall 时 conversationType 传 0，targetId 传 nil，calllib 会调用您设置的代理来发送消息。
 请务必使用一个全局代理，确保在拨打和接听 VoIP 的时候代理对象都存活，这样才能确保正常通话。
 */
- (void)setSignalServerDelegate:(id<RCCallSignalServerDelegate>)signalServerDelegate;

/*!
 当前的通话会话实体
 */
@property(nonatomic, strong, readonly) RCCallSession *currentCallSession;

/*!
 是否生成通话记录消息，默认为YES
 */
@property(nonatomic, assign) BOOL enableCallSummary;
@end
