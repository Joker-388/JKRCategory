//
//  UITextField+JKRFilter.h
//  JKRCategoryDemo
//
//  Created by Joker on 2018/11/5.
//  Copyright © 2018 Joker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (JKRFilter)

/// 限制输入多少位
- (BOOL)jkr_limitInputMaxLength:(NSInteger)length shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

/// 限制输入仅限数字
- (BOOL)jkr_limitInputNumberWithShouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

@end

