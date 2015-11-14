//
//  MyWordViewController.m
//  MyStatus
//
//  Created by NengQuan on 15/10/29.
//  Copyright © 2015年 NengQuan. All rights reserved.
//

#import "MyWordViewController.h"
#import "MyTopics.h"

@interface MyWordViewController ()

@end

@implementation MyWordViewController

- (MyTopicType)type
{
    return MyWordType;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"段子";
    
}

@end
