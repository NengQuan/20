//
//  MyDIVHeader.m
//  MyStatus
//
//  Created by NengQuan on 15/10/27.
//  Copyright © 2015年 NengQuan. All rights reserved.
//

#import "MyDIVHeader.h"

@implementation MyDIVHeader

- (void)prepare
{
    [super prepare];
    
    self.automaticallyChangeAlpha = YES;
    
    self.stateLabel.textColor = MyColor(222, 20,0);
    
    [self setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [self setTitle:@"释放更新" forState:MJRefreshStatePulling];
    [self setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    
}

@end
