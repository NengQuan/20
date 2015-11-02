//
//  MyTopics.m
//  MyStatus
//
//  Created by NengQuan on 15/10/27.
//  Copyright © 2015年 NengQuan. All rights reserved.
//

#import "MyTopics.h"
#import <MJExtension.h>
#import "MyComment.h"
#import "MyUser.h"
#import "NSDate+Extension.h"

@implementation MyTopics

+(NSDictionary *)objectClassInArray
{
    return @{
             @"top_cmt" : [MyComment class]
             };
}

+(NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"top_cmt" : @"top_cmt[0]",
             @"smallImage" : @"image0",
             @"middleImage" : @"image2",
             @"largeImage" : @"image1" ,
             };
}

- (CGFloat)cellHeight
{
    if (_cellHeight == 0) {
        
        // 头像的高度
        CGFloat iconY = 10;
        CGFloat iconH = 35;
        
        _cellHeight = iconY + iconH + Mymargin;
    
        // 有中间内容
        if (self.type != MyWordType) {
            // 中间控件的Y值
            CGFloat picY = iconY + iconH + Mymargin;
            // 中间控件的W
            CGFloat picW = MyScreen.size.width;
            // 中间控件的H
            CGFloat picH = self.height * picW / self.width;
            
            if (picH >= 300) {
                self.BigImage = YES;
                picH = 300;
            }
            _centerFrame = CGRectMake(0, picY, picW, picH);
            
            _cellHeight += picH + Mymargin;
        }
        
        // 正文内容
        CGFloat textW = MyScreen.size.width - 2 * (Mymargin + 6) ;
        CGFloat textH = [self.text boundingRectWithSize:CGSizeMake(textW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont fontWithName:@"PingFang SC" size:16]} context:nil].size.height;
        _cellHeight += textH + Mymargin;
        
        // 赞和评论
        CGFloat likeW = MyScreen.size.width - 2 * (Mymargin + 6);
        NSString *liketext = [NSString stringWithFormat:@"%zd个赞 . %zd个评论",self.ding,self.comment];
        CGFloat likeH = [liketext boundingRectWithSize:CGSizeMake(likeW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont fontWithName:@"PingFang SC" size:14]} context:nil].size.height;
        _cellHeight += likeH + Mymargin;
        
        // 底部工具条
        CGFloat toolBarH = 40;
        _cellHeight += toolBarH + Mymargin;
    }
    return _cellHeight ;

}

- (NSString *)created_at
{
    //获取服务器返回时间
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *createDate = [fmt dateFromString:_created_at];
    
    // 获取当前时间
    NSDate *nowDate = [NSDate date];
    
    // 日历对象
    NSCalendar *calendar = [NSCalendar currentCalendar];
    if ([createDate isThisYear]) { // 今年
        
        if([createDate isthisToday]) { // 今天
            NSCalendarUnit unit = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
            NSDateComponents *cmt = [calendar components:unit fromDate:createDate toDate:nowDate options:0];
            
            if (cmt.hour >= 1) { // 时间间隔>=1 小时
                return [NSString stringWithFormat:@"%zd小时前",cmt.hour];
            } else if (cmt.minute >= 1){ // 时间间隔>=1 分钟
                return [NSString stringWithFormat:@"%zd分钟前",cmt.minute];
            } else {
                return @"刚刚";
            }
        } else if ([createDate isthisYesterday]) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:createDate];
        } else {
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:createDate];
        }
    } else{ // 非今年
        return _created_at;
    }
    
}

@end
