//
//  UIImage+JKR_MessageImage.m
//  MessageImageDemo
//
//  Created by tronsis_ios on 16/10/12.
//  Copyright © 2016年 tronsis_ios. All rights reserved.
//

#import "UIImage+JKR_MessageImage.h"
#import <objc/runtime.h>

@implementation UIImage (JKR_MessageImage)

- (BOOL)jkr_isDecoded {
    if (self.images.count > 1) return YES;
    NSNumber *num = objc_getAssociatedObject(self, @selector(jkr_isDecoded));
    return [num boolValue];
}

- (void)setJkr_isDecoded:(BOOL)jkr_isDecoded {
    objc_setAssociatedObject(self, @selector(jkr_isDecoded), @(jkr_isDecoded), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (instancetype)jkr_imageByDecoded {
    if (self.jkr_isDecoded) return self;
    CGImageRef imageRef = self.CGImage;
    if (!imageRef) return self;
    CGImageRef newImageRef = jkr_CGImageCreateDecodedCopy(imageRef, YES);
    if (!newImageRef) return self;
    UIImage *newImage = [[self.class alloc] initWithCGImage:newImageRef scale:self.scale orientation:self.imageOrientation];
    CGImageRelease(newImageRef);
    if (!newImage) newImage = self;
    newImage.jkr_isDecoded = YES;
    return newImage;
}

CGColorSpaceRef jkr_CGColorSpaceGetDeviceRGB() {
    static CGColorSpaceRef space;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        space = CGColorSpaceCreateDeviceRGB();
    });
    return space;
}

CGImageRef jkr_CGImageCreateDecodedCopy(CGImageRef imageRef, BOOL decodeForDisplay) {
    if (!imageRef) return NULL;
    size_t width = CGImageGetWidth(imageRef);
    size_t height = CGImageGetHeight(imageRef);
    if (width == 0 || height == 0) return NULL;
    if (decodeForDisplay) {
        CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(imageRef) & kCGBitmapAlphaInfoMask;
        BOOL hasAlpha = NO;
        if (alphaInfo == kCGImageAlphaPremultipliedFirst || alphaInfo == kCGImageAlphaPremultipliedLast || alphaInfo == kCGImageAlphaFirst || alphaInfo == kCGImageAlphaLast) hasAlpha = YES;
        CGBitmapInfo bitmapInfo = kCGBitmapByteOrder32Host;
        bitmapInfo |= hasAlpha ? kCGImageAlphaPremultipliedFirst : kCGImageAlphaNoneSkipFirst;
        CGContextRef context = CGBitmapContextCreate(NULL, width, height, 8, 0, jkr_CGColorSpaceGetDeviceRGB(), bitmapInfo);
        if (!context) return NULL;
        CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
        CGImageRef newImage = CGBitmapContextCreateImage(context);
        CFRelease(context);
        return newImage;
    } else {
        CGColorSpaceRef space = CGImageGetColorSpace(imageRef);
        size_t bitsPerComponent = CGImageGetBitsPerComponent(imageRef);
        size_t bitsPerPixel = CGImageGetBitsPerPixel(imageRef);
        size_t bytesPerRow = CGImageGetBytesPerRow(imageRef);
        CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(imageRef);
        if (bytesPerRow == 0 || width == 0 || height == 0) return NULL;
        CGDataProviderRef dataProvider = CGImageGetDataProvider(imageRef);
        if (!dataProvider) return NULL;
        CFDataRef data = CGDataProviderCopyData(dataProvider); // decode
        if (!data) return NULL;
        CGDataProviderRef newProvider = CGDataProviderCreateWithCFData(data);
        CFRelease(data);
        if (!newProvider) return NULL;
        CGImageRef newImage = CGImageCreate(width, height, bitsPerComponent, bitsPerPixel, bytesPerRow, space, bitmapInfo, newProvider, NULL, false, kCGRenderingIntentDefault);
        CFRelease(newProvider);
        return newImage;
    }
}

- (instancetype)jkr_messageImageWithCount:(NSInteger)count imageSize:(CGSize)imageSize tipRadius:(CGFloat)tipRadius tipTop:(CGFloat)tipTop tipRight:(CGFloat)tipRight fontSize:(CGFloat)fontSize textColor:(UIColor *)textColor tipColor:(UIColor *)tipColor{
    UIImage *image = nil;
    size_t width = 0;
    if (count == 0) width = imageSize.width;
    else if (count < 10) width = imageSize.width + tipRight;
    else if (count < 100) width = imageSize.width + (8 * fontSize) / 13  + tipRight;
    else width = imageSize.width + (8 * fontSize) / 13 * 2 + tipRight;
    if (width < imageSize.width) width = imageSize.width;
    size_t height = imageSize.height + (count == 0 ? 0 : (tipTop > 0 ? tipTop : 0));
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, height), NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (!context) return nil;
    size_t circleCenterY = tipTop > 0 ? tipRadius : -tipTop + tipRadius;
    [self drawInRect:CGRectMake(0, count == 0 ? 0 : (tipTop > 0 ? tipTop : 0), imageSize.width, imageSize.height)];
    if (count != 0) {
        size_t endX = 0;
        UIBezierPath *circle = [UIBezierPath bezierPath];
        [circle addArcWithCenter:CGPointMake(imageSize.width + (tipRight - tipRadius), circleCenterY) radius:tipRadius startAngle:M_PI_2 endAngle:M_PI_2 * 3 clockwise:YES];
        if (count >= 100) {
            endX = imageSize.width + (8 * fontSize) / 13 * 2 + tipRight - tipRadius;
            [circle addLineToPoint:CGPointMake(endX, circleCenterY - tipRadius)];
        } else if (count >= 10) {
            endX = imageSize.width + (8 * fontSize) / 13  + tipRight - tipRadius;
            [circle addLineToPoint:CGPointMake(endX, circleCenterY - tipRadius)];
        } else if (count > 0) {
            endX = imageSize.width + tipRight - tipRadius;
        }
        [circle addArcWithCenter:CGPointMake(endX, circleCenterY) radius:tipRadius startAngle:M_PI_2 * 3 endAngle:M_PI_2 clockwise:YES];
        [tipColor ? tipColor : [UIColor redColor] setFill];
        CGContextAddPath(context, circle.CGPath);
        CGContextFillPath(context);
        NSDictionary *dict = @{NSFontAttributeName : [UIFont systemFontOfSize:fontSize], NSForegroundColorAttributeName : textColor ? textColor : [UIColor whiteColor]};
        NSString *countStr = nil;
        if (count < 100) countStr = [NSString stringWithFormat:@"%zd", count];
        else countStr = @"99+";
        size_t textY = 0;
        if (tipTop >= 0) textY = tipRadius - (fontSize) * 0.6;
        else textY = -tipTop + tipRadius - (fontSize) * 0.6;
        [countStr drawAtPoint:CGPointMake(imageSize.width + tipRight - tipRadius - ((8 * fontSize) / 13) * 0.5, textY) withAttributes:dict];
    }
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    image = [image jkr_imageByDecoded];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return image;
}


@end
