//
//  FullView.m
//  AVplayer
//
//  Created by NengQuan on 15/11/9.
//  Copyright © 2015年 NengQuan. All rights reserved.
//

#import "FullView.h"

@implementation FullView

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.backgroundColor = [UIColor blackColor];
    }
    return self;
}

@end
