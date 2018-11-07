//
//  UITextField+JKRFilter.m
//  JKRCategoryDemo
//
//  Created by Joker on 2017/10/5.
//  Copyright © 2017 Joker. All rights reserved.
//

#import "UITextField+JKRFilter.h"
#import <objc/runtime.h>

@interface UITextField ()

@property (nonatomic, assign) NSInteger jkr_max_limit;
@property (nonatomic, copy) jkr_textFieldChangeBlock jkr_textFieldChangeBlock;

@end

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

- (void)jkr_addlimitMaxInputLength:(NSInteger)length {
    [self jkr_addlimitMaxInputLength:length changeBlock:nil];
}

- (void)jkr_addlimitMaxInputLength:(NSInteger)length changeBlock:(jkr_textFieldChangeBlock)changeBlock {
    if (length <= 0) return;
    self.jkr_max_limit = length;
    self.jkr_textFieldChangeBlock = changeBlock;
    [self addTarget:self action:@selector(textDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (NSInteger)jkr_max_limit {
    return [objc_getAssociatedObject(self, @selector(jkr_max_limit)) integerValue];
}

- (void)setJkr_max_limit:(NSInteger)jkr_max_limit {
    objc_setAssociatedObject(self, @selector(jkr_max_limit), [NSNumber numberWithInteger:jkr_max_limit], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (jkr_textFieldChangeBlock)jkr_textFieldChangeBlock {
    return objc_getAssociatedObject(self, @selector(jkr_textFieldChangeBlock));
}

- (void)setJkr_textFieldChangeBlock:(jkr_textFieldChangeBlock)jkr_textFieldChangeBlock {
    objc_setAssociatedObject(self, @selector(jkr_textFieldChangeBlock), jkr_textFieldChangeBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)textDidChange:(UITextField *)textField {
    NSInteger kMaxLength = self.jkr_max_limit;
    NSString *toBeString = textField.text;
    NSString *lang = [[UIApplication sharedApplication]textInputMode].primaryLanguage; //ios7之前使用[UITextInputMode currentInputMode].primaryLanguage
    if ([lang isEqualToString:@"zh-Hans"]) { //中文输入
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        if (!position) {// 没有高亮选择的字，则对已输入的文字进行字数统计和限制
            if (toBeString.length > kMaxLength) {
                textField.text = [toBeString substringToIndex:kMaxLength];
            }
        } else {//有高亮选择的字符串，则暂不对文字进行统计和限制
            
        }
    }else{//中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        if (toBeString.length > kMaxLength) {
            textField.text = [toBeString substringToIndex:kMaxLength];
        }
    }
    
    if (self.jkr_textFieldChangeBlock) self.jkr_textFieldChangeBlock(textField);
}

@end
