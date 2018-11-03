//
//  UIView+JKRTapGestureRecognizer.h
//  JKRTouch
//
//  Created by Lucky on 2016/8/9.
//  Copyright © 2016年 Lucky. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^tapGestureRecognizerBlock)(UIGestureRecognizer *gestureRecognizer);

@interface UIView (JKRTapGestureRecognizer)

/// 给控件添加一个点击手势并在block中处理
- (void)jkr_addTapGestureRecognizerWithBlock:(tapGestureRecognizerBlock)block;

@end
