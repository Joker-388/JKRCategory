//
//  AVAsset+JKRVideoSize.h
//  BaoJiDianJing
//
//  Created by Lucky on 2018/5/19.
//  Copyright © 2018年 KaiHei. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

@interface AVAsset (JKRVideoSize)

/// 获取视频图像尺寸
- (CGSize)videoSize;

@end
