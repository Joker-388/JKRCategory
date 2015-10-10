//
//  JKRMusicsTool.m
//  MusicPlayerDemo
//
//  Created by Lucky on 15/10/8.
//  Copyright © 2015年 Lucky. All rights reserved.
//

#import "JKRMusicsTool.h"
#import "JKRMusic.h"
#import "MJExtension.h"

@implementation JKRMusicsTool

static NSArray *_musics;

static JKRMusic *_playingMusic;

+ (NSArray *)musics
{
    if (!_musics) {
        _musics = [JKRMusic objectArrayWithFilename:@"Musics.plist"];
    }
    return _musics;
}

+ (void)setPlayingMusic:(JKRMusic *)music
{
    if (!music || ![[self musics] containsObject:music]) {
        return;
    }
    
    _playingMusic = music;
}

+ (JKRMusic *)playingMusic
{
    return _playingMusic;
}

+ (JKRMusic *)nextMusic
{
    NSUInteger currentIndex = [[self musics] indexOfObject:_playingMusic];
    NSInteger nextIndex = currentIndex + 1;
    if (nextIndex >= [self musics].count) {
        nextIndex = 0;
    }
    return [self musics][nextIndex];
}

+ (JKRMusic *)previousMusic
{
    NSUInteger currentIndex = [[self musics] indexOfObject:_playingMusic];
    NSInteger previousIndex = currentIndex - 1;
    if (previousIndex < 0) {
        previousIndex = [self musics].count - 1;
    }
    return [self musics][previousIndex];
}

@end
