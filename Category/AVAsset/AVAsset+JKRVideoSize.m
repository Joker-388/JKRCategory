//
//  AVAsset+JKRVideoSize.m
//  BaoJiDianJing
//
//  Created by Lucky on 2018/5/19.
//  Copyright © 2018年 KaiHei. All rights reserved.
//

#import "AVAsset+JKRVideoSize.h"

@implementation AVAsset (JKRVideoSize)

- (CGSize)videoSize {
    NSArray *array = self.tracks;
    CGSize videoSize = CGSizeZero;
    
    for (AVAssetTrack *track in array) {
        if ([track.mediaType isEqualToString:AVMediaTypeVideo]) {
            videoSize = track.naturalSize;
        }
    }
    return videoSize;
}

@end
