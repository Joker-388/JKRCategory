//
//  UIImage+JKRImage.h
//  UINavDemo
//
//  Created by Lucky on 2015/8/17.
//  Copyright © 2015年 Lucky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (JKRImage)

/// 通过颜色获取一张宽高都为1px的图片
+ (UIImage *)jkr_imageWithColor:(UIColor *)color;
/// 通过颜色获取一张规定尺寸的图片
+ (UIImage *)jkr_imageWithColor:(UIColor *)color size:(CGSize)size;
/// 将图片压缩到指定宽度
- (UIImage *)jkr_compressWithWidth:(CGFloat)width;
/// 将图片在子线程中压缩，block在主线层回调
- (void)jkr_compressToDataLength:(NSInteger)length withBlock:(void(^)(UIImage *image))block;
/// 将图片在当前线程中压缩
- (UIImage *)jkr_compressToDataLength:(NSInteger)length;

@end
