//
//  UIImage+JKRRender.h
//  JKRImageDemo
//
//  Created by Lucky on 14-3-4.
//  Copyright (c) 2014年 Lucky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (JKRRender)

/// 不拉伸的图片
+ (instancetype)jkr_originalImageNamed:(NSString *)name;
/// 中心拉伸的图片
+ (instancetype)jkr_stretchableImageNamed:(NSString *)name;

@end
