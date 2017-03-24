//
//  UIView+JKR_HitTest.h
//  JKRUIResponderDemo
//
//  Created by Lucky on 17/3/24.
//  Copyright © 2017年 Lucky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (JKR_HitTest)

- (UIView *)jkr_hitTest:(CGPoint)point withEvent:(UIEvent *)event;

@end
