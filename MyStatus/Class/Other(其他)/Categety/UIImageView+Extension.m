//
//  UIImageView+Extension.m
//  01-百思不得姐-基本框架
//
//  Created by NengQuan on 15/10/7.
//  Copyright © 2015年 NengQuan. All rights reserved.
//

#import "UIImageView+Extension.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Extension.h"

@implementation UIImageView (Extension)

-(void)SetCircleimageWithUrl:(NSString *)url
{
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        if (image == nil) return ;
        self.image = [image circleImage];
    }];
}


@end
