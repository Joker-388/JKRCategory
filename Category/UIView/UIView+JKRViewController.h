//
//  UIView+JKRViewController.h
//  JKRSearchDemo
//
//  Created by Joker on 2016/5/16.
//  Copyright © 2016年 Lucky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (JKRViewController)

/// 当前视图最近一级的UIViewController
@property (nonatomic, strong, readonly) UIViewController *jkr_viewController;

@end
