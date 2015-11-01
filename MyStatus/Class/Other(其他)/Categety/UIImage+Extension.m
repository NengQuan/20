//
//  UIImage+Extension.m
//  MyStatus
//
//  Created by NengQuan on 15/10/30.
//  Copyright © 2015年 NengQuan. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

- (instancetype)circleImage
{
    
    UIGraphicsBeginImageContext(self.size);
    
    // 获得上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 添加一个圆
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(context, rect);
    
    // 裁剪(根据添加到上下文中的路径进行裁剪)
    // 以后超出裁剪后形状的内容都看不见
    CGContextClip(context);
    
    // 绘制图片到上下文中
    [self drawInRect:rect];
    
    // 从上下文中获得最终的图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭图形上下文
    UIGraphicsEndImageContext();
    
    return image;

}

+ (instancetype)circleImageNamed:(NSString *)name
{
    return [[self imageNamed:name ]circleImage];
}
@end
