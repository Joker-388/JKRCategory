//
//  NSString+JKRRegular.m
//  JKRCategoryDemo
//
//  Created by Joker on 2017/10/3.
//  Copyright © 2018 Joker. All rights reserved.
//

#import "NSString+JKRRegular.h"

@implementation NSString (JKRRegular)

- (BOOL)jkr_regular_isPhoneNumber {
    if (self.length < 11) return NO;
    // NSString *regular = @"^1\\d{10}$"; 非精确，只判断位数
    NSString *regular = @"^1(3[0-9]|4[579]|5[0-35-9]|7[0-35-8]|8[0-9])\\d{8}$";
    NSPredicate *regextestMobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regular];
    BOOL isValid = [regextestMobile evaluateWithObject:self];
    return isValid;
}

@end
