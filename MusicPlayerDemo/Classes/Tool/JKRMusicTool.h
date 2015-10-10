//
//  JKRMusicTool.h
//  AVAudioPlayerDemo
//
//  Created by Lucky on 15/10/7.
//  Copyright © 2015年 Lucky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface JKRMusicTool : NSObject

//* 根据文件名播放音乐 */
+ (AVAudioPlayer *)playMusicWithFileName:(NSString *)fileName;

//* 根据文件名暂停音乐 */
+ (void)pauseMusicWithFileName:(NSString *)fileName;

//* 根据文件名停止音乐 */
+ (void)stopMusicWithFileName:(NSString *)fileName;

@end
