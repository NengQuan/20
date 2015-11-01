//
//  MyComment.h
//  MyStatus
//
//  Created by NengQuan on 15/10/27.
//  Copyright © 2015年 NengQuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MyUser;
@interface MyComment : NSObject

/** 评论内容 **/
@property (nonatomic,strong) NSString *content;

/** 用户模型 **/
@property (nonatomic,strong) MyUser *user;
@end
