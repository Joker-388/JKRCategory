//
//  UIView+JKRSnap.m
//  JKRUIViewDemo
//
//  Created by Joker on 2015/9/6.
//  Copyright © 2015年 ZHYQ. All rights reserved.
//

#import "UIView+JKRSnap.h"

@implementation UIView (JKRSnap)

- (UIImage *)jkr_snapImage {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *snapImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snapImage;
}

@end
