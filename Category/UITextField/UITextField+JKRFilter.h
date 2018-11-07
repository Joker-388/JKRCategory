//
//  UITextField+JKRFilter.h
//  JKRCategoryDemo
//
//  Created by Joker on 2017/10/5.
//  Copyright © 2017 Joker. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^jkr_textFieldChangeBlock)(UITextField *textField);

@interface UITextField (JKRFilter)

#pragma mark - delegate:shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
/// 限制输入多少位，中文或联想输入可能会被屏幕
- (BOOL)jkr_limitInputMaxLength:(NSInteger)length shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
/// 限制输入仅限数字
- (BOOL)jkr_limitInputNumberWithShouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

#pragma mark - ControlEvents 会和ControlEvents监听冲突
/// 添加长度限制，支持联想和中文
- (void)jkr_addlimitMaxInputLength:(NSInteger)length;
/// 添加长度限制，支持联想和中文，回调实时文字改变
- (void)jkr_addlimitMaxInputLength:(NSInteger)length changeBlock:(jkr_textFieldChangeBlock)changeBlock;

@end

