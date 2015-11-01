//
//  MyAbout20ViewController.m
//  MyStatus
//
//  Created by NengQuan on 15/10/31.
//  Copyright © 2015年 NengQuan. All rights reserved.
//

#import "MyAbout20ViewController.h"
#import "UIBarButtonItem+Extension.h"

@interface MyAbout20ViewController ()

@end

@implementation MyAbout20ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
       self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithimage:@"nav_back" Heightimage:@"nav_back" target:self action:@selector(btnClick)];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.title = @"关于20";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)btnClick
{
    NSLog(@"sds");
    [self.navigationController popViewControllerAnimated:YES];
}

@end
