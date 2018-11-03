//
//  RongIMKit.h
//  RongIMKit
//
//  Created by xugang on 15/1/13.
//  Copyright (c) 2015年 RongCloud. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for RongIMKit.
FOUNDATION_EXPORT double RongIMKitVersionNumber;

//! Project version string for RongIMKit.
FOUNDATION_EXPORT const unsigned char RongIMKitVersionString[];

/// IMKit核心类
#import <RongIMKit/RCIM.h>
/// 会话列表相关类
#import <RongIMKit/RCConversationListViewController.h>
#import <RongIMKit/RCPublicServiceListViewController.h>
/// 会话页面相关类
#import <RongIMKit/RCConversationViewController.h>
#import <RongIMKit/RCImagePreviewController.h>
#import <RongIMKit/RCImageSlideController.h>
#import <RongIMKit/RCLocationPickerViewController.h>
#import <RongIMKit/RCLocationViewController.h>
#import <RongIMKit/RCPublicServiceChatViewController.h>
#import <RongIMKit/RCPublicServiceSearchViewController.h>
/// 会话列表Cell相关类
#import <RongIMKit/RCConversationBaseCell.h>
#import <RongIMKit/RCConversationCell.h>
#import <RongIMKit/RCConversationModel.h>
/// 消息Cell相关类
#import <RongIMKit/RCFileMessageCell.h>
#import <RongIMKit/RCImageMessageCell.h>
#import <RongIMKit/RCImageMessageProgressView.h>
#import <RongIMKit/RCLocationMessageCell.h>
#import <RongIMKit/RCMessageBaseCell.h>
#import <RongIMKit/RCMessageCell.h>
#import <RongIMKit/RCMessageCellDelegate.h>
#import <RongIMKit/RCMessageCellNotificationModel.h>
#import <RongIMKit/RCMessageModel.h>
#import <RongIMKit/RCRichContentMessageCell.h>
#import <RongIMKit/RCTextMessageCell.h>
#import <RongIMKit/RCTipMessageCell.h>
#import <RongIMKit/RCUnknownMessageCell.h>
#import <RongIMKit/RCVoiceMessageCell.h>

/// 工具类
#import <RongIMKit/RCKitUtility.h>
#import <RongIMKit/RCThemeDefine.h>
/// 其他
#import <RongIMKit/RCAttributedLabel.h>
#import <RongIMKit/RCBaseViewController.h>
#import <RongIMKit/RCContentView.h>
#import <RongIMKit/RCConversationSettingTableViewHeader.h>
#import <RongIMKit/RCEmoticonTabSource.h>
#import <RongIMKit/RCMessageBubbleTipView.h>
#import <RongIMKit/RCPublicServiceProfileViewController.h>
#import <RongIMKit/RCSettingViewController.h>
#import <RongIMKit/RCTextView.h>
#import <RongIMKit/RCTipLabel.h>
#import <RongIMKit/RongIMKitExtensionModule.h>
/// VoIPCall
