//
//  NSString+JKRFile.h
//  Lucky
//
//  Created by Lucky on 2014/08/02.
//  Copyright © 2014年 Lucky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JKRFile)

/// 获取当前字符串路径下文件夹内文件总大小
- (NSString *)jkr_documentFileSize;
/// 清空当前字符串路径下的文件夹
- (BOOL)jkr_clearDocument;

@end
