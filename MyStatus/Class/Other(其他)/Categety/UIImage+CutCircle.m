//
//  UIImage+CutCircle.m
//  02-裁剪图片
//
//  Created by Quan on 15/7/28.
//  Copyright (c) 2015年 Quan. All rights reserved.
//

#import "UIImage+CutCircle.h"

@implementation UIImage (CutCircle)

+(instancetype)CircleImagewithname:(UIImage *)image andborderWidth:(int)width andborderColoe:(UIColor *)bordercolor
{
    // 1.加载原图
    UIImage *oldimage = image;
    //1.开启上下文
    CGFloat border = width * 2;
    CGSize bigcicle = CGSizeMake(border + oldimage.size.width , border + oldimage.size.height );
    UIGraphicsBeginImageContextWithOptions(bigcicle, NO, 0.0);
    
    //2.获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //3.画大圆
    CGFloat bigradium = bigcicle.width * 0.5 ;
    CGFloat bigcenterX = bigradium;
    CGFloat bigcenterY = bigradium;
    CGContextAddArc(ctx, bigcenterX, bigcenterY, bigradium, 0, M_PI * 2, 0);
    [bordercolor set];
    CGContextFillPath(ctx);
    
    //4.画小圆
    CGFloat smallRadium = bigradium - border;
    
    CGContextAddArc(ctx, bigcenterX, bigcenterY, smallRadium, 0, M_PI * 2, 0);
    CGContextClip(ctx);
    [[UIColor blackColor]set];
    CGContextFillPath(ctx);
    
    //5.画图
    [oldimage drawInRect:CGRectMake(border, border, oldimage.size.width , oldimage.size.height )];
    
    //6.取出图片
    UIImage *newimage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return newimage;
}

@end
