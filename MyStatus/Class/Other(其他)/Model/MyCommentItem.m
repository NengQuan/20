//
//  MyCommentItem.m
//  MyStatus
//
//  Created by NengQuan on 15/10/20.
//  Copyright © 2015年 NengQuan. All rights reserved.
//

#import "MyCommentItem.h"

@implementation MyCommentItem

+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon
{
    MyCommentItem *item = [[self alloc] init];
    item.title = title;
    item.icon = icon;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title
{
    return [self itemWithTitle:title icon:nil];
}

@end
