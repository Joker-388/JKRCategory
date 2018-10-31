//
//  UITableView+JKREmptyView.m
//  Demo
//
//  Created by Lucky on 2017/5/27.
//  Copyright © 2017年 Lucky. All rights reserved.
//

#import "UITableView+JKREmptyView.h"
#import <objc/runtime.h>

@implementation UITableView (JKREmptyView)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method originMethod = class_getInstanceMethod(self, @selector(reloadData));
        Method swizzedMethod = class_getInstanceMethod(self, @selector(jkr_reloadData));
        BOOL methodAdded = class_addMethod(self, @selector(reloadData), method_getImplementation(swizzedMethod), method_getTypeEncoding(swizzedMethod));
        
        if (methodAdded) {
            class_replaceMethod(self, @selector(jkr_reloadData), method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
        }else{
            method_exchangeImplementations(originMethod, swizzedMethod);
        }
    });
}

- (void)setPlaceHolderView:(UIView *)placeHolderView {
    objc_setAssociatedObject(self, @selector(placeHolderView), placeHolderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    placeHolderView.hidden = YES;
    [self insertSubview:placeHolderView atIndex:0];
}

- (UIView *)placeHolderView {
    return objc_getAssociatedObject(self, @selector(placeHolderView));
}

- (void)setPlaceHolderIgnoreFirstRow:(BOOL)placeHolderIgnoreFirstRow {
    objc_setAssociatedObject(self, @selector(placeHolderIgnoreFirstRow), [NSNumber numberWithBool:placeHolderIgnoreFirstRow], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)placeHolderIgnoreFirstRow {
    return [objc_getAssociatedObject(self, @selector(placeHolderIgnoreFirstRow)) boolValue];
}

- (void)jkr_reloadData {
    [self jkr_reloadData];
    [self jkr_resetPlaceHoderView];
}

- (void)jkr_resetPlaceHoderView {
    BOOL isEmpty = YES;
    id<UITableViewDataSource> dataSource = self.dataSource;
    NSInteger sectionCount;
    if ([dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        sectionCount = [dataSource numberOfSectionsInTableView:self];
    } else {
        sectionCount = 1;
    }
    if ([dataSource respondsToSelector:@selector(tableView:numberOfRowsInSection:)]) {
        for (int i = 0; i < sectionCount; i++) {
            if (i == 0 && self.placeHolderIgnoreFirstRow) {
                continue;
            }
            if ([dataSource tableView:self numberOfRowsInSection:i]) {
                isEmpty = NO;
                break;
            }
        }
        self.placeHolderView.hidden = !isEmpty;
    }
}

@end
