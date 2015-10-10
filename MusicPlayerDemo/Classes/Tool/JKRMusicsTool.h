//
//  JKRMusicsTool.h
//  MusicPlayerDemo
//
//  Created by Lucky on 15/10/8.
//  Copyright © 2015年 Lucky. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JKRMusic;

@interface JKRMusicsTool : NSObject

+ (NSArray *)musics;

+ (void)setPlayingMusic:(JKRMusic *)music;

+ (JKRMusic *)playingMusic;

+ (JKRMusic *)nextMusic;

+ (JKRMusic *)previousMusic;

@end
