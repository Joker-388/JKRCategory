//
//  UIImage+Tool.h
//  WaterMark
//
//  Created by Lucky on 15/7/19.
//  Copyright (c) 2015年 Lucky. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    UIImageWaterMarkTypePattern,
    UIImageWaterMarkTypeLeftTop,
    UIImageWaterMarkTypeLeftBottom,
    UIImageWaterMarkTypeRightTop,
    UIImageWaterMarkTypeRightBottom
}UIImageWaterMarkType;

@interface UIImage (Tool)

+(instancetype)image:(UIImage *)image withBorder:(CGFloat)borderWidth withColor:(UIColor *)borderColor;

+(instancetype)imageForScreenCapture:(UIView *)viewForCapture;

+(instancetype)imageWithWaterMark:(UIImage *)imageForWaterMark withMarkString:(NSString *)markString withMarkStringAttributes:(NSDictionary *)markStringAttributes withMarkType:(UIImageWaterMarkType)markType;

+(instancetype)imageWithStretchCenter:(UIImage *)image;

@end
