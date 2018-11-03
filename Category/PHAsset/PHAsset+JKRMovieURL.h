//
//  PHAsset+JKRMovieURL.h
//  BaoJiDianJing
//
//  Created by Lucky on 2018/5/14.
//  Copyright © 2018年 KaiHei. All rights reserved.
//

#import <Photos/Photos.h>

@interface PHAsset (JKRMovieURL)

/// 获取视频URL
- (NSURL *)jkr_movieURL;

@end
