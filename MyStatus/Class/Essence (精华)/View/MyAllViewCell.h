//
//  MyAllViewCell.h
//  MyStatus
//
//  Created by NengQuan on 15/10/27.
//  Copyright © 2015年 NengQuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyAllViewCell;
@protocol MyAllViewCellDelegate <NSObject>

@optional
- (void)MyAllViewDidClick:(MyAllViewCell *)cell;

@end
@class MyTopics;
@interface MyAllViewCell : UITableViewCell

@property (nonatomic,strong) MyTopics *topic;

@property (nonatomic,weak) id <MyAllViewCellDelegate> delegate;
@end
