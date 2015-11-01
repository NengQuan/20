//
//  UIBarButtonItem+Extension.h
//  01-百思不得姐-基本框架
//
//  Created by NengQuan on 15/9/29.
//  Copyright (c) 2015年 NengQuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+ (instancetype)itemWithimage:(NSString *)image Heightimage:(NSString *)heightimage target:(id)target action:(SEL)selector;
@end
