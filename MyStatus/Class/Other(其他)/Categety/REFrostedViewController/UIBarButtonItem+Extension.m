//
//  UIBarButtonItem+Extension.m
//  01-百思不得姐-基本框架
//
//  Created by NengQuan on 15/9/29.
//  Copyright (c) 2015年 NengQuan. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

+ (instancetype)itemWithimage:(NSString *)image Heightimage:(NSString *)heightimage target:(id)target action:(SEL)selector
{
    UIButton *leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftbtn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [leftbtn setImage:[UIImage imageNamed:heightimage] forState:UIControlStateHighlighted];
    [leftbtn sizeToFit];
    [leftbtn setContentEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [leftbtn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc]initWithCustomView:leftbtn];
    
}

@end
