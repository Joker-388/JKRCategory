//
//  UIImage+JKRRender.h
//  JKRImageDemo
//
//  Created by Lucky on 14-3-4.
//  Copyright (c) 2014年 Lucky. All rights reserved.
//

#import "UIImage+JKRRender.h"

@implementation UIImage (JKRRender)

+ (instancetype)jkr_originalImageNamed:(NSString *)name {
    UIImage *image = [UIImage imageNamed:name];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

+ (instancetype)jkr_stretchableImageNamed:(NSString *)name {
    UIImage *image = [UIImage imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5f topCapHeight:image.size.height * 0.5f];
}

@end
