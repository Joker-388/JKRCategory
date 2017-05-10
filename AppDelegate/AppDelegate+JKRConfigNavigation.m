//
//  AppDelegate+JKRConfigNavigation.m
//  RongCloudDemo
//
//  Created by Lucky on 2017/5/4.
//  Copyright © 2017年 KaiHei. All rights reserved.
//

#import "AppDelegate+JKRConfigNavigation.h"

@implementation AppDelegate (JKRConfigNavigation)

- (void)jkr_configNavigation {
    //    UINavigationBar *navigationBar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[JKRNavigationController class]]];
    UINavigationBar *navigationBar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[UINavigationController class]]];
    navigationBar.barTintColor = JKRColorHex(000000); // 设置顶栏背景色，不会被模糊，最直接有效的设置顶栏背景色方法
    navigationBar.tintColor = [UIColor whiteColor];
    
    //设置中间title文字的字体和颜色
    NSMutableDictionary *titleTextAttributesDictionary = [NSMutableDictionary dictionary];
    titleTextAttributesDictionary[NSForegroundColorAttributeName] = [UIColor whiteColor];
    titleTextAttributesDictionary[NSFontAttributeName] = [UIFont systemFontOfSize:16];
    navigationBar.titleTextAttributes = titleTextAttributesDictionary;
    
    // 设置左右按钮BarButtonItem文字的字体和颜色
    //    UIBarButtonItem *barButtonItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[JKRNavigationController class]]];
    UIBarButtonItem *barButtonItem = [UIBarButtonItem appearance];
    // 默认状态下的字体和颜色
    NSMutableDictionary *normalBarButtonItemAttributesDictionary = [NSMutableDictionary dictionary];
    normalBarButtonItemAttributesDictionary[NSForegroundColorAttributeName] = [UIColor whiteColor];
    normalBarButtonItemAttributesDictionary[NSFontAttributeName] = [UIFont systemFontOfSize:16];
    [barButtonItem setTitleTextAttributes:normalBarButtonItemAttributesDictionary forState:UIControlStateNormal];
    // 高亮状态下的字体和颜色
    NSMutableDictionary *highLightBarButtomItemAttributesDictionary = [NSMutableDictionary dictionary];
    highLightBarButtomItemAttributesDictionary[NSForegroundColorAttributeName] = [UIColor whiteColor];
    highLightBarButtomItemAttributesDictionary[NSFontAttributeName] = [UIFont systemFontOfSize:16];
    [barButtonItem setTitleTextAttributes:highLightBarButtomItemAttributesDictionary forState:UIControlStateHighlighted];
    // 禁用状态下的字体和颜色
    NSMutableDictionary *disableBarButtonItemAttributesDictionary = [NSMutableDictionary dictionary];
    disableBarButtonItemAttributesDictionary[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    disableBarButtonItemAttributesDictionary[NSFontAttributeName] = [UIFont systemFontOfSize:16];
    [barButtonItem setTitleTextAttributes:disableBarButtonItemAttributesDictionary forState:UIControlStateDisabled];
}

@end
