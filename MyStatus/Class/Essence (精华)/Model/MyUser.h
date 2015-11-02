//
//  MyUser.h
//  MyStatus
//
//  Created by NengQuan on 15/10/27.
//  Copyright © 2015年 NengQuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyUser : NSObject

/** 用户名 **/
@property (nonatomic,strong) NSString *username;

/** 头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 性别 */
@property (nonatomic, copy) NSString *sex;
@end
