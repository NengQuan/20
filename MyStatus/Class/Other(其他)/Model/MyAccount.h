//
//  MyAccount.h
//  MyStatus
//
//  Created by NengQuan on 15/10/21.
//  Copyright © 2015年 NengQuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyAccount : NSObject <NSCoding>

/** access_token 	string 	用于调用access_token，接口获取授权后的access token。 **/
@property (nonatomic,strong) NSString *access_token;

/** //expires_in 	string 	access_token的生命周期，单位是秒数。 **/
@property (nonatomic,strong) NSString *expires_in;

/** //uid 	string 	当前授权用户的UID。 **/
@property (nonatomic,strong) NSString *uid;

+ (instancetype)accountWithDict:(NSDictionary *)dict;
@end
