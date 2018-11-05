//
//  NSString+JKRSubNumber.m
//  JKRCategoryDemo
//
//  Created by Joker on 2016/10/2.
//  Copyright © 2018 Joker. All rights reserved.
//

#import "NSString+JKRFilter.h"

@implementation NSString (JKRFilter)

- (NSString *)jkr_filter_subNumberString {
    if (!self || ![self containsString:@"."]) return self;
    BOOL hasComma = [self containsString:@","];
    NSString *subCommaString;
    if (hasComma) {
        hasComma = YES;
        subCommaString = [self stringByReplacingOccurrencesOfString:@"," withString:@""];
    } else {
        subCommaString = self;
    }
    NSString *subfloatString = [NSString stringWithFormat:@"%.4f", subCommaString.doubleValue];
    NSString *ms = [NSString stringWithString:subfloatString];
    subNumberString(&ms);
    if (hasComma) {
        if ([ms containsString:@"."]) {
            NSRange dRange = [ms rangeOfString:@"."];
            NSString *fString = [ms substringWithRange:NSMakeRange(0, dRange.location)];
            NSString *bString = [ms substringWithRange:NSMakeRange(dRange.location + 1, ms.length - dRange.location - 1)];
            NSString *rString;
            NSMutableString *mFString = [NSMutableString stringWithString:fString];
            for (NSInteger i = 0; (i + 1) * 3 + i < mFString.length; i++) {
                [mFString insertString:@"," atIndex:mFString.length - ((i + 1) * 3 + i)];
            }
            rString = [NSString stringWithFormat:@"%@.%@", mFString, bString];
            return rString;
        } else {
            NSString *fString = ms;
            NSString *rString;
            NSMutableString *mFString = [NSMutableString stringWithString:fString];
            for (NSInteger i = 0; (i + 1) * 3 + i < mFString.length; i++) {
                [mFString insertString:@"," atIndex:mFString.length - ((i + 1) * 3 + i)];
            }
            rString = [NSString stringWithFormat:@"%@", mFString];
            return rString;
        }
    }
    return ms;
}

static inline void subNumberString(NSString **string) {
    NSString *ms = *string;
    while ([ms hasSuffix:@"0"] && ms.length > 0) {
        ms = [ms substringToIndex:ms.length - 1];
    }
    if ([ms hasSuffix:@"."]) {
        ms = [ms substringToIndex:ms.length - 1];
    }
    *string = ms;
}

- (NSString *)jkr_filter_emoji {
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:self options:0 range:NSMakeRange(0, [self length]) withTemplate:@""];
    return modifiedString;
}


@end
