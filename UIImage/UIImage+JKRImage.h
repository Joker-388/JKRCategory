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
/// 将图片裁剪成一张圆形图片
- (UIImage *)jkr_clipCircleImageWithBorder:(CGFloat)borderWidth withColor:(UIColor *)borderColor;
/// 将图片压缩到指定宽度
- (UIImage *)jkr_compressWithWidth:(CGFloat)width;
/// 将图片在子线程中压缩，block在主线层回调，保证压缩到指定文件大小，尽量减少失真
- (void)jkr_compressToDataLength:(NSInteger)length withBlock:(void(^)(NSData *data))block;
/// 尽量将图片压缩到指定大小，不一定满足条件
- (void)jkr_tryCompressToDataLength:(NSInteger)length withBlock:(void(^)(NSData *data))block;
/// 快速将图片压缩到指定大小，失真严重
- (void)jkr_fastCompressToDataLength:(NSInteger)length withBlock:(void(^)(NSData *data))block;

/**
 通过修改r.g.b像素点来处理图片
 
 @discussion
 [_albumImage jkr_fliterImageWithFliterBlock:^(int *red, int *green, int *blue) {
 int gray = (*red + *green + *blue) / 3;
 *red = gray;
 *green = gray;
 *blue = gray;
 } success:^(UIImage *image) {
 [_pngImageV setImage:image];
 }];
 */
- (void)jkr_fliterImageWithFliterBlock:(void(^)(int *red, int *green, int *blue))Fliterblock success:(void(^)(UIImage *image))success;

/**
 传入需要的占位图尺寸 获取占位图
 @param size 需要的站位图尺寸
 @return 占位图
 */
+ (UIImage *)placeholderImageWithSize:(CGSize)size;



@end
