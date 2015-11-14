//
//  FullViewController.m
//  AVplayer
//
//  Created by NengQuan on 15/11/9.
//  Copyright © 2015年 NengQuan. All rights reserved.
//

#import "FullViewController.h"
#import "FullView.h"

@interface FullViewController ()

@end

@implementation FullViewController


- (void)loadView
{
    FullView *fullView = [[FullView alloc]init];
    self.view = fullView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    
}

/**
 *  控制器是否支持旋转屏幕
 */
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

/**
 *  是否自动旋转屏幕
 */
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}
@end
