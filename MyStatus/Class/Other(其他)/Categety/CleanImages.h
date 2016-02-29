//
//  CleanImages.h
//  BanTang
//
//  Created by NengQuan on 15/11/22.
//  Copyright © 2015年 NengQuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CleanImages : NSObject

- (void)cleanOldFileAtDirectory:(NSString *)dirPath maxSize:(NSUInteger)maxSize;
@end
