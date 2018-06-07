//
//  UIImage+JKRBlur.m
//  BaoJiDianJing
//
//  Created by Lucky on 2018/6/5.
//  Copyright © 2018年 KaiHei. All rights reserved.
//

#import "UIImage+JKRBlur.h"
#import <Accelerate/Accelerate.h>
#import "JKRGroupChatManager.h"

@implementation UIImage (JKRBlur)

- (UIImage *)jkr_Blur {
    if (self == nil || [self isKindOfClass:[NSNull class]] || ![self isKindOfClass:[UIImage class]]) {
        return nil;
    }
//    return nil;
    if (TARGET_IPHONE_SIMULATOR) {
        return [self jkr_BlurWithBlur:1.0];
    } else {
        CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
        CIImage *ciImage = [[CIImage alloc] initWithImage:self];
        [filter setValue:ciImage forKey:kCIInputImageKey];
        [filter setValue:@(20.0) forKey:kCIInputRadiusKey];
        CIImage *outImage = [filter valueForKey:kCIOutputImageKey];
        CIContext *context = [CIContext contextWithOptions:nil];
        CGImageRef cgImage = [context createCGImage:outImage fromRect:[ciImage extent]];
        UIImage *result = [UIImage imageWithCGImage:cgImage];
        CGImageRelease(cgImage);
        return result;
    }
}

- (UIImage *)jkr_BlurWithBlur:(CGFloat)blur {
    if (self == nil || [self isKindOfClass:[NSNull class]] || ![self isKindOfClass:[UIImage class]]) {
        return nil;
    }
    
    if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
    }
    int boxSize = (int)(blur * 40);
    boxSize = boxSize - (boxSize % 2) + 1;
    
    CGImageRef img = self.CGImage;
    
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    
    void *pixelBuffer;
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) *
                         CGImageGetHeight(img));
    
    if(pixelBuffer == NULL) {
        NSLog(@"No pixelbuffer");
        return nil;
    }
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    
    if (error) {
        NSLog(@"error from convolution %ld", error);
        return nil;
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    CFRelease(inBitmapData);
    
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    
    return returnImage;
}

@end
