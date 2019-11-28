//
//  UIImage+JKRImage.h
//  UINavDemo
//
//  Created by Lucky on 2015/8/17.
//  Copyright © 2015年 Lucky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (JKRImage)

/// 根据颜色获取1x1尺寸的图片
/// @param color 图片颜色
/// @return 图片
+ (UIImage *)jkr_imageWithColor:(UIColor *)color;

/// 根据颜色获取图片
/// @param color 图片颜色
/// @param size 图片尺寸
/// @return 图片
+ (UIImage *)jkr_imageWithColor:(UIColor *)color size:(CGSize)size;

/// 画一条水平虚线
/// @param totalLength 虚线总长度
/// @param height 虚线高度
/// @param perLength 虚心每一段实现的宽度
/// @param intervalLength 虚线每一段空白间距
/// @param lineColor 虚线的颜色
/// @return 返回一张符合规定的虚线图片
+ (UIImage *)jkr_imaginaryLineWithTotalLength:(CGFloat)totalLength height:(CGFloat)height perLength:(CGFloat)perLength intervalLength:(CGFloat)intervalLength lineColor:(UIColor *)lineColor;

/// 裁剪圆形图片加边框
/// @param borderWidth borderWidth 边框宽度
/// @param borderColor borderColor 边框颜色
/// @return 裁剪后图片
- (UIImage *)jkr_clipCircleImageWithBorder:(CGFloat)borderWidth withColor:(UIColor *)borderColor;
 
/// 压缩图片到指定宽度，通过重新绘制
/// @param width 新图片宽度尺寸
/// @return 绘制后图片
- (UIImage *)jkr_drawWithWidth:(CGFloat)width;

/// 压缩图片
///
/// 压缩单位byte，如果是byte需要乘以1024，如60K，如需要传 60 * 1024
///
/// @param length 文件大小 单位byte
/// @return 压缩后的文件
- (NSData *)jkr_compressWithLength:(NSInteger)length;

/// 通过修改r.g.b像素点来处理图片
///
/// [_albumImage jkr_fliterImageWithFliterBlock:^(int *red, int *green, int *blue) {
///
/// int gray = (*red + *green + *blue) / 3;
///
/// *red = gray;
///
/// *green = gray;
///
/// *blue = gray;
///
/// } success:^(UIImage *image) {
///
/// [_pngImageV setImage:image];
///
/// }];
///
/// @param Fliterblock 具体像素点编辑
/// @param success 返回编辑后的图片
- (void)jkr_fliterImageWithFliterBlock:(void(^)(int *red, int *green, int *blue))Fliterblock success:(void(^)(UIImage *image))success;

/// 处理相册图片方向不对的问题
/// @return 方向正确的图片
- (UIImage *)jkr_fixOrientation;

@end
