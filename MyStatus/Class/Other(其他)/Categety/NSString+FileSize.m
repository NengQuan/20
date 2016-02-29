//
//  NSString+FileSize.m
//  
//
//  Created by NengQuan on 15/10/12.
//  Copyright © 2015年 NengQuan. All rights reserved.
//

#import "NSString+FileSize.h"

@implementation NSString (FileSize)

- (NSUInteger)filesize
{
    // 获取文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    // 是否为文件夹
    BOOL isDiretery = NO;
    
    BOOL exisit = [mgr fileExistsAtPath:self isDirectory:&isDiretery];
    
    // 判断路径是否存在
    if (!exisit) return 0;
    
    // 如果是文件夹
    if (isDiretery) {
        unsigned long long filesize = 0;
        NSDirectoryEnumerator *emumeras = [mgr enumeratorAtPath:self];
        // 遍历所有文件
        for (NSString *subpath in emumeras) {
            NSString *fullpath = [self stringByAppendingPathComponent:subpath];
            filesize += [mgr attributesOfItemAtPath:fullpath error:nil].fileSize;
        }
        return filesize;
    }
    // 如果是文件
    return [mgr attributesOfItemAtPath:self error:nil].fileSize;

}
@end
