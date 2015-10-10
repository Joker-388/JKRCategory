//
//  JKRMusicTool.m
//  AVAudioPlayerDemo
//
//  Created by Lucky on 15/10/7.
//  Copyright © 2015年 Lucky. All rights reserved.
//

#import "JKRMusicTool.h"
#import <AVFoundation/AVFoundation.h>

@implementation JKRMusicTool

//* 固定写法 */
+ (void)initialize
{
    //创建音频会话
    AVAudioSession *session = [[AVAudioSession alloc] init];
    //设置会话类型
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    //激活会话
    [session setActive:YES error:nil];
}

//* 用一个字典保存所有的player */
static NSMutableDictionary *_players;

+ (NSMutableDictionary *)players
{
    if (!_players) {
        _players = [NSMutableDictionary dictionary];
    }
    return _players;
}

+ (AVAudioPlayer *)playMusicWithFileName:(NSString *)fileName
{
    if (!fileName) {
        return nil;
    }
    
    //* 从字典中取出播放器 */
    AVAudioPlayer *player = [self players][fileName];
    
    //* 如果字典中不存在这个播放器，新建 */
    if (!player) {
        NSURL *url = [[NSBundle mainBundle] URLForResource:fileName withExtension:nil];
        
        if (!url) {
            return nil;
        }
        
        //* 创建播放器 */
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        
        //* 准备播放 */
        if (![player prepareToPlay]) {
            return nil;
        }
        
        //* 是否允许更改速率 */
        player.enableRate = YES;
        //* 播放速率，1是正常，2是双倍 */
        player.rate = 1;
        
        //* 将新建的播放器存到字典中 */
        [self players][fileName] = player;
    }
    
    //*  如果当前没有在播放，播放音乐 */
    if (!player.playing) {
        [player play];
    }
    
    return player;
}

+ (void)pauseMusicWithFileName:(NSString *)fileName
{
    if (!fileName) {
        return;
    }
    
    AVAudioPlayer *player = [self players][fileName];
    
    if (player) {
        if (player.playing) {
            [player pause];
        }
    }
}

+ (void)stopMusicWithFileName:(NSString *)fileName
{
    if (!fileName) {
        return;
    }
    
    AVAudioPlayer *player = [self players][fileName];
    
    if (player) {
        [player stop];
        
        [[self players] removeObjectForKey:fileName];
    }
}

@end
