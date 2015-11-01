//
//  MyFriendUser.h
//  MyStatus
//
//  Created by NengQuan on 15/10/29.
//  Copyright © 2015年 NengQuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyFriendUser : NSObject

/** 昵称 */
@property (nonatomic, copy) NSString *screen_name;
/** 粉丝数 */
@property (nonatomic, assign) NSInteger fans_count;
/** 头像 */
@property (nonatomic, copy) NSString *header;
@end
