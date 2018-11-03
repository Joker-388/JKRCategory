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

- (void)jkr_addTapGestureRecognizerWithBlock:(tapGestureRecognizerBlock)block;

@end
