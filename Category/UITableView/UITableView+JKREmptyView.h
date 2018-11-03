//
//  UITableView+JKREmptyView.h
//  Demo
//
//  Created by Lucky on 2017/5/27.
//  Copyright © 2017年 Lucky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (JKREmptyView)

@property (nonatomic, strong) UIView *placeHolderView;
@property (nonatomic, assign) BOOL placeHolderIgnoreFirstRow;

@end

