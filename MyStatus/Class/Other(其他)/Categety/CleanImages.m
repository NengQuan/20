//
//  CleanImages.m
//  BanTang
//
//  Created by NengQuan on 15/11/22.
//  Copyright © 2015年 NengQuan. All rights reserved.
//

#import "CleanImages.h"
#import <sys/stat.h>


@implementation CleanImages

// C 语言版本
- (void)cleanOldFileAtDirectory:(NSString *)dirPath maxSize:(NSUInteger)maxSize
{
    NSFileManager *mgr = [NSFileManager defaultManager];
    // 判断路径是否存在
    BOOL exisit = [mgr fileExistsAtPath:dirPath];
    if (exisit) {
        // 获取所有路径
        NSArray *fileArray = [mgr subpathsOfDirectoryAtPath:dirPath error:nil];
        // 缓存图片数量大于最大数目
        if (fileArray.count > maxSize) {
            // 进行排序
            NSArray *stortedPaths = [fileArray sortedArrayUsingComparator:^NSComparisonResult(NSString *firstPath, NSString *secondPath) {
            // 获得全路径
                NSString *firstUrl = [dirPath stringByAppendingPathComponent:firstPath];
                NSString *secondUrl = [dirPath stringByAppendingPathComponent:secondPath];
            // 获得修改时间
                long firstTime = [self modifyTime:firstUrl];
                long secondTime = [self modifyTime:secondUrl];
            // 正序
                if (firstTime > secondTime) {
                    return NSOrderedAscending;
            // 逆序
                } else if (firstTime < secondTime) {
                    return NSOrderedDescending;
                }
                return NSOrderedSame;
            }];
            
            for (int i = maxSize; i<stortedPaths.count; i++) {
                NSString *filePath = stortedPaths[i];
                NSString *fileUrl = [dirPath stringByAppendingPathComponent:filePath];
                [mgr removeItemAtPath:fileUrl error:nil];
            }
        }
        
    }

}

- (long)modifyTime:(NSString *)filePath
{
    struct stat stat;
    if(lstat([filePath cStringUsingEncoding:NSUTF8StringEncoding], &stat) == 0){
        return stat.st_mtimespec.tv_sec;
    }

    return 0;
}

// OC版本
- (void)cleanAllFileAtDirectory:(NSString *)dirPath maxSize:(NSUInteger)maxSize
{
    NSFileManager *mgr = [NSFileManager defaultManager];
    BOOL exisit = [mgr fileExistsAtPath:dirPath];
    
    if (exisit) {
        NSArray *fileArray = [mgr subpathsOfDirectoryAtPath:dirPath error:nil];
        
        if (fileArray.count > maxSize) {
            NSArray *stortedPaths = [fileArray sortedArrayUsingComparator:^NSComparisonResult(NSString *firstPath, NSString *secondPath) {
                NSString *firstUrl = [dirPath stringByAppendingPathComponent:firstPath];
                NSString *secondUrl = [dirPath stringByAppendingPathComponent:secondPath];
        
                NSDictionary *firstFileInfo = [mgr attributesOfItemAtPath:firstUrl error:nil];
                NSDictionary *secondFileInfo = [mgr attributesOfItemAtPath:secondUrl error:nil];
                NSDate *firstDate = [firstFileInfo objectForKey:NSFileModificationDate];
                NSDate *secondeDate = [secondFileInfo objectForKey:NSFileModificationDate];
            
                
                return [secondeDate compare:firstDate];
            }];
            
            
            for (int i = maxSize; i<fileArray.count; i++) {
                NSString *filePath = stortedPaths[i];
                NSString *fileUrl = [dirPath stringByAppendingPathComponent:filePath];
                [mgr removeItemAtPath:fileUrl error:nil];
            }
        }
        
    }

        
}

@end
