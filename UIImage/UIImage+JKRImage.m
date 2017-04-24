//
//  UIImage+JKRImage.m
//  UINavDemo
//
//  Created by Lucky on 2015/8/17.
//  Copyright © 2015年 Lucky. All rights reserved.
//

#import "UIImage+JKRImage.h"

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

- (UIImage *)jkr_compressWithWidth:(CGFloat)width {
    if (width <= 0 || [self isKindOfClass:[NSNull class]] || self == nil) return nil;
    CGSize newSize = CGSizeMake(width, width * (self.size.height / self.size.width));
    UIGraphicsBeginImageContext(newSize);
    [self drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)jkr_compressToDataLength:(NSInteger)length withBlock :(void (^)(UIImage *))block {
    if (length <= 0 || [self isKindOfClass:[NSNull class]] || self == nil) block(nil);
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        UIImage *newImage = [strongSelf copy];
        CGFloat scale = 1.0;
        NSInteger newImageLength = UIImagePNGRepresentation(newImage).length;
        while (newImageLength > length) {
            // 如果限定的大小比当前的尺寸大0.9的平方倍，就用开方求缩放倍数,减少缩放次数
            if ((double)length / (double)newImageLength < 0.81) {
                scale = sqrtf((double)length / (double)newImageLength);
            } else {
                scale = 0.9;
            }
            CGFloat width = newImage.size.width * scale;
            newImage = [newImage jkr_compressWithWidth:width];
            newImageLength = UIImagePNGRepresentation(newImage).length;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            block(newImage);
        });
    });
}

- (UIImage *)jkr_compressToDataLength:(NSInteger)length {
    if (length <= 0 || [self isKindOfClass:[NSNull class]] || self == nil) return nil;
    UIImage *newImage = [self copy];
    CGFloat scale = 1.0;
    NSInteger newImageLength = UIImagePNGRepresentation(newImage).length;
    while (newImageLength > length) {
        // 如果限定的大小比当前的尺寸大0.9的平方倍，就用开方求缩放倍数,减少缩放次数
        if ((double)length / (double)newImageLength < 0.81) {
            scale = sqrtf((double)length / (double)newImageLength);
        } else {
            scale = 0.9;
        }
        CGFloat width = newImage.size.width * scale;
        newImage = [newImage jkr_compressWithWidth:width];
        newImageLength = UIImagePNGRepresentation(newImage).length;
    }
    return newImage;
}

@end
