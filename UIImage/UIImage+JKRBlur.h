//
//  UIImage+JKRBlur.h
//  BaoJiDianJing
//
//  Created by Lucky on 2018/6/5.
//  Copyright © 2018年 KaiHei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (JKRBlur)

- (UIImage *)jkr_Blur;

- (UIImage *)jkr_BlurWithBlur:(CGFloat)blur;

@end
