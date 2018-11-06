//
//  UIImage+JKRImage.h
//  UINavDemo
//
//  Created by Lucky on 2015/8/17.
//  Copyright © 2015年 Lucky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (JKRImage)

/**
 根据颜色获取1x1尺寸的图片

 @param color 图片颜色
 @return 返回图片
 */
+ (UIImage *)jkr_imageWithColor:(UIColor *)color;

/**
 根据颜色获取图片
 
 @param color 图片颜色
 @param size 图片尺寸
 @return 返回图片
 */
+ (UIImage *)jkr_imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 画一条水平虚线
 
 @param totalLength 虚线总长度
 @param height 虚线高度
 @param perLength 虚心每一段实现的宽度
 @param intervalLength 虚线每一段空白间距
 @param lineColor 虚线的颜色
 @return 返回一张符合规定的虚线图片
 */
+ (UIImage *)jkr_imaginaryLineWithTotalLength:(CGFloat)totalLength height:(CGFloat)height perLength:(CGFloat)perLength intervalLength:(CGFloat)intervalLength lineColor:(UIColor *)lineColor;

/**
 裁剪圆形图片加边框
 
 @param borderWidth 边框宽度
 @param borderColor 边框颜色
 @return 裁剪后图片
 */
- (UIImage *)jkr_clipCircleImageWithBorder:(CGFloat)borderWidth withColor:(UIColor *)borderColor;
 
/**
 压缩图片到指定宽度，通过重新绘制
 
 @param width 新图片宽度尺寸
 @return 返回重绘的图片
 */
- (UIImage *)jkr_compressWithWidth:(CGFloat)width;

/**
 压缩图片到指定大小，通过压缩+重绘，损耗小，时间长
 
 @param length 要压缩到的文件大小
 @param block 返回图片
 */
- (void)jkr_compressToDataLength:(NSInteger)length withBlock:(void(^)(NSData *data))block;

/**
 尽量压缩图片到指定大小，大图片很可能压缩不到指定大小
 
 @param length 要压缩到的文件大小
 @param block 返回图片
 */
- (void)jkr_tryCompressToDataLength:(NSInteger)length withBlock:(void(^)(NSData *data))block;

/**
 快速压缩图片到指定大小，损耗高
 
 @param length 要压缩到的文件大小
 @param block 返回图片
 */
- (void)jkr_fastCompressToDataLength:(NSInteger)length withBlock:(void(^)(NSData *data))block;

/**
 通过修改r.g.b像素点来处理图片
 
 @param Fliterblock 具体像素点编辑
 @param success 返回编辑后的图片
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
 处理相册图片方向不对的问题

 @return 方向正确的图片
 */
- (UIImage *)jkr_fixOrientation;

@end
