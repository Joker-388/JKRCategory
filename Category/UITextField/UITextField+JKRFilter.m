//
//  UITextField+JKRFilter.m
//  JKRCategoryDemo
//
//  Created by Joker on 2018/11/5.
//  Copyright © 2018 Joker. All rights reserved.
//

#import "UITextField+JKRFilter.h"

@implementation UITextField (JKRFilter)

/// 限制输入多少位
- (BOOL)jkr_limitInputMaxLength:(NSInteger)length shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // 允许回删
    if (range.length == 1 && string.length == 0) return YES;
    NSString *prefix = self.text;
    NSString *newValueStr = prefix.length == 0 ? string : [NSString stringWithFormat:@"%@%@",prefix, string];
    if (newValueStr.length > length) return NO;
    return YES;
}

/// 限制输入仅限数字
- (BOOL)jkr_limitInputNumberWithShouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // 允许回删
    if (range.length == 1 && string.length == 0) return YES;
    BOOL res = YES;
    NSCharacterSet *tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < string.length) {
        NSString * str = [string substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [str rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}

@end
