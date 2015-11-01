//
//  NSString+Filepath.m
//  05-下载多张图片
//
//  Created by NengQuan on 15/9/3.
//  Copyright (c) 2015年 NengQuan. All rights reserved.
//

#import "NSString+Filepath.h"

@implementation NSString (Filepath)

- (instancetype)pathCaches
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
    NSString *filepath = [path stringByAppendingPathComponent:[self lastPathComponent]];
    
    return filepath;
}

- (instancetype)pathDoc
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    
    NSString *filepath = [path stringByAppendingPathComponent:[self lastPathComponent]];
    
    return filepath;
}

-(instancetype)pathTem
{
    NSString *path = NSTemporaryDirectory();
    
    NSString *filepath = [path stringByAppendingPathComponent:[self lastPathComponent]];
    
    return filepath;
    
}
@end
