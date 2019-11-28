//
//  UIView+JKRFrame.h
//  JKRDemo
//
//  Created by Lucky on 14/7/12.
//  Copyright © 2014年 Lucky. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

@interface UIView (JKRFrame)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origan;

@end
