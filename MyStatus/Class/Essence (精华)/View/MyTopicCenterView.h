//
//  MyTopicCenterView.h
//  MyStatus
//
//  Created by NengQuan on 15/10/28.
//  Copyright © 2015年 NengQuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyTopics;
@interface MyTopicCenterView : UIView
{
    __weak UIImageView *_iconview;
}

@property (nonatomic,strong) MyTopics *topics;

+ (instancetype)topicCenter;

@end
