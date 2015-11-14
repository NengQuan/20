//
//  MyVoiceViewController.m
//  MyStatus
//
//  Created by NengQuan on 15/10/29.
//  Copyright © 2015年 NengQuan. All rights reserved.
//

#import "MyVoiceViewController.h"
#import "MyTopics.h"

@interface MyVoiceViewController ()

@end

@implementation MyVoiceViewController

- (MyTopicType)type
{
    return MyVoiceType;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"声音";
    
}
@end
