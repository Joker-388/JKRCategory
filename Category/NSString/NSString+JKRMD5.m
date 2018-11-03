//
//  NSString+JKRMD5.m
//  JKRBaseProject
//
//  Created by Lucky on 2017/6/8.
//  Copyright © 2017年 Joker. All rights reserved.
//

#import "NSString+JKRMD5.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (JKRMD5)

- (NSString *)jkr_md5String {
    CC_MD5_CTX md5;
    CC_MD5_Init (&md5);
    CC_MD5_Update (&md5, [self UTF8String], (CC_LONG) [self length]);
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final (digest, &md5);
    NSString *s = [NSString stringWithFormat: @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                   digest[0],  digest[1],
                   digest[2],  digest[3],
                   digest[4],  digest[5],
                   digest[6],  digest[7],
                   digest[8],  digest[9],
                   digest[10], digest[11],
                   digest[12], digest[13],
                   digest[14], digest[15]];
    return s;
}

@end
