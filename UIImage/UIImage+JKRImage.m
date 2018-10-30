//
//  UIImage+JKRImage.m
//  UINavDemo
//
//  Created by Lucky on 2015/8/17.
//  Copyright © 2015年 Lucky. All rights reserved.
//

#import "UIImage+JKRImage.h"
#import <CoreFoundation/CoreFoundation.h>

@implementation UIImage (JKRImage)

+ (UIImage *)jkr_imageWithColor:(UIColor *)color {
    return [self jkr_imageWithColor:color size:CGSizeMake(1, 1)];
}

+ (UIImage *)jkr_imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.f, 0.f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)jkr_clipCircleImageWithBorder:(CGFloat)borderWidth withColor:(UIColor *)borderColor {
    CGFloat dia;
    if (self.size.width >= self.size.height) {
        dia = self.size.height;
    } else {
        dia = self.size.width;
    }
    CGRect mframe = CGRectMake(0, 0, dia + borderWidth * 2, dia + borderWidth * 2);
    UIGraphicsBeginImageContextWithOptions(mframe.size, NO, 0.0f);
    UIBezierPath *pathCir = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, mframe.size.width, mframe.size.height)];
    CGContextRef ctr = UIGraphicsGetCurrentContext();
    [borderColor setFill];
    CGContextAddPath(ctr, pathCir.CGPath);
    CGContextFillPath(ctr);
    UIBezierPath *pathClip = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(borderWidth, borderWidth, dia, dia)];
    [pathClip addClip];
    [self drawAtPoint:CGPointMake(borderWidth, borderWidth)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)jkr_compressWithWidth:(CGFloat)width {
    if (width <= 0 || [self isKindOfClass:[NSNull class]] || self == nil) return nil;
    CGSize newSize = CGSizeMake(width, width * (self.size.height / self.size.width));
    UIGraphicsBeginImageContext(newSize);
    [self drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)jkr_compressToDataLength:(NSInteger)length withBlock :(void (^)(NSData *))block {
    if (length <= 0 || [self isKindOfClass:[NSNull class]] || self == nil) {
        block(nil);
        return;
    }
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIImage *newImage = [self copy];
        {
            CGFloat clipScale = 0.9;
            NSData *pngData = UIImagePNGRepresentation(self);
            NSLog(@"Original pnglength %zd", pngData.length);
            NSData *jpgData = UIImageJPEGRepresentation(self, 1.0);
            NSLog(@"Original jpglength %zd", jpgData.length);
            while (jpgData.length > length) {
                NSData *newImageData = UIImageJPEGRepresentation(newImage, 0.0);
                if (newImageData.length < length) {
                    CGFloat scale = 1.0;
                    newImageData = UIImageJPEGRepresentation(newImage, scale);
                    while (newImageData.length > length) {
                        scale -= 0.1;
                        newImageData = UIImageJPEGRepresentation(newImage, scale);
                    }
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSLog(@"Result jpglength %zd", newImageData.length);
                        block(newImageData);
                    });
                    return;
                } else {
                    newImage = [newImage jkr_compressWithWidth:newImage.size.width * clipScale];
                    jpgData = UIImageJPEGRepresentation(newImage, 1.0);
                }
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"Result jpglength %zd", jpgData.length);
                block(jpgData);
            });
        }
    });
}

- (void)jkr_tryCompressToDataLength:(NSInteger)length withBlock:(void (^)(NSData *))block {
    if (length <= 0 || [self isKindOfClass:[NSNull class]] || self == nil) block(nil);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        CGFloat scale = 0.9;
        NSData *scaleData = UIImageJPEGRepresentation(self, scale);
        while (scaleData.length > length) {
            scale -= 0.1;
            if (scale < 0) {
                break;
            }
            NSLog(@"%f", scale);
            scaleData = UIImageJPEGRepresentation(self, scale);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            block(scaleData);
        });
    });
}

- (void)jkr_fastCompressToDataLength:(NSInteger)length withBlock:(void (^)(NSData *))block {
    if (length <= 0 || [self isKindOfClass:[NSNull class]] || self == nil) block(nil);
    CGFloat scale = 1.0;
    UIImage *newImage = [self copy];
     NSInteger newImageLength = UIImageJPEGRepresentation(newImage, 1.0).length;
    while (newImageLength > length) {
        NSLog(@"Do compress");
        // 如果限定的大小比当前的尺寸大0.9的平方倍，就用开方求缩放倍数,减少缩放次数
        if ((double)length / (double)newImageLength < 0.81) {
            scale = sqrtf((double)length / (double)newImageLength);
        } else {
            scale = 0.9;
        }
        CGFloat width = newImage.size.width * scale;
        newImage = [newImage jkr_compressWithWidth:width];
        newImageLength = UIImageJPEGRepresentation(newImage, 1.0).length;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        block(UIImageJPEGRepresentation(newImage, 1.0));
    });
}

- (void)jkr_fliterImageWithFliterBlock:(void (^)(int *, int *, int *))Fliterblock success:(void (^)(UIImage *))success{
    if ([self isKindOfClass:[NSNull class]] || self == nil) return;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        CGImageRef imageRef = self.CGImage;
        // 图片宽度
        size_t width = CGImageGetWidth(imageRef);
        // 图片高度
        size_t height = CGImageGetHeight(imageRef);
        // 每个颜色值存储的字节数
        size_t bits = CGImageGetBitsPerComponent(imageRef);
        // 每行的字节数
        size_t bitsPerRow = CGImageGetBytesPerRow(imageRef);
        // 透明度
        int alphaInfo = CGImageGetAlphaInfo(imageRef);
        // colorSpace RGBA AGBR RGB: 颜色空间
        CGColorSpaceRef colorSpace = CGImageGetColorSpace(imageRef);
        // bitmap data provider:bitmap数据提供器
        CGDataProviderRef providerRef = CGImageGetDataProvider(imageRef);
        // bitmap data:bitmap数据
        CFDataRef dataRef = CGDataProviderCopyData(providerRef);
        // bitmap数据长度
        int length = (int)CFDataGetLength(dataRef);
        // 颜色通道字符格式数组
        Byte *pixelBuf = (UInt8 *)CFDataGetMutableBytePtr((CFMutableDataRef)dataRef);
        // 遍历颜色通道数据，4个一组，RGBA
        for (int i = 0; i < length; i+=4) { // i+=4因为4个一组:RGBA
            // 原始R序列号
            int offsetR = i;
            // 原始G序列号
            int offsetG = i + 1;
            // 原始B序列号
            int offsetB = i + 2;
            // 原始A序列号
            int offsetA = i + 3;
            // 原始R值
            int red = pixelBuf[offsetR];
            // 原始G值
            int green = pixelBuf[offsetG];
            // 原始B值
            int blue = pixelBuf[offsetB];
            // 原始A值
            int alpha = pixelBuf[offsetA];
            // 修改原始像素RGB数据
            Fliterblock(&red, &green, &blue);
            // 用修改的RGB数据替换原数据
            pixelBuf[offsetR] = red;
            pixelBuf[offsetG] = green;
            pixelBuf[offsetB] = blue;
            pixelBuf[offsetA] = alpha;
        }
        // bitmap生成上下文
        CGContextRef contextRef = CGBitmapContextCreate(pixelBuf, width, height, bits, bitsPerRow, colorSpace, alphaInfo);
        // 通过上下文生成图片
        CGImageRef backImageRef = CGBitmapContextCreateImage(contextRef);
        UIImage *backImage = [UIImage imageWithCGImage:backImageRef scale:[UIScreen mainScreen].scale orientation:self.imageOrientation];
        // 内存释放
        CFRelease(dataRef);
        CFRelease(contextRef);
        CFRelease(backImageRef);
        dispatch_async(dispatch_get_main_queue(), ^{
            success(backImage);
        });
    });
}

+ (UIImage *)jkr_imaginaryLineWithTotalLength:(CGFloat)totalLength height:(CGFloat)height perLength:(CGFloat)perLength intervalLength:(CGFloat)intervalLength lineColor:(UIColor *)lineColor {
    CGSize size = CGSizeMake(totalLength, height);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (!context) return nil;
    [lineColor setFill];
    CGContextSetLineWidth(context, height);
    for (int i = 0; i < totalLength; i+= (intervalLength + intervalLength)) {
        CGContextMoveToPoint(context, i * (perLength + intervalLength), 0.5);
        CGContextAddLineToPoint(context, i * (perLength + intervalLength) + perLength, 0.5);
    }
    CGContextStrokePath(context);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
