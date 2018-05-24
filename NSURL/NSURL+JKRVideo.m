//
//  NSURL+JKRVideo.m
//  BaoJiDianJing
//
//  Created by Lucky on 2018/5/17.
//  Copyright © 2018年 KaiHei. All rights reserved.
//

#import "NSURL+JKRVideo.h"

@implementation NSURL (JKRVideo)

- (CGFloat)jkr_videoDuration {
    NSDictionary *opts = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:self options:opts];
    CMTime duration = asset.duration;
    float durationSeconds = CMTimeGetSeconds(duration);
    return durationSeconds;
}

@end
