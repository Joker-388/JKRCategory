//
//  UIGestureRecognizer+JKRTouch.h
//  JKRTouchDemo
//
//  Created by Joker on 2016/12/31.
//  Copyright © 2016年 Lucky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIGestureRecognizer (JKRTouch)

/// 设置一个控件的不响应手势事件的区域
@property (nonatomic, assign) BOOL unTouch;

@end
