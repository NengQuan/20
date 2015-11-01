//
//  MyCategery.h
//  MyStatus
//
//  Created by NengQuan on 15/10/29.
//  Copyright © 2015年 NengQuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyCategery : NSObject

/** 名字 */
@property (nonatomic, copy) NSString *name;
/** id */
@property (nonatomic, copy) NSString *id;

/** 用户数据 **/
@property (nonatomic,strong) NSMutableArray *users;
/** 页码 **/
@property (nonatomic,assign)NSInteger page;

/** 总数 **/
@property (nonatomic,assign)NSInteger total;

@end
