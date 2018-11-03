//
//  UIImage+JKRBlur.h
//  BaoJiDianJing
//
//  Created by Lucky on 2018/6/5.
//  Copyright © 2018年 KaiHei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (JKRBlur)

/// 高效果的模糊，低性能或模拟器可能会卡顿
- (UIImage *)jkr_Blur;
/// 地效果不完善的，速度快
- (UIImage *)jkr_BlurWithBlur:(CGFloat)blur;

@end
