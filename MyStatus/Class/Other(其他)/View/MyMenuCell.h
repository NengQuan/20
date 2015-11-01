//
//  MyMenuCell.h
//  MyStatus
//
//  Created by NengQuan on 15/10/20.
//  Copyright © 2015年 NengQuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyCommentItem;
@interface MyMenuCell : UITableViewCell

/** cell对应的item数据 **/

@property (nonatomic,strong) MyCommentItem *item;
@end
