//
//  MyAllViewController.m
//  MyStatus
//
//  Created by NengQuan on 15/10/27.
//  Copyright © 2015年 NengQuan. All rights reserved.
//

#import "MyAllViewController.h"

#import "MyTopics.h"


@interface MyAllViewController ()


@end

static NSString * const cellID = @"topic";
@implementation MyAllViewController

- (MyTopicType)type
{
    return MyAllType;
}


@end
