//
//  NSURL+JKRFileSize.m
//  Lucky
//
//  Created by Lucky on 2016/4/15.
//  Copyright © 2016年 Lucky. All rights reserved.
//

#import "NSURL+JKRFileSize.h"

@implementation NSURL (JKRFileSize)

- (CGFloat)jkr_fileSize {
    if (self && self.absoluteString.length > 0) {
        NSData *data = [NSData dataWithContentsOfURL:self];
        if (data) {
            return [data length] / 1024.00 / 1024.00;
        } else {
            return 0.f;
        }
    } else {
        return 0.f;
    }
}

@end
