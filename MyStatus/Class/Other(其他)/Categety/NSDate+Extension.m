//
//  NSDate+Extension.m
//  01-百思不得姐-基本框架
//
//  Created by NengQuan on 15/10/18.
//  Copyright © 2015年 NengQuan. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

- (BOOL)isThisYear
{
    NSCalendar *canler = [NSCalendar currentCalendar];
   
    NSInteger create = [canler component:NSCalendarUnitYear fromDate:self];
    NSInteger now = [canler component:NSCalendarUnitYear fromDate:[NSDate date]];
    
    return create == now;
}

- (BOOL)isthisYesterday
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *cretestr = [fmt stringFromDate:self];
    NSString *nowstr = [fmt stringFromDate:[NSDate date]];
    
    NSDate *creteDate = [fmt dateFromString:cretestr];
    NSDate *nowDate = [fmt dateFromString:nowstr];
    
    NSCalendar *canler = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    
    NSDateComponents *cmt = [canler components:unit fromDate:creteDate toDate:nowDate options:0];
    
    return cmt.year == 0 && cmt.month == 0 && cmt.day == 1;
    
}

- (BOOL)isthisToday
{
    NSCalendar *canler = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    NSDateComponents *cmtCreate = [canler components:unit fromDate:self];
    NSDateComponents *cmtNow = [canler components:unit fromDate:[NSDate date]];
    
    return cmtCreate.year == cmtNow.year && cmtCreate.month == cmtNow.month && cmtCreate.day == cmtNow.day;
    
    
}

@end
