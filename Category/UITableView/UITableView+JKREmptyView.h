//
//  UITableView+JKREmptyView.h
//  Demo
//
//  Created by Lucky on 2017/5/27.
//  Copyright © 2017年 Lucky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (JKREmptyView)

/// 为UITableView添加一个空占位控件，跟随滑动，需要制定frame，不支持autolayout
@property (nonatomic, strong) UIView *jkr_placeHolderView;
/// 判定为空是否忽略第一个cell，防止有人用cell充当顶部控件
@property (nonatomic, assign) BOOL jkr_placeHolderIgnoreFirstRow;

@end

