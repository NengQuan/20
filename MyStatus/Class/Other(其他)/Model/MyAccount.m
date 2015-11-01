//
//  MyAccount.m
//  MyStatus
//
//  Created by NengQuan on 15/10/21.
//  Copyright © 2015年 NengQuan. All rights reserved.
//

#import "MyAccount.h"

@implementation MyAccount

+ (instancetype)accountWithDict:(NSDictionary *)dict
{
    MyAccount *acount = [[self alloc]init];
    
    acount.access_token = dict[@"access_token"];
    acount.uid = dict[@"uid"];
    acount.expires_in = dict[@"expires_in"];
    
    return acount;
}

// 解析数据
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
        self.expires_in = [aDecoder decodeObjectForKey:@"expires_in"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeObject:self.uid forKey:@"access_token"];
    [aCoder encodeObject:self.expires_in forKey:@"expires_in"];
}

@end
