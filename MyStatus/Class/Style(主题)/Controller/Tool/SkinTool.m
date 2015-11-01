//
//  SkinTool.m
//  MyStatus
//
//  Created by NengQuan on 15/10/31.
//  Copyright © 2015年 NengQuan. All rights reserved.
//

#import "SkinTool.h"

NSString *const skinColor = @"skin_color";
@implementation SkinTool

static NSString *_skinColor; // 用于记录外面切换的皮肤
+ (void)initialize
{
    _skinColor = [[NSUserDefaults standardUserDefaults] objectForKey:skinColor];
    if (_skinColor == nil) {
        _skinColor = @"black";
    }
}

+ (void)setSkinColor:(NSString *)skinColor
{
    _skinColor = skinColor;
    
    // 记录用户选中的皮肤
    
    [[NSUserDefaults standardUserDefaults] setObject:skinColor forKey:skinColor];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - 切换背景图片的换肤方法
+ (UIImage *)skinToolWithName:(NSString *)name
{
    NSString *imageName = [NSString stringWithFormat:@"skin/%@/%@", _skinColor, name];
    return [UIImage imageNamed:imageName];
}

@end
