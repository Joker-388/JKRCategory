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

#pragma mark - 根据颜色获取一张图片
+ (UIImage *)jkr_imageWithColor:(UIColor *)color {
    return [self jkr_imageWithColor:color size:CGSizeMake(1, 1)];
}

#pragma mark - 根据颜色和尺寸获取一张图片
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

#pragma mark - 画一条水平虚线
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

#pragma mark - 图片截圆加边框
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

#pragma mark - 图片根据宽度重绘
- (UIImage *)jkr_drawWithWidth:(CGFloat)width {
    if (width <= 0 || [self isKindOfClass:[NSNull class]] || self == nil) return nil;
    CGSize newSize = CGSizeMake(width, width * (self.size.height / self.size.width));
    UIGraphicsBeginImageContext(newSize);
    [self drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


- (NSData *)jkr_compressWithLength:(NSInteger)length {
    UIImage *image = [self copy];
    CGFloat compression = 1;
    NSData *imageData = UIImageJPEGRepresentation(image, compression);
    NSUInteger fImageBytes = length;
    if (imageData.length <= fImageBytes) return imageData;
    CGFloat max = 1;
    CGFloat min = 0;
    compression = pow(2, -6);
    imageData = UIImageJPEGRepresentation(image, compression);
    if (imageData.length < fImageBytes) {
        for (int i = 0; i < 6; ++i) {
            compression = (max + min) / 2;
            imageData = UIImageJPEGRepresentation(image, compression);
            if (imageData.length < fImageBytes * 0.9) {
                min = compression;
            } else if (imageData.length > fImageBytes) {
                max = compression;
            } else {
                break;
            }
        }
        return imageData;
    }
    UIImage *resultImage = [UIImage imageWithData:imageData];
    while (imageData.length > fImageBytes) {
        @autoreleasepool {
            CGFloat ratio = (CGFloat)fImageBytes / imageData.length;
            CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)), (NSUInteger)(resultImage.size.height * sqrtf(ratio)));
            resultImage = [self thumbnailForData:imageData maxPixelSize:MAX(size.width, size.height)];
            imageData = UIImageJPEGRepresentation(resultImage, compression);
        }
    }
    return imageData;
}

- (UIImage *)thumbnailForData:(NSData *)data maxPixelSize:(NSUInteger)size {
    CGDataProviderRef provider = CGDataProviderCreateWithCFData((__bridge CFDataRef)data);
    CGImageSourceRef source = CGImageSourceCreateWithDataProvider(provider, NULL);
    CGImageRef imageRef = CGImageSourceCreateThumbnailAtIndex(source, 0, (__bridge CFDictionaryRef) @{(NSString *)kCGImageSourceCreateThumbnailFromImageAlways : @YES, (NSString *)kCGImageSourceThumbnailMaxPixelSize : @(size), (NSString *)kCGImageSourceCreateThumbnailWithTransform : @YES,});
    CFRelease(source);
    CFRelease(provider);
    if (!imageRef) return nil;
    UIImage *toReturn = [UIImage imageWithCGImage:imageRef];
    CFRelease(imageRef);
    return toReturn;
}

#pragma mark - 图片编辑
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

#pragma mark - 图片方向矫正
- (UIImage *)jkr_fixOrientation {
    // No-op if the orientation is already correct
    if (self.imageOrientation == UIImageOrientationUp) return self;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation) {
            case UIImageOrientationDown:
            case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
            case UIImageOrientationLeft:
            case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
            case UIImageOrientationRight:
            case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (self.imageOrientation) {
            case UIImageOrientationUpMirrored:
            case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
            case UIImageOrientationLeftMirrored:
            case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
            case UIImageOrientationLeft:
            case UIImageOrientationLeftMirrored:
            case UIImageOrientationRight:
            case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }
    
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

@end
