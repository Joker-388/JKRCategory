//
//  UIImage+Tool.m
//  WaterMark
//
//  Created by Lucky on 15/7/19.
//  Copyright (c) 2015年 Lucky. All rights reserved.
//

#import "UIImage+Tool.h"

@implementation UIImage (Tool)

/**图片加环形边框*/
+(instancetype)image:(UIImage *)image withBorder:(CGFloat)borderWidth withColor:(UIColor *)borderColor
{
    CGRect mframe = CGRectMake(0, 0, image.size.width + borderWidth * 2, image.size.height + borderWidth * 2);
    
    UIGraphicsBeginImageContextWithOptions(mframe.size, NO, 0.0);
    
    UIBezierPath *pathCir = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, mframe.size.width, mframe.size.height)];
    
    CGContextRef ctr = UIGraphicsGetCurrentContext();
    
    [borderColor setFill];
    
    CGContextAddPath(ctr, pathCir.CGPath);
    
    CGContextFillPath(ctr);
    
    
    UIBezierPath *pathClip = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(borderWidth, borderWidth, image.size.width, image.size.height)];
    
    [pathClip addClip];
    
    [image drawAtPoint:CGPointMake(borderWidth, borderWidth)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

/**屏幕截图*/
+(instancetype)imageForScreenCapture:(UIView *)viewForCapture
{
    
    UIGraphicsBeginImageContext(viewForCapture.bounds.size);
    
    CGContextRef ctr = UIGraphicsGetCurrentContext();
    
    [viewForCapture.layer renderInContext:ctr];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

/**添加水印*/
+(instancetype)imageWithWaterMark:(UIImage *)imageForWaterMark withMarkString:(NSString *)markString withMarkStringAttributes:(NSDictionary *)markStringAttributes withMarkType:(UIImageWaterMarkType)markType
{
    UIGraphicsBeginImageContextWithOptions(imageForWaterMark.size, NO, 0.0);
    
    [imageForWaterMark drawAtPoint:CGPointZero];
    
    NSString *str = markString;
    
    NSDictionary *dict = markStringAttributes;
    //    [str drawAtPoint:CGPointMake(self.oldImage.size.width * 0.7, self.oldImage.size.height * 0.8) withAttributes:dict];
    CGSize textSize = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    
    switch (markType) {
        case UIImageWaterMarkTypePattern:
        {
            
            CGFloat widx = 10;
            CGFloat widy = 20;
            int xCount = (int)(imageForWaterMark.size.width / (textSize.width + widx)) + 1;
            int yCount = (int)(imageForWaterMark.size.height/(textSize.height + widy)) + 1;
            int aCount = xCount * yCount;
            for (int i = 0; i < aCount; i++) {
                CGFloat tx = (widx + textSize.width) * (i % xCount);
                CGFloat ty = (widy + textSize.height) * (i / xCount);
                [str drawAtPoint:CGPointMake(tx, ty) withAttributes:dict];
            }
        }
        break;
        case UIImageWaterMarkTypeLeftBottom:
        {
            [str drawAtPoint:CGPointMake(imageForWaterMark.size.width * 0.05, imageForWaterMark.size.height - textSize.height - imageForWaterMark.size.height * 0.05) withAttributes:markStringAttributes];
        }
        break;
        case UIImageWaterMarkTypeLeftTop:
        {
            [str drawAtPoint:CGPointMake(imageForWaterMark.size.width * 0.05, imageForWaterMark.size.height * 0.05) withAttributes:markStringAttributes];
        }
        break;
        case UIImageWaterMarkTypeRightBottom:
        {
            [str drawAtPoint:CGPointMake(imageForWaterMark.size.width - textSize.width - imageForWaterMark.size.width * 0.05, imageForWaterMark.size.height - textSize.height - imageForWaterMark.size.height * 0.05) withAttributes:markStringAttributes];
        }
        break;
        case UIImageWaterMarkTypeRightTop:
        {
            [str drawAtPoint:CGPointMake(imageForWaterMark.size.width - textSize.width -imageForWaterMark.size.width * 0.05, imageForWaterMark.size.height * 0.05) withAttributes:markStringAttributes];
        }
        break;
        default:
        break;
    }
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
   
    return newImage;
}

+(instancetype)imageWithStretchCenter:(UIImage *)image
{
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

@end
